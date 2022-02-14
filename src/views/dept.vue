<script setup lang='ts'>
import { reactive, ref, onMounted } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addListDept, getlistDept, updateListDept } from '@/api/dept'
import AddButton from '@/common/AddButton.vue'
import Table from '@/components/dept/Table.vue'
import Pagination from '@/common/Pagination.vue'
import AddDialog from '@/components/dept/AddDialog.vue'
import UpdateDialog from '@/components/dept/UpdateDialog.vue'

//! 数据
// 控制添加对话框数据
const dialogVisible = ref<Boolean | any>(false)
// 添加表单数据
let addListDepDataForm = reactive<any>({
  uid: '',
  aid: '',
  name: '',
  creditor: '',
  type: '',
  borrowingAmount: '',
  repaymentAmount: '',
  endAmount: '',
  borrowingTime: '',
  repaymentTime: ''
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
  const res = await getlistDept(id.value, PaginationRef.value.pageData.pageNum + '', PaginationRef.value.pageData.pageSize + '')
  PaginationRef.value.pageData.total = res.data.totalNumber
  res.data.data.forEach((data: any) => {
    data.borrowingTime = data.borrowingTime.split('T')[0]
    data.repaymentTime = data.repaymentTime.split('T')[0]
  });
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
    updateListDept(
      updateInvestmentForm.value.id,
      updateInvestmentForm.value.uid,
      updateInvestmentForm.value.aid,
      updateInvestmentForm.value.name,
      updateInvestmentForm.value.creditor,
      updateInvestmentForm.value.type,
      updateInvestmentForm.value.borrowingAmount,
      updateInvestmentForm.value.repaymentAmount,
      updateInvestmentForm.value.endAmount,
      updateInvestmentForm.value.borrowingTime + 'T19:13:21',
      updateInvestmentForm.value.repaymentTime + 'T19:13:21',
    ).then(() => {
      ElMessage.success('编辑成功')
      updateDialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('编辑失败'))
  })
}
// 点击添加
const clickAddButton = () => {
  dialogVisible.value = true
  addListDepDataForm.aid = ''
  addListDepDataForm.name = ''
  addListDepDataForm.creditor = ''
  addListDepDataForm.type = ''
  addListDepDataForm.borrowingAmount = ''
  addListDepDataForm.repaymentAmount = ''
  addListDepDataForm.endAmount = ''
  addListDepDataForm.borrowingTime = ''
  addListDepDataForm.repaymentTime = ''
}
// 提交添加表单
const subaddListDepDataForm = () => {
  AddDialogRef.value.addListDepDataFormRef.validate((valid: Boolean) => {
    if (!valid) return
    addListDept(
      addListDepDataForm.uid,
      addListDepDataForm.aid,
      addListDepDataForm.name,
      addListDepDataForm.creditor,
      addListDepDataForm.type,
      addListDepDataForm.borrowingAmount,
      addListDepDataForm.repaymentAmount,
      addListDepDataForm.endAmount,
      addListDepDataForm.borrowingTime + 'T19:13:21',
      addListDepDataForm.repaymentTime + 'T19:13:21',
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
  <Table
    :investmentData="investmentData"
    :loading="loading"
    @clickUpdateInvestment="clickUpdateInvestment"
    @getInvestmentData="getInvestmentData"
  ></Table>
  <!-- 分页器 -->
  <Pagination ref="PaginationRef" @getData="getInvestmentData"></Pagination>
  <!-- 添加债务信息对话框 -->
  <AddDialog
    ref="AddDialogRef"
    :dialogVisible="dialogVisible"
    :addListDepDataForm="addListDepDataForm"
    @subaddListDepDataForm="subaddListDepDataForm"
  ></AddDialog>
  <!-- 编辑债务信息对话框 -->
  <UpdateDialog
    ref="UpdateDialogRef"
    :updateDialogVisible="updateDialogVisible"
    :updateInvestmentForm="updateInvestmentForm"
    @subUpdateInvestmentForm="subUpdateInvestmentForm"
  ></UpdateDialog>
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
