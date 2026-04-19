import financeService from './finance.service.js';

/**
 * Finance Controller — Routing logic for Income and Expenses
 */
const financeController = {
  /**
   * Add new transaction
   */
  async create(req, res, next) {
    try {
      const transaction = await financeService.createTransaction(req.user.id, req.body);
      res.status(201).json({ success: true, data: transaction });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get filtered transactions
   */
  async list(req, res, next) {
    try {
      const transactions = await financeService.getTransactions(req.user.id, req.query);
      res.json({ success: true, data: transactions });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Get financial summary (Balance, Monthly, Breakdown)
   */
  async getSummary(req, res, next) {
    try {
      const { month, year } = req.query;
      const summary = await financeService.getSummary(req.user.id, month, year);
      res.json({ success: true, data: summary });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Update transaction
   */
  async update(req, res, next) {
    try {
      const id = req.params.id;
      const transaction = await financeService.updateTransaction(id, req.user.id, req.body);
      res.json({ success: true, data: transaction });
    } catch (err) {
      next(err);
    }
  },

  /**
   * Delete transaction
   */
  async delete(req, res, next) {
    try {
      const id = req.params.id;
      await financeService.deleteTransaction(id, req.user.id);
      res.json({ success: true, message: 'Transaction deleted' });
    } catch (err) {
      next(err);
    }
  },
};

export default financeController;
