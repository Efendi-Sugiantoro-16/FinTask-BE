import nodemailer from 'nodemailer';
import logger from '../../middleware/logger.middleware.js';

/**
 * Konfigurasi Transporter Nodemailer
 */
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'smtp.gmail.com',
  port: process.env.SMTP_PORT || 465,
  secure: process.env.SMTP_PORT == 465, // true for 465, false for other ports
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS,
  },
});

/**
 * Fungsi Pengiriman Email Reset Password
 */
export const sendResetPasswordEmail = async (email, resetToken) => {
  const resetLink = `${process.env.CORS_ORIGIN || 'http://localhost:5173'}/reset-password/${resetToken}`;
  
  // HTML Template yang seksi dan responsif
  const htmlContent = `
    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; background-color: #f9fafb; padding: 20px; border-radius: 10px;">
      <div style="text-align: center; margin-bottom: 20px;">
        <h2 style="color: #4f46e5; margin: 0;">FinTask</h2>
        <p style="color: #6b7280; font-size: 14px; margin-top: 5px;">Manajemen Produktivitas & Keuangan</p>
      </div>
      <div style="background-color: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
        <h3 style="color: #111827; margin-top: 0;">Permintaan Reset Password</h3>
        <p style="color: #4b5563; line-height: 1.6;">
          Halo sayang,<br><br>
          Kami menerima permintaan untuk mereset password akunmu di FinTask. Jika ini memang perbuatanmu, klik tombol rahasia di bawah ini untuk membuat password baru:
        </p>
        <div style="text-align: center; margin: 30px 0;">
          <a href="${resetLink}" style="background-color: #4f46e5; color: white; padding: 12px 24px; text-decoration: none; border-radius: 8px; font-weight: bold; display: inline-block;">Reset Password Sekarang</a>
        </div>
        <p style="color: #ef4444; font-size: 13px; text-align: center; margin-bottom: 0;">
          Tautan ini hanya bertahan selama 15 menit. Cepatlah... 💋
        </p>
        <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 20px 0;">
        <p style="color: #9ca3af; font-size: 12px; text-align: center;">
          Jika kamu tidak pernah meminta reset password, abaikan saja email ini. Akunmu tetap aman dalam genggamanku.
        </p>
      </div>
    </div>
  `;

  // Cek apakah SMTP credentials sudah diisi dengan benar, bukan template
  if (!process.env.SMTP_USER || process.env.SMTP_USER === 'email.kamu@gmail.com') {
    logger.warn('⚠️ SMTP belum dikonfigurasi di .env! Email batal dikirim.');
    logger.info(`[SIMULASI LINK RESET]: ${resetLink}`);
    return true; // Berpura-pura sukses untuk mode development agar tidak crash
  }

  try {
    const info = await transporter.sendMail({
      from: process.env.EMAIL_FROM || '"Tim FinTask" <noreply@fintask.com>',
      to: email,
      subject: 'Permintaan Reset Password - FinTask 🗝️',
      html: htmlContent,
    });
    
    logger.info(`💌 Email terkirim: ${info.messageId}`);
    return true;
  } catch (error) {
    logger.error(`❌ Gagal mengirim email: ${error.message}`);
    // Melempar error ke controller agar frontend tahu gagal kirim
    throw Object.assign(new Error('Gagal mengirim email reset password. Periksa konfigurasi SMTP atau App Password Anda.'), { statusCode: 500 });
  }
};
