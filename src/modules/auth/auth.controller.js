import authService from './auth.service.js';
import { sendSuccess, sendError } from '../../shared/helpers/response.helper.js';
import { MESSAGES } from '../../shared/constants/messages.js';

/**
 * Auth Controller — Handle HTTP requests
 */
const authController = {
  /**
   * POST /api/auth/register
   */
  async register(req, res, next) {
    try {
      const result = await authService.register(req.body);
      return sendSuccess(res, 201, MESSAGES.REGISTER_SUCCESS, result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * POST /api/auth/login
   */
  async login(req, res, next) {
    try {
      const result = await authService.login(req.body);
      return sendSuccess(res, 200, MESSAGES.LOGIN_SUCCESS, result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * POST /api/auth/refresh
   */
  async refreshToken(req, res, next) {
    try {
      const result = await authService.refreshToken(req.body.refreshToken);
      return sendSuccess(res, 200, MESSAGES.TOKEN_REFRESHED, result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/auth/me
   */
  async getProfile(req, res, next) {
    try {
      const user = await authService.getProfile(req.user.id);
      return sendSuccess(res, 200, MESSAGES.DATA_FETCHED, user);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/auth/profile
   */
  async updateProfile(req, res, next) {
    try {
      const user = await authService.updateProfile(req.user.id, req.body);
      return sendSuccess(res, 200, MESSAGES.PROFILE_UPDATED, user);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/auth/password
   */
  async updatePassword(req, res, next) {
    try {
      await authService.updatePassword(req.user.id, req.body);
      return sendSuccess(res, 200, 'Password berhasil diperbarui.');
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/auth/profile/avatar
   */
  async updateAvatar(req, res, next) {
    try {
      if (!req.file) {
        return sendError(res, 400, 'Pilih file gambar untuk diunggah.');
      }

      // Simpan path relative untuk DB
      const avatarUrl = `/uploads/avatars/${req.file.filename}`;
      const user = await authService.updateProfile(req.user.id, { avatarUrl });

      return sendSuccess(res, 200, 'Foto profil berhasil diperbarui.', user);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/auth/qr/generate
   */
  async getLoginQR(req, res, next) {
    try {
      const result = await authService.generateQR();
      return sendSuccess(res, 200, MESSAGES.DATA_FETCHED, result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/auth/qr/status/:token
   */
  async checkQRStatus(req, res, next) {
    try {
      const result = await authService.checkQRStatus(req.params.token);
      return sendSuccess(res, 200, MESSAGES.DATA_FETCHED, result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * POST /api/auth/qr/verify
   * (Diakses oleh user yang sudah login untuk memverifikasi QR token)
   */
  async verifyQR(req, res, next) {
    try {
      const { token } = req.body;
      const result = await authService.verifyQR(token, req.user.id);
      return sendSuccess(res, 200, 'QR Berhasil diverifikasi. Silakan cek browser Anda.', result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/auth/qr/instant
   * (Diakses oleh user yang sudah login untuk membuat QR Magic Link)
   */
  async generateInstantQR(req, res, next) {
    try {
      const result = await authService.generateInstantQR(req.user.id);
      return sendSuccess(res, 200, 'QR Instant Login berhasil dibuat.', result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/auth/magic-login/:token
   * (Diakses oleh device baru untuk login instan)
   */
  async magicLogin(req, res, next) {
    try {
      const result = await authService.verifyMagicToken(req.params.token);
      return sendSuccess(res, 200, 'Login instan berhasil!', result);
    } catch (error) {
      next(error);
    }
  },

  /**
   * POST /api/auth/logout
   */
  async logout(req, res) {
    // Stateless JWT — client harus hapus token sendiri
    return sendSuccess(res, 200, MESSAGES.LOGOUT_SUCCESS);
  },
};

export default authController;
