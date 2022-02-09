import axios from 'axios'

export function request(config: any) {
  const instance = axios.create({
    baseURL: '/api',
    timeout: 2 * 1000,
  })
  //! 请求拦截
  instance.interceptors.request.use(
    (config: any) => {
      config.data = JSON.stringify(config.data)
      //* 配置请求头
      config.headers = {
        'Content-Type': 'application/json;charSet=UTF-8',
        Authorization: window.sessionStorage.getItem('token'),
      }
      return config
    },
    (error) => {
      return Promise.reject(error)
    }
  )

  //! 响应拦截
  instance.interceptors.response.use(
    (response) => {
      if (response.status !== 200) {
        console.log('请求信息', response)
        return Promise.reject(new Error('Error'))
      } else {
        return response
      }
    },
    (error) => {
      console.log(`err${error}`)
      return Promise.reject(error)
    }
  )
  return instance(config)
}
