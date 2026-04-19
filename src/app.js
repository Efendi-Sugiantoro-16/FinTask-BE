import express from 'express';
import path from 'path';
import cors from 'cors';
import helmet from 'helmet';
import cookieParser from 'cookie-parser';
import config from './config/index.js';
import { requestLogger } from './middleware/logger.middleware.js';
import { generalLimiter } from './middleware/rateLimiter.middleware.js';
import { errorHandler, notFoundHandler } from './middleware/errorHandler.middleware.js';

// Import routes
import authRoutes from './modules/auth/auth.routes.js';
import taskRoutes from './modules/task/task.routes.js';
import pomodoroRoutes from './modules/pomodoro/pomodoro.routes.js';
import calendarRoutes from './modules/calendar/calendar.routes.js';
import financeRoutes from './modules/finance/finance.routes.js';
import gamificationRoutes from './modules/gamification/gamification.routes.js';
import adminRoutes from './modules/admin/admin.routes.js';
import notificationRoutes from './modules/notification/notification.routes.js';

const app = express();

// ==================== MIDDLEWARE ====================

// Security
app.use(helmet({
  crossOriginResourcePolicy: { policy: "cross-origin" }
}));

// CORS
app.use(cors({
  origin: config.cors.origin,
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

// Body parsing
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Serve Static Files for Avatars
app.use('/uploads', express.static(path.join(process.cwd(), 'uploads')));

// Logging
app.use(requestLogger);

// Rate limiting
app.use(generalLimiter);

// ==================== ROUTES ====================

// Welcome route
app.get('/', (req, res) => {
  res.json({
    success: true,
    message: 'Welcome to FinTask API! 🚀',
    docs: 'Check /api/health for system status',
  });
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({
    success: true,
    message: 'FinTask API is running! 🚀',
    timestamp: new Date().toISOString(),
    environment: config.env,
  });
});

// API routes
app.use('/api/auth', authRoutes);
app.use('/api/tasks', taskRoutes);
app.use('/api/pomodoros', pomodoroRoutes);
app.use('/api/calendar', calendarRoutes);
app.use('/api/finance', financeRoutes);
app.use('/api/gamification', gamificationRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/notifications', notificationRoutes);

// ==================== ERROR HANDLING ====================

// 404 handler
app.use(notFoundHandler);

// Global error handler (must be last)
app.use(errorHandler);

export default app;
