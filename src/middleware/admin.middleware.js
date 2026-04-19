import { sendError } from '../shared/helpers/response.helper.js';

/**
 * Middleware: Verifikasi role ADMIN
 * Harus dipasang SEBELAH authenticate middleware
 */
export const authorizeAdmin = (req, res, next) => {
  if (!req.user) {
    return sendError(res, 401, 'Autentikasi diperlukan.');
  }

  if (req.user.role !== 'ADMIN') {
    return sendError(res, 403, 'Akses ditolak. Fitur ini hanya untuk Admin.');
  }

  next();
};

/**
 * Middleware: Verifikasi role spesifik (Versi Fleksibel)
 */
export const authorizeRole = (...roles) => {
  return (req, res, next) => {
    if (!req.user) {
      return sendError(res, 401, 'Autentikasi diperlukan.');
    }

    if (!roles.includes(req.user.role)) {
      return sendError(res, 403, 'Akses ditolak. Anda tidak memiliki izin yang cukup.');
    }

    next();
  };
};
