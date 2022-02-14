<script setup lang='ts'>
import { reactive, ref, onMounted } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addListDept, getlistDept, updateListDept } from '@/api/dept'
import AddButton from '@/common/AddButton.vue'
import Table from '@/components/dept/Table.vue'
import Pagination from '@/common/Pagination.vue'

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
// 添加表单数据验证
const addListDepDataFormRules = reactive<any>({})
// 添加表单ref
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
  updateInvestmentFormRef.value.validate((valid: Boolean) => {
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
  addListDepDataFormRef.value.validate((valid: Boolean) => {
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
  <el-dialog v-model="dialogVisible" title="添加债务信息" width="30%">
    <el-form
      ref="addListDepDataFormRef"
      :model="addListDepDataForm"
      :rules="addListDepDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员编号">
        <el-input disabled v-model="addListDepDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="银行账户编号">
        <el-input v-model="addListDepDataForm.aid" placeholder="请输入银行账户编号"></el-input>
      </el-form-item>
      <el-form-item label="债务名">
        <el-input v-model="addListDepDataForm.name" placeholder="请输入债务名"></el-input>
      </el-form-item>
      <el-form-item label="债权人">
        <el-input v-model="addListDepDataForm.creditor" placeholder="请输入债权人"></el-input>
      </el-form-item>
      <el-form-item label="债权类型">
        <el-input v-model="addListDepDataForm.type" placeholder="请输入债权类型"></el-input>
      </el-form-item>
      <el-form-item label="借债金额">
        <el-input v-model="addListDepDataForm.borrowingAmount" placeholder="请输入借债金额"></el-input>
      </el-form-item>
      <el-form-item label="还款金额">
        <el-input v-model="addListDepDataForm.repaymentAmount" placeholder="请输入还款金额"></el-input>
      </el-form-item>
      <el-form-item label="剩余还款金额">
        <el-input v-model="addListDepDataForm.endAmount" placeholder="请输入剩余还款金额"></el-input>
      </el-form-item>
      <el-form-item label="借款时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="addListDepDataForm.borrowingTime"
          type="date"
          placeholder="请选择借款时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="还款时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="addListDepDataForm.repaymentTime"
          type="date"
          placeholder="请选择还款时间"
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
  <!-- 编辑债务信息对话框 -->
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
      <el-form-item label="债务名">
        <el-input v-model="updateInvestmentForm.name" placeholder="请输入债务名"></el-input>
      </el-form-item>
      <el-form-item label="债权人">
        <el-input v-model="updateInvestmentForm.creditor" placeholder="请输入债权人"></el-input>
      </el-form-item>
      <el-form-item label="债权类型">
        <el-input v-model="updateInvestmentForm.type" placeholder="请输入债权类型"></el-input>
      </el-form-item>
      <el-form-item label="借债金额">
        <el-input v-model="updateInvestmentForm.borrowingAmount" placeholder="请输入借债金额"></el-input>
      </el-form-item>
      <el-form-item label="还款金额">
        <el-input v-model="updateInvestmentForm.repaymentAmount" placeholder="请输入还款金额"></el-input>
      </el-form-item>
      <el-form-item label="剩余还款金额">
        <el-input v-model="updateInvestmentForm.endAmount" placeholder="请输入剩余还款金额"></el-input>
      </el-form-item>
      <el-form-item label="借款时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateInvestmentForm.borrowingTime"
          type="date"
          placeholder="请选择借款时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="还款时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateInvestmentForm.repaymentTime"
          type="date"
          placeholder="请选择还款时间"
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
