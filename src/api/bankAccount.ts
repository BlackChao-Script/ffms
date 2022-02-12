import { request } from '@/utils/request'

//! 根据家庭成员id查找银行账户
export const findListBankAccount = (
  id: string,
  pageNum: string,
  pageSize: string
) => {
  return request({
    url: '/ffms/bankAccount/listBankAccount',
    params: {
      id,
      pageNum,
      pageSize,
    },
  })
}
//! 添加银行账户
export const addBankAccount = (
  uid: string,
  note: string,
  name: string,
  password: string,
  cardNumber: string,
  cardType: string,
  accountOpeningTime: string,
  accountOpeningAddress: string,
  balance: string
) => {
  return request({
    method: 'post',
    url: '/ffms/bankAccount/addBankAccount',
    data: {
      uid,
      note,
      name,
      password,
      cardNumber,
      cardType,
      accountOpeningTime,
      accountOpeningAddress,
      balance,
    },
  })
}
//! 更新银行账户
export const updateBankAccount = (
  id: string,
  uid: string,
  note: string,
  name: string,
  password: string,
  cardNumber: string,
  cardType: string,
  accountOpeningTime: string,
  accountOpeningAddress: string,
  balance: string
) => {
  return request({
    method: 'put',
    url: `/ffms/bankAccount/updateBankAccount/${id}`,
    data: {
      uid,
      note,
      name,
      password,
      cardNumber,
      cardType,
      accountOpeningTime,
      accountOpeningAddress,
      balance,
    },
  })
}
//! 删除银行账户
export const deleteBankAccount = (id: string) => {
  return request({
    method: 'delete',
    url: `/ffms/bankAccount/deleteBankAccount/${id}`,
  })
}
