<script setup lang='ts'>
import { ref } from 'vue-demi';

const { dialogVisible, addListDepDataForm = {} } = defineProps({
  dialogVisible: Boolean,
  addListDepDataForm: Object
})
const em = defineEmits(['subaddListDepDataForm'])
// 获取添加表单ref
const addListDepDataFormRef = ref<any>(null)

const subaddListDepDataForm = () => em('subaddListDepDataForm')

defineExpose({
  addListDepDataFormRef
})

</script>

<template>
  <el-dialog v-model="dialogVisible" title="添加收入信息" width="30%">
    <el-form
      ref="addListDepDataFormRef"
      :model="addListDepDataForm"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员编号">
        <el-input disabled v-model="addListDepDataForm.uid"></el-input>
      </el-form-item>
      <el-form-item label="银行账户编号">
        <el-input v-model="addListDepDataForm.aid" placeholder="请输入银行账户编号"></el-input>
      </el-form-item>
      <el-form-item label="金额">
        <el-input v-model="addListDepDataForm.amount" placeholder="请输入收入金额"></el-input>
      </el-form-item>
      <el-form-item label="地址">
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
</style>
