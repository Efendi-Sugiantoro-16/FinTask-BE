/**
 * XP Rewards per aksi — digunakan oleh gamifikasi service
 */
export const XP_REWARDS = {
  TASK_COMPLETE_LOW: 10,
  TASK_COMPLETE_MEDIUM: 20,
  TASK_COMPLETE_HIGH: 35,
  TASK_COMPLETE_URGENT: 50,
  TASK_DAILY_BONUS: 15,
  TASK_WEEKLY_BONUS: 30,
  POMODORO_COMPLETE: 15,
  LOGIN_STREAK: 5,
  FIRST_TRANSACTION: 5,
  BADGE_UNLOCK: 25,
};

/**
 * Level thresholds
 */
export const LEVELS = [
  { level: 1, minXP: 0, name: 'Pemula' },
  { level: 2, minXP: 100, name: 'Pelajar' },
  { level: 3, minXP: 300, name: 'Terampil' },
  { level: 4, minXP: 600, name: 'Mahir' },
  { level: 5, minXP: 1000, name: 'Ahli' },
  { level: 6, minXP: 1500, name: 'Master' },
  { level: 7, minXP: 2200, name: 'Grandmaster' },
  { level: 8, minXP: 3000, name: 'Legend' },
  { level: 9, minXP: 4000, name: 'Mythic' },
  { level: 10, minXP: 5500, name: 'Supreme' },
];

/**
 * Get level dari total XP
 */
export const getLevelFromXP = (totalXP) => {
  let currentLevel = LEVELS[0];
  for (const level of LEVELS) {
    if (totalXP >= level.minXP) {
      currentLevel = level;
    } else {
      break;
    }
  }
  return currentLevel;
};

/**
 * Get XP reward berdasarkan task priority
 */
export const getTaskXPReward = (priority) => {
  const rewards = {
    low: XP_REWARDS.TASK_COMPLETE_LOW,
    medium: XP_REWARDS.TASK_COMPLETE_MEDIUM,
    high: XP_REWARDS.TASK_COMPLETE_HIGH,
    urgent: XP_REWARDS.TASK_COMPLETE_URGENT,
  };
  return rewards[priority] || XP_REWARDS.TASK_COMPLETE_MEDIUM;
};
