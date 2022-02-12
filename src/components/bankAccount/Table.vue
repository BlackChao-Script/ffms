<script setup lang='ts'>
import { deleteBankAccount } from '@/api/bankAccount'
import { ElMessage } from 'element-plus'
const { bankAccountData } = defineProps({
  bankAccountData: Array,
})
const em = defineEmits(['clickUpdateBankAccount'])
const clickUpdateBankAccount = (data: any) => em('clickUpdateBankAccount', data)
const deleteBankAccountData = (id: string): any => {
  deleteBankAccount(id)
    .then(() => ElMessage.success('删除成功'))
    .catch(() => ElMessage.error('删除失败'))
}

</script>

<template>
  <el-table
    :default-sort="{ prop: 'accountOpeningTime', order: 'ascending' }"
    :stripe="true"
    :border="false"
    :data="bankAccountData"
    style="width: 100%;"
  >
    <el-table-column prop="id" label="编号" width="80" />
    <el-table-column sortable prop="accountOpeningTime" label="开户时间" width="150" />
    <el-table-column prop="name" label="银行账户名" width="150" />
    <el-table-column prop="cardNumber" label="银行账号" width="250" />
    <el-table-column prop="cardType" label="银行账户" width="150" />
    <el-table-column prop="accountOpeningAddress" label="开户地址" width="200" />
    <el-table-column prop="note" label="类型" width="100" />
    <el-table-column prop="password" label="密码" width="100" />
    <el-table-column prop="balance" label="账户余额" width="200" />
    <el-table-column label="操作">
      <template #default="scope">
        <el-button
          @click="clickUpdateBankAccount(scope.row)"
          color="#d3e4cd"
          style="color: white"
        >编辑</el-button>
        <el-popconfirm title="确定要删除?" @confirm="deleteBankAccountData(scope.row.id)">
          <template #reference>
            <el-button type="danger" style="color: white">删除</el-button>
          </template>
        </el-popconfirm>
      </template>
    </el-table-column>
  </el-table>
</template>

<style scoped lang="less">
</style>
