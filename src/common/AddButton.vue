<script setup lang='ts'>

const em = defineEmits(['clickAddButton'])
const clickAddButton = () => em('clickAddButton')


</script>

<template>
  <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加银行账户</el-button>
</template>

<style scoped lang="less">
</style>
