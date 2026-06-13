import authRepository from './auth.repository.js';
import { hashPassword, comparePassword } from '../../shared/utils/hash.util.js';
import { generateTokens, verifyRefreshToken } from '../../shared/utils/jwt.util.js';
import { startOfDay } from '../../shared/utils/date.util.js';
import gamificationService from '../gamification/gamification.service.js';
import { v4 as uuidv4 } from 'uuid';
import QRCode from 'qrcode';
import prisma from '../../config/prisma.js';
import crypto from 'crypto';
import { sendResetPasswordEmail } from '../../shared/helpers/email.helper.js';

/**
 * Auth Service — Business logic for authentication
 */
const authService = {
  /**
   * Register user baru
   */
  async register({ email, username, password, fullName }) {
    // Cek apakah email sudah digunakan
    const existingEmail = await authRepository.findByEmail(email);
    if (existingEmail) {
      throw Object.assign(new Error('Email sudah terdaftar.'), { statusCode: 409 });
    }

    // Cek apakah username sudah digunakan
    const existingUsername = await authRepository.findByUsername(username);
    if (existingUsername) {
      throw Object.assign(new Error('Username sudah digunakan.'), { statusCode: 409 });
    }

    // Hash password
    const passwordHash = await hashPassword(password);

    // Buat user
    const user = await authRepository.create({
      email,
      username,
      passwordHash,
      fullName,
    });

    // Generate tokens
    const { accessToken, refreshToken } = generateTokens(user.id, user.role);

    return { user, token: accessToken, refreshToken };
  },

  /**
   * Login user
   */
  async login({ identifier, password }) {
    // Cari user by email atau username
    let user = await authRepository.findByEmail(identifier);
    
    if (!user) {
      user = await authRepository.findByUsername(identifier);
    }

    if (!user) {
      throw Object.assign(new Error('Email/Username atau password salah.'), { statusCode: 401 });
    }

    // Verifikasi password
    const isValidPassword = await comparePassword(password, user.passwordHash);
    if (!isValidPassword) {
      throw Object.assign(new Error('Email/Username atau password salah.'), { statusCode: 401 });
    }

    // Update login streak
    const today = startOfDay();
    const lastLogin = user.lastLoginAt ? startOfDay(user.lastLoginAt) : null;
    let newStreak = 1;

    if (lastLogin) {
      const diffDays = Math.floor((today - lastLogin) / (1000 * 60 * 60 * 24));
      if (diffDays === 1) {
        // Consecutive day — increment streak
        newStreak = user.loginStreak + 1;
      } else if (diffDays === 0) {
        // Same day — keep streak
        newStreak = user.loginStreak;
      }
      // else: streak broken, reset to 1
    }

    await authRepository.updateLoginStreak(user.id, newStreak, new Date());

    // Generate tokens
    const { accessToken, refreshToken } = generateTokens(user.id, user.role);

    // Return user tanpa passwordHash
    const { passwordHash, ...userWithoutPassword } = user;
    userWithoutPassword.loginStreak = newStreak;

    // Trigger Badge Check
    await gamificationService.checkAndAwardBadges(user.id, 'LOGIN');

    return { user: userWithoutPassword, token: accessToken, refreshToken };
  },

  /**
   * Refresh token
   */
  async refreshToken(refreshToken) {
    try {
      const decoded = verifyRefreshToken(refreshToken);

      // Cek user masih ada
      const user = await authRepository.findById(decoded.userId);
      if (!user) {
        throw Object.assign(new Error('User tidak ditemukan.'), { statusCode: 401 });
      }

      // Generate tokens baru
      const { accessToken, refreshToken: newRefreshToken } = generateTokens(user.id, user.role);
      return { user, token: accessToken, refreshToken: newRefreshToken };
    } catch (error) {
      if (error.statusCode) throw error;
      throw Object.assign(new Error('Refresh token tidak valid.'), { statusCode: 401 });
    }
  },

  /**
   * Get current user profile
   */
  async getProfile(userId) {
    const user = await authRepository.findById(userId);
    if (!user) {
      throw Object.assign(new Error('User tidak ditemukan.'), { statusCode: 404 });
    }
    return user;
  },

  /**
   * Update user profile
   */
  async updateProfile(userId, data) {
    // Cek jika username berubah, apakah sudah digunakan
    if (data.username) {
      const existing = await authRepository.findByUsername(data.username);
      if (existing && existing.id !== userId) {
        throw Object.assign(new Error('Username sudah digunakan.'), { statusCode: 409 });
      }
    }

    return authRepository.update(userId, data);
  },

  /**
   * Update user password
   */
  async updatePassword(userId, { oldPassword, newPassword }) {
    const user = await authRepository.findById(userId);
    if (!user) {
      throw Object.assign(new Error('User tidak ditemukan.'), { statusCode: 404 });
    }

    // Verifikasi password lama
    const isValid = await comparePassword(oldPassword, user.passwordHash);
    if (!isValid) {
      throw Object.assign(new Error('Password saat ini salah.'), { statusCode: 401 });
    }

    // Hash password baru
    const passwordHash = await hashPassword(newPassword);

    await authRepository.update(userId, { passwordHash });
    return { success: true };
  },

  /**
   * QR LOGIN — Step 1: Generate QR Code for login page
   */
  async generateQR() {
    const token = uuidv4();
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000); // 5 menit

    // 0. Auto-Cleanup: Hapus sesi basi (Expired atau Completed > 1 jam)
    const oneHourAgo = new Date(Date.now() - 60 * 60 * 1000);
    await prisma.qrsession.deleteMany({
      where: {
        OR: [
          { expiresAt: { lt: new Date() } },
          { status: 'completed' },
          { updatedAt: { lt: oneHourAgo } }
        ]
      }
    });

    // 1. Simpan ke DB
    await prisma.qrsession.create({
      data: {
        token,
        status: 'pending',
        expiresAt,
      },
    });

    // Generate URL untuk QR (Universal Scan Support)
    const frontendUrl = process.env.CORS_ORIGIN || 'http://localhost:5173';
    const verifyUrl = `${frontendUrl}/verify-qr?token=${token}`;
    
    // Generate QR Image (Base64)
    const qrDataUrl = await QRCode.toDataURL(verifyUrl);

    return { token, qrImage: qrDataUrl, verifyUrl, expiresAt };
  },

  /**
   * QR LOGIN — Step 2: User "Scans" and Authorizes (simulated)
   */
  async verifyQR(token, userId) {
    const session = await prisma.qrsession.findUnique({
      where: { token },
    });

    if (!session || session.status !== 'pending') {
      throw Object.assign(new Error('Sesi QR tidak valid atau sudah kadaluarsa.'), { statusCode: 400 });
    }

    if (new Date() > session.expiresAt) {
      await prisma.qrsession.update({
        where: { token },
        data: { status: 'expired' },
      });
      throw Object.assign(new Error('Sesi QR sudah kadaluarsa.'), { statusCode: 400 });
    }

    // Update session dengan userId pemindai
    return await prisma.qrsession.update({
      where: { token },
      data: {
        userId,
        status: 'verified',
      },
    });
  },

  /**
   * QR LOGIN — Step 3: Polling status dari halaman Login
   */
  async checkQRStatus(token) {
    const session = await prisma.qrsession.findUnique({
      where: { token },
      include: { user: true },
    });

    if (!session) {
      throw Object.assign(new Error('Sesi tidak ditemukan.'), { statusCode: 404 });
    }

    if (session.status === 'verified' && session.userId) {
      // Generate JWT untuk user yang memverifikasi
      const { accessToken, refreshToken } = generateTokens(session.userId, session.user.role);
      
      // Update sesi jadi 'completed' daripada langsung dihapus
      // Ini memberi kesempatan polling lain (jika ada) untuk tetap sukses sebentar
      await prisma.qrsession.update({ 
        where: { token },
        data: { status: 'completed' }
      });

      return {
        status: 'verified', // Tetap kirim 'verified' agar frontend tidak bingung
        user: session.user,
        token: accessToken,
        refreshToken,
      };
    }

    // Tambahan: Jika status di DB sudah 'completed', berarti polling sebelumnya sudah berhasil
    // Tapi kita tetap return data yang sama jika memungkinkan (tapi tokens biasanya dinamis)
    // Untuk simplisitas, jika sudah completed tapi dipanggil lagi, anggap verified
    if (session.status === 'completed') {
       // Catatan: Ini jarang terjadi karena polling distop di FE setelah sukses
       return { status: 'verified' }; 
    }

    // Cek kadaluarsa manual jika status masih pending
    if (session.status === 'pending' && new Date() > session.expiresAt) {
      return { status: 'expired' };
    }

    return { status: session.status };
  },

  /**
   * INSTANT LOGIN — Step 1: Generate pre-verified QR (Magic Link)
   */
  async generateInstantQR(userId) {
    const token = uuidv4();
    const expiresAt = new Date(Date.now() + 15 * 60 * 1000); // 15 menit (lebih aman)

    // Simpan ke DB dengan status 'verified' langsung
    await prisma.qrsession.create({
      data: {
        token,
        userId,
        status: 'verified',
        expiresAt,
      },
    });

    // Generate URL untuk QR (misal ke route khusus di frontend)
    // URL ini akan ditangani oleh Mobile/Browser lain
    // Generate URL untuk Magic Login (PDF & Mobile Support)
    const frontendUrl = process.env.CORS_ORIGIN || 'http://localhost:5173';
    const magicUrl = `${frontendUrl}/login/magic/${token}`;

    // Generate QR Image (Base64)
    const qrDataUrl = await QRCode.toDataURL(magicUrl);

    return { token, qrImage: qrDataUrl, magicUrl, expiresAt };
  },

  /**
   * INSTANT LOGIN — Step 2: Verify Magic Link and Return Tokens
   */
  async verifyMagicToken(token) {
    const session = await prisma.qrsession.findUnique({
      where: { token },
      include: { user: true },
    });

    if (!session || session.status !== 'verified' || !session.userId) {
      throw Object.assign(new Error('Magic link tidak valid atau sudah digunakan.'), { statusCode: 400 });
    }

    if (new Date() > session.expiresAt) {
      await prisma.qrsession.delete({ where: { token } });
      throw Object.assign(new Error('Magic link sudah kadaluarsa.'), { statusCode: 400 });
    }

    // Generate JWT untuk user tersebut
    const { accessToken, refreshToken } = generateTokens(session.userId, session.user.role);
    
    // Hapus sesi agar tidak bisa dipakai ulang
    await prisma.qrsession.delete({ where: { token } });

    return {
      user: session.user,
      token: accessToken,
      refreshToken,
    };
  },

  /**
   * FORGOT PASSWORD — Generate reset token and send email
   */
  async forgotPassword(email) {
    const user = await authRepository.findByEmail(email);
    if (!user) {
      throw Object.assign(new Error('Email tidak terdaftar.'), { statusCode: 404 });
    }

    // Generate token
    const resetToken = crypto.randomBytes(32).toString('hex');
    const resetPasswordExpires = new Date(Date.now() + 15 * 60 * 1000); // 15 menit

    // Simpan ke DB
    await prisma.user.update({
      where: { id: user.id },
      data: {
        resetPasswordToken: resetToken,
        resetPasswordExpires,
      },
    });

    // Kirim email (Simulasi Console)
    await sendResetPasswordEmail(user.email, resetToken);

    return { success: true, message: 'Link reset password telah dikirim ke email.' };
  },

  /**
   * RESET PASSWORD — Verify token and update password
   */
  async resetPassword(token, newPassword) {
    const user = await prisma.user.findUnique({
      where: {
        resetPasswordToken: token,
      },
    });

    if (!user || !user.resetPasswordExpires || new Date() > user.resetPasswordExpires) {
      throw Object.assign(new Error('Token tidak valid atau sudah kadaluarsa.'), { statusCode: 400 });
    }

    // Hash password baru
    const passwordHash = await hashPassword(newPassword);

    // Update user & hapus token
    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordHash,
        resetPasswordToken: null,
        resetPasswordExpires: null,
      },
    });

    return { success: true, message: 'Password berhasil direset. Silakan login.' };
  },
};


export default authService;
