import prisma from '../../config/prisma.js';
import notificationService from '../../modules/notification/notification.service.js';
import logger from '../../middleware/logger.middleware.js';

/**
 * Deadline Worker — Background task to check for upcoming task deadlines
 */
export const startDeadlineWorker = () => {
  // Jalankan setiap 1 jam (3600000ms)
  const INTERVAL = 3600000;
  
  logger.info('🕒 Deadline Worker started...');
  
  setInterval(async () => {
    try {
      const now = new Date();
      const tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);
      
      // Ambil tugas yang jatuh tempo dalam 24 jam ke depan dan belum selesai
      const upcomingTasks = await prisma.task.findMany({
        where: {
          dueDate: {
            gte: now,
            lte: tomorrow
          },
          status: { not: 'completed' },
        },
        include: { user: true }
      });
      
      for (const task of upcomingTasks) {
        // Cek apakah sudah pernah dikirimi notifikasi dalam 24 jam terakhir untuk tugas ini
        // (Sangat sederhana: cek keberadaan notifikasi serupa)
        const existingNotif = await prisma.notification.findFirst({
          where: {
            userId: task.userId,
            title: { contains: task.title },
            type: 'alarm',
            createdAt: { gte: new Date(now.getTime() - 24 * 60 * 60 * 1000) }
          }
        });
        
        if (!existingNotif) {
          await notificationService.createNotification(task.userId, {
            type: 'alarm',
            title: '⏰ Tugas Mendekati Deadline!',
            message: `Tugas "${task.title}" akan segera berakhir pada ${task.dueDate.toLocaleString('id-ID')}. Jangan sampai telat ya sayang... mwhehehe.`,
            link: `/dashboard/tasks`
          });
          logger.info(`🔔 Deadline notification sent for task: ${task.title} to user: ${task.userId}`);
        }
      }
    } catch (error) {
      logger.error('❌ Deadline Worker Error:', error);
    }
  }, INTERVAL);
};
