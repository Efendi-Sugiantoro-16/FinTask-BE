import express from 'express';
import financeController from './finance.controller.js';
import reportController from './report.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';

const router = express.Router();

// All routes require authentication
router.use(authenticate);

/**
 * @route   POST /api/finance/transactions
 * @desc    Create a new transaction
 */
router.post('/transactions', financeController.create);

/**
 * @route   GET /api/finance/transactions
 * @desc    Get filtered transactions list
 */
router.get('/transactions', financeController.list);

/**
 * @route   GET /api/finance/summary
 * @desc    Get financial summary (Balance, Monthly, Breakdown)
 */
router.get('/summary', financeController.getSummary);

/**
 * @route   GET /api/finance/reports
 * @desc    Get report data preview (P&L, Balance Sheet)
 */
router.get('/reports', reportController.getReport);

/**
 * @route   GET /api/finance/reports/export/excel
 * @desc    Export report to Excel
 */
router.get('/reports/export/excel', reportController.exportExcel);

/**
 * @route   GET /api/finance/reports/export/pdf
 * @desc    Export report to PDF
 */
router.get('/reports/export/pdf', reportController.exportPDF);

/**
 * @route   PATCH /api/finance/transactions/:id
 * @desc    Update a transaction
 */
router.patch('/transactions/:id', financeController.update);

/**
 * @route   DELETE /api/finance/transactions/:id
 * @desc    Delete a transaction
 */
router.delete('/transactions/:id', financeController.delete);

export default router;
