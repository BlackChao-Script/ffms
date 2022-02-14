<script setup lang='ts'>
import { ref } from 'vue-demi';

const { updateDialogVisible, updateInvestmentForm = {} } = defineProps({
  updateDialogVisible: Boolean,
  updateInvestmentForm: Object
})
const em = defineEmits(['subUpdateInvestmentForm'])

const updateInvestmentFormRef = ref<any>(null)

const subUpdateInvestmentForm = () => em('subUpdateInvestmentForm')

defineExpose({
  updateInvestmentFormRef
})
</script>

<template>
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
</style>
