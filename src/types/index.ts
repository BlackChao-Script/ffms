export interface LoginDataType<T = any> {
  loginUser: object | T
  rules: object | T
}
export interface RegisterDateType<T = any> {
  registerUser: object | T
  registerRules: object | T
}
export interface PageDataType {
  pageNum: Number
  pageSize: Number
  total: Number
}
export interface UserDataFormRulesType {
  name: Array<object>
  password: Array<object>
}
export interface bankAccountDataFormType<T = any> {
  uid: String | T
  note: String | T
  name: string | T
  password: String | T
  cardNumber: String | T
  cardType: String | T
  accountOpeningTime: String | T
  accountOpeningAddress: String | T
  balance: String | T
}
