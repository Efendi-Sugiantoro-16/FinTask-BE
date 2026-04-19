import pomodoroService from './pomodoro.service.js';

/**
 * Pomodoro Controller — Routing logic for Productivity Sessions
 */
const pomodoroController = {
  /**
   * Start a new session
   */
  async start(req, res, next) {
    try {
      const { taskId, focusDuration = 25, breakDuration = 5 } = req.body;
      const session = await pomodoroService.startSession(req.user.id, taskId, {
        focusDuration,
        breakDuration,
      });
      res.status(201).json({ success: true, data: session });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get active session
   */
  async getActive(req, res, next) {
    try {
      const session = await pomodoroService.getActiveSession(req.user.id);
      res.json({ success: true, data: session });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Pause or Resume a session
   */
  async updateStatus(req, res, next) {
    try {
      const { status } = req.body; // paused | running | cancelled
      const session = await pomodoroService.updateStatus(req.params.id, status);
      res.json({ success: true, data: session });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Complete a session
   */
  async complete(req, res, next) {
    try {
      const session = await pomodoroService.completeSession(req.params.id);
      res.json({ success: true, data: session });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get statistics
   */
  async getStats(req, res, next) {
    try {
      const stats = await pomodoroService.getStats(req.user.id);
      res.json({ success: true, data: stats });
    } catch (err) {
      next(err);
    }
  },
};

export default pomodoroController;
