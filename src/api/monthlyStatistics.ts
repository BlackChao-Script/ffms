import { request } from '@/utils/request'

export const listMonthlyStatistics = (id: string) => {
  return request({
    url: '/ffms/monthlyStatistics/listMonthlyStatistics',
    params: {
      id,
      pageNum: '1',
      pageSize: '1',
    },
  })
}
export const statisticsData = () => {
  return request({
    method: 'put',
    url: '/ffms/monthlyStatistics/statisticsData',
  })
}
