import { formatRequest } from '@/utils/index';

export const clssCRUDApi = (method = 'get', data = {}) => {
  return formatRequest({ method, url: '/student/clsslist', data });
};

export const clssBatchAddApi = (method = 'post', data = {}) => {
  return formatRequest({ method, url: '/student/batchAddClss', data });
};
