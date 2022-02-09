<script setup lang='ts'>
import {
  Stopwatch,
  Folder,
  Document,
  DocumentChecked,
} from '@element-plus/icons-vue'
import { useStore } from '@/store'

const store = useStore()
</script>

<template>
  <el-aside :width="store.asideOpen ? '200px' : '64px'">
    <div class="aside_heard">
      <div class="heard_img">
        <img src="@/assets/img/uugai.com-s4703-16441376109131.png" />
      </div>
      <div class="heard_title" v-if="store.asideOpen">ffms_admin</div>
    </div>
    <el-menu
      :collapse="!store.asideOpen"
      :collapse-transition="false"
      active-text-color="#fff5eb"
      background-color="#d3e4cd"
      class="el-menu-vertical-demo"
      text-color="#fff"
      :router="true"
    >
      <!-- 仪表盘 -->
      <el-menu-item index="/home/systemIntroduction">
        <el-icon>
          <stopwatch />
        </el-icon>
        <span>首页</span>
      </el-menu-item>
      <!-- 博文 -->
      <el-sub-menu index="2">
        <template #title>
          <el-icon>
            <folder />
          </el-icon>
          <span>博文</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="/home/blogadmin">
            <template #title>
              <el-icon>
                <document />
              </el-icon>
              <span>博文文件管理</span>
            </template>
          </el-menu-item>
          <el-menu-item index="/home/blogadmindet">
            <template #title>
              <el-icon>
                <document-checked />
              </el-icon>
              <span>博文详细管理</span>
            </template>
          </el-menu-item>
        </el-menu-item-group>
      </el-sub-menu>
    </el-menu>
  </el-aside>
</template>

<style scoped lang="less">
.el-aside {
  height: 100vh;
  background-color: @primary;
  .el-menu {
    height: 100%;
    border-right: 0 !important;
  }
  .aside_heard {
    display: flex;
    align-items: center;
    color: @fc;
    .heard_img {
      width: 65px;
      height: 55px;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .heard_title {
      font-size: 17px;
      font-weight: 600;
    }
  }
}
</style>
