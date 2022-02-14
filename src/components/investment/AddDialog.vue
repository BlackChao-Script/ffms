<script setup lang='ts'>
import { ref } from 'vue-demi';

const { dialogVisible, addInvestmentDataForm = {} } = defineProps({
  dialogVisible: Boolean,
  addInvestmentDataForm: Object
})
const em = defineEmits(['subAddInvestmentDataForm'])
// 获取添加表单ref
const addInvestmentDataFormRef = ref<any>(null)

const subAddInvestmentDataForm = () => em('subAddInvestmentDataForm')

defineExpose({
  addInvestmentDataFormRef
})

</script>

<template>
  <el-dialog v-model="dialogVisible" title="添加投资信息" width="30%">
    <el-form
      ref="addInvestmentDataFormRef"
      :model="addInvestmentDataForm"
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
</style>
