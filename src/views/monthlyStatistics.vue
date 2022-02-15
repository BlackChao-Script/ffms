<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi'
import echarts from '@/utils/echarts'
import { listMonthlyStatistics } from '@/api/monthlyStatistics'

const monthlyData = reactive<any>({
  monthlyExpensesData: '',
  monthlyIncomeData: ''
})
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
    data: ['本月']
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
  monthlyData.monthlyExpensesData = res.data.data[0].monthlyExpenses
  monthlyData.monthlyIncomeData = res.data.data[0].monthlyIncome
  chartsInit.setOption({
    series: [
      {
        name: '收入',
        type: 'bar',
        data: [monthlyData.monthlyIncomeData],
        label: {
          show: true,
          position: 'top'
        }
      },
      {
        name: '支出',
        type: 'bar',
        data: [monthlyData.monthlyExpensesData],
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

