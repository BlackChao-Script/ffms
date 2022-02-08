import { request } from '@/utils/request'

//! 登录
export const userLogin = (name: String, password: String) => {
  return request({
    method: 'post',
    url: '/ffms/user/login',
    data: {
      name,
      password,
    },
  })
}
//! 注册
export const userRegister = (name: String, password: String) => {
  return request({
    method: 'post',
    url: '/ffms/user/register',
    data: {
      name,
      password,
    },
  })
}
