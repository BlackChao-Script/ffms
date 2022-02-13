<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { findListBankAccount, addBankAccount, updateBankAccount } from '@/api/bankAccount'
import { ElMessage } from 'element-plus'
import { PageDataType, bankAccountDataFormType } from '@/types'
import Serch from '@/common/Serch.vue'
import Table from '@/components/bankAccount/Table.vue'

//! 数据
// 表格数据
const bankAccountData = ref<Array<any>>([])
// 分页器数据
const pageData = reactive<PageDataType>({
  pageNum: 1,
  pageSize: 10,
  total: 0
})
// 展示添加对话框数据
const dialogVisible = ref<Boolean | any>(false)
// 展示修改对话框数据
const updatedialogVisible = ref<Boolean | any>(false)
// 添加表单数据
const bankAccountDataForm = reactive<bankAccountDataFormType>({
  uid: '',
  note: '',
  name: '',
  password: '',
  cardNumber: '',
  cardType: '',
  accountOpeningTime: '',
  accountOpeningAddress: '',
  balance: ''
})
// 编辑表单数据
let updateBankAccountDataForm = ref<object | any>({})
// 表单验证
const bankAccountDataFormRules = reactive<any>({

})
// 获取添加表单
const addBankAccountForm = ref<any>(null)
// 获取编辑表单
const updateBankAccountForm = ref<any>(null)

//! 方法
// 点击搜索
const clickSerch = async (id: any) => {
  bankAccountDataForm.uid = id.value
  try {
    const res = await findListBankAccount(id.value, pageData.pageNum + '', pageData.pageSize + '')
    pageData.total = res.data.totalNumber
    bankAccountData.value = res.data.data
    ElMessage.success('查询成功')
  } catch (err) {
    ElMessage.error('查询失败')
  }
}
// 点击添加按钮
const clickAddButton = () => {
  dialogVisible.value = true
  bankAccountDataForm.note = ''
  bankAccountDataForm.name = ''
  bankAccountDataForm.password = ''
  bankAccountDataForm.cardNumber = ''
  bankAccountDataForm.cardType = ''
  bankAccountDataForm.accountOpeningTime = ''
  bankAccountDataForm.accountOpeningAddress = ''
  bankAccountDataForm.balance = ''
}
// 点击完成添加提交表单
const SubAddBankAccount = () => {
  addBankAccountForm.value.validate((valid: Boolean) => {
    if (!valid) return
    addBankAccount(
      bankAccountDataForm.uid,
      bankAccountDataForm.note,
      bankAccountDataForm.name,
      bankAccountDataForm.password,
      bankAccountDataForm.cardNumber,
      bankAccountDataForm.cardType,
      bankAccountDataForm.accountOpeningTime,
      bankAccountDataForm.accountOpeningAddress,
      bankAccountDataForm.balance
    ).then(() => {
      ElMessage.success('添加成功')
      dialogVisible.value = false
    }).catch(() => ElMessage.error('添加失败'))
  })
}
// 点击编辑按钮
const clickUpdateBankAccount = (data: any) => {
  const { createTime, lastModifyTime, version, ...params } = data
  updateBankAccountDataForm.value = params
  updatedialogVisible.value = true
}
// 点击完成编辑提交表单
const SubUpdataBankAccount = () => {
  updateBankAccountForm.value.validate((valid: Boolean) => {
    if (!valid) return
    updateBankAccount(
      updateBankAccountDataForm.value.id,
      updateBankAccountDataForm.value.uid,
      updateBankAccountDataForm.value.note,
      updateBankAccountDataForm.value.name,
      updateBankAccountDataForm.value.password,
      updateBankAccountDataForm.value.cardNumber,
      updateBankAccountDataForm.value.cardType,
      updateBankAccountDataForm.value.accountOpeningTime,
      updateBankAccountDataForm.value.accountOpeningAddress,
      updateBankAccountDataForm.value.balance
    ).then(() => {
      ElMessage.success('编辑成功')
      updatedialogVisible.value = false
    }).catch(() => ElMessage.error('编辑失败'))
  })
}

// 生命周期
onMounted(() => {
  bankAccountDataForm.uid = window.sessionStorage.getItem('uid') as string
})
</script>

<template>
  <div class="serch">
    <!-- 搜索框 -->
    <Serch @clickSerch="clickSerch"></Serch>
    <!-- 添加 -->
    <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加银行账户</el-button>
  </div>
  <!-- 表格 -->
  <Table :bankAccountData="bankAccountData" @clickUpdateBankAccount="clickUpdateBankAccount"></Table>
  <!-- 添加对话框 -->
  <el-dialog v-model="dialogVisible" title="添加" width="30%">
    <el-form
      ref="addBankAccountForm"
      :model="bankAccountDataForm"
      :rules="bankAccountDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员id" prop="name">
        <el-input disabled v-model="bankAccountDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="类型">
        <el-input v-model="bankAccountDataForm.note" placeholder="请输入类型"></el-input>
      </el-form-item>
      <el-form-item label="银行账户名">
        <el-input v-model="bankAccountDataForm.name" placeholder="请输入银行账户名"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="bankAccountDataForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="银行账号">
        <el-input v-model="bankAccountDataForm.cardNumber" placeholder="请输入银行账号"></el-input>
      </el-form-item>
      <el-form-item label="银行账户">
        <el-input v-model="bankAccountDataForm.cardType" placeholder="请输入银行账户"></el-input>
      </el-form-item>
      <el-form-item label="开户地址">
        <el-input v-model="bankAccountDataForm.accountOpeningAddress" placeholder="请输入开户地址"></el-input>
      </el-form-item>
      <el-form-item label="开户时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="bankAccountDataForm.accountOpeningTime"
          type="date"
          placeholder="请选择开户时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="账户余额">
        <el-input v-model="bankAccountDataForm.balance" placeholder="请输入账户余额"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button @click="SubAddBankAccount" color="#d3e4cd" type="primary" class="submit-btn">立即添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
  <!-- 修改对话框 -->
  <el-dialog v-model="updatedialogVisible" title="编辑" width="30%">
    <el-form
      ref="updateBankAccountForm"
      :model="updateBankAccountDataForm"
      :rules="bankAccountDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员id" prop="name">
        <el-input disabled v-model="updateBankAccountDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="类型">
        <el-input v-model="updateBankAccountDataForm.note" placeholder="请输入类型"></el-input>
      </el-form-item>
      <el-form-item label="银行账户名">
        <el-input v-model="updateBankAccountDataForm.name" placeholder="请输入银行账户名"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="updateBankAccountDataForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="银行账号">
        <el-input v-model="updateBankAccountDataForm.cardNumber" placeholder="请输入银行账号"></el-input>
      </el-form-item>
      <el-form-item label="银行账户">
        <el-input v-model="updateBankAccountDataForm.cardType" placeholder="请输入银行账户"></el-input>
      </el-form-item>
      <el-form-item label="开户地址">
        <el-input v-model="updateBankAccountDataForm.accountOpeningAddress" placeholder="请输入开户地址"></el-input>
      </el-form-item>
      <el-form-item label="开户时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateBankAccountDataForm.accountOpeningTime"
          type="date"
          placeholder="请选择开户时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="账户余额">
        <el-input v-model="updateBankAccountDataForm.balance" placeholder="请输入账户余额"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button
          @click="SubUpdataBankAccount"
          color="#d3e4cd"
          type="primary"
          class="submit-btn"
        >立即添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<style scoped lang="less">
.serch {
  width: 40%;
  margin-bottom: 20px;
  display: flex;
  .el-button {
    margin-left: 30px;
  }
}
</style>
