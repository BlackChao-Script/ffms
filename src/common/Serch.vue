<script setup lang='ts'>
import { Search } from '@element-plus/icons-vue'
import { ref } from 'vue-demi';

const userId = ref<string>('')
const em = defineEmits(['clickSerch'])
const clickSerch = () => em('clickSerch', userId)

</script>

<template>
  <el-input v-model="userId" placeholder="请输入要查询的家庭成员id">
    <template #append>
      <el-button :icon="Search" @click="clickSerch"></el-button>
    </template>
  </el-input>
</template>

<style scoped lang="less">
</style>
