import prisma from '../../config/prisma.js';

/**
 * Admin Service — Global system logic
 */
const adminService = {
  /**
   * Get global statistics
   */
  async getStats() {
    const [totalUsers, totalTasks, totalXP, totalTransactions] = await Promise.all([
      prisma.user.count(),
      prisma.task.count(),
      prisma.user.aggregate({ _sum: { totalXP: true } }),
      prisma.transaction.count(),
    ]);

    // Top active users (by XP)
    const topUsers = await prisma.user.findMany({
      take: 5,
      orderBy: { totalXP: 'desc' },
      select: {
        id: true,
        username: true,
        fullName: true,
        totalXP: true,
        level: true,
      },
    });

    // Task distribution by priority
    const priorityStats = await prisma.task.groupBy({
      by: ['priority'],
      _count: { id: true },
    });

    return {
      overview: {
        totalUsers,
        totalTasks,
        totalXP: totalXP._sum.totalXP || 0,
        totalTransactions,
      },
      topUsers,
      priorityStats,
    };
  },

  /**
   * Get all users with their stats
   */
  async getUsers() {
    return await prisma.user.findMany({
      orderBy: { createdAt: 'desc' },
      select: {
        id: true,
        email: true,
        username: true,
        fullName: true,
        role: true,
        level: true,
        totalXP: true,
        createdAt: true,
        lastLoginAt: true,
      },
    });
  },

  /**
   * Update user role
   */
  async updateRole(userId, role) {
    if (!['USER', 'ADMIN'].includes(role)) {
      throw Object.assign(new Error('Role tidak valid.'), { statusCode: 400 });
    }

    return await prisma.user.update({
      where: { id: userId },
      data: { role },
      select: {
        id: true,
        username: true,
        role: true,
      },
    });
  },
};

export default adminService;
