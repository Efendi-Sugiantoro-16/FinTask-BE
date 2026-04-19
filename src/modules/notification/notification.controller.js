import notificationService from './notification.service.js';
import { sendSuccess, sendError } from '../../shared/helpers/response.helper.js';

/**
 * Notification Controller — Handle user notification requests
 */
const notificationController = {
  /**
   * GET /api/notifications
   * Mengambil semua notifikasi milik user yang sedang login
   */
  async getMyNotifications(req, res, next) {
    try {
      const notifications = await notificationService.getNotifications(req.user.id);
      return sendSuccess(res, 200, 'Berhasil mengambil data notifikasi.', notifications);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/notifications/:id/read
   * Menandai satu notifikasi sebagai 'sudah dibaca'
   */
  async markAsRead(req, res, next) {
    try {
      const notification = await notificationService.markAsRead(req.params.id, req.user.id);
      return sendSuccess(res, 200, 'Notifikasi ditandai sebagai dibaca.', notification);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/notifications/read-all
   * Menandai semua notifikasi user sebagai 'sudah dibaca'
   */
  async markAllAsRead(req, res, next) {
    try {
      await notificationService.markAllRead(req.user.id);
      return sendSuccess(res, 200, 'Semua notifikasi ditandai sebagai dibaca.');
    } catch (error) {
      next(error);
    }
  },

  /**
   * DELETE /api/notifications/:id
   * Menghapus satu notifikasi
   */
  async deleteNotification(req, res, next) {
    try {
      await notificationService.deleteNotification(req.params.id, req.user.id);
      return sendSuccess(res, 200, 'Notifikasi berhasil dihapus.');
    } catch (error) {
      next(error);
    }
  },

  /**
   * DELETE /api/notifications
   * Menghapus semua notifikasi user (Clear)
   */
  async clearNotifications(req, res, next) {
    try {
      await notificationService.clearAllNotifications(req.user.id);
      return sendSuccess(res, 200, 'Semua notifikasi berhasil dibersihkan.');
    } catch (error) {
      next(error);
    }
  }
};

export default notificationController;
