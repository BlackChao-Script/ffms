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
