<script setup lang='ts'>
import { useStore } from '@/store'
import { getMenuData } from '@/api/menu'
import { onMounted, ref } from 'vue-demi'

const store = useStore()
const menuList = ref<Array<any>>([])
const menuListChildren = ref<Array<any>>([])
const menuListIcon = ref<Array<string>>(['user', 'setting', 'shop', 'tickets'])
const menuListChildrenIcon = ref<Array<string>>(['suitcase', 'goblet'])

const getMenu = async () => {
  const res = await getMenuData()
  for (const i of res.data) {
    if (i.children == null) {
      menuList.value.push(i)
    } else {
      menuListChildren.value.push(i)
    }
  }
  menuListChildren.value[1].authName = menuListChildren.value[1].authName.replace('年', '')
}
const saveNavState = (path: string) => {
  window.sessionStorage.setItem('path', path)
}

store.changPath()

onMounted(() => {
  getMenu()
})
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
      active-text-color="#99a799"
      background-color="#d3e4cd"
      class="el-menu-vertical-demo"
      text-color="#fff"
      :router="true"
      :default-active="store.path"
      :default-openeds="['103', '104']"
    >
      <el-menu-item
        :index="'/home' + item.path"
        v-for="(item,index) in menuList"
        :key="item.id"
        @click="saveNavState('/home' + item.path)"
      >
        <el-icon>
          <component :is="menuListIcon[index]"></component>
        </el-icon>
        <span>{{ item.authName }}</span>
      </el-menu-item>
      <el-sub-menu :index="item.id + ''" v-for="(item,index) in menuListChildren" :key="item.id">
        <template #title>
          <el-icon>
            <component :is="menuListChildrenIcon[index]"></component>
          </el-icon>
          <span>{{ item.authName }}</span>
        </template>
        <el-menu-item
          :index="'/home' + subItem.path"
          v-for="subItem in item.children"
          :key="subItem.id"
          @click="saveNavState('/home' + subItem.path)"
        >
          <template #title>
            <span>{{ subItem.authName }}</span>
          </template>
        </el-menu-item>
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
