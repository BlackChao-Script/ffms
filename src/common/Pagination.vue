<script setup lang='ts'>


const { pageData = {}, } = defineProps({
  pageData: Object,
})
const em = defineEmits(['getData'])
const PageGetUserData = () => em('getData')
const handleSizeChange = (val: number) => {
  pageData.pageSize = val
  PageGetUserData()
}
const handleCurrentChange = (val: number) => {
  pageData.pageNum = val
  PageGetUserData()
}
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
