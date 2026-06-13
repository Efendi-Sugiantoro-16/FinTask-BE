import { z } from 'zod';

export const registerSchema = z.object({
  email: z
    .string({ required_error: 'Email wajib diisi.' })
    .email('Format email tidak valid.'),
  username: z
    .string({ required_error: 'Username wajib diisi.' })
    .min(3, 'Username minimal 3 karakter.')
    .max(30, 'Username maksimal 30 karakter.'),
  password: z
    .string({ required_error: 'Password wajib diisi.' })
    .min(6, 'Password minimal 6 karakter.')
    .max(100, 'Password maksimal 100 karakter.'),
  fullName: z
    .string({ required_error: 'Nama lengkap wajib diisi.' })
    .min(2, 'Nama lengkap minimal 2 karakter.')
    .max(100, 'Nama lengkap maksimal 100 karakter.'),
});

export const loginSchema = z.object({
  identifier: z
    .string({ required_error: 'Email atau Username wajib diisi.' })
    .min(1, 'Email atau Username wajib diisi.'),
  password: z
    .string({ required_error: 'Password wajib diisi.' })
    .min(1, 'Password wajib diisi.'),
});

export const updateProfileSchema = z.object({
  fullName: z.string().min(2).max(100).optional(),
  username: z
    .string()
    .min(3)
    .max(30)
    .regex(/^[a-zA-Z0-9_]+$/)
    .optional(),
  avatarUrl: z.string().url().optional().nullable(),
});

export const updatePasswordSchema = z.object({
  oldPassword: z.string().min(1, 'Password lama wajib diisi.'),
  newPassword: z.string().min(6, 'Password baru minimal 6 karakter.').max(100),
});

export const refreshTokenSchema = z.object({
  refreshToken: z.string({ required_error: 'Refresh token wajib diisi.' }),
});

export const forgotPasswordSchema = z.object({
  email: z.string({ required_error: 'Email wajib diisi.' }).email('Format email tidak valid.'),
});

export const resetPasswordSchema = z.object({
  token: z.string({ required_error: 'Token wajib diisi.' }),
  newPassword: z.string().min(6, 'Password baru minimal 6 karakter.').max(100),
});

