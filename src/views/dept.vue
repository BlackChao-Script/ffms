<script setup lang='ts'>
import { reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addListDept } from '@/api/dept'
import Table from '@/components/dept/Table.vue'

//! 数据
// 控制添加对话框数据
const dialogVisible = ref<Boolean | any>(false)
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
const bankAccountDataFormRules = reactive<any>({})
const addListDepDataFormRef = ref<any>(null)
const TableRef = ref<any>(null)

//! 方法
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
      TableRef.value.getInvestmentData()
    }).catch(() => ElMessage.error('添加失败'))
  })
}

</script>

<template>
  <!-- 添加 -->
  <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加债务信息</el-button>
  <!-- 表格 -->
  <Table ref="TableRef" :addListDepDataForm="addListDepDataForm"></Table>
  <!-- 添加添加债务信息对话框 -->
  <el-dialog v-model="dialogVisible" title="添加债务信息" width="30%">
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
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
