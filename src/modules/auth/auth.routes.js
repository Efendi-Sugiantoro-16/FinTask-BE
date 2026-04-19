import { Router } from 'express';
import authController from './auth.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
import { validate } from '../../middleware/validator.middleware.js';
import { authLimiter } from '../../middleware/rateLimiter.middleware.js';
import { uploadAvatar } from '../../config/multer.js';
import {
  registerSchema,
  loginSchema,
  updateProfileSchema,
  updatePasswordSchema,
  refreshTokenSchema,
} from './auth.validation.js';

const router = Router();

// Public routes (dengan rate limiter ketat)
router.post('/register', authLimiter, validate(registerSchema), authController.register);
router.post('/login', authLimiter, validate(loginSchema), authController.login);
router.post('/refresh', validate(refreshTokenSchema), authController.refreshToken);

// QR Login routes (Public)
router.get('/qr/generate', authController.getLoginQR);
router.get('/qr/status/:token', authController.checkQRStatus);
router.get('/magic-login/:token', authController.magicLogin);

// Protected routes (butuh JWT)
router.get('/me', authenticate, authController.getProfile);
router.put('/profile', authenticate, validate(updateProfileSchema), authController.updateProfile);
router.put('/profile/avatar', authenticate, uploadAvatar.single('avatar'), authController.updateAvatar);
router.put('/password', authenticate, validate(updatePasswordSchema), authController.updatePassword);
router.post('/qr/verify', authenticate, authController.verifyQR);
router.get('/qr/instant', authenticate, authController.generateInstantQR);
router.post('/logout', authenticate, authController.logout);

export default router;

