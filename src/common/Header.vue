<script setup lang='ts'>
import {
  Fold,
  Expand,
  FullScreen,
} from '@element-plus/icons-vue'
import { useStore } from '@/store'
import { useRoute, useRouter } from 'vue-router'
import screenfull from 'screenfull'
import { onMounted, ref, watch } from 'vue-demi'

const store = useStore()
const router = useRouter()
const route = useRoute()
const username = ref<String | any>('')
const breadcrumbList = ref<Array<any> | any>([])

const nextLogin = () => {
  router.push('/')
  location.reload()
  window.sessionStorage.removeItem('token')
  window.sessionStorage.removeItem('path')
}
const clickFull = () => {
  if (screenfull.isEnabled) {
    screenfull.toggle()
  }
}
const initBreadcrumbList = () => {
  breadcrumbList.value = route.matched[1].path.replace('/home/', '')
}

watch(route, () => {
  initBreadcrumbList()
}, { deep: true, immediate: true })

onMounted(() => {
  username.value = window.sessionStorage.getItem('username')
})
</script>

<template>
  <div class="header">
    <div class="header_button" @click="store.changAsideOpen()">
      <div v-if="store.asideOpen">
        <el-icon>
          <fold />
        </el-icon>
      </div>
      <div v-else>
        <el-icon>
          <expand />
        </el-icon>
      </div>
    </div>

    <div class="header_tag">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>home</el-breadcrumb-item>
        <el-breadcrumb-item>{{ breadcrumbList }}</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="header_utils">
      <div class="utils_full">
        <el-icon @click="clickFull">
          <full-screen />
        </el-icon>
      </div>
      <div class="utils_user">
        <div class="user_img">
          <el-dropdown>
            <img src="@/assets/img/userIcon.gif" />
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item disabled>{{ username }}</el-dropdown-item>
                <el-dropdown-item divided @click="nextLogin">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="less">
.header {
  line-height: 60px;
  display: flex;
  .header_button {
    width: 5%;
    .fja();
    div {
      .fja();
      .el-icon {
        cursor: pointer;
        font-size: 25px;
      }
    }
  }
  .header_tag {
    width: 80%;
    display: flex;
    align-items: center;
  }
  .header_utils {
    width: 15%;
    display: flex;
    justify-content: end;
    text-align: center;
    align-items: center;
    .utils_full {
      width: 30%;
      font-size: 25px;
      .el-icon {
        cursor: pointer;
      }
    }
    .utils_user {
      cursor: pointer;
      .fja();
      .user_img {
        width: 60%;
        .fja();
        img {
          border-radius: 10%;
          width: 100%;
        }
      }
    }
  }
}
</style>
