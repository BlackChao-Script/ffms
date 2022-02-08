<script setup lang='ts'>
import { ref } from 'vue-demi';

const { loginUser = {}, rules = {} } = defineProps({
  loginUser: Object,
  rules: Object
})

const loginForm = ref<any>(null)

const handleLogin = () => {
  loginForm.value.validate((valid: boolean) => {
    if (valid) {
      alert("submit!");
    } else {
      console.log("error submit!!");
      return false;
    }
  })
}
</script>

<template>
  <el-form
    ref="loginForm"
    :model="loginUser"
    :rules="rules"
    label-width="100px"
    class="loginForm sign-in-form"
  >
    <el-form-item label="用户名" prop="username">
      <el-input v-model="loginUser.username" placeholder="Enter Username..."></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="password">
      <el-input v-model="loginUser.password" type="password" placeholder="Enter Password..."></el-input>
    </el-form-item>

    <el-form-item>
      <el-button @click="handleLogin" type="primary" class="submit-btn">提交</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="scss">
.loginForm {
  margin-top: 20px;
  background-color: #fff;
  padding: 20px 40px 20px 20px;
  border-radius: 5px;
  box-shadow: 0px 5px 10px #cccc;
}

.submit-btn {
  width: 100%;
}
.tiparea {
  text-align: right;
  font-size: 12px;
  color: #333;
}
.tiparea p a {
  color: #409eff;
}
</style>
