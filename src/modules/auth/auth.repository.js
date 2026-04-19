import prisma from '../../config/prisma.js';

/**
 * Auth Repository — Database queries for auth operations
 */
const authRepository = {
  /**
   * Cari user by email
   */
  async findByEmail(email) {
    return prisma.user.findUnique({ where: { email } });
  },

  /**
   * Cari user by username
   */
  async findByUsername(username) {
    return prisma.user.findUnique({ where: { username } });
  },

  /**
   * Cari user by ID
   */
  async findById(id) {
    return prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        email: true,
        username: true,
        fullName: true,
        avatarUrl: true,
        role: true,
        level: true,
        totalXP: true,
        loginStreak: true,
        lastLoginAt: true,
        companyName: true,
        companyAddress: true,
        companyLogoUrl: true,
        createdAt: true,
        updatedAt: true,
      },
    });
  },

  /**
   * Buat user baru
   */
  async create(data) {
    return prisma.user.create({
      data,
      select: {
        id: true,
        email: true,
        username: true,
        fullName: true,
        role: true,
        level: true,
        totalXP: true,
        createdAt: true,
      },
    });
  },

  /**
   * Update user
   */
  async update(id, data) {
    return prisma.user.update({
      where: { id },
      data,
      select: {
        id: true,
        email: true,
        username: true,
        fullName: true,
        avatarUrl: true,
        role: true,
        level: true,
        totalXP: true,
        loginStreak: true,
        companyName: true,
        companyAddress: true,
        companyLogoUrl: true,
        updatedAt: true,
      },
    });
  },

  /**
   * Update login streak
   */
  async updateLoginStreak(id, streak, lastLoginAt) {
    return prisma.user.update({
      where: { id },
      data: {
        loginStreak: streak,
        lastLoginAt,
      },
    });
  },
};

export default authRepository;
