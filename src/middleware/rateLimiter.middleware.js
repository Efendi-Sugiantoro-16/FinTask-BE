import rateLimit from 'express-rate-limit';
import config from '../config/index.js';

/**
 * General rate limiter — 100 requests per minute
 */
export const generalLimiter = rateLimit({
  windowMs: config.rateLimit.windowMs,
  max: config.rateLimit.max,
  message: {
    success: false,
    message: 'Terlalu banyak request. Coba lagi nanti.',
  },
  standardHeaders: true,
  legacyHeaders: false,
});

/**
 * Auth rate limiter — 5 requests per minute (prevent brute force)
 */
export const authLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 10,
  message: {
    success: false,
    message: 'Terlalu banyak percobaan login. Coba lagi dalam 1 menit.',
  },
  standardHeaders: true,
  legacyHeaders: false,
});
