<script setup lang='ts'>
import { onMounted, reactive, ref } from 'vue-demi';
import { getListIncome, updateIncome, deleteIncome } from '@/api/income'
import { PageDataType } from '@/types'
import { ElMessage } from 'element-plus'

//! 数据
// 接收父组件传递的数据
const { addListDepDataForm = {} } = defineProps({
  addListDepDataForm: Object
})
// 表格数据
const investmentData = ref<Array<any>>([]) as any
// 家庭成员id
const id = ref<string>('')
// 分页器数据
const pageData = reactive<PageDataType>({
  pageNum: 1,
  pageSize: 5,
  total: 0
})
// 控制更新对话框数据
const updateDialogVisible = ref<Boolean>(false) as any
// 加载动画数据
const loading = ref<Boolean>(true) as any
// 更新表单数据
const updateInvestmentForm = ref<object | any>({})
// 更新表单验证数据
const updateInvestmentFormRef = ref<any>(null)

//! 方法
// 获取表格数据
const getInvestmentData = async () => {
  const res = await getListIncome(id.value, pageData.pageNum + '', pageData.pageSize + '')
  pageData.total = res.data.totalNumber
  res.data.data.forEach((data: any) => {
    data.transactionHour = data.transactionHour.split('T')[0]
  })
  investmentData.value = res.data.data
  loading.value = false
}
// 点击编辑
const clickUpdateInvestment = (data: any) => {
  const { bankAccount, createTime, version, lastModifyTime, ...parmas } = data
  updateInvestmentForm.value = parmas
  updateDialogVisible.value = true
}
// 提交更新表单
const subUpdateInvestmentForm = () => {
  updateInvestmentFormRef.value.validate((valid: Boolean) => {
    if (!valid) return
    updateIncome(
      updateInvestmentForm.value.id,
      updateInvestmentForm.value.uid,
      updateInvestmentForm.value.aid,
      updateInvestmentForm.value.amount,
      updateInvestmentForm.value.address,
      updateInvestmentForm.value.transactionOrganization,
      updateInvestmentForm.value.transactionHour + 'T19:13:21',
      updateInvestmentForm.value.transactionNumber,
      updateInvestmentForm.value.merchantNumber,
      updateInvestmentForm.value.type,
      updateInvestmentForm.value.commodity,
    ).then(() => {
      ElMessage.success('编辑成功')
      updateDialogVisible.value = false
      getInvestmentData()
    }).catch(() => ElMessage.error('编辑失败'))
  })
}
// 删除数据
const deleteInvestmentData = (id: string): any => {
  deleteIncome(id)
    .then(() => {
      ElMessage.success('删除成功')
      getInvestmentData()
    })
    .catch(() => ElMessage.error('删除失败'))
}
const handleSizeChange = (val: number) => {
  pageData.pageSize = val
  getInvestmentData()
}
const handleCurrentChange = (val: number) => {
  pageData.pageNum = val
  getInvestmentData()
}

onMounted(() => {
  id.value = window.sessionStorage.getItem('uid') as string
  addListDepDataForm.uid = window.sessionStorage.getItem('uid') as string
  getInvestmentData()
})

defineExpose({
  getInvestmentData
})
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

  <!-- 分页器 -->
  <el-pagination
    :page-sizes="[3, 5, 10]"
    :page-size="pageData.pageSize"
    layout="sizes, prev, pager, next"
    :total="pageData.total"
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange"
  ></el-pagination>
  <!-- 编辑 -->
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
      <el-form-item label="收入金额">
        <el-input v-model="updateInvestmentForm.amount" placeholder="请输入收入金额"></el-input>
      </el-form-item>
      <el-form-item label="收入地址">
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
.expandcard {
  width: 50%;
  margin-left: 10px;
}
</style>

