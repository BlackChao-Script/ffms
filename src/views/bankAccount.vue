<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { findListBankAccount, addBankAccount, updateBankAccount } from '@/api/bankAccount'
import { ElMessage } from 'element-plus'
import { PageDataType, bankAccountDataFormType } from '@/types'
import AddButton from '@/common/AddButton.vue'
import Serch from '@/common/Serch.vue'
import BankAccountTable from '@/components/bankAccount/BankAccountTable.vue'
import BankAccountAddDialog from '@/components/bankAccount/BankAccountAddDialog.vue'
import BankAccountUpdateDialog from '@/components/bankAccount/BankAccountUpdateDialog.vue'

//! 数据
// 表格数据
const bankAccountData = ref<Array<any>>([])
// 分页器数据
const pageData = reactive<PageDataType>({
  pageNum: 1,
  pageSize: 10,
  total: 0
})
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
// 添加表单对话框
const dialogVisible = ref<Boolean | any>(false)
// 编辑表单数据
let updateBankAccountDataForm = ref<object | any>({})
// 添加对话框ref
const AddDialogRef = ref<any>(null)
// 修改对话框ref
const UpdateDialogRef = ref<any>(null)

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
  AddDialogRef.value.addBankAccountFormRef.validate((valid: Boolean) => {
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
  UpdateDialogRef.value.updateBankAccountFormRef.validate((valid: Boolean) => {
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
    <!-- 添加按钮 -->
    <AddButton @clickAddButton="clickAddButton"></AddButton>
  </div>
  <!-- 表格 -->
  <BankAccountTable
    :bankAccountData="bankAccountData"
    @clickUpdateBankAccount="clickUpdateBankAccount"
  ></BankAccountTable>
  <!-- 添加对话框 -->
  <BankAccountAddDialog
    ref="AddDialogRef"
    :dialogVisible="dialogVisible"
    :bankAccountDataForm="bankAccountDataForm"
    @SubAddBankAccount="SubAddBankAccount"
  ></BankAccountAddDialog>
  <!-- 修改对话框 -->
  <BankAccountUpdateDialog
    ref="UpdateDialogRef"
    :updatedialogVisible="updatedialogVisible"
    :updateBankAccountDataForm="updateBankAccountDataForm"
    @SubUpdataBankAccount="SubUpdataBankAccount"
  ></BankAccountUpdateDialog>
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
