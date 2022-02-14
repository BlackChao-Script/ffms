<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addIncome, getListIncome, updateIncome } from '@/api/income'
import Table from '@/components/income/Table.vue'
import Pagination from '@/common/Pagination.vue'

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
const bankAccountDataFormRules = reactive<any>({})
const addListDepDataFormRef = ref<any>(null)
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
// 更新表单验证数据
const updateInvestmentFormRef = ref<any>(null)
// 分页器ref
const PaginationRef = ref<any>(null)

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
  updateInvestmentFormRef.value.validate((valid: Boolean) => {
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
  addListDepDataFormRef.value.validate((valid: Boolean) => {
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
  <!-- 添加 -->
  <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加收入信息</el-button>
  <!-- 表格 -->
  <Table
    :investmentData="investmentData"
    :loading="loading"
    @getInvestmentData="getInvestmentData"
    @clickUpdateInvestmen="clickUpdateInvestment"
  ></Table>
  <!-- 分页器 -->
  <Pagination ref="PaginationRef" @getData="getInvestmentData"></Pagination>
  <!-- 添加收入信息对话框 -->
  <el-dialog v-model="dialogVisible" title="添加收入信息" width="30%">
    <el-form
      ref="addListDepDataFormRef"
      :model="addListDepDataForm"
      :rules="bankAccountDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员编号">
        <el-input disabled v-model="addListDepDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="银行账户编号">
        <el-input v-model="addListDepDataForm.aid" placeholder="请输入银行账户编号"></el-input>
      </el-form-item>
      <el-form-item label="收入金额">
        <el-input v-model="addListDepDataForm.amount" placeholder="请输入收入金额"></el-input>
      </el-form-item>
      <el-form-item label="收入地址">
        <el-input v-model="addListDepDataForm.address" placeholder="请输入收入地址"></el-input>
      </el-form-item>
      <el-form-item label="交易机构">
        <el-input v-model="addListDepDataForm.transactionOrganization" placeholder="请输入交易机构"></el-input>
      </el-form-item>
      <el-form-item label="交易单号">
        <el-input v-model="addListDepDataForm.transactionNumber" placeholder="请输入交易单号"></el-input>
      </el-form-item>
      <el-form-item label="商户单号">
        <el-input v-model="addListDepDataForm.merchantNumber" placeholder="请输入商户单号"></el-input>
      </el-form-item>
      <el-form-item label="交易类型">
        <el-input v-model="addListDepDataForm.type" placeholder="请输入交易类型"></el-input>
      </el-form-item>
      <el-form-item label="交易商品">
        <el-input v-model="addListDepDataForm.commodity" placeholder="请输入交易商品"></el-input>
      </el-form-item>
      <el-form-item label="交易时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="addListDepDataForm.transactionHour"
          type="date"
          placeholder="请选择交易时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button
          @click="subaddListDepDataForm"
          color="#d3e4cd"
          type="primary"
          class="submit-btn"
        >立即添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
  <!-- 编辑 -->
  <el-dialog v-model="updateDialogVisible" title="编辑债务信息" width="30%">
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
      <el-form-item label="收入金额">
        <el-input v-model="updateInvestmentForm.amount" placeholder="请输入收入金额"></el-input>
      </el-form-item>
      <el-form-item label="收入地址">
        <el-input v-model="updateInvestmentForm.address" placeholder="请输入收入地址"></el-input>
      </el-form-item>
      <el-form-item label="交易机构">
        <el-input v-model="updateInvestmentForm.transactionOrganization" placeholder="请输入交易机构"></el-input>
      </el-form-item>
      <el-form-item label="交易单号">
        <el-input v-model="updateInvestmentForm.transactionNumber" placeholder="请输入交易单号"></el-input>
      </el-form-item>
      <el-form-item label="商户单号">
        <el-input v-model="updateInvestmentForm.merchantNumber" placeholder="请输入商户单号"></el-input>
      </el-form-item>
      <el-form-item label="交易类型">
        <el-input v-model="updateInvestmentForm.type" placeholder="请输入剩余还款金额"></el-input>
      </el-form-item>
      <el-form-item label="交易商品">
        <el-input v-model="updateInvestmentForm.commodity" placeholder="请输入剩余交易商品"></el-input>
      </el-form-item>
      <el-form-item label="交易时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateInvestmentForm.transactionHour"
          type="date"
          placeholder="请选择交易时间"
        ></el-date-picker>
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
