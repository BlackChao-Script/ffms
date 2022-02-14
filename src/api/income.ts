import { request } from '@/utils/request'

//! 展示当前家庭成员的收入信息
export const getListIncome = (
  id: string,
  pageNum: string,
  pageSize: string
) => {
  return request({
    url: '/ffms/income/listIncome',
    params: {
      id,
      pageNum,
      pageSize,
    },
  })
}
//! 添加收入信息
export const addIncome = (
  uid: string,
  aid: string,
  amount: string,
  address: string,
  transactionOrganization: string,
  transactionHour: string,
  transactionNumber: string,
  merchantNumber: string,
  type: string,
  commodity: string
) => {
  return request({
    method: 'post',
    url: '/ffms/income/addIncome',
    data: {
      uid,
      aid,
      amount,
      address,
      transactionOrganization,
      transactionHour,
      transactionNumber,
      merchantNumber,
      type,
      commodity,
    },
  })
}
//! 更新收入信息
export const updateIncome = (
  id: string,
  uid: string,
  aid: string,
  amount: string,
  address: string,
  transactionOrganization: string,
  transactionHour: string,
  transactionNumber: string,
  merchantNumber: string,
  type: string,
  commodity: string
) => {
  return request({
    method: 'put',
    url: `/ffms/income/updateIncome/${id}`,
    data: {
      uid,
      aid,
      amount,
      address,
      transactionOrganization,
      transactionHour,
      transactionNumber,
      merchantNumber,
      type,
      commodity,
    },
  })
}
//! 删除收入信息
export const deleteIncome = (id: string) => {
  return request({
    method: 'delete',
    url: `/ffms/income/deleteIncome/${id}`,
  })
}
