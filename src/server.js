import app from './app.js';
import config from './config/index.js';
import logger from './middleware/logger.middleware.js';
import { startDeadlineWorker } from './shared/workers/deadline.worker.js';

const PORT = config.port;

const server = app.listen(PORT, () => {
  logger.info(`🚀 FinTask API server running on http://localhost:${PORT}`);
  logger.info(`📋 Environment: ${config.env}`);
  logger.info(`🔗 Health check: http://localhost:${PORT}/api/health`);
  
  // Start background workers
  startDeadlineWorker();
});

// Pelindung Global — Menghindari server mati mendadak tanpa log
process.on('uncaughtException', (err) => {
  logger.error('❌ UNCAUGHT EXCEPTION! Server dimatikan dengan aman...', err);
  process.exit(1);
});

process.on('unhandledRejection', (err) => {
  logger.error('❌ UNHANDLED REJECTION! Server dimatikan dengan aman...', err);
  server.close(() => {
    process.exit(1);
  });
});
