export default [
  {
    // 登录页
    path: '/user',
    layout: false,
    routes: [
      {
        name: 'login',
        path: '/user/login',
        component: './user/Login',
      },
      {
        component: './404',
      },
    ],
  },
  {
    // 首页
    path: '/welcome',
    name: 'welcome',
    icon: 'smile',
    component: './Welcome',
  },
  {
    path: '/Student',
    name: 'adminStu',
    icon: 'crown',
    access: 'canAdmin',
    routes: [
      {
        path: '/Student/Clss',
        name: 'Clss',
        icon: 'smile',
        component: './Student/Clss/Clss',
      },
      {
        path: '/Student/Teacher',
        name: 'Teacher',
        icon: 'smile',
        component: './Student/Teacher/Teacher',
      },
      {
        path: '/Student/Student',
        name: 'Student',
        icon: 'smile',
        component: './Student/Student/Student',
      },
      {
        component: './404',
      },
    ],
  },
  {
    path: '/admin',
    name: 'admin',
    icon: 'crown',
    access: 'canAdmin',
    routes: [
      {
        path: '/admin/sub-page',
        name: 'sub-page',
        icon: 'smile',
        component: './Welcome',
      },
      {
        component: './404',
      },
    ],
  },
  {
    name: 'list.table-list',
    icon: 'table',
    path: '/list',
    component: './TableList',
  },
  {
    // 跟路径 重定向到 首页
    path: '/',
    redirect: '/welcome',
  },
  {
    component: './404',
  },
];
