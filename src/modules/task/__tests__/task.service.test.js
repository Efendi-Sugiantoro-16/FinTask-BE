import { jest } from '@jest/globals';

// 1. Mock the modules using unstable_mockModule (must be before imports)
jest.unstable_mockModule('../task.repository.js', () => ({
  __esModule: true,
  default: {
    findById: jest.fn(),
    update: jest.fn(),
  },
}));

jest.unstable_mockModule('../../../config/prisma.js', () => ({
  __esModule: true,
  default: {
    xphistory: {
      findFirst: jest.fn(),
      create: jest.fn(),
    },
    user: {
      update: jest.fn(),
    },
    $transaction: jest.fn((promises) => Promise.all(promises)),
    task: {
      updateMany: jest.fn(),
      findFirst: jest.fn(),
    }
  },
}));

jest.unstable_mockModule('../../gamification/gamification.service.js', () => ({
  __esModule: true,
  default: {
    checkAndAwardBadges: jest.fn(),
  },
}));

// 2. Import the mocked modules and the service
const taskRepository = (await import('../task.repository.js')).default;
const prisma = (await import('../../../config/prisma.js')).default;
const taskService = (await import('../task.service.js')).default;

describe('Task Service Unit Tests', () => {
  const userId = 'user-123';
  const taskId = 'task-456';

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('updateStatus', () => {
    it('should award XP for daily task if it was NOT awarded today', async () => {
      // Mock existing task
      const mockTask = {
        id: taskId,
        userId,
        title: 'Daily Workout',
        status: 'todo',
        xpReward: 100,
        isDaily: true,
      };
      taskRepository.findById.mockResolvedValue(mockTask);

      // Mock that XP was awarded yesterday (not today)
      prisma.xphistory.findFirst.mockResolvedValue(null); 
      // Karena logika sekarang pake query date, findFirst akan return null 
      // jika tidak ada entry untuk HARI INI.

      // Action: Mark as done
      await taskService.updateStatus(userId, taskId, 'done');

      // Assert: XP should be awarded
      expect(prisma.user.update).toHaveBeenCalled();
    });

    it('should NOT award XP for daily task if it WAS already awarded today', async () => {
      const mockTask = {
        id: taskId,
        userId,
        title: 'Daily Workout',
        status: 'todo',
        xpReward: 100,
        isDaily: true,
      };
      taskRepository.findById.mockResolvedValue(mockTask);

      // Mock that XP was already awarded today
      prisma.xphistory.findFirst.mockResolvedValue({ id: 'history-1', earnedAt: new Date() });

      await taskService.updateStatus(userId, taskId, 'done');

      expect(prisma.user.update).not.toHaveBeenCalled();
    });

    it('should award XP if task completes for the first time', async () => {
       const mockTask = {
        id: taskId,
        userId,
        title: 'New Task',
        status: 'todo',
        xpReward: 100,
      };
      taskRepository.findById.mockResolvedValue(mockTask);
      prisma.xphistory.findFirst.mockResolvedValue(null);

      await taskService.updateStatus(userId, taskId, 'done');

      expect(prisma.user.update).toHaveBeenCalledWith(expect.objectContaining({
        where: { id: userId },
        data: { totalXP: { increment: 100 } }
      }));
    });
  });
});
