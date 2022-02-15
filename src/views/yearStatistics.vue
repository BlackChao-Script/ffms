<script setup lang='ts'>
import { onMounted, ref } from 'vue-demi'
import echarts from '@/utils/echarts'
import { listYearStatistics, statisticsData } from '@/api/YearStatistics'

const xAxisData = ref<Array<any>>([])
const yearExpensesData = ref<Array<any>>([])
const yearIncomeData = ref<Array<any>>([])
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

const getListYearStatistics = async () => {
  const res = await listYearStatistics(id.value)
  res.data.data.forEach((data: any) => {
    xAxisData.value.push(data.note + '年')
    yearExpensesData.value.push(data.yearExpenses)
    yearIncomeData.value.push(data.yearIncome)
  })
  chartsInit.setOption({
    xAxis: {
      data: xAxisData.value
    },
    series: [
      {
        name: '收入',
        type: 'bar',
        data: yearIncomeData.value,
        label: {
          show: true,
          position: 'top'
        }
      },
      {
        name: '支出',
        type: 'bar',
        data: yearExpensesData.value,
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

