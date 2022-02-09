<script setup lang='ts'>
import {
  Fold,
  Expand,
} from '@element-plus/icons-vue'
import { useStore } from '@/store'

const store = useStore()

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

    <div class="header_tag">2</div>

    <div class="header_utils">3</div>
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
        font-size: 25px;
      }
    }
  }
  .header_tag {
    width: 75%;
  }
  .header_utils {
    width: 20%;
  }
}
</style>
