import prisma from '../../config/prisma.js';

/**
 * Task Repository — Database queries for task operations
 */
const taskRepository = {
  /**
   * Find all tasks for a user with filters
   */
  async findAll(userId, { where = {}, orderBy = {}, skip = 0, take = 10 }) {
    const [tasks, total] = await Promise.all([
      prisma.task.findMany({
        where: { userId, ...where },
        orderBy,
        skip,
        take,
      }),
      prisma.task.count({
        where: { userId, ...where },
      }),
    ]);

    return { tasks, total };
  },

  /**
   * Find task by ID (scoped to user)
   */
  async findById(id, userId) {
    return prisma.task.findFirst({
      where: { id, userId },
    });
  },

  /**
   * Create a new task
   */
  async create(data) {
    return prisma.task.create({ data });
  },

  /**
   * Update a task
   */
  async update(id, userId, data) {
    return prisma.task.updateMany({
      where: { id, userId },
      data,
    }).then(async () => {
      return prisma.task.findFirst({ where: { id, userId } });
    });
  },

  /**
   * Delete a task
   */
  async delete(id, userId) {
    return prisma.task.deleteMany({
      where: { id, userId },
    });
  },

  /**
   * Count tasks by status for a user
   */
  async countByStatus(userId) {
    const [todo, inProgress, done, total] = await Promise.all([
      prisma.task.count({ where: { userId, status: 'todo' } }),
      prisma.task.count({ where: { userId, status: 'in_progress' } }),
      prisma.task.count({ where: { userId, status: 'done' } }),
      prisma.task.count({ where: { userId } }),
    ]);

    return { todo, inProgress, done, total };
  },

  /**
   * Count completed tasks today
   */
  async countCompletedToday(userId) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    return prisma.task.count({
      where: {
        userId,
        status: 'done',
        completedAt: { gte: today },
      },
    });
  },
};

export default taskRepository;
