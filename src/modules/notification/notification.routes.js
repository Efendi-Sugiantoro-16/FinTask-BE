import express from 'express';
import notificationController from './notification.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';

const router = express.Router();

// Semua route notifikasi butuh autentikasi
router.use(authenticate);

// Mengambil semua notifikasi
router.get('/', notificationController.getMyNotifications);

// Operasi Bulk
router.put('/read-all', notificationController.markAllAsRead);
router.delete('/clear', notificationController.clearNotifications);

// Operasi Spesifik
router.put('/:id/read', notificationController.markAsRead);
router.delete('/:id', notificationController.deleteNotification);

export default router;
