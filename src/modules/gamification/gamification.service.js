import prisma from '../../config/prisma.js';

/**
 * Gamification Service — Logic for levels, ranks, and XP history
 */
const gamificationService = {
  /**
   * Get All Available Badges in the system
   */
  async getAllAvailableBadges() {
    return await prisma.badge.findMany({
      orderBy: { category: 'asc' }
    });
  },
  /**
   * Calculate level and progress based on total XP
   * Base 1000 XP per level (linear)
   */
  calculateLevel(totalXP) {
    const level = Math.floor(totalXP / 1000) + 1;
    const currentLevelXP = totalXP % 1000;
    const xpToNextLevel = 1000 - currentLevelXP;
    const progress = (currentLevelXP / 1000) * 100;

    return {
      level,
      currentLevelXP,
      xpToNextLevel,
      progress,
    };
  },

  /**
   * Get user XP History
   */
  async getXPHistory(userId, limit = 20) {
    return await prisma.xphistory.findMany({
      where: { userId },
      orderBy: { earnedAt: 'desc' },
      take: limit,
    });
  },

  /**
   * Get Global Leaderboard
   */
  async getLeaderboard(limit = 10) {
    const users = await prisma.user.findMany({
      select: {
        id: true,
        username: true,
        fullName: true,
        totalXP: true,
        level: true,
      },
      orderBy: { totalXP: 'desc' },
      take: limit,
    });

    return users.map((user, index) => ({
      rank: index + 1,
      ...user,
      // For leaderboard, use username for privacy
      displayName: user.username,
    }));
  },

  /**
   * Get comprehensive gamification stats for a user
   */
  async getStats(userId) {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { totalXP: true, loginStreak: true },
    });

    if (!user) throw new Error('User not found');

    const levelData = this.calculateLevel(user.totalXP);
    const history = await this.getXPHistory(userId);

    return {
      totalXP: user.totalXP,
      loginStreak: user.loginStreak,
      ...levelData,
      recentHistory: history,
      badges: await this.getUserBadges(userId),
    };
  },

  /**
   * Get all badges earned by a user
   */
  async getUserBadges(userId) {
    return await prisma.userbadge.findMany({
      where: { userId },
      include: { badge: true },
      orderBy: { unlockedAt: 'desc' },
    });
  },

  /**
   * Logic to check and award badges based on triggers
   */
  async checkAndAwardBadges(userId, triggerType) {
    // 1. Get all badges from DB
    const badges = await prisma.badge.findMany();
    
    // 2. Get user's current badges
    const userBadges = await prisma.userbadge.findMany({
      where: { userId },
      select: { badgeId: true }
    });
    const userBadgeIds = new Set(userBadges.map(ub => ub.badgeId));

    // 3. Define Achievement Logic
    for (const badge of badges) {
      if (userBadgeIds.has(badge.id)) continue;

      let awarded = false;

      if (badge.code === 'productive_starter' && triggerType === 'TASK_COMPLETED') {
        const count = await prisma.task.count({ where: { userId, status: 'done' } });
        if (count >= 1) awarded = true;
      }

      if (badge.code === 'zen_initiate' && triggerType === 'POMODORO_COMPLETED') {
        const count = await prisma.pomodorosession.count({ where: { userId, type: 'work' } });
        if (count >= 1) awarded = true;
      }

      if (badge.code === 'streak_3' && triggerType === 'LOGIN') {
        const user = await prisma.user.findUnique({ where: { id: userId }, select: { loginStreak: true } });
        if (user.loginStreak >= 3) awarded = true;
      }

      if (awarded) {
        await prisma.userbadge.create({
          data: {
            userId,
            badgeId: badge.id,
          }
        });
        
        // Bonus XP for badge unlock (Optional)
        await prisma.user.update({
          where: { id: userId },
          data: { totalXP: { increment: 50 } }
        });

        await prisma.xphistory.create({
          data: {
            userId,
            amount: 50,
            source: 'badge_unlock',
            sourceId: badge.id,
            description: `Membuka lencana: ${badge.name}`,
          }
        });
      }
    }
  }
};

export default gamificationService;
