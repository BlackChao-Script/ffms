<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { getUserList, cancelAccount, update, recover } from '@/api/user'
import { UserDataFormRulesType } from '@/types'
import UserTable from '@/components/user/UserTable.vue'
import Pagination from '@/common/Pagination.vue'

//!数据
// 用户表格数据
const UserData = ref<Array<any>>([])
// 加载动画数据
const loading = ref<Boolean | any>(true)
// 用户表单数据
const UserDataForm = ref<object | any>({})
// 用户表单数据验证
const UserDataFormRules = reactive<UserDataFormRulesType>({
  name: [
    {
      required: true,
      message: '请输入家庭成员姓名',
      trigger: 'blur',
    }
  ],
  password: [
    {
      required: true,
      message: '请输入密码',
      trigger: 'blur',
    },
  ]
})
// 展示对话框数据
const dialogVisible = ref<Boolean | any>(false)
// 获取用户表单ref
const userForm = ref<any>(null)
// 分页器ref
const PaginationRef = ref<any>(null)

//! 方法
//获取用户表格数据
const getUserData = async () => {
  const res = await getUserList(PaginationRef.value.pageData.pageNum + '', PaginationRef.value.pageData.pageSize + '')
  for (const i of res.data.data) {
    i.createTime = i.createTime.split(' ')[0]
  }
  UserData.value = res.data.data
  PaginationRef.value.pageData.total = res.data.totalNumber
  loading.value = false
}
// 用户注销
const cancelAccountUser = (id: string) => {
  cancelAccount(id).then(() => {
    ElMessage.success('操作成功')
    getUserData()
  }).catch(() => ElMessage.error('操作失败'))
}
// 用户恢复
const recoverUser = (id: string) => {
  recover(id).then(() => {
    ElMessage.success('操作成功')
    getUserData()
  }).catch(() => ElMessage.error('操作失败'))
}
// 点击编辑按钮
const updateUser = (data: any) => {
  dialogVisible.value = true
  const { token, createTime, lastModifyTime, ...params } = data
  UserDataForm.value = params
}
// 完成修改编辑
const changUserForm = () => {
  userForm.value.validate((valid: boolean) => {
    if (!valid) return
    update(
      UserDataForm.value.id,
      UserDataForm.value.name,
      UserDataForm.value.note,
      UserDataForm.value.age,
      UserDataForm.value.sex,
      UserDataForm.value.cardId,
      UserDataForm.value.password,
      UserDataForm.value.phone,
      UserDataForm.value.type,
      UserDataForm.value.email,
      UserDataForm.value.birthday,
    ).then(() => {
      ElMessage.success('编辑成功')
      dialogVisible.value = false
      getUserData()
    }).catch(() => { ElMessage.error('编辑失败') })
  })
}

onMounted(() => {
  getUserData()
})

</script>

<template>
  <!-- 数据表格 -->
  <UserTable
    :UserData="UserData"
    :loading="loading"
    @updateUser="updateUser"
    @cancelAccountUser="cancelAccountUser"
    @recoverUser="recoverUser"
  ></UserTable>
  <!-- 分页器 -->
  <Pagination ref="PaginationRef" @getdata="getUserData"></Pagination>
  <!-- 编辑对话框 -->
  <el-dialog v-model="dialogVisible" title="编辑" width="30%">
    <el-form
      ref="userForm"
      :model="UserDataForm"
      :rules="UserDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员名" prop="name">
        <el-input v-model="UserDataForm.name" placeholder="请输入家庭成员名"></el-input>
      </el-form-item>
      <el-form-item label="身份">
        <el-input v-model="UserDataForm.note" placeholder="请输入身份"></el-input>
      </el-form-item>
      <el-form-item label="年龄">
        <el-input v-model="UserDataForm.age" placeholder="请输入年龄"></el-input>
      </el-form-item>
      <el-form-item label="性别">
        <el-radio v-model="UserDataForm.sex" label="男" size="large">男</el-radio>
        <el-radio v-model="UserDataForm.sex" label="女" size="large">女</el-radio>
      </el-form-item>
      <el-form-item label="身份证号码">
        <el-input v-model="UserDataForm.cardId" placeholder="请输入身份证号码"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="UserDataForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="联系方式">
        <el-input v-model="UserDataForm.phone" placeholder="请输入联系方式"></el-input>
      </el-form-item>
      <el-form-item label="权限">
        <el-radio v-model="UserDataForm.type" label="管理员" size="large">管理员</el-radio>
        <el-radio v-model="UserDataForm.type" label="家庭成员" size="large">家庭成员</el-radio>
      </el-form-item>
      <el-form-item label="电子邮箱">
        <el-input v-model="UserDataForm.email" placeholder="请输入电子邮箱"></el-input>
      </el-form-item>
      <el-form-item label="出生日期">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="UserDataForm.birthday"
          type="date"
          placeholder="请选择出生日期"
        ></el-date-picker>
      </el-form-item>

      <el-form-item>
        <el-button @click="changUserForm" color="#d3e4cd" type="primary" class="submit-btn">完成修改</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>
