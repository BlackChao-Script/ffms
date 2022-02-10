import { request } from '@/utils/request'

//! 获取菜单数据
export const getMenuData = () => {
  return request({
    url: '/ffms/user/menu',
  })
}
