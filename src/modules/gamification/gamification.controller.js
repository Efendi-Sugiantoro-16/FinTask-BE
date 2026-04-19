import gamificationService from './gamification.service.js';

/**
 * Gamification Controller — Routing logic for XP, Levels, and Leaderboards
 */
const gamificationController = {
  /**
   * Get current user gamification stats
   */
  async getStats(req, res, next) {
    try {
      const stats = await gamificationService.getStats(req.user.id);
      res.json({ success: true, data: stats });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get Global Leaderboard
   */
  async getLeaderboard(req, res, next) {
    try {
      const { limit } = req.query;
      const leaderboard = await gamificationService.getLeaderboard(limit ? parseInt(limit) : 10);
      res.json({ success: true, data: leaderboard });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get XP History for current user
   */
  async getHistory(req, res, next) {
    try {
      const { limit } = req.query;
      const history = await gamificationService.getXPHistory(req.user.id, limit ? parseInt(limit) : 20);
      res.json({ success: true, data: history });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get all badges available in the system
   */
  async listBadges(req, res, next) {
    try {
      const badges = await gamificationService.getAllAvailableBadges();
      res.json({ success: true, data: badges });
    } catch (err) {
      next(err);
    }
  }
};

export default gamificationController;
