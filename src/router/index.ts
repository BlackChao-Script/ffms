import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  { path: '/', redirect: '/login' },
  {
    path: '/login',
    component: () => import('@/views/login.vue'),
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
