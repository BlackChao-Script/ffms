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
      <el-form-item label="金额">
        <el-input v-model="updateInvestmentForm.amount" placeholder="请输入收入金额"></el-input>
      </el-form-item>
      <el-form-item label="地址">
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
</style>
