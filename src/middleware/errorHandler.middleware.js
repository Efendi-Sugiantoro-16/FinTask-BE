import { sendError } from '../shared/helpers/response.helper.js';

/**
 * Middleware: Global error handler
 * Harus didaftarkan TERAKHIR setelah semua routes
 */
export const errorHandler = (err, req, res, next) => {
  console.error('❌ Error:', err);

  // Prisma errors
  if (err.code === 'P2002') {
    const field = err.meta?.target?.[0] || 'field';
    return sendError(res, 409, `${field} sudah digunakan.`);
  }

  if (err.code === 'P2025') {
    return sendError(res, 404, 'Data tidak ditemukan.');
  }

  // JWT errors
  if (err.name === 'JsonWebTokenError') {
    return sendError(res, 401, 'Token tidak valid.');
  }

  if (err.name === 'TokenExpiredError') {
    return sendError(res, 401, 'Token sudah expired.');
  }

  // Zod validation error
  if (err.name === 'ZodError') {
    const errors = err.errors.map((e) => ({
      field: e.path.join('.'),
      message: e.message,
    }));
    return sendError(res, 400, 'Validasi gagal.', errors);
  }

  // Default error
  const statusCode = err.statusCode || 500;
  const message = err.message || 'Terjadi kesalahan pada server.';

  if (statusCode === 500) {
    console.error('❌ STACK TRACE:', err.stack);
  }

  return sendError(res, statusCode, message);
};

/**
 * Middleware: Handle 404 Not Found
 */
export const notFoundHandler = (req, res) => {
  return sendError(res, 404, `Route ${req.method} ${req.originalUrl} tidak ditemukan.`);
};
