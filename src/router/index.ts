import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  { path: '/', redirect: '/login' },
  {
    path: '/login',
    component: () => import('@/views/login.vue'),
  },
  {
    path: '/home',
    component: () => import('@/views/home.vue'),
    redirect: '/home/user',
    children: [
      {
        path: 'user',
        component: () => import('@/views/user.vue'),
      },
      {
        path: 'bankAccount',
        component: () => import('@/views/bankAccount.vue'),
      },
      {
        path: 'investment',
        component: () => import('@/views/investment.vue'),
      },
      {
        path: 'dept',
        component: () => import('@/views/dept.vue'),
      },
      {
        path: 'income',
        component: () => import('@/views/income.vue'),
      },
      {
        path: 'expenditure',
        component: () => import('@/views/expenditure.vue'),
      },
      {
        path: 'monthlyStatistics',
        component: () => import('@/views/monthlyStatistics.vue'),
      },
      {
        path: 'yearStatistics',
        component: () => import('@/views/yearStatistics.vue'),
      },
    ],
  },
]

//! 工厂函数创建router实例
const router = createRouter({
  history: createWebHistory(),
  routes,
})
//! 路由导航守卫
router.beforeEach((to, from, next) => {
  const islogin = window.sessionStorage.getItem('token') ? true : false
  if (to.path == '/login') {
    next()
  } else {
    islogin ? next() : next('/')
  }
})

export default router
