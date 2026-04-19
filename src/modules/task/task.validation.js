import { z } from 'zod';

export const createTaskSchema = z.object({
  title: z
    .string({ required_error: 'Judul task wajib diisi.' })
    .min(1, 'Judul task tidak boleh kosong.')
    .max(200, 'Judul task maksimal 200 karakter.'),
  description: z.string().max(2000).optional().nullable(),
  priority: z.enum(['low', 'medium', 'high', 'urgent']).default('medium'),
  status: z.enum(['todo', 'in_progress', 'done']).default('todo'),
  category: z.string().max(50).optional().nullable(),
  dueDate: z.string().optional().nullable().or(z.literal('')),
  isDaily: z.preprocess((val) => val === 'true' || val === true, z.boolean()).optional().default(false),
  isWeekly: z.preprocess((val) => val === 'true' || val === true, z.boolean()).optional().default(false),
});

export const updateTaskSchema = z.object({
  title: z.string().min(1).max(200).optional(),
  description: z.string().max(2000).optional().nullable(),
  priority: z.enum(['low', 'medium', 'high', 'urgent']).optional(),
  status: z.enum(['todo', 'in_progress', 'done']).optional(),
  category: z.string().max(50).optional().nullable(),
  dueDate: z.string().optional().nullable().or(z.literal('')),
  isDaily: z.preprocess((val) => val === 'true' || val === true, z.boolean()).optional(),
  isWeekly: z.preprocess((val) => val === 'true' || val === true, z.boolean()).optional(),
  sortOrder: z.number().int().optional(),
});


export const updateStatusSchema = z.object({
  status: z.enum(['todo', 'in_progress', 'done'], {
    required_error: 'Status wajib diisi.',
  }),
});

export const taskQuerySchema = z.object({
  page: z.string().optional().default('1'),
  limit: z.string().optional().default('10'),
  status: z.enum(['todo', 'in_progress', 'done', 'all']).optional().default('all'),
  priority: z.enum(['low', 'medium', 'high', 'urgent', 'all']).optional().default('all'),
  category: z.string().optional(),
  search: z.string().optional(),
  sortBy: z.enum(['createdAt', 'dueDate', 'priority', 'title', 'sortOrder']).optional().default('createdAt'),
  sortOrder: z.enum(['asc', 'desc']).optional().default('desc'),
  isDaily: z.string().optional(),
  isWeekly: z.string().optional(),
});
