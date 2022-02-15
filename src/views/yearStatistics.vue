<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi'
import echarts from '@/utils/echarts'
import { listYearStatistics } from '@/api/YearStatistics'

const YearStatisticsData = reactive<any>({
  yearExpensesData: '',
  yearIncomeData: ''
})
const id = ref<string | any>('')
const myChartref = ref<any>(null)
let chartsInit: any
//柱状图配置项
const barOption = {
  title: {
    text: '年统计'
  },
  legend: {
    data: ['收入', '支出']
  },
  xAxis: {
    data: ['今年']
  },
  yAxis: {},
  series: [
    {
      name: '收入',
      type: 'bar',
      data: [''],
      label: {
        show: true,
        position: 'top'
      }
    },
    {
      name: '支出',
      type: 'bar',
      data: [''],
      label: {
        show: true,
        position: 'top'
      }
    }
  ]
}
let option = barOption

const getListYearStatistics = async () => {
  const res = await listYearStatistics(id.value)
  YearStatisticsData.yearExpensesData = res.data.data[0].yearExpenses
  YearStatisticsData.yearIncomeData = res.data.data[0].yearIncome
  chartsInit.setOption({
    series: [
      {
        name: '收入',
        type: 'bar',
        data: [YearStatisticsData.yearIncomeData],
        label: {
          show: true,
          position: 'top'
        }
      },
      {
        name: '支出',
        type: 'bar',
        data: [YearStatisticsData.yearExpensesData],
        label: {
          show: true,
          position: 'top'
        }
      }
    ]
  })
}

onMounted(() => {
  chartsInit = echarts.init(myChartref.value)
  chartsInit.setOption(option, true)
  id.value = window.sessionStorage.getItem('uid')
  getListYearStatistics()
})
</script>

<template>
  <div id="charts_box" ref="myChartref"></div>
</template>

<style scoped lang="less">
#charts_box {
  height: 500px;
  width: 80%;
  margin-top: 100px;
  margin-left: 10%;
}
</style>

