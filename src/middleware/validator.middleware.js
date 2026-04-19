import { sendError } from '../shared/helpers/response.helper.js';

/**
 * Middleware: Validasi request body menggunakan Zod schema
 * @param {import('zod').ZodSchema} schema - Zod schema
 */
export const validate = (schema) => {
  return (req, res, next) => {
    try {
      const result = schema.safeParse(req.body);

      if (!result.success) {
        const errors = result.error.errors.map((err) => ({
          field: err.path.join('.'),
          message: err.message,
        }));

        return sendError(res, 400, 'Validasi gagal.', errors);
      }

      // Use Object.assign to avoid read-only property errors
      Object.assign(req.body, result.data);
      next();
    } catch (error) {
      console.error('❌ Validation Error Body:', error);
      return sendError(res, 500, 'Terjadi kesalahan pada validasi.');
    }
  };
};

/**
 * Middleware: Validasi query params menggunakan Zod schema
 */
export const validateQuery = (schema) => {
  return (req, res, next) => {
    try {
      const result = schema.safeParse(req.query);

      if (!result.success) {
        const errors = result.error.errors.map((err) => ({
          field: err.path.join('.'),
          message: err.message,
        }));

        return sendError(res, 400, 'Parameter tidak valid.', errors);
      }

      // Use Object.assign to avoid read-only property errors
      Object.assign(req.query, result.data);
      next();
    } catch (error) {
      console.error('❌ Validation Error Query:', error);
      return sendError(res, 500, 'Terjadi kesalahan pada validasi.');
    }
  };
};

/**
 * Middleware: Validasi params (URL params)
 */
export const validateParams = (schema) => {
  return (req, res, next) => {
    try {
      const result = schema.safeParse(req.params);

      if (!result.success) {
        const errors = result.error.errors.map((err) => ({
          field: err.path.join('.'),
          message: err.message,
        }));

        return sendError(res, 400, 'Parameter URL tidak valid.', errors);
      }

      // Use Object.assign to avoid read-only property errors
      Object.assign(req.params, result.data);
      next();
    } catch (error) {
      return sendError(res, 500, 'Terjadi kesalahan pada validasi.');
    }
  };
};
