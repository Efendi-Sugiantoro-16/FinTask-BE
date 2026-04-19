import ExcelJS from 'exceljs';
import PDFDocument from 'pdfkit';

/**
 * Export Utility — Handles generation of Excel and PDF files
 */
const exportUtil = {
  /**
   * Generate Excel Report
   */
  async generateExcel(reportData, branding) {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Report');

    // 1. Branding Header
    worksheet.mergeCells('A1:D1');
    worksheet.getCell('A1').value = branding.companyName || 'FinTask Financial Report';
    worksheet.getCell('A1').font = { size: 16, bold: true };
    worksheet.getCell('A1').alignment = { horizontal: 'center' };

    worksheet.mergeCells('A2:D2');
    worksheet.getCell('A2').value = branding.companyAddress || '';
    worksheet.getCell('A2').alignment = { horizontal: 'center' };

    worksheet.addRow([]); // Gap

    // 2. Report Summary
    worksheet.addRow(['Report Type', reportData.type]);
    worksheet.addRow(['Period/Date', reportData.period || reportData.asOfDate]);
    worksheet.addRow([]);

    // 3. Table Headers
    const headerRow = worksheet.addRow(['Category', 'Amount']);
    headerRow.font = { bold: true };
    headerRow.fill = {
      type: 'pattern',
      pattern: 'solid',
      fgColor: { argb: 'FFE0E0E0' }
    };

    // 4. Data
    if (reportData.details) {
      Object.entries(reportData.details).forEach(([section, categories]) => {
        const sectionRow = worksheet.addRow([section.toUpperCase(), '']);
        sectionRow.font = { bold: true };
        
        categories.forEach(item => {
          worksheet.addRow([item.category, item.amount]);
        });
        worksheet.addRow([]);
      });
    }

    // 5. Totals
    worksheet.addRow([]);
    if (reportData.type === 'Profit & Loss') {
      worksheet.addRow(['Total Revenue', reportData.totalRevenue]);
      worksheet.addRow(['Total Expenses', reportData.totalExpenses]);
      const netRow = worksheet.addRow(['Net Profit', reportData.netProfit]);
      netRow.font = { bold: true };
    } else {
      worksheet.addRow(['Total Assets', reportData.totalAssets]);
      worksheet.addRow(['Total Liabilities', reportData.totalLiabilities]);
      worksheet.addRow(['Total Equity', reportData.totalEquity]);
    }

    // Formatting columns
    worksheet.getColumn(2).numFmt = '#,##0.00';
    worksheet.getColumn(1).width = 30;
    worksheet.getColumn(2).width = 20;

    return workbook;
  },

  /**
   * Generate PDF Report
   */
  async generatePDF(reportData, branding, res) {
    const doc = new PDFDocument({ margin: 50 });

    doc.pipe(res);

    // 1. Branding Header
    doc.fontSize(20).text(branding.companyName || 'FinTask Financial Report', { align: 'center' });
    doc.fontSize(10).text(branding.companyAddress || '', { align: 'center' });
    doc.moveDown();
    doc.moveTo(50, doc.y).lineTo(550, doc.y).stroke();
    doc.moveDown();

    // 2. Report Info
    doc.fontSize(14).text(`${reportData.type} Report`, { bold: true });
    doc.fontSize(12).text(`Period: ${reportData.period || reportData.asOfDate}`);
    doc.moveDown();

    // 3. Table
    const tableTop = doc.y;
    doc.fontSize(10).text('Category', 50, tableTop);
    doc.text('Amount', 400, tableTop, { align: 'right' });
    doc.moveDown();
    doc.moveTo(50, doc.y).lineTo(550, doc.y).stroke();
    doc.moveDown();

    if (reportData.details) {
      Object.entries(reportData.details).forEach(([section, categories]) => {
        doc.fillColor('blue').fontSize(11).text(section.toUpperCase());
        doc.fillColor('black').fontSize(10);
        doc.moveDown(0.5);

        categories.forEach(item => {
          doc.text(item.category, 70);
          doc.text(this._formatCurrency(item.amount), 400, doc.y - 12, { align: 'right' });
          doc.moveDown(0.5);
        });
        doc.moveDown();
      });
    }

    // 4. Totals
    doc.moveTo(50, doc.y).lineTo(550, doc.y).stroke();
    doc.moveDown();
    
    if (reportData.type === 'Profit & Loss') {
      this._addTotalRow(doc, 'Total Revenue', reportData.totalRevenue);
      this._addTotalRow(doc, 'Total Expenses', reportData.totalExpenses);
      this._addTotalRow(doc, 'Net Profit', reportData.netProfit, true);
    } else {
      this._addTotalRow(doc, 'Total Assets', reportData.totalAssets);
      this._addTotalRow(doc, 'Total Liabilities', reportData.totalLiabilities);
      this._addTotalRow(doc, 'Total Equity', reportData.totalEquity, true);
    }

    doc.end();
  },

  _formatCurrency(amount) {
    return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(amount);
  },

  _addTotalRow(doc, label, amount, isBold = false) {
    if (isBold) doc.font('Helvetica-Bold');
    doc.text(label, 50);
    doc.text(this._formatCurrency(amount), 400, doc.y - 12, { align: 'right' });
    if (isBold) doc.font('Helvetica');
    doc.moveDown(0.5);
  }
};

export default exportUtil;
