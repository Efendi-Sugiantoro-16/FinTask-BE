import jwt from 'jsonwebtoken';
import config from '../config/index.js';
import prisma from '../config/prisma.js';
import { sendError } from '../shared/helpers/response.helper.js';

/**
 * Middleware: Verifikasi JWT token dari header Authorization
 */
export const authenticate = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return sendError(res, 401, 'Akses ditolak. Token tidak ditemukan.');
    }

    const token = authHeader.split(' ')[1];

    const decoded = jwt.verify(token, config.jwt.secret);

    // Cek apakah user masih ada di database
    const user = await prisma.user.findUnique({
      where: { id: decoded.userId },
      select: {
        id: true,
        email: true,
        username: true,
        fullName: true,
        avatarUrl: true,
        role: true,
        level: true,
        totalXP: true,
      },
    });

    if (!user) {
      return sendError(res, 401, 'User tidak ditemukan.');
    }

    // Attach user ke request object
    req.user = user;
    next();
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      return sendError(res, 401, 'Token sudah expired. Silakan refresh token.');
    }
    if (error.name === 'JsonWebTokenError') {
      return sendError(res, 401, 'Token tidak valid.');
    }
    return sendError(res, 500, 'Terjadi kesalahan pada autentikasi.');
  }
};

/**
 * Middleware opsional — tidak error jika tidak ada token
 */
export const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.split(' ')[1];
      const decoded = jwt.verify(token, config.jwt.secret);

      const user = await prisma.user.findUnique({
        where: { id: decoded.userId },
        select: { id: true, email: true, username: true, fullName: true },
      });

      if (user) {
        req.user = user;
      }
    }

    next();
  } catch {
    // Token invalid tapi tidak error — lanjut tanpa auth
    next();
  }
};
