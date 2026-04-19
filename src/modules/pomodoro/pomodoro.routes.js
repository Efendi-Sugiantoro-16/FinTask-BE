import express from 'express';
import pomodoroController from './pomodoro.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';

const router = express.Router();

// All routes require authentication
router.use(authenticate);

/**
 * @route   POST /api/pomodoros
 */
router.post('/', pomodoroController.start);

/**
 * @route   GET /api/pomodoros/active
 */
router.get('/active', pomodoroController.getActive);

/**
 * @route   PATCH /api/pomodoros/:id/status
 */
router.patch('/:id/status', pomodoroController.updateStatus);

/**
 * @route   POST /api/pomodoros/:id/complete
 */
router.post('/:id/complete', pomodoroController.complete);

/**
 * @route   GET /api/pomodoros/stats
 */
router.get('/stats', pomodoroController.getStats);

export default router;
