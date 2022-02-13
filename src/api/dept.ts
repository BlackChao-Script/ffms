import { request } from '@/utils/request'

//! 分页展示债务信息
export const getlistDept = (id: string, pageNum: string, pageSize: string) => {
  return request({
    url: '/ffms/dept/listDept',
    params: {
      id,
      pageNum,
      pageSize,
    },
  })
}
//! 添加债务信息
export const addListDept = (
  uid: string,
  aid: string,
  name: string,
  creditor: string,
  type: string,
  borrowingAmount: string,
  repaymentAmount: string,
  endAmount: string,
  borrowingTime: string,
  repaymentTime: string
) => {
  return request({
    method: 'post',
    url: '/ffms/dept/addDept',
    data: {
      uid,
      aid,
      name,
      creditor,
      type,
      borrowingAmount,
      repaymentAmount,
      endAmount,
      borrowingTime,
      repaymentTime,
    },
  })
}
//! 更新债务信息
export const updateListDept = (
  id: string,
  uid: string,
  aid: string,
  name: string,
  creditor: string,
  type: string,
  borrowingAmount: string,
  repaymentAmount: string,
  endAmount: string,
  borrowingTime: string,
  repaymentTime: string
) => {
  return request({
    method: 'put',
    url: `/ffms/dept/updateDept/${id}`,
    data: {
      uid,
      aid,
      name,
      creditor,
      type,
      borrowingAmount,
      repaymentAmount,
      endAmount,
      borrowingTime,
      repaymentTime,
    },
  })
}
//! 删除债务信息
export const deleteListDept = (id: string) => {
  return request({
    method: 'delete',
    url: `/ffms/dept/deleteDept/${id}`,
  })
}
