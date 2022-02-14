<script setup lang='ts'>
import { ref } from 'vue-demi';

const { updatedialogVisible, updateBankAccountDataForm = {} } = defineProps({
  updatedialogVisible: Boolean,
  updateBankAccountDataForm: Object
})
const em = defineEmits(['SubUpdataBankAccount'])
// 获取添加表单ref
const addBankAccountFormRef = ref<any>(null)

const SubUpdataBankAccount = () => em('SubUpdataBankAccount')

defineExpose({
  addBankAccountFormRef
})
</script>

<template>
  <el-dialog v-model="updatedialogVisible" title="编辑" width="30%">
    <el-form
      ref="updateBankAccountForm"
      :model="updateBankAccountDataForm"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员id" prop="name">
        <el-input disabled v-model="updateBankAccountDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="类型">
        <el-input v-model="updateBankAccountDataForm.note" placeholder="请输入类型"></el-input>
      </el-form-item>
      <el-form-item label="银行账户名">
        <el-input v-model="updateBankAccountDataForm.name" placeholder="请输入银行账户名"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="updateBankAccountDataForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="银行账号">
        <el-input v-model="updateBankAccountDataForm.cardNumber" placeholder="请输入银行账号"></el-input>
      </el-form-item>
      <el-form-item label="银行账户">
        <el-input v-model="updateBankAccountDataForm.cardType" placeholder="请输入银行账户"></el-input>
      </el-form-item>
      <el-form-item label="开户地址">
        <el-input v-model="updateBankAccountDataForm.accountOpeningAddress" placeholder="请输入开户地址"></el-input>
      </el-form-item>
      <el-form-item label="开户时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateBankAccountDataForm.accountOpeningTime"
          type="date"
          placeholder="请选择开户时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="账户余额">
        <el-input v-model="updateBankAccountDataForm.balance" placeholder="请输入账户余额"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button
          @click="SubUpdataBankAccount"
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
