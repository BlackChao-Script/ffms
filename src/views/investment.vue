<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi'
import { ElMessage } from 'element-plus'
import { addInvestment, getListInvestment, updateInvestment } from '@/api/investment'
import { addInvestmentDataFormType } from '@/types'
import Table from '@/components/investment/Table.vue'
import Pagination from '@/common/Pagination.vue'

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
// 更新表单数据验证
const updateInvestmentFormRef = ref<any>(null)
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
// 表单验证规则
const bankAccountDataFormRules = reactive<any>({})
// 添加表单ref
const addInvestmentDataFormRef = ref<any>(null)
// 分页器ref
const PaginationRef = ref<any>(null)

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
  updateInvestmentFormRef.value.validate((valid: Boolean) => {
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
  addInvestmentDataFormRef.value.validate((valid: Boolean) => {
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
  <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加投资信息</el-button>
  <!-- 表格 -->
  <Table
    :investmentData="investmentData"
    :loading="loading"
    @getInvestmentData="getInvestmentData"
    @clickUpdateInvestment="clickUpdateInvestment"
  ></Table>
  <!-- 分页器 -->
  <Pagination ref="PaginationRef" @getData="getInvestmentData"></Pagination>
  <!-- 添加投资信息对话框 -->
  <el-dialog v-model="dialogVisible" title="添加投资信息" width="30%">
    <el-form
      ref="addInvestmentDataFormRef"
      :model="addInvestmentDataForm"
      :rules="bankAccountDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员编号">
        <el-input disabled v-model="addInvestmentDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="银行账户编号">
        <el-input v-model="addInvestmentDataForm.aid" placeholder="请输入银行账户编号"></el-input>
      </el-form-item>
      <el-form-item label="投资名">
        <el-input v-model="addInvestmentDataForm.name" placeholder="请输入投资名"></el-input>
      </el-form-item>
      <el-form-item label="投资时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="addInvestmentDataForm.investmentTime"
          type="date"
          placeholder="请选择投资时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="投资类型">
        <el-input v-model="addInvestmentDataForm.type" placeholder="请输入投资类型"></el-input>
      </el-form-item>
      <el-form-item label="投资金额">
        <el-input v-model="addInvestmentDataForm.amount" placeholder="请输入投资金额"></el-input>
      </el-form-item>
      <el-form-item label="利润">
        <el-input v-model="addInvestmentDataForm.interestRate" placeholder="请输入利润"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button
          @click="subAddInvestmentDataForm"
          color="#d3e4cd"
          type="primary"
          class="submit-btn"
        >立即添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
  <!--编辑投资信息对话框  -->
  <el-dialog v-model="updateDialogVisible" title="编辑投资信息" width="30%">
    <el-form
      ref="updateInvestmentFormRef"
      :model="updateInvestmentForm"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员编号">
        <el-input disabled v-model="updateInvestmentForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="银行账户编号">
        <el-input v-model="updateInvestmentForm.aid" placeholder="请输入银行账户编号"></el-input>
      </el-form-item>
      <el-form-item label="投资名">
        <el-input v-model="updateInvestmentForm.name" placeholder="请输入投资名"></el-input>
      </el-form-item>
      <el-form-item label="投资时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateInvestmentForm.investmentTime"
          type="date"
          placeholder="请选择投资时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="投资类型">
        <el-input v-model="updateInvestmentForm.type" placeholder="请输入投资类型"></el-input>
      </el-form-item>
      <el-form-item label="投资金额">
        <el-input v-model="updateInvestmentForm.amount" placeholder="请输入投资金额"></el-input>
      </el-form-item>
      <el-form-item label="利润">
        <el-input v-model="updateInvestmentForm.interestRate" placeholder="请输入利润"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button
          @click="subUpdateInvestmentForm"
          color="#d3e4cd"
          type="primary"
          class="submit-btn"
        >立即添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
