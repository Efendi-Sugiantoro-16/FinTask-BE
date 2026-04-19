import prisma from '../../config/prisma.js';

/**
 * Notification Service — Logic for managing user notifications
 */
const notificationService = {
  /**
   * Create a new notification for a user
   */
  async createNotification(userId, data) {
    const { type = 'info', title, message, link } = data;
    
    return await prisma.notification.create({
      data: {
        userId,
        type,
        title,
        message,
        link,
      },
    });
  },

  /**
   * Get all notifications for a user
   */
  async getNotifications(userId, limit = 50) {
    return await prisma.notification.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
      take: parseInt(limit),
    });
  },

  /**
   * Get unread count
   */
  async getUnreadCount(userId) {
    return await prisma.notification.count({
      where: { userId, isRead: false },
    });
  },

  /**
   * Mark as read
   */
  async markAsRead(notificationId, userId) {
    return await prisma.notification.update({
      where: { id: notificationId, userId },
      data: { isRead: true },
    });
  },

  /**
   * Mark all as read
   */
  async markAllRead(userId) {
    return await prisma.notification.updateMany({
      where: { userId, isRead: false },
      data: { isRead: true },
    });
  },

  /**
   * Delete all notifications (Clear all)
   */
  async clearAllNotifications(userId) {
    return await prisma.notification.deleteMany({
      where: { userId },
    });
  },

  /**
   * Delete notification
   */
  async deleteNotification(notificationId, userId) {
    return await prisma.notification.delete({
      where: { id: notificationId, userId },
    });
  },
};

export default notificationService;
