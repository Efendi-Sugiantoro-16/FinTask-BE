import prisma from '../../config/prisma.js';
import gamificationService from '../gamification/gamification.service.js';

/**
 * Pomodoro Service — Logic for managing productivity focus sessions
 */
const pomodoroService = {
  /**
   * Start a new Pomodoro session
   */
  async startSession(userId, taskId, durations) {
    const { focusDuration, breakDuration } = durations;
    
    return await prisma.pomodorosession.create({
      data: {
        userId,
        taskId: taskId || null,
        focusDuration,
        breakDuration,
        status: 'running',
        startedAt: new Date(),
      },
    });
  },

  /**
   * Get the active session for a user
   */
  async getActiveSession(userId) {
    return await prisma.pomodorosession.findFirst({
      where: {
        userId,
        status: { in: ['running', 'paused'] },
      },
      orderBy: { startedAt: 'desc' },
      include: { task: true },
    });
  },

  /**
   * Update session status (pause/resume/cancel)
   */
  async updateStatus(sessionId, status) {
    const data = { status };
    
    if (status === 'cancelled') {
      data.endedAt = new Date();
    }

    return await prisma.pomodorosession.update({
      where: { id: sessionId },
      data,
    });
  },

  /**
   * Complete a session and reward XP
   */
  async completeSession(sessionId, { cycleBonus = false } = {}) {
    const session = await prisma.pomodorosession.findUnique({
      where: { id: sessionId },
    });

    if (!session || session.status === 'completed') {
      throw new Error('Session not found or already completed');
    }

    // Calculate XP: 1 XP per focus minute (standard) + Cycle Bonus
    const baseXP = session.focusDuration;
    const bonusXP = cycleBonus ? 20 : 0;
    const totalXPEarned = baseXP + bonusXP;

    return await prisma.$transaction(async (tx) => {
      // 1. Update session
      const updatedSession = await tx.pomodorosession.update({
        where: { id: sessionId },
        data: {
          status: 'completed',
          endedAt: new Date(),
          xpEarned: totalXPEarned,
        },
      });

      // 2. Add XP to user
      await tx.user.update({
        where: { id: session.userId },
        data: {
          totalXP: { increment: totalXPEarned },
        },
      });

      // 3. Log XP History
      await tx.xphistory.create({
        data: {
          userId: session.userId,
          amount: totalXPEarned,
          source: 'pomodoro',
          sourceId: sessionId,
          description: cycleBonus 
            ? `Selesaikan siklus penuh Pomodoro (Sesi ke-4) dan bonus XP!`
            : `Selesaikan sesi fokus Pomodoro selama ${session.focusDuration} menit`,
        },
      });

      // Trigger Badge Check
      await gamificationService.checkAndAwardBadges(session.userId, 'POMODORO_COMPLETED');

      return updatedSession;
    });
  },

  /**
   * Get user pomodoro statistics
   */
  async getStats(userId) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const sessions = await prisma.pomodorosession.findMany({
      where: { userId, status: 'completed' },
    });

    const sessionsToday = await prisma.pomodorosession.count({
      where: { 
        userId, 
        status: 'completed',
        endedAt: { gte: today }
      },
    });

    const totalMinutes = sessions.reduce((sum, s) => sum + s.focusDuration, 0);
    const totalXP = sessions.reduce((sum, s) => sum + s.xpEarned, 0);

    return {
      dailyCount: sessionsToday,
      totalSessions: sessions.length,
      totalMinutes,
      totalXP,
    };
  },
};


export default pomodoroService;
