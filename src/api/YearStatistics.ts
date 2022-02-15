import { request } from '@/utils/request'

export const listYearStatistics = (id: string) => {
  return request({
    url: '/ffms/yearStatistics/listYearStatistics',
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
    url: '/ffms/yearStatistics/statisticsData',
  })
}
