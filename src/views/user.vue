<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';

import { ElMessage } from 'element-plus'

import { getUserList, cancelAccount, update } from '@/api/user'

import { PageDataType, UserDataFormRulesType } from '@/types'

import Pagination from '@/common/Pagination.vue'
import Table from '@/components/user/Table.vue'
import Dialog from '@/components/user/Dialog.vue'

//!数据
// 用户表格数据
const UserData = ref<Array<any>>([])
// 加载动画数据
const loading = ref<Boolean | any>(true)
// 控制页面分页数据
const pageData = reactive<PageDataType>({
  pageNum: 1,
  pageSize: 5,
  total: 0
})
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
  type: [
    {
      required: true,
      message: '请选择权限',
      trigger: 'change',
    },
  ]
})
// 展示对话框数据
const dialogVisible = ref<Boolean | any>(false)
// 获取用户表单ref
const userForm = ref<any>(null)

//! 方法
//获取用户表格数据
const getUserData = async () => {
  const res = await getUserList(pageData.pageNum + '', pageData.pageSize + '')
  for (const i of res.data.data) {
    i.createTime = i.createTime.split(' ')[0]
  }
  console.log(res.data)
  UserData.value = res.data.data
  pageData.total = UserData.value.length
  loading.value = false
}
// 改变用户状态
const cancelAccountUser = async (id: string) => {
  cancelAccount(id + '').then(() => {
    ElMessage({
      message: '操作成功',
      type: 'success',
    })
    getUserData()
  }).catch(() => ElMessage.error('操作失败'))
}
// 点击编辑按钮
const updateUser = (data: any) => {
  dialogVisible.value = true
  const { token, createTime, lastModifyTime, ...params } = data
  UserDataForm.value = params
  console.log(UserDataForm.value)
}
// 完成修改编辑
const changUserForm = () => {
  userForm.value.validate((valid: boolean) => {
    if (!valid) return
    update(
      UserDataForm.value.id,
      UserDataForm.value.name,
      UserDataForm.value.note,
      UserDataForm.age,
      UserDataForm.value.sex,
      UserDataForm.value.cardId,
      UserDataForm.value.password,
      UserDataForm.value.phone,
      UserDataForm.value.type,
      UserDataForm.value.email,
      UserDataForm.value.birthday,
    ).then(() => {
      ElMessage({
        message: '编辑成功',
        type: 'success',
      })
      dialogVisible.value = false
      // getUserData()
    }).catch(() => { ElMessage.error('编辑失败') })
  })
}

onMounted(() => {
  getUserData()
})

</script>

<template>
  <!-- 数据表格 -->
  <Table
    :UserData="UserData"
    :loading="loading"
    @updateUser="updateUser"
    @cancelAccountUser="cancelAccountUser"
  ></Table>
  <!-- 分页器 -->
  <Pagination :pageData="pageData" @getData="getUserData" />
  <!-- 编辑对话框 -->
  <Dialog
    :dialogVisible="dialogVisible"
    :UserDataForm="UserDataForm"
    :UserDataFormRules="UserDataFormRules"
    @changUserForm="changUserForm"
  ></Dialog>
</template>
