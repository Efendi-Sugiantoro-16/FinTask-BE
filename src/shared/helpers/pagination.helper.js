/**
 * Pagination helper — parse & validate pagination params
 */
export const parsePagination = (query) => {
  const page = Math.max(1, parseInt(query.page) || 1);
  const limit = Math.min(100, Math.max(1, parseInt(query.limit) || 10));
  const skip = (page - 1) * limit;

  return { page, limit, skip };
};

/**
 * Sort helper — parse sort params
 * @param {string} sortBy - field name
 * @param {string} sortOrder - 'asc' | 'desc'
 * @param {string[]} allowedFields - list of allowed sort fields
 */
export const parseSort = (sortBy, sortOrder, allowedFields) => {
  const field = allowedFields.includes(sortBy) ? sortBy : 'createdAt';
  const order = sortOrder === 'asc' ? 'asc' : 'desc';

  return { [field]: order };
};
