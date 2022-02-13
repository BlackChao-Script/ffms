<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { getListInvestment, updateInvestment, deleteInvestment } from '@/api/investment'
import { PageDataType } from '@/types'
import { ElMessage } from 'element-plus'
import Pagination from '@/common/Pagination.vue'

const { addInvestmentDataForm = {} } = defineProps({
  addInvestmentDataForm: Object
})
const investmentData = ref<Array<any>>([]) as any
const id = ref<string>('')
const pageData = reactive<PageDataType>({
  pageNum: 1,
  pageSize: 3,
  total: 0
})
const updateDialogVisible = ref<Boolean>(false) as any
const loading = ref<Boolean>(true) as any
const updateInvestmentForm = ref<object | any>({})
const updateInvestmentFormRef = ref<any>(null)

const getInvestmentData = async () => {
  const res = await getListInvestment(id.value, pageData.pageNum + '', pageData.pageSize + '')
  pageData.total = res.data.totalNumber
  res.data.data.forEach((data: any) => data.investmentTime = data.investmentTime.split('T')[0]);
  investmentData.value = res.data.data
  loading.value = false
}

onMounted(() => {
  id.value = window.sessionStorage.getItem('uid') as string
  addInvestmentDataForm.uid = window.sessionStorage.getItem('uid') as string
  getInvestmentData()
})
const clickUpdateInvestment = (data: any) => {
  const { bankAccount, createTime, version, lastModifyTime, ...parmas } = data
  updateInvestmentForm.value = parmas
  updateDialogVisible.value = true
}
const subUpdateInvestmentForm = () => {
  updateInvestmentFormRef.value.validate((valid: Boolean) => {
    if (!valid) return
    updateInvestment(
      updateInvestmentForm.value.id,
      updateInvestmentForm.value.uid,
      updateInvestmentForm.value.aid,
      updateInvestmentForm.value.name,
      updateInvestmentForm.value.investmentTime + 'T19:13:21',
      updateInvestmentForm.value.type,
      updateInvestmentForm.value.amount,
      updateInvestmentForm.value.interestRate
    ).then(() => {
      ElMessage.success('编辑成功')
      updateDialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('编辑失败'))
  })
}
const deleteInvestmentData = (id: string): any => {
  deleteInvestment(id)
    .then(() => {
      ElMessage.success('删除成功')
      getInvestmentData()
    })
    .catch(() => ElMessage.error('删除失败'))
}

</script>

<template>
  <el-table
    :default-sort="{ prop: 'investmentTime', order: 'ascending' }"
    :stripe="true"
    :border="false"
    :data="investmentData"
    style="width: 100%;"
  >
    <el-table-column type="expand">
      <template #default="props">
        <el-card>
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
    <el-table-column prop="name" label="投资名" width="130" />
    <el-table-column prop="uid" label="家庭成员编号" width="130" />
    <el-table-column prop="aid" label="银行账户编号" width="130" />
    <el-table-column prop="investmentTime" label="投资时间" width="130" />
    <el-table-column prop="amount" label="投资金额" width="130" />
    <el-table-column prop="interestRate" label="利润" width="130" />

    <el-table-column label="操作">
      <template #default="scope">
        <el-button @click="clickUpdateInvestment(scope.row)" color="#d3e4cd" style="color: white">编辑</el-button>
        <el-popconfirm title="确定要删除?" @confirm="deleteInvestmentData(scope.row.id)">
          <template #reference>
            <el-button type="danger" style="color: white">删除</el-button>
          </template>
        </el-popconfirm>
      </template>
    </el-table-column>
  </el-table>

  <Pagination :pageData="pageData"></Pagination>

  <el-dialog v-model="updateDialogVisible" title="添加投资信息" width="30%">
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
      <el-form-item label="投资名">
        <el-input v-model="updateInvestmentForm.name" placeholder="请输入投资名"></el-input>
      </el-form-item>
      <el-form-item label="投资时间">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="updateInvestmentForm.investmentTime"
          type="date"
          placeholder="请选择投资时间"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="投资类型">
        <el-input v-model="updateInvestmentForm.type" placeholder="请输入投资类型"></el-input>
      </el-form-item>
      <el-form-item label="投资金额">
        <el-input v-model="updateInvestmentForm.amount" placeholder="请输入投资金额"></el-input>
      </el-form-item>
      <el-form-item label="利润">
        <el-input v-model="updateInvestmentForm.interestRate" placeholder="请输入利润"></el-input>
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
.el-card {
  width: 50%;
  margin-left: 10px;
}
</style>

