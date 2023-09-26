import { formatRequest } from '@/utils/index';

export const loginApi = (data: any) => {
  formatRequest({ method: 'post', url: '/user/loginOrout', data });
};
export const logoutApi = () => {
  formatRequest({ method: 'delete', url: '/user/loginOrout' });
};
