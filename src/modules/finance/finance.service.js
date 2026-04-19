import prisma from '../../config/prisma.js';
import { startOfMonth, endOfMonth } from 'date-fns';
import { parseDate, isValidDate } from '../../shared/utils/date.util.js';

/**
 * Finance Service — Logic for tracking income, expenses, and summaries
 */
const financeService = {
  /**
   * Create a new transaction
   */
  async createTransaction(userId, data) {
    const { amount, type, category, coaType, description, paymentMethod, transactionDate } = data;
    
    const numAmount = parseFloat(amount);
    if (isNaN(numAmount) || numAmount <= 0) {
      throw new Error('Jumlah transaksi tidak boleh negatif atau nol');
    }
    
    const parsedDate = parseDate(transactionDate) || new Date();
    if (!isValidDate(parsedDate)) throw new Error('Format tanggal transaksi tidak valid');

    return await prisma.transaction.create({
      data: {
        userId,
        amount: parseFloat(amount),
        type,
        category,
        coaType: coaType || (type === 'income' ? 'REVENUE' : 'EXPENSE'),
        description,
        paymentMethod: paymentMethod || 'cash',
        transactionDate: parsedDate,
      },
    });
  },

  /**
   * Get all transactions for a user with filters
   */
  async getTransactions(userId, filters = {}) {
    const { type, category, startDate, endDate, limit = 50 } = filters;
    
    const where = { userId };
    
    if (type && type !== 'all') where.type = type;
    if (category && category !== 'all') where.category = category;
    if (startDate || endDate) {
      where.transactionDate = {};
      if (startDate) {
        const parsedStart = parseDate(startDate);
        if (isValidDate(parsedStart)) where.transactionDate.gte = parsedStart;
      }
      if (endDate) {
        const parsedEnd = parseDate(endDate);
        if (isValidDate(parsedEnd)) where.transactionDate.lte = parsedEnd;
      }
    }

    return await prisma.transaction.findMany({
      where,
      orderBy: { transactionDate: 'desc' },
      take: parseInt(limit),
    });
  },

  /**
   * Get summary (Total Balance, Monthly Income, Monthly Expense)
   */
  async getSummary(userId, month, year) {
    // 1. Calculate Grand Total Balance (Optimized with Aggregate)
    const [incomeAgg, expenseAgg] = await Promise.all([
      prisma.transaction.aggregate({
        where: { userId, type: 'income' },
        _sum: { amount: true }
      }),
      prisma.transaction.aggregate({
        where: { userId, type: 'expense' },
        _sum: { amount: true }
      })
    ]);

    const totalBalance = (incomeAgg._sum.amount || 0) - (expenseAgg._sum.amount || 0);

    // 2. Calculate Monthly Stats
    const now = new Date();
    const queryMonth = month ? parseInt(month) - 1 : now.getMonth();
    const queryYear = year ? parseInt(year) : now.getFullYear();
    
    const targetDate = new Date(queryYear, queryMonth, 1);
    const start = startOfMonth(targetDate);
    const end = endOfMonth(targetDate);

    const [monthlyIncomeAgg, monthlyExpenseAgg] = await Promise.all([
      prisma.transaction.aggregate({
        where: { userId, type: 'income', transactionDate: { gte: start, lte: end } },
        _sum: { amount: true }
      }),
      prisma.transaction.aggregate({
        where: { userId, type: 'expense', transactionDate: { gte: start, lte: end } },
        _sum: { amount: true }
      })
    ]);

    const monthlyIncome = monthlyIncomeAgg._sum.amount || 0;
    const monthlyExpense = monthlyExpenseAgg._sum.amount || 0;
    
    // Fetch transactions only for category breakdown and details
    const monthlyTransactions = await prisma.transaction.findMany({
      where: {
        userId,
        transactionDate: { gte: start, lte: end }
      }
    });

    // 3. Category Breakdown (Expenses only)
    const categoryMap = {};
    monthlyTransactions
      .filter(t => t.type === 'expense')
      .forEach(t => {
        categoryMap[t.category] = (categoryMap[t.category] || 0) + t.amount;
      });

    const categoryBreakdown = Object.entries(categoryMap).map(([name, amount]) => ({
      category: name,
      amount,
      percentage: monthlyExpense > 0 ? (amount / monthlyExpense) * 100 : 0
    }));

    return {
      totalBalance,
      monthlyIncome,
      monthlyExpense,
      netSavings: monthlyIncome - monthlyExpense,
      categoryBreakdown
    };
  },

  /**
   * Delete a transaction
   */
  async deleteTransaction(transactionId, userId) {
    return await prisma.transaction.delete({
      where: { id: transactionId, userId }
    });
  },

  /**
   * Update a transaction
   */
  async updateTransaction(transactionId, userId, data) {
    const updateData = { ...data };
    
    if (data.amount !== undefined) {
      const numAmount = parseFloat(data.amount);
      if (isNaN(numAmount) || numAmount <= 0) {
        throw new Error('Jumlah transaksi tidak boleh negatif atau nol');
      }
      updateData.amount = numAmount;
    }
    
    if (data.transactionDate) {
      const parsedDate = parseDate(data.transactionDate);
      if (!isValidDate(parsedDate)) throw new Error('Format tanggal transaksi tidak valid');
      updateData.transactionDate = parsedDate;
    }

    return await prisma.transaction.update({
      where: { id: transactionId, userId },
      data: updateData
    });
  },
};

export default financeService;
