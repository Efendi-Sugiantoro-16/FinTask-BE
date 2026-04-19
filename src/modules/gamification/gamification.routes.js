import express from 'express';
import gamificationController from './gamification.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';

const router = express.Router();

// All routes require authentication
router.use(authenticate);

/**
 * @route   GET /api/gamification/stats
 * @desc    Get user leveling stats, XP, and history
 */
router.get('/stats', gamificationController.getStats);

/**
 * @route   GET /api/gamification/leaderboard
 * @desc    Get global rankings
 */
router.get('/leaderboard', gamificationController.getLeaderboard);

/**
 * @route   GET /api/gamification/history
 * @desc    Get detailed XP history
 */
router.get('/history', gamificationController.getHistory);

/**
 * @route   GET /api/gamification/badges
 * @desc    Get all available badges in the system
 */
router.get('/badges', gamificationController.listBadges);

export default router;
