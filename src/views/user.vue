<script setup lang='ts'>
import { findUserById } from '@/api/user'
import { onMounted } from 'vue-demi';

const findUser = async () => {
  const res = await findUserById('1')
  console.log(res)
}

onMounted(() => {
  findUser()
})
</script>

<template>user</template>

<style scoped lang="less">
</style>
