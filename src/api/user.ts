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
export const userRegister = (name: String, password: String, type: String) => {
  return request({
    method: 'post',
    url: '/ffms/user/register',
    data: {
      name,
      password,
      type,
    },
  })
}

//! 根据家庭成员id展示家庭成员
export const findUserById = (id: string) => {
  return request({
    url: 'ffms/user/findUserById',
    params: {
      id,
    },
  })
}
