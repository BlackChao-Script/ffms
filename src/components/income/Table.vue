<script setup lang='ts'>
import { deleteIncome } from '@/api/income'
import { ElMessage } from 'element-plus'

const { investmentData } = defineProps({
  investmentData: Array,
  loading: Boolean
})
const em = defineEmits(['getInvestmentData', 'clickUpdateInvestment'])
const getInvestmentData = () => em('getInvestmentData')
const clickUpdateInvestment = (data: any) => em('clickUpdateInvestment', data)

const deleteInvestmentData = (id: string): any => {
  deleteIncome(id)
    .then(() => {
      ElMessage.success('删除成功')
      getInvestmentData()
    })
    .catch(() => ElMessage.error('删除失败'))
}


</script>

<template>
  <!-- 表格 -->
  <el-row type="flex" justify="center">
    <el-col :span="24">
      <el-card>
        <el-table
          :default-sort="{ prop: 'investmentTime', order: 'ascending' }"
          :stripe="true"
          :border="false"
          :loading="loading"
          :data="investmentData"
          style="width: 100%;"
        >
          <el-table-column type="expand">
            <template #default="props">
              <el-card class="expandcard">
                <el-descriptions border title="银行卡信息">
                  <el-descriptions-item label="银行账户名">{{ props.row.bankAccount.name }}</el-descriptions-item>
                  <el-descriptions-item label="银行卡类型">
                    <el-tag size="small">{{ props.row.bankAccount.cardType }}</el-tag>
                  </el-descriptions-item>
                  <el-descriptions-item label="银行账户号码">{{ props.row.bankAccount.cardNumber }}</el-descriptions-item>
                  <el-descriptions-item label="余额">{{ props.row.bankAccount.balance }}</el-descriptions-item>
                  <el-descriptions-item label="备注">{{ props.row.bankAccount.note }}</el-descriptions-item>
                </el-descriptions>
              </el-card>
            </template>
          </el-table-column>
          <el-table-column prop="id" label="编号" width="80" />
          <el-table-column prop="address" label="交易地址" width="200" />
          <el-table-column prop="uid" label="家庭成员编号" width="130" />
          <el-table-column prop="aid" label="银行账户编号" width="130" />
          <el-table-column prop="transactionOrganization" label="交易机构" width="130" />
          <el-table-column prop="transactionHour" label="交易时间" width="130" />
          <el-table-column prop="transactionNumber" label="交易单号" width="150" />
          <el-table-column prop="merchantNumber" label="商户号" width="130" />
          <el-table-column prop="type" label="交易类型" width="130" />
          <el-table-column prop="commodity" label="交易商品" width="130" />

          <el-table-column label="操作" fixed="right" width="240">
            <template #default="scope">
              <el-button
                @click="clickUpdateInvestment(scope.row)"
                color="#d3e4cd"
                style="color: white"
              >编辑</el-button>
              <el-popconfirm title="确定要删除?" @confirm="deleteInvestmentData(scope.row.id)">
                <template #reference>
                  <el-button type="danger" style="color: white">删除</el-button>
                </template>
              </el-popconfirm>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </el-col>
  </el-row>
</template>

<style scoped lang="less">
.expandcard {
  width: 50%;
  margin-left: 10px;
}
</style>

