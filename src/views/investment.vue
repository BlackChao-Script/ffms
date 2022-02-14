<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi'
import { ElMessage } from 'element-plus'
import { addInvestment, getListInvestment, updateInvestment } from '@/api/investment'
import { addInvestmentDataFormType } from '@/types'
import AddButton from '@/common/AddButton.vue'
import InvestmentTable from '@/components/investment/InvestmentTable.vue'
import Pagination from '@/common/Pagination.vue'
import InvestmentAddDialog from '@/components/investment/InvestmentAddDialog.vue'
import InvestmentUpdateDialog from '@/components/investment/InvestmentUpdateDialog.vue'

//! 数据
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
// 控制添加对话框数据
const dialogVisible = ref<Boolean | any>(false)
// 添加表单数据
let addInvestmentDataForm = reactive<addInvestmentDataFormType>({
  uid: '',
  aid: '',
  name: '',
  investmentTime: '',
  type: '',
  amount: '',
  interestRate: ''
})
// 分页器ref
const PaginationRef = ref<any>(null)
const AddDialogRef = ref<any>(null)
const UpdateDialogRef = ref<any>(null)

//! 方法
// 获取表格数据
const getInvestmentData = async () => {
  const res = await getListInvestment(id.value, PaginationRef.value.pageData.pageNum + '', PaginationRef.value.pageData.pageSize + '')
  PaginationRef.value.pageData.total = res.data.totalNumber
  res.data.data.forEach((data: any) => data.investmentTime = data.investmentTime.split('T')[0]);
  investmentData.value = res.data.data
  loading.value = false
}
// 点击编辑按钮
const clickUpdateInvestment = (data: any) => {
  const { bankAccount, createTime, version, lastModifyTime, ...parmas } = data
  updateInvestmentForm.value = parmas
  updateDialogVisible.value = true
}
// 提交更新表单
const subUpdateInvestmentForm = () => {
  UpdateDialogRef.value.updateInvestmentFormRef.validate((valid: Boolean) => {
    if (!valid) return
    updateInvestment(
      updateInvestmentForm.value.id,
      updateInvestmentForm.value.uid,
      updateInvestmentForm.value.aid,
      updateInvestmentForm.value.name,
      updateInvestmentForm.value.investmentTime + 'T19:13:21',
      updateInvestmentForm.value.type,
      updateInvestmentForm.value.amount,
      updateInvestmentForm.value.interestRate
    ).then(() => {
      ElMessage.success('编辑成功')
      updateDialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('编辑失败'))
  })
}
// 点击添加按钮
const clickAddButton = () => {
  dialogVisible.value = true
  addInvestmentDataForm.aid = ''
  addInvestmentDataForm.investmentTime = ''
  addInvestmentDataForm.type = ''
  addInvestmentDataForm.amount = ''
  addInvestmentDataForm.interestRate = ''
}
// 提交添加表单
const subAddInvestmentDataForm = () => {
  AddDialogRef.value.addInvestmentDataFormRef.validate((valid: Boolean) => {
    if (!valid) return
    addInvestment(
      addInvestmentDataForm.uid,
      addInvestmentDataForm.aid,
      addInvestmentDataForm.name,
      addInvestmentDataForm.investmentTime + 'T19:13:21',
      addInvestmentDataForm.type,
      addInvestmentDataForm.amount,
      addInvestmentDataForm.interestRate
    ).then(() => {
      ElMessage.success('添加成功')
      dialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('添加失败'))
  })
}

onMounted(() => {
  id.value = window.sessionStorage.getItem('uid') as string
  addInvestmentDataForm.uid = window.sessionStorage.getItem('uid') as string
  getInvestmentData()
})

</script>

<template>
  <!-- 添加 -->
  <AddButton @clickAddButton="clickAddButton"></AddButton>
  <!-- 表格 -->
  <InvestmentTable
    :investmentData="investmentData"
    :loading="loading"
    @getInvestmentData="getInvestmentData"
    @clickUpdateInvestment="clickUpdateInvestment"
  ></InvestmentTable>
  <!-- 分页器 -->
  <Pagination ref="PaginationRef" @getData="getInvestmentData"></Pagination>
  <!-- 添加投资信息对话框 -->
  <InvestmentAddDialog
    ref="AddDialogRef"
    :dialogVisible="dialogVisible"
    :addInvestmentDataForm="addInvestmentDataForm"
    @subAddInvestmentDataForm="subAddInvestmentDataForm"
  ></InvestmentAddDialog>
  <!--编辑投资信息对话框  -->
  <InvestmentUpdateDialog
    ref="UpdateDialogRef"
    :updateDialogVisible="updateDialogVisible"
    :updateInvestmentForm="updateInvestmentForm"
    @subUpdateInvestmentForm="subUpdateInvestmentForm"
  ></InvestmentUpdateDialog>
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
