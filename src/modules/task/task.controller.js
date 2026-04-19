import taskService from './task.service.js';
import { sendSuccess, sendPaginated } from '../../shared/helpers/response.helper.js';
import { MESSAGES } from '../../shared/constants/messages.js';

/**
 * Task Controller — Handle HTTP requests for todo list
 */
const taskController = {
  /**
   * GET /api/tasks
   */
  async getAll(req, res, next) {
    try {
      const { tasks, pagination } = await taskService.getAllTasks(req.user.id, req.query);
      return sendPaginated(res, MESSAGES.DATA_FETCHED, tasks, pagination, 'tasks');
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/tasks/stats
   */
  async getStats(req, res, next) {
    try {
      const stats = await taskService.getStats(req.user.id);
      return sendSuccess(res, 200, MESSAGES.DATA_FETCHED, stats);
    } catch (error) {
      next(error);
    }
  },

  /**
   * GET /api/tasks/:id
   */
  async getById(req, res, next) {
    try {
      const task = await taskService.getTaskById(req.user.id, req.params.id);
      return sendSuccess(res, 200, MESSAGES.DATA_FETCHED, task);
    } catch (error) {
      next(error);
    }
  },

  /**
   * POST /api/tasks
   */
  async create(req, res, next) {
    try {
      const task = await taskService.createTask(req.user.id, req.body);
      return sendSuccess(res, 201, MESSAGES.TASK_CREATED, task);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PUT /api/tasks/:id
   */
  async update(req, res, next) {
    try {
      const task = await taskService.updateTask(req.user.id, req.params.id, req.body);
      return sendSuccess(res, 200, MESSAGES.TASK_UPDATED, task);
    } catch (error) {
      next(error);
    }
  },

  /**
   * PATCH /api/tasks/:id/status
   */
  async updateStatus(req, res, next) {
    try {
      const task = await taskService.updateStatus(req.user.id, req.params.id, req.body.status);
      return sendSuccess(res, 200, MESSAGES.TASK_STATUS_UPDATED, task);
    } catch (error) {
      next(error);
    }
  },

  /**
   * DELETE /api/tasks/:id
   */
  async delete(req, res, next) {
    try {
      await taskService.deleteTask(req.user.id, req.params.id);
      return sendSuccess(res, 200, MESSAGES.TASK_DELETED);
    } catch (error) {
      next(error);
    }
  },
};

export default taskController;
