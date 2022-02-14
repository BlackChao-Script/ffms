<script setup lang='ts'>
import { reactive, ref } from 'vue-demi';
import { ElMessage } from 'element-plus'
import { addIncome } from '@/api/income'
import Table from '@/components/income/Table.vue'

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
// Table组件ref
const TableRef = ref<any>(null)

//! 方法
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
      TableRef.value.getInvestmentData()
    }).catch(() => ElMessage.error('添加失败'))
  })
}

</script>

<template>
  <!-- 添加 -->
  <el-button @click="clickAddButton" color="#d3e4cd" style="color: white">添加收入信息</el-button>
  <!-- 表格 -->
  <Table ref="TableRef" :addListDepDataForm="addListDepDataForm"></Table>
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
</template>

<style scoped lang="less">
.el-button {
  margin-bottom: 20px;
}
</style>
