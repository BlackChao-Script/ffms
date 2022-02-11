<script setup lang='ts'>

const props = defineProps({
  UserData: Array,
  loading: Boolean
})

const em = defineEmits(['updateUser', 'cancelAccountUser', 'recoverUser'])

const updateUser = (data: any) => em('updateUser', data)
const cancelAccountUser = (id: string) => em('cancelAccountUser', id)
const recoverUser = (id: string) => em('recoverUser', id)

</script>

<template>
  <el-table
    :default-sort="{ prop: 'createTime', order: 'ascending' }"
    :stripe="true"
    :border="false"
    :data="props.UserData"
    v-loading="props.loading"
    style="width: 100%"
  >
    <el-table-column type="index" />
    <el-table-column sortable prop="createTime" label="创建用户时间" width="150" />
    <el-table-column prop="name" label="姓名" width="90" />
    <el-table-column prop="cardId" label="身份证号码" width="170" />
    <el-table-column prop="birthday" label="出生日期" width="100" />
    <el-table-column prop="age" label="年龄" width="60" />
    <el-table-column prop="email" label="电子邮箱" width="200" />
    <el-table-column prop="sex" label="性别" width="80" />
    <el-table-column prop="note" label="身份" width="100" />
    <el-table-column prop="phone" label="联系方式" width="180" />
    <el-table-column prop="type" label="权限" width="100" />
    <el-table-column label="状态" width="100">
      <template #default="scope">
        <el-tag
          effect="plain"
          type="success"
          class="mx-1"
          size="large"
          v-if="scope.row.status == 1"
        >正常</el-tag>
        <el-tag effect="plain" type="warning" class="mx-1" size="large" v-else>注销</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作">
      <template #default="scope">
        <el-button color="#d3e4cd" style="color: white" @click="updateUser(scope.row)">编辑</el-button>
        <el-button
          v-if="scope.row.status == 1"
          @click="cancelAccountUser(scope.row.id)"
          type="warning"
          style="color: white"
        >注销</el-button>
        <el-button v-else type="success" @click="recoverUser(scope.row.id)" style="color: white">恢复</el-button>
      </template>
    </el-table-column>
  </el-table>
</template>
