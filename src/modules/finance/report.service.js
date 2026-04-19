import prisma from '../../config/prisma.js';
import { startOfMonth, endOfMonth, format } from 'date-fns';

/**
 * Report Service — Logic for generating Accounting Reports (P&L, Balance Sheet)
 */
const reportService = {
  /**
   * Get Profit & Loss Report
   */
  async getProfitLoss(userId, month, year) {
    const now = new Date();
    const qMonth = month ? parseInt(month) - 1 : now.getMonth();
    const qYear = year ? parseInt(year) : now.getFullYear();
    
    const start = startOfMonth(new Date(qYear, qMonth, 1));
    const end = endOfMonth(new Date(qYear, qMonth, 1));

    const transactions = await prisma.transaction.findMany({
      where: {
        userId,
        transactionDate: { gte: start, lte: end },
        coaType: { in: ['REVENUE', 'EXPENSE'] }
      }
    });

    const revenue = transactions.filter(t => t.coaType === 'REVENUE');
    const expenses = transactions.filter(t => t.coaType === 'EXPENSE');

    const totalRevenue = revenue.reduce((sum, t) => sum + t.amount, 0);
    const totalExpenses = expenses.reduce((sum, t) => sum + t.amount, 0);

    // Group by category for detail
    const revenueDetails = this._groupByCategory(revenue);
    const expenseDetails = this._groupByCategory(expenses);

    return {
      period: format(start, 'MMMM yyyy'),
      totalRevenue,
      totalExpenses,
      netProfit: totalRevenue - totalExpenses,
      details: {
        revenue: revenueDetails,
        expenses: expenseDetails
      }
    };
  },

  /**
   * Get Balance Sheet (Neraca)
   * Note: Balance sheet is cumulative (snapshot of current state)
   */
  async getBalanceSheet(userId) {
    const transactions = await prisma.transaction.findMany({
      where: {
        userId,
        coaType: { in: ['ASSET', 'LIABILITY', 'EQUITY'] }
      }
    });

    const assets = transactions.filter(t => t.coaType === 'ASSET');
    const liabilities = transactions.filter(t => t.coaType === 'LIABILITY');
    const equity = transactions.filter(t => t.coaType === 'EQUITY');

    const totalAssets = assets.reduce((sum, t) => sum + t.amount, 0);
    const totalLiabilities = liabilities.reduce((sum, t) => sum + t.amount, 0);
    const totalEquity = equity.reduce((sum, t) => sum + t.amount, 0);

    return {
      asOfDate: format(new Date(), 'dd MMMM yyyy'),
      totalAssets,
      totalLiabilities,
      totalEquity,
      isBalanced: totalAssets === (totalLiabilities + totalEquity),
      details: {
        assets: this._groupByCategory(assets),
        liabilities: this._groupByCategory(liabilities),
        equity: this._groupByCategory(equity)
      }
    };
  },

  /**
   * Helper: Group transactions by category
   */
  _groupByCategory(transactions) {
    const map = {};
    transactions.forEach(t => {
      map[t.category] = (map[t.category] || 0) + t.amount;
    });
    return Object.entries(map).map(([name, amount]) => ({
      category: name,
      amount
    }));
  }
};

export default reportService;
