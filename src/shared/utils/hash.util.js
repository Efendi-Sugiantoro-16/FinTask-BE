import bcrypt from 'bcryptjs';

const SALT_ROUNDS = 12;

/**
 * Hash password
 */
export const hashPassword = async (password) => {
  return bcrypt.hash(password, SALT_ROUNDS);
};

/**
 * Compare password with hash
 */
export const comparePassword = async (password, hash) => {
  return bcrypt.compare(password, hash);
};
