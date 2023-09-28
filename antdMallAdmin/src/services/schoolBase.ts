import { formatRequest } from '@/utils/index';

export const classRoomCRUDApi = (method = 'get', data = {}) => {
  return formatRequest({ method, url: '/student/schoolClassRoomlist', data });
};

export const teacherCRUDApi = (method = 'get', data = {}) => {
  return formatRequest({ method, url: '/student/schoolTeacherlist', data });
};

export const stuDetailCRUDApi = (method = 'get', data = {}) => {
  return formatRequest({ method, url: '/student/schoolStuDetaillist', data });
};

export const studentCRUDApi = (method = 'get', data = {}) => {
  return formatRequest({ method, url: '/student/schoolStudentlist', data });
};
