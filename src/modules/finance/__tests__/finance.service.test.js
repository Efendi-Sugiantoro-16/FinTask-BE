import { jest } from '@jest/globals';

jest.unstable_mockModule('../../../config/prisma.js', () => ({
  __esModule: true,
  default: {
    transaction: {
      create: jest.fn(),
    },
  },
}));

const prisma = (await import('../../../config/prisma.js')).default;
const financeService = (await import('../finance.service.js')).default;

describe('Finance Service Unit Tests', () => {
  const userId = 'user-123';

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('createTransaction', () => {
    it('should reject negative amounts', async () => {
      const data = {
        amount: -5000,
        type: 'expense',
        category: 'Food',
        transactionDate: '2026-04-10',
      };

      // Kita mengharapkan ini melempar error setelah diperbaiki
      // Untuk sekarang, kita buktikan dulu kalau ini masih melempar error / gagal validasi
      await expect(financeService.createTransaction(userId, data))
        .rejects.toThrow('Jumlah transaksi tidak boleh negatif atau nol');
    });

    it('should create transaction with valid positive amount', async () => {
      const data = {
        amount: 5000,
        type: 'expense',
        category: 'Food',
        paymentMethod: 'cash',
        transactionDate: '2026-04-10',
      };

      prisma.transaction.create.mockResolvedValue({ id: 'tx-1', ...data });

      const result = await financeService.createTransaction(userId, data);
      
      expect(prisma.transaction.create).toHaveBeenCalled();
      expect(result.amount).toBe(5000);
    });
  });
});
