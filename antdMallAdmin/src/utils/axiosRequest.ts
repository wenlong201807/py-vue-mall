import axios from 'axios';
// import NProgress from 'nprogress'; // progress bar
// import 'nprogress/nprogress.css';
import { message } from 'antd';

// const pkgObj = JSON.parse(process.env.VUE_APP_BUILD || '') || {};

axios.defaults.baseURL = 'http://127.0.0.1:8000/api';

axios.defaults.timeout = 30000;
// 返回其他状态吗
axios.defaults.validateStatus = function (status) {
  return status >= 200 && status <= 500; // 默认的
};
// 跨域请求，允许保存cookie
axios.defaults.withCredentials = true;

// NProgress.configure({
//   showSpinner: false,
// });

// HTTPrequest拦截
axios.interceptors.request.use(
  (config: any) => {
    // NProgress.start(); // start progress bar

    // if (token && !isToken) {
    //   config.headers['Authorization'] = 'Bearer ' + token; // token
    // }
    // headers: {'X-CSRFToken': localStorage.getItem("token")},

    if (config.uploadPicHeaders) {
      config.headers = {
        ...config.headers,
        ...config.uploadPicHeaders,
        'X-CSRFToken': localStorage.getItem('token') || '',
      };
    }

    return config;
  },
  (error) => {
    return Promise.reject(error);
  },
);

// HTTPresponse拦截
axios.interceptors.response.use(
  (res: any) => {
    // NProgress.done();
    return res;
  },
  (error) => {
    console.log('error:', error);
    if (error.message === 'Network Error') {
      // 跨域
      message.error(`网络异常，请稍后再试`);
    }

    // 处理 503 网络异常
    // if (error.response.status === 503) {
    //   message.error(error.response.data.msg);
    // }
    // NProgress.done();
    return Promise.reject(new Error(error));
  },
);

export default axios;

/**
 * @description [课程管理，师训管理] 接口统一格式化处理接口数据
 * @params {String} method  请求方式
 * @params {String} url  请求地址
 * @params {Object} data  请求参数
 * @params {Object} headers  头部参数
 * @params {Object} option  其他备用参数
 */
export const formatRequest = async ({
  method = 'get',
  url = '',
  data = {},
  headers = {},
  option = {},
}) => {
  let r = await axios({
    url,
    method,
    [['get', 'delete'].includes(method) ? 'params' : 'data']: data,
    headers,
    ...option,
  });

  return r.data || {};
};
