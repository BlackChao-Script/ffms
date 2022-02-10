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
//! 展示家庭成员
export const getUserList = (pageNum: string, pageSize: string) => {
  return request({
    method: 'post',
    url: '/ffms/user/listUser',
    data: {
      pageNum,
      pageSize,
    },
  })
}
//! 注销家庭成员
export const cancelAccount = (id: string) => {
  return request({
    method: 'put',
    url: `/ffms/user/cancelAccount`,
    data: {
      id,
    },
  })
}
//! 更新家庭成员数据
export const update = (...arg: any) => {
  return request({
    method: 'put',
    url: `/ffms/user/update`,
    data: {
      ...arg,
    },
  })
}
