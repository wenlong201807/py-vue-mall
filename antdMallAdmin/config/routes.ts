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
    // 校级看板
    path: '/SchoolBase',
    name: 'adminSchoolBase',
    icon: 'crown',
    access: 'canAdmin',
    routes: [
      {
        path: '/SchoolBase/ClassRoom',
        name: 'ClassRoom',
        icon: 'smile',
        component: './SchoolBase/ClassRoom/ClassRoom',
      },
      {
        path: '/SchoolBase/Teacher',
        name: 'Teacher',
        icon: 'smile',
        component: './SchoolBase/Teacher/Teacher',
      },
      {
        path: '/SchoolBase/Student/list',
        name: 'StuList',
        icon: 'smile',
        component: './SchoolBase/Student/Student',
      },
      {
        path: '/SchoolBase/Student/detail',
        name: 'StuDetail',
        icon: 'smile',
        component: './SchoolBase/Student/StuDetail',
      },
      {
        component: './404',
      },
    ],
  },
  {
    // 学生看板
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
