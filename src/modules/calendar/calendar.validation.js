import { z } from 'zod';

/**
 * Validasi untuk Calendar Event
 */
export const createEventSchema = z.object({
  title: z
    .string({ required_error: 'Judul event wajib diisi.' })
    .min(1, 'Judul event tidak boleh kosong.')
    .max(200, 'Judul event maksimal 200 karakter.'),
  description: z.string().max(2000).optional().nullable(),
  startDate: z.string({ required_error: 'Tanggal mulai wajib diisi.' }),
  endDate: z.string({ required_error: 'Tanggal selesai wajib diisi.' }),
  allDay: z.boolean().optional().default(false),
  recurrence: z.enum(['none', 'daily', 'weekly', 'monthly']).default('none'),
  color: z.string().regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/, 'Format warna tidak valid').default('#4F46E5'),
  reminder: z.enum(['none', '5min', '15min', '30min', '1hour']).default('none'),
  taskId: z.string().uuid().optional().nullable(),
});

export const updateEventSchema = z.object({
  title: z.string().min(1).max(200).optional(),
  description: z.string().max(2000).optional().nullable(),
  startDate: z.string().optional(),
  endDate: z.string().optional(),
  allDay: z.boolean().optional(),
  recurrence: z.enum(['none', 'daily', 'weekly', 'monthly']).optional(),
  color: z.string().regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/).optional(),
  reminder: z.enum(['none', '5min', '15min', '30min', '1hour']).optional(),
  taskId: z.string().uuid().optional().nullable(),
});
