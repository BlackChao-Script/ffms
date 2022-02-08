<script setup lang='ts'>
import { ref } from 'vue-demi';


const { registerUser = {}, registerRules = {} } = defineProps({
  registerUser: Object,
  registerRules: Object
})
const registerForm = ref<any>(null)
const handleRegister = () => {
  registerForm.value.validate((valid: boolean) => {
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
    ref="registerForm"
    :model="registerUser"
    :rules="registerRules"
    label-width="100px"
    class="registerForm sign-up-form"
  >
    <el-form-item label="用户名" prop="username">
      <el-input v-model="registerUser.name" placeholder="Enter UserName..."></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="password">
      <el-input v-model="registerUser.password" type="password" placeholder="Enter Password..."></el-input>
    </el-form-item>
    <el-form-item>
      <el-button @click="handleRegister" type="primary" class="submit-btn">注册</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="scss">
</style>

