import adminService from './admin.service.js';
import { sendSuccess } from '../../shared/helpers/response.helper.js';

/**
 * Admin Controller — Management and analytics
 */
const adminController = {
  /**
   * GET /api/admin/stats
   * Ringkasan statistik sistem global
   */
  async getSystemStats(req, res, next) {
    try {
      const stats = await adminService.getStats();
      return sendSuccess(res, 200, 'Statistik sistem berhasil dimuat.', stats);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/admin/users
   * Daftar semua pengguna dalam sistem
   */
  async getAllUsers(req, res, next) {
    try {
      const users = await adminService.getUsers();
      return sendSuccess(res, 200, 'Daftar pengguna berhasil dimuat.', users);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/admin/users/:id/role
   * Mengubah role pengguna (Promote/Demote)
   */
  async updateUserRole(req, res, next) {
    try {
      if (req.user.role !== 'SUPERADMIN') {
        return res.status(403).json({ success: false, message: 'Akses ditolak. Hanya Super Admin yang dapat mengubah role.' });
      }

      const { id } = req.params;
      const { role } = req.body;
      const user = await adminService.updateRole(id, role);
      return sendSuccess(res, 200, `Role user ${user.username} berhasil diubah menjadi ${role}.`, user);
    } catch (error) {
      next(error);
    }
  },
};

export default adminController;
