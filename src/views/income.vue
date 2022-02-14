<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addIncome, getListIncome, updateIncome } from '@/api/income'
import AddButton from '@/common/AddButton.vue'
import IncomeTable from '@/components/income/IncomeTable.vue'
import Pagination from '@/common/Pagination.vue'
import IncomeAddDialog from '@/components/income/IncomeAddDialog.vue'
import IncomeUpdateDialog from '@/components/income/IncomeUpdateDialog.vue'

//! 数据
// 控制添加对话框数据
const dialogVisible = ref<Boolean | any>(false)
let addListDepDataForm = reactive<any>({
  uid: '',
  aid: '',
  amount: '',
  address: '',
  transactionOrganization: '',
  transactionHour: '',
  transactionNumber: '',
  merchantNumber: '',
  type: '',
  commodity: ''
})
// 表格数据
const investmentData = ref<Array<any>>([]) as any
// 家庭成员id
const id = ref<string>('')
// 控制更新对话框数据
const updateDialogVisible = ref<Boolean>(false) as any
// 加载动画数据
const loading = ref<Boolean>(true) as any
// 更新表单数据
const updateInvestmentForm = ref<object | any>({})
// 分页器ref
const PaginationRef = ref<any>(null)
// 添加对话框ref
const AddDialogRef = ref<any>(null)
// 编辑对话框ref
const UpdateDialogRef = ref<any>(null)

//! 方法
// 获取表格数据
const getInvestmentData = async () => {
  const res = await getListIncome(id.value, PaginationRef.value.pageData.pageNum + '', PaginationRef.value.pageData.pageSize + '')
  PaginationRef.value.pageData.total = res.data.totalNumber
  res.data.data.forEach((data: any) => {
    data.transactionHour = data.transactionHour.split('T')[0]
  })
  investmentData.value = res.data.data
  loading.value = false
}
// 点击编辑
const clickUpdateInvestment = (data: any) => {
  const { bankAccount, createTime, version, lastModifyTime, ...parmas } = data
  updateInvestmentForm.value = parmas
  updateDialogVisible.value = true
}
// 提交更新表单
const subUpdateInvestmentForm = () => {
  UpdateDialogRef.value.updateInvestmentFormRef.validate((valid: Boolean) => {
    if (!valid) return
    updateIncome(
      updateInvestmentForm.value.id,
      updateInvestmentForm.value.uid,
      updateInvestmentForm.value.aid,
      updateInvestmentForm.value.amount,
      updateInvestmentForm.value.address,
      updateInvestmentForm.value.transactionOrganization,
      updateInvestmentForm.value.transactionHour + 'T19:13:21',
      updateInvestmentForm.value.transactionNumber,
      updateInvestmentForm.value.merchantNumber,
      updateInvestmentForm.value.type,
      updateInvestmentForm.value.commodity,
    ).then(() => {
      ElMessage.success('编辑成功')
      updateDialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('编辑失败'))
  })
}
const clickAddButton = () => {
  dialogVisible.value = true
  addListDepDataForm.aid = ''
  addListDepDataForm.amount = ''
  addListDepDataForm.address = ''
  addListDepDataForm.transactionOrganization = ''
  addListDepDataForm.transactionHour = ''
  addListDepDataForm.transactionNumber = ''
  addListDepDataForm.merchantNumber = ''
  addListDepDataForm.type = ''
  addListDepDataForm.commodity = ''
}
const subaddListDepDataForm = () => {
  AddDialogRef.value.addListDepDataFormRef.validate((valid: Boolean) => {
    if (!valid) return
    addIncome(
      addListDepDataForm.uid,
      addListDepDataForm.aid,
      addListDepDataForm.amount,
      addListDepDataForm.address,
      addListDepDataForm.transactionOrganization,
      addListDepDataForm.transactionHour + 'T19:13:21',
      addListDepDataForm.transactionNumber,
      addListDepDataForm.merchantNumber,
      addListDepDataForm.type,
      addListDepDataForm.commodity,
    ).then(() => {
      ElMessage.success('添加成功')
      dialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('添加失败'))
  })
}

onMounted(() => {
  id.value = window.sessionStorage.getItem('uid') as string
  addListDepDataForm.uid = window.sessionStorage.getItem('uid') as string
  getInvestmentData()
})

</script>

<template>
  <!-- 添加按钮 -->
  <AddButton @clickAddButton="clickAddButton"></AddButton>
  <!-- 表格 -->
  <IncomeTable
    :investmentData="investmentData"
    :loading="loading"
    @getInvestmentData="getInvestmentData"
    @clickUpdateInvestment="clickUpdateInvestment"
  ></IncomeTable>
  <!-- 分页器 -->
  <Pagination ref="PaginationRef" @getData="getInvestmentData"></Pagination>
  <!-- 添加收入信息对话框 -->
  <IncomeAddDialog
    ref="AddDialogRef"
    :dialogVisible="dialogVisible"
    :addListDepDataForm="addListDepDataForm"
    @subaddListDepDataForm="subaddListDepDataForm"
  ></IncomeAddDialog>
  <!-- 编辑信息对话框 -->
  <IncomeUpdateDialog
    ref="UpdateDialogRef"
    :updateDialogVisible="updateDialogVisible"
    :updateInvestmentForm="updateInvestmentForm"
    @subUpdateInvestmentForm="subUpdateInvestmentForm"
  ></IncomeUpdateDialog>
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
