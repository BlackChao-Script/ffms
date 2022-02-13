<script setup lang='ts'>
import { reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addInvestment } from '@/api/investment'
import Table from '@/components/investment/Table.vue'

//! 数据
// 控制添加对话框数据
const dialogVisible = ref<Boolean | any>(false)
let addInvestmentDataForm = reactive<object | any>({
  uid: '',
  aid: '',
  name: '',
  investmentTime: '',
  type: '',
  amount: '',
  interestRate: ''
})
const bankAccountDataFormRules = reactive<any>({})
const addInvestmentDataFormRef = ref<any>(null)

//! 方法
const clickAddButton = () => {
  dialogVisible.value = true
  addInvestmentDataForm.aid = ''
  addInvestmentDataForm.investmentTime = ''
  addInvestmentDataForm.type = ''
  addInvestmentDataForm.amount = ''
  addInvestmentDataForm.interestRate = ''
}
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
    }).catch(() => ElMessage.error('添加失败'))
  })
}



</script>

<template>
  <!-- 添加 -->
  <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加投资信息</el-button>
  <!-- 表格 -->
  <Table :addInvestmentDataForm="addInvestmentDataForm"></Table>
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
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
