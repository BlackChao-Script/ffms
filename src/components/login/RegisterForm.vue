<script setup lang='ts'>
import { ref } from 'vue-demi';
import { userRegister } from '@/api/user'
import { ElMessage } from 'element-plus'

const { registerUser = {}, registerRules = {} } = defineProps({
  registerUser: Object,
  registerRules: Object
})
const registerForm = ref<any>(null)
const handleRegister = () => {
  registerForm.value.validate((valid: boolean) => {
    if (!valid) return
    try {
      userRegister(registerUser.username, registerUser.password)
      ElMessage({
        message: '注册成功',
        type: 'success',
      })
    } catch (err) {
      ElMessage.error('注册失败')
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
      <el-input v-model="registerUser.name" placeholder="请输入用户名"></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="password">
      <el-input show-password v-model="registerUser.password" type="password" placeholder="请输入密码"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button color="#d3e4cd" @click="handleRegister" type="primary" class="submit-btn">注册</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="less">
</style>

