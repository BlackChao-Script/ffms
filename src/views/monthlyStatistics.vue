<script setup lang='ts'>
import { onMounted, ref } from 'vue-demi'
import echarts from '@/utils/echarts'
import { listMonthlyStatistics, statisticsData } from '@/api/monthlyStatistics'

const xAxisData = ref<Array<any>>([])
const monthlyExpensesData = ref<Array<any>>([])
const monthlyIncomeData = ref<Array<any>>([])
const id = ref<string | any>('')
const myChartref = ref<any>(null)
let chartsInit: any
//柱状图配置项
const barOption = {
  title: {
    text: '月统计'
  },
  legend: {
    data: ['收入', '支出']
  },
  xAxis: {
    data: []
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

const getListMonthlyStatistics = async () => {
  const res = await listMonthlyStatistics(id.value)
  res.data.data.forEach((data: any) => {
    xAxisData.value.push(data.note + '月')
    monthlyExpensesData.value.push(data.monthlyExpenses)
    monthlyIncomeData.value.push(data.monthlyIncome)
  })
  chartsInit.setOption({
    xAxis: {
      data: xAxisData.value
    },
    series: [
      {
        name: '收入',
        type: 'bar',
        data: monthlyIncomeData.value,
        label: {
          show: true,
          position: 'top'
        }
      },
      {
        name: '支出',
        type: 'bar',
        data: monthlyExpensesData.value,
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
  getListMonthlyStatistics()
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

