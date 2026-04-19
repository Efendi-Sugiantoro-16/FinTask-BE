/**
 * Parse string date (YYYY-MM-DD atau DD-MM-YYYY [HH:mm]) ke Date object
 */
export const parseDate = (dateString) => {
  if (!dateString || typeof dateString !== 'string') {
    if (dateString instanceof Date) return dateString;
    return null;
  }

  // Cek format YYYY-MM-DD (ISO)
  if (/^\d{4}-\d{2}-\d{2}/.test(dateString)) {
    const d = new Date(dateString);
    return isNaN(d.getTime()) ? null : d;
  }

  // Cek format DD-MM-YYYY [HH:mm]
  const dmYMatch = dateString.match(/^(\d{1,2})-(\d{1,2})-(\d{4})(?:\s+(\d{1,2}):(\d{1,2}))?/);
  if (dmYMatch) {
    const [_, day, month, year, hour, minute] = dmYMatch;
    const d = new Date(
      parseInt(year), 
      parseInt(month) - 1, 
      parseInt(day), 
      hour ? parseInt(hour) : 0, 
      minute ? parseInt(minute) : 0
    );
    return isNaN(d.getTime()) ? null : d;
  }

  // Fallback to standard constructor
  const fallback = new Date(dateString);
  return isNaN(fallback.getTime()) ? null : fallback;
};

/**
 * Validasi apakah objek Date valid
 */
export const isValidDate = (date) => {
  return date instanceof Date && !isNaN(date.getTime());
};

/**
 * Format tanggal ke string readable (ISO)
 */
export const formatDate = (date) => {
  return new Date(date).toISOString();
};

/**
 * Format tanggal ke DD-MM-YYYY (Indonesian standard)
 */
export const formatToID = (date) => {
  if (!date) return '-';
  const d = new Date(date);
  const day = String(d.getDate()).padStart(2, '0');
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const year = d.getFullYear();
  return `${day}-${month}-${year}`;
};

/**
 * Cek apakah tanggal sudah expired
 */
export const isExpired = (date) => {
  return new Date(date) < new Date();
};


/**
 * Get start of day
 */
export const startOfDay = (date = new Date()) => {
  const d = new Date(date);
  d.setHours(0, 0, 0, 0);
  return d;
};

/**
 * Get end of day
 */
export const endOfDay = (date = new Date()) => {
  const d = new Date(date);
  d.setHours(23, 59, 59, 999);
  return d;
};

/**
 * Get start of week (Monday)
 */
export const startOfWeek = (date = new Date()) => {
  const d = new Date(date);
  const day = d.getDay();
  const diff = d.getDate() - day + (day === 0 ? -6 : 1);
  d.setDate(diff);
  d.setHours(0, 0, 0, 0);
  return d;
};

/**
 * Get start of month
 */
export const startOfMonth = (date = new Date()) => {
  const d = new Date(date);
  d.setDate(1);
  d.setHours(0, 0, 0, 0);
  return d;
};
