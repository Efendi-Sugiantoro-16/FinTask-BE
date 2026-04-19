import reportService from './report.service.js';
import exportUtil from '../../shared/utils/export.util.js';
import prisma from '../../config/prisma.js';

/**
 * Report Controller — Handles requests for financial reports and exports
 */
const reportController = {
  /**
   * Get JSON Report Data (for UI Preview)
   */
  async getReport(req, res, next) {
    try {
      const { type, month, year } = req.query;
      const userId = req.user.id;

      let reportData;
      if (type === 'balance-sheet') {
        reportData = await reportService.getBalanceSheet(userId);
        reportData.type = 'Balance Sheet';
      } else {
        reportData = await reportService.getProfitLoss(userId, month, year);
        reportData.type = 'Profit & Loss';
      }

      res.json({ success: true, data: reportData });
    } catch (error) {
      next(error);
    }
  },

  /**
   * Export Report to Excel
   */
  async exportExcel(req, res, next) {
    try {
      const { type, month, year } = req.query;
      const userId = req.user.id;

      // 1. Get Report Data
      let reportData;
      if (type === 'balance-sheet') {
        reportData = await reportService.getBalanceSheet(userId);
        reportData.type = 'Balance Sheet';
      } else {
        reportData = await reportService.getProfitLoss(userId, month, year);
        reportData.type = 'Profit & Loss';
      }

      // 2. Get User Branding
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { companyName: true, companyAddress: true }
      });

      // 3. Generate Excel
      const workbook = await exportUtil.generateExcel(reportData, user);

      // 4. Send Response
      const filename = `Report_${reportData.type.replace(/\s/g, '_')}_${new Date().getTime()}.xlsx`;
      
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', `attachment; filename=${filename}`);

      await workbook.xlsx.write(res);
      res.end();
    } catch (error) {
      next(error);
    }
  },

  /**
   * Export Report to PDF
   */
  async exportPDF(req, res, next) {
    try {
      const { type, month, year } = req.query;
      const userId = req.user.id;

      // 1. Get Report Data
      let reportData;
      if (type === 'balance-sheet') {
        reportData = await reportService.getBalanceSheet(userId);
        reportData.type = 'Balance Sheet';
      } else {
        reportData = await reportService.getProfitLoss(userId, month, year);
        reportData.type = 'Profit & Loss';
      }

      // 2. Get User Branding
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { companyName: true, companyAddress: true }
      });

      // 3. Generate PDF
      const filename = `Report_${reportData.type.replace(/\s/g, '_')}_${new Date().getTime()}.pdf`;
      
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader('Content-Disposition', `attachment; filename=${filename}`);

      await exportUtil.generatePDF(reportData, user, res);
    } catch (error) {
      next(error);
    }
  }
};

export default reportController;
