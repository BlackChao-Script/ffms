<script setup lang='ts'>
import { getUserList, cancelAccount, update } from '@/api/user'
import { onMounted, reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'

const UserData = ref<Array<any>>([])
const loading = ref<Boolean>(true)
const pageData = reactive<any>({
  pageNum: 1,
  pageSize: 5,
  total: 0
})
const UserDataForm = ref<object | any>({})
const UserDataFormRules = reactive<any>({
  id: [
    {
      required: true,
      message: '请输入id',
      trigger: 'blur',
    }
  ],
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
const dialogVisible = ref<Boolean | any>(false)
const userForm = ref<any>(null)

const getUserData = async () => {
  const res = await getUserList(pageData.pageNum + '', pageData.pageSize + '')
  for (const i of res.data.data) {
    i.createTime = i.createTime.split(' ')[0]
  }
  UserData.value = res.data.data
  pageData.total = UserData.value.length
  loading.value = false
}
const cancelAccountUser = async (id: string) => {
  cancelAccount(id + '').then(() => {
    ElMessage({
      message: '操作成功',
      type: 'success',
    })
    getUserData()
  }).catch(() => ElMessage.error('操作失败'))
}
const handleSizeChange = (val: number) => {
  pageData.pageSize = val
  getUserData()
}
const handleCurrentChange = (val: number) => {
  pageData.pageNum = val
  getUserData()
}
const updateUser = (data: any) => {
  UserDataForm.value = data
  dialogVisible.value = true
}
const changUserForm = () => {
  userForm.value.validate((valid: boolean) => {
    if (!valid) return
    update(UserDataForm.value).then(() => {
      ElMessage({
        message: '编辑成功',
        type: 'success',
      })
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
  <el-table
    :default-sort="{ prop: 'createTime', order: 'descending' }"
    :stripe="true"
    :border="false"
    :data="UserData"
    v-loading="loading"
    border
    style="width: 100%"
  >
    <el-table-column type="index" />
    <el-table-column sortable prop="createTime" label="创建用户时间" width="180" />
    <el-table-column prop="name" label="Name" width="120" />
    <el-table-column prop="birthday" label="出生日期" width="100" />
    <el-table-column prop="email" label="电子邮箱" width="180" />
    <el-table-column prop="sex" label="性别" width="100" />
    <el-table-column prop="note" label="身份" width="150" />
    <el-table-column prop="phone" label="联系方式" width="180" />
    <el-table-column prop="type" label="权限" />
    <el-table-column label="状态">
      <template #default="scope">
        <el-tag
          effect="plain"
          type="success"
          class="mx-1"
          size="large"
          v-if="scope.row.status == 1"
        >正常</el-tag>
        <el-tag effect="plain" type="warning" class="mx-1" size="large" v-else>注销</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作">
      <template #default="scope">
        <el-button color="#d3e4cd" style="color: white" @click="updateUser(scope.row)">编辑</el-button>
        <el-button @click="cancelAccountUser(scope.row.id)" type="warning" style="color: white">注销</el-button>
      </template>
    </el-table-column>
  </el-table>

  <el-pagination
    :page-sizes="[3, 5, 10]"
    :page-size="pageData.pageSize"
    layout="sizes, prev, pager, next"
    :total="pageData.total"
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange"
  ></el-pagination>

  <el-dialog v-model="dialogVisible" title="编辑" width="30%">
    <el-form
      ref="userForm"
      :model="UserDataForm"
      :rules="UserDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="编号" prop="id">
        <el-input v-model="UserDataForm.id" placeholder="请输入家庭成员编号"></el-input>
      </el-form-item>
      <el-form-item label="身份">
        <el-input v-model="UserDataForm.note" placeholder="请输入身份"></el-input>
      </el-form-item>
      <el-form-item label="家庭成员名" prop="name">
        <el-input v-model="UserDataForm.name" placeholder="请输入家庭成员名"></el-input>
      </el-form-item>
      <el-form-item label="性别">
        <el-radio v-model="UserDataForm.sex" label="男" size="large">男</el-radio>
        <el-radio v-model="UserDataForm.sex" label="女" size="large">女</el-radio>
      </el-form-item>
      <el-form-item label="联系方式">
        <el-input v-model="UserDataForm.phone" placeholder="请输入联系方式"></el-input>
      </el-form-item>
      <el-form-item label="权限" prop="type">
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

<style scoped lang="less">
.el-pagination {
  margin-top: 25px;
  .fja();
}
</style>
