import { request } from '@/utils/request'

//! 分页展示投资信息
export const getListInvestment = (
  id: string,
  pageNum: string,
  pageSize: string
) => {
  return request({
    url: '/ffms/investment/listInvestment',
    params: {
      id,
      pageNum,
      pageSize,
    },
  })
}
//! 添加投资信息
export const addInvestment = (
  uid: string,
  aid: string,
  name: string,
  investmentTime: string,
  type: string,
  amount: string,
  interestRate: string
) => {
  return request({
    method: 'post',
    url: '/ffms/investment/addInvestment',
    data: {
      uid,
      aid,
      name,
      investmentTime,
      type,
      amount,
      interestRate,
    },
  })
}
//! 更新投资信息
export const updateInvestment = (
  id: string,
  uid: string,
  aid: string,
  name: string,
  investmentTime: string,
  type: string,
  amount: string,
  interestRate: string
) => {
  return request({
    method: 'put',
    url: `/ffms/investment/updateInvestment/${id}`,
    data: {
      uid,
      aid,
      name,
      investmentTime,
      type,
      amount,
      interestRate,
    },
  })
}
//! 删除投资信息
export const deleteInvestment = (id: string) => {
  return request({
    method: 'delete',
    url: `/ffms/investment/deleteInvestment/${id}`,
  })
}
