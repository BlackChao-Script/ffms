<script setup lang='ts'>
import { reactive } from 'vue-demi';
import { PageDataType } from '@/types'
// 分页器数据
const pageData = reactive<PageDataType>({
  pageNum: 1,
  pageSize: 5,
  total: 0
})
const em = defineEmits(['getData'])

const getData = () => em('getData')

const handleSizeChange = (val: number) => {
  pageData.pageSize = val
  getData()
}
const handleCurrentChange = (val: number) => {
  pageData.pageNum = val
  getData()
}

defineExpose({
  pageData
})
</script>

<template>
  <el-pagination
    :page-sizes="[3, 5, 10]"
    :page-size="pageData.pageSize"
    layout="sizes, prev, pager, next"
    :total="pageData.total"
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange"
  ></el-pagination>
</template>

<style scoped lang="less">
</style>
