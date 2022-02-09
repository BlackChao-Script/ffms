<script setup lang='ts'>
import Aside from '@/common/Aside.vue'
import Header from '@/common/Header.vue'

</script>
<template>
  <el-container>
    <!-- 侧边栏 -->
    <Aside></Aside>
    <el-container>
      <!-- 头部 -->
      <el-header>
        <Header></Header>
      </el-header>
      <!-- 主题 -->
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>
