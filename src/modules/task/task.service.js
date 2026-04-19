import taskRepository from './task.repository.js';
import { getTaskXPReward } from '../../shared/constants/xpRewards.js';
import prisma from '../../config/prisma.js';
import { parsePagination, parseSort } from '../../shared/helpers/pagination.helper.js';
import { parseDate, isValidDate } from '../../shared/utils/date.util.js';
import gamificationService from '../gamification/gamification.service.js';
import { isSameDay, isSameWeek } from 'date-fns';

/**
 * Task Service — Business logic for task operations
 */
const taskService = {
  // ... (getAllTasks and getTaskById are the same)
  async getAllTasks(userId, query) {
    // Jalankan reset otomatis untuk tugas rutin
    await this.checkTaskResets(userId);

    const { page, limit, skip } = parsePagination(query);

    // Build where clause
    const where = {};
    if (query.status && query.status !== 'all') where.status = query.status;
    if (query.priority && query.priority !== 'all') where.priority = query.priority;
    if (query.category) where.category = query.category;
    if (query.isDaily === 'true') where.isDaily = true;
    if (query.isWeekly === 'true') where.isWeekly = true;
    if (query.search) {
      where.OR = [
        { title: { contains: query.search } },
        { description: { contains: query.search } },
      ];
    }

    // Build sort
    const allowedSortFields = ['createdAt', 'dueDate', 'priority', 'title', 'sortOrder'];
    const orderBy = parseSort(query.sortBy, query.sortOrder, allowedSortFields);

    const { tasks, total } = await taskRepository.findAll(userId, {
      where,
      orderBy,
      skip,
      take: limit,
    });

    return {
      tasks,
      pagination: { page, limit, totalItems: total },
    };
  },

  async getTaskById(userId, taskId) {
    const task = await taskRepository.findById(taskId, userId);
    if (!task) {
      throw Object.assign(new Error('Task tidak ditemukan.'), { statusCode: 404 });
    }
    return task;
  },

  /**
   * Create a new task
   */
  async createTask(userId, data) {
    // Set XP reward berdasarkan priority
    const xpReward = getTaskXPReward(data.priority || 'medium');

    const task = await taskRepository.create({
      ...data,
      userId,
      xpReward,
      dueDate: parseDate(data.dueDate),
    });

    return task;
  },

  /**
   * Update a task
   */
  async updateTask(userId, taskId, data) {
    // Cek task exists
    const existing = await taskRepository.findById(taskId, userId);
    if (!existing) {
      throw Object.assign(new Error('Task tidak ditemukan.'), { statusCode: 404 });
    }

    // Update XP reward jika priority berubah
    if (data.priority) {
      data.xpReward = getTaskXPReward(data.priority);
    }

    if (data.dueDate !== undefined) {
      data.dueDate = parseDate(data.dueDate);
    }

    return taskRepository.update(taskId, userId, data);
  },


  /**
   * Update task status (mark done / undone)
   */
  async updateStatus(userId, taskId, status) {
    const existing = await taskRepository.findById(taskId, userId);
    if (!existing) {
      throw Object.assign(new Error('Task tidak ditemukan.'), { statusCode: 404 });
    }

    const updateData = { status };

    // Jika status berubah ke 'done', set completedAt dan award XP
    if (status === 'done' && existing.status !== 'done') {
      updateData.completedAt = new Date();

      // Cek apakah XP sudah diberikan untuk task ini dalam periode sekarang
      let alreadyAwarded = false;
      
      const whereClause = { userId, source: 'task_complete', sourceId: taskId };
      
      if (existing.isDaily) {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        whereClause.earnedAt = { gte: today };
      } else if (existing.isWeekly) {
        // Logika mingguan bisa lebih kompleks, sementara gunakan pendekatan yang sama
        // atau biarkan reset harian menghapus entry lama jika perlu.
        // Untuk sekarang, kita cek apakah ada di periode ini.
      }

      const recentAward = await prisma.xphistory.findFirst({
        where: whereClause
      });
      
      alreadyAwarded = !!recentAward;

      if (!alreadyAwarded) {
        // Award XP
        const xpAmount = existing.xpReward;

        await prisma.$transaction([
          // Update user totalXP
          prisma.user.update({
            where: { id: userId },
            data: { totalXP: { increment: xpAmount } },
          }),
          // Record XP history
          prisma.xphistory.create({
            data: {
              userId,
              amount: xpAmount,
              source: 'task_complete',
              sourceId: taskId,
              description: `Menyelesaikan task: ${existing.title}`,
            },
          }),
        ]);

        // Trigger Badge Check
        await gamificationService.checkAndAwardBadges(userId, 'TASK_COMPLETED');
      }
    }

    // Jika status berubah dari 'done' ke lainnya, hapus completedAt
    if (status !== 'done') {
      updateData.completedAt = null;
    }

    return taskRepository.update(taskId, userId, updateData);
  },

  /**
   * Delete a task
   */
  async deleteTask(userId, taskId) {
    const existing = await taskRepository.findById(taskId, userId);
    if (!existing) {
      throw Object.assign(new Error('Task tidak ditemukan.'), { statusCode: 404 });
    }

    await taskRepository.delete(taskId, userId);
    return { id: taskId };
  },

  /**
   * Get task statistics
   */
  async getStats(userId) {
    const [statusCount, completedToday] = await Promise.all([
      taskRepository.countByStatus(userId),
      taskRepository.countCompletedToday(userId),
    ]);

    return {
      ...statusCount,
      completedToday,
    };
  },

  /**
   * Reset tugas harian/mingguan jika sudah ganti hari/minggu
   */
  async checkTaskResets(userId) {
    const tasks = await prisma.task.findMany({
      where: {
        userId,
        status: 'done',
        OR: [{ isDaily: true }, { isWeekly: true }],
      },
    });

    const now = new Date();
    const tasksToReset = [];

    for (const task of tasks) {
      const completedAt = task.completedAt;
      if (!completedAt) continue;

      if (task.isDaily && !isSameDay(completedAt, now)) {
        tasksToReset.push(task.id);
      } else if (task.isWeekly && !isSameWeek(completedAt, now, { weekStartsOn: 1 })) {
        tasksToReset.push(task.id);
      }
    }

    if (tasksToReset.length > 0) {
      await prisma.task.updateMany({
        where: { id: { in: tasksToReset } },
        data: {
          status: 'todo',
          completedAt: null,
        },
      });
    }
  },
};

export default taskService;
