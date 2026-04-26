# ⚙️ FinTask Backend — Modular API Service

Ini adalah inti dari sistem FinTask, dibangun dengan arsitektur **Modular Monolith** menggunakan Express.js 5 dan Prisma ORM untuk memastikan performa yang cepat dan skalabilitas yang mudah.

## 🛠️ Tech Stack
*   **Runtime**: Node.js (ES Modules)
*   **Framework**: Express.js 5.x
*   **ORM**: Prisma v5.x
*   **Database**: MySQL / MariaDB
*   **Security**: JWT, BcryptJS, Helmet, Express-Rate-Limit
*   **Validation**: Zod
*   **Reporting**: ExcelJS, PDFKit
*   **Utility**: Date-fns, Winston (Logging), QRCode

## 📁 Struktur Folder
*   `src/app.js`: Inisialisasi Express & Middleware.
*   `src/modules/`: Logika bisnis per fitur (Auth, Task, Finance, dll).
*   `src/middleware/`: Middleware kustom (Auth Guard, Error Handler).
*   `src/config/`: Konfigurasi database dan environment.
*   `src/shared/`: Utilitas yang digunakan bersama di berbagai modul.

## 🚀 Instalasi & Setup
1. Instal dependensi: `npm install`
2. Atur file `.env` (DATABASE_URL, JWT_SECRET, dll).
3. Sinkronisasi Database: `npx prisma db push`
4. Jalankan server: `npm run dev`

## 🔑 Autentikasi
API ini mendukung tiga metode akses:
1. **Standard**: Email/Username + Password.
2. **Magic Link**: Login instan via token unik satu kali pakai.
3. **QR Login**: Sinkronisasi login antar perangkat (Mobile to Web).

---
*FinTask Backend - Empowering Productivity.*
