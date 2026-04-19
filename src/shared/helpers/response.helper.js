/**
 * Standardized API Response Helpers
 */

/**
 * Kirim response sukses
 */
export const sendSuccess = (res, statusCode = 200, message = 'Berhasil', data = null, meta = null) => {
  const response = {
    success: true,
    message,
  };

  if (data !== null) response.data = data;
  if (meta !== null) response.meta = meta;

  return res.status(statusCode).json(response);
};

/**
 * Kirim response error
 */
export const sendError = (res, statusCode = 500, message = 'Terjadi kesalahan', errors = null) => {
  const response = {
    success: false,
    message,
  };

  if (errors !== null) response.errors = errors;

  return res.status(statusCode).json(response);
};

/**
 * Kirim response dengan pagination
 */
export const sendPaginated = (res, message, data, pagination, resourceName = 'data') => {
  return res.status(200).json({
    success: true,
    message,
    data: {
      [resourceName]: data,
      pagination: {
        page: pagination.page,
        limit: pagination.limit,
        totalItems: pagination.totalItems,
        totalPages: Math.ceil(pagination.totalItems / pagination.limit),
      },
    },
  });
};
