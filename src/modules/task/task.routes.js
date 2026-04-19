import { Router } from 'express';
import taskController from './task.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
import { validate, validateQuery } from '../../middleware/validator.middleware.js';
import {
  createTaskSchema,
  updateTaskSchema,
  updateStatusSchema,
  taskQuerySchema,
} from './task.validation.js';

const router = Router();

// Semua routes butuh authentication
router.use(authenticate);

// Routes
router.get('/stats', taskController.getStats);
router.get('/', validateQuery(taskQuerySchema), taskController.getAll);
router.post('/', validate(createTaskSchema), taskController.create);
router.get('/:id', taskController.getById);
router.put('/:id', validate(updateTaskSchema), taskController.update);
router.patch('/:id/status', validate(updateStatusSchema), taskController.updateStatus);
router.delete('/:id', taskController.delete);

export default router;
