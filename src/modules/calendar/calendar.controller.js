import calendarService from './calendar.service.js';

/**
 * Calendar Controller — Routing logic for Events and Tasks Sync
 */
const calendarController = {
  /**
   * Create new event
   */
  async create(req, res, next) {
    try {
      const event = await calendarService.createEvent(req.user.id, req.body);
      res.status(201).json({ success: true, data: event });
    } catch (err) {
      next(err);
    }
  },

  /**
   * List events for a range
   */
  async list(req, res, next) {
    try {
      const { start, end } = req.query;
      const events = await calendarService.getEvents(req.user.id, start, end);
      res.json({ success: true, data: events });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Update event
   */
  async update(req, res, next) {
    try {
      const eventId = req.params.id;
      const event = await calendarService.updateEvent(eventId, req.user.id, req.body);
      res.json({ success: true, data: event });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Delete event
   */
  async delete(req, res, next) {
    try {
      const eventId = req.params.id;
      await calendarService.deleteEvent(eventId, req.user.id);
      res.json({ success: true, message: 'Event deleted' });
    } catch (err) {
      next(err);
    }
  },
};

export default calendarController;
