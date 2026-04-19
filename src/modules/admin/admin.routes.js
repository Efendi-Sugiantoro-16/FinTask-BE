import express from 'express';
import adminController from './admin.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
import { authorizeAdmin } from '../../middleware/admin.middleware.js';

const router = express.Router();

/**
 * Route: /api/admin
 * Semua route di bawah ini diproteksi oleh authenticate dan authorizeAdmin
 */
router.use(authenticate);
router.use(authorizeAdmin);

/**
 * Endpoint Statistik Sistem
 */
router.get('/stats', adminController.getSystemStats);

/**
 * Endpoint Manajemen User
 */
router.get('/users', adminController.getAllUsers);
router.put('/users/:id/role', adminController.updateUserRole);

export default router;
