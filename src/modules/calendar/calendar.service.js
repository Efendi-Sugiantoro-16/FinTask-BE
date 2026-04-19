import prisma from '../../config/prisma.js';
import { startOfMonth, endOfMonth, startOfDay, endOfDay } from 'date-fns';
import { parseDate, isValidDate } from '../../shared/utils/date.util.js';

/**
 * Calendar Service — Logic for managing events and task synchronization
 */
const calendarService = {
  /**
   * Create a new calendar event
   */
  async createEvent(userId, data) {
    const startDate = parseDate(data.startDate);
    const endDate = parseDate(data.endDate);

    if (!isValidDate(startDate) || !isValidDate(endDate)) {
      throw new Error('Format tanggal tidak valid. Gunakan DD-MM-YYYY HH:mm');
    }

    return await prisma.calendarevent.create({
      data: {
        ...data,
        userId,
        startDate,
        endDate,
      },
    });
  },

  /**
   * Get all events for a user within a date range
   * Also includes Tasks with due dates in the same range
   */
  async getEvents(userId, start, end) {
    const startDate = new Date(start);
    const endDate = new Date(end);

    // 1. Fetch specific calendar events
    const events = await prisma.calendarevent.findMany({
      where: {
        userId,
        startDate: { gte: startDate, lte: endDate },
      },
    });

    // 2. Fetch tasks with due dates in the range
    const tasks = await prisma.task.findMany({
      where: {
        userId,
        dueDate: { not: null, gte: startDate, lte: endDate },
      },
    });

    // Transform tasks into calendar-friendly format
    const transformedTasks = tasks.map(task => ({
      id: `task-${task.id}`,
      title: `Task: ${task.title}`,
      startDate: task.dueDate,
      endDate: task.dueDate,
      allDay: true,
      color: task.priority === 'urgent' ? '#EF4444' : task.priority === 'high' ? '#F59E0B' : '#4F46E5',
      type: 'task',
      originalId: task.id,
      status: task.status,
    }));

    return [...events, ...transformedTasks];
  },

  /**
   * Update a calendar event
   */
  async updateEvent(eventId, userId, data) {
    const updateData = { ...data };
    
    if (data.startDate) {
      const parsedStart = parseDate(data.startDate);
      if (!isValidDate(parsedStart)) throw new Error('Format tanggal mulai tidak valid');
      updateData.startDate = parsedStart;
    }
    
    if (data.endDate) {
      const parsedEnd = parseDate(data.endDate);
      if (!isValidDate(parsedEnd)) throw new Error('Format tanggal selesai tidak valid');
      updateData.endDate = parsedEnd;
    }

    return await prisma.calendarevent.update({
      where: { id: eventId, userId },
      data: updateData,
    });
  },

  /**
   * Delete a calendar event
   */
  async deleteEvent(eventId, userId) {
    return await prisma.calendarevent.delete({
      where: { id: eventId, userId },
    });
  },
};


export default calendarService;
