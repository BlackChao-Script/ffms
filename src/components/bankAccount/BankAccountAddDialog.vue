<script setup lang='ts'>
import { ref } from 'vue-demi';

const { dialogVisible, bankAccountDataForm = {} } = defineProps({
  dialogVisible: Boolean,
  bankAccountDataForm: Object
})
const em = defineEmits(['SubAddBankAccount'])
// 获取添加表单ref
const addBankAccountFormRef = ref<any>(null)

const SubAddBankAccount = () => em('SubAddBankAccount')

defineExpose({
  addBankAccountFormRef
})

</script>

<template>
  <el-dialog v-model="dialogVisible" title="添加" width="30%">
    <el-form
      ref="addBankAccountFormRef"
      :model="bankAccountDataForm"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="类型">
        <el-input v-model="bankAccountDataForm.note" placeholder="请输入类型"></el-input>
      </el-form-item>
      <el-form-item label="银行账户名">
        <el-input v-model="bankAccountDataForm.name" placeholder="请输入银行账户名"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="bankAccountDataForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="银行账号">
        <el-input v-model="bankAccountDataForm.cardNumber" placeholder="请输入银行账号"></el-input>
      </el-form-item>
      <el-form-item label="银行账户">
        <el-input v-model="bankAccountDataForm.cardType" placeholder="请输入银行账户"></el-input>
      </el-form-item>
      <el-form-item label="开户地址">
        <el-input v-model="bankAccountDataForm.accountOpeningAddress" placeholder="请输入开户地址"></el-input>
      </el-form-item>
      <el-form-item label="开户时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="bankAccountDataForm.accountOpeningTime"
          type="date"
          placeholder="请选择开户时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="账户余额">
        <el-input v-model="bankAccountDataForm.balance" placeholder="请输入账户余额"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button @click="SubAddBankAccount" color="#d3e4cd" type="primary" class="submit-btn">立即添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<style scoped lang="less">
</style>
