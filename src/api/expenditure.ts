import { request } from '@/utils/request'

export const getlistExpenditure = (
  id: string,
  pageNum: string,
  pageSize: string
) => {
  return request({
    url: '/ffms/expenditure/listExpenditure',
    params: {
      id,
      pageNum,
      pageSize,
    },
  })
}
export const addExpenditure = (
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
    url: '/ffms/expenditure/addExpenditure',
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
export const updateExpenditure = (
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
    url: `/ffms/expenditure/updateExpenditure/${id}`,
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
export const deleteIncome = (id: string) => {
  return request({
    method: 'delete',
    url: `/ffms/expenditure/deleteExpenditure/${id}`,
  })
}
