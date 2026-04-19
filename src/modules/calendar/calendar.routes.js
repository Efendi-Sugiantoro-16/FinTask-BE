import express from 'express';
import calendarController from './calendar.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
import { validate } from '../../middleware/validator.middleware.js';
import { createEventSchema, updateEventSchema } from './calendar.validation.js';

const router = express.Router();

// All routes require authentication
router.use(authenticate);

/**
 * @route   GET /api/calendar
 * @desc    Get all events and sync tasks for a given range
 */
router.get('/', calendarController.list);

/**
 * @route   POST /api/calendar
 * @desc    Create a new calendar event
 */
router.post('/', validate(createEventSchema), calendarController.create);

/**
 * @route   PATCH /api/calendar/:id
 * @desc    Update a calendar event
 */
router.patch('/:id', validate(updateEventSchema), calendarController.update);

/**
 * @route   DELETE /api/calendar/:id
 * @desc    Delete a calendar event
 */
router.delete('/:id', calendarController.delete);

export default router;

