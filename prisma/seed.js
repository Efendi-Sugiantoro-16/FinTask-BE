import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

const badges = [
  {
    name: 'Task Master',
    code: 'task_master',
    description: 'Selesaikan 100 task',
    iconUrl: '📋',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'task_complete', count: 100 }),
    xpReward: 100,
  },
  {
    name: 'Productive Starter',
    code: 'productive_starter',
    description: 'Selesaikan tugas pertama Anda',
    iconUrl: '🌟',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'task_complete', count: 1 }),
    xpReward: 25,
  },
  {
    name: 'Focus Warrior',
    code: 'focus_warrior',
    description: 'Selesaikan 50 sesi Pomodoro',
    iconUrl: '🍅',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'pomodoro_complete', count: 50 }),
    xpReward: 75,
  },
  {
    name: 'Zen Initiate',
    code: 'zen_initiate',
    description: 'Selesaikan sesi fokus pertama Anda',
    iconUrl: '🧘',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'pomodoro_complete', count: 1 }),
    xpReward: 25,
  },
  {
    name: 'Wealthy Mind',
    code: 'wealthy_mind',
    description: 'Catat transaksi pemasukan pertama Anda',
    iconUrl: '💰',
    category: 'finance',
    requirement: JSON.stringify({ type: 'income_added', count: 1 }),
    xpReward: 25,
  },
  {
    name: 'On Fire',
    code: 'streak_3',
    description: 'Login 3 hari berturut-turut',
    iconUrl: '🔥',
    category: 'streak',
    requirement: JSON.stringify({ type: 'login_streak', count: 3 }),
    xpReward: 50,
  },
  {
    name: 'Marathon',
    code: 'marathon',
    description: 'Login 30 hari berturut-turut',
    iconUrl: '🏃',
    category: 'streak',
    requirement: JSON.stringify({ type: 'login_streak', count: 30 }),
    xpReward: 100,
  },
  {
    name: 'Speed Demon',
    code: 'speed_demon',
    description: 'Selesaikan 5 task dalam 1 hari',
    iconUrl: '⚡',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'daily_task', count: 5 }),
    xpReward: 50,
  },
  {
    name: 'Time Lord',
    code: 'time_lord',
    description: 'Buat 50 calendar events',
    iconUrl: '📅',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'calendar_events', count: 50 }),
    xpReward: 50,
  },
  {
    name: 'Goal Getter',
    code: 'goal_getter',
    description: 'Selesaikan semua weekly task dalam 1 minggu',
    iconUrl: '🎯',
    category: 'productivity',
    requirement: JSON.stringify({ type: 'weekly_complete', count: 1 }),
    xpReward: 75,
  },
];

async function main() {
  console.log('🌱 Seeding database...\n');

  // --- Seed Test User ---
  const testUserEmail = 'test@fintask.com';
  const existingUser = await prisma.user.findUnique({
    where: { email: testUserEmail },
  });

  if (!existingUser) {
    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash('password123', salt);

    await prisma.user.create({
      data: {
        email: testUserEmail,
        username: 'fintask_tester',
        passwordHash,
        fullName: 'FinTask Tester',
        level: 5,
        totalXP: 2450,
        loginStreak: 12,
      },
    });
    console.log('  ✅ User: test@fintask.com created (password: password123)');
  } else {
    console.log('  ⏭️  User test@fintask.com sudah ada');
  }

  // --- Seed Admin User ---
  const adminEmail = 'admin@fintask.com';
  const existingAdmin = await prisma.user.findUnique({ where: { email: adminEmail } });
  if (!existingAdmin) {
    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash('admin123', salt);
    await prisma.user.create({
      data: {
        email: adminEmail,
        username: 'admin',
        passwordHash,
        fullName: 'Administrator',
        role: 'ADMIN',
        level: 99,
        totalXP: 9999,
      },
    });
    console.log('  ✅ Admin: admin@fintask.com created (password: admin123)');
  } else {
    console.log('  ⏭️  Admin admin@fintask.com sudah ada');
  }

  // --- Seed Super Admin User ---
  const superAdminEmail = 'superadmin@fintask.com';
  const existingSuperAdmin = await prisma.user.findUnique({ where: { email: superAdminEmail } });
  if (!existingSuperAdmin) {
    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash('superadmin123', salt);
    await prisma.user.create({
      data: {
        email: superAdminEmail,
        username: 'superadmin',
        passwordHash,
        fullName: 'Super Administrator',
        role: 'SUPERADMIN',
        level: 999,
        totalXP: 99999,
      },
    });
    console.log('  ✅ Super Admin: superadmin@fintask.com created (password: superadmin123)');
  } else {
    console.log('  ⏭️  Super Admin superadmin@fintask.com sudah ada');
  }

  // --- Seed Badges ---
  for (const badge of badges) {
    const existing = await prisma.badge.findUnique({
      where: { name: badge.name },
    });

    if (!existing) {
      await prisma.badge.create({ data: badge });
      console.log(`  ✅ Badge: ${badge.iconUrl} ${badge.name}`);
    } else {
      console.log(`  ⏭️  Badge sudah ada: ${badge.name}`);
    }
  }

  console.log('\n🎉 Seeding selesai!');
}

main()
  .catch((e) => {
    console.error('❌ Seeding error:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
