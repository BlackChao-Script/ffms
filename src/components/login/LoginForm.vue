<script setup lang='ts'>
import { ref } from 'vue-demi'
import { userLogin } from '@/api/user'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'

const { loginUser = {}, rules = {} } = defineProps({
  loginUser: Object,
  rules: Object
})
const router = useRouter()

const loginForm = ref<any>(null)

const handleLogin = () => {
  loginForm.value.validate(async (valid: boolean) => {
    if (!valid) return
    try {
      const res = await userLogin(loginUser.username, loginUser.password)
      window.sessionStorage.setItem('token', res.data.data.token)
      ElMessage({
        message: '登录成功',
        type: 'success',
      })
      router.push('/home')
    } catch (err) {
      ElMessage.error('账号或密码错误')
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
      <el-input v-model="loginUser.username" placeholder="请输入用户名"></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="password">
      <el-input show-password v-model="loginUser.password" type="password" placeholder="请输入密码"></el-input>
    </el-form-item>

    <el-form-item>
      <el-button color="#d3e4cd" @click="handleLogin" type="primary" class="submit-btn">登录</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="less">
.loginForm {
  margin-top: 20px;
  background-color: #fff;
  padding: 20px 40px 20px 20px;
  border-radius: 5px;
  box-shadow: 0px 5px 10px #cccc;
}

.submit-btn {
  width: 20%;
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
