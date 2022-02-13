export interface LoginDataType<T = any> {
  loginUser: object | T
  rules: object | T
}
export interface RegisterDateType<T = any> {
  registerUser: object | T
  registerRules: object | T
}
export interface PageDataType {
  pageNum: number
  pageSize: number
  total: number
}
export interface UserDataFormRulesType {
  name: Array<object>
  password: Array<object>
}
export interface bankAccountDataFormType {
  uid: string
  note: string
  name: string
  password: string
  cardNumber: string
  cardType: string
  accountOpeningTime: string
  accountOpeningAddress: string
  balance: string
}
export interface addInvestmentDataFormType {
  uid: string
  aid: string
  name: string
  investmentTime: string
  type: string
  amount: string
  interestRate: string
}
