<script setup lang='ts'>
const { dialogVisible, UserDataForm = {}, UserDataFormRules } = defineProps({
  dialogVisible: Boolean,
  UserDataFormRules: Object,
  UserDataForm: Object
})
const em = defineEmits(['changUserForm'])
const changUserForm = () => em('changUserForm')
</script>

<template>
  <el-dialog v-model="dialogVisible" title="编辑" width="30%">
    <el-form
      ref="userForm"
      :model="UserDataForm"
      :rules="UserDataFormRules"
      label-width="100px"
      class="loginForm sign-in-form"
    >
      <el-form-item label="家庭成员名" prop="name">
        <el-input v-model="UserDataForm.name" placeholder="请输入家庭成员名"></el-input>
      </el-form-item>
      <el-form-item label="身份">
        <el-input v-model="UserDataForm.note" placeholder="请输入身份"></el-input>
      </el-form-item>
      <el-form-item label="年龄">
        <el-input v-model="UserDataForm.age" placeholder="请输入年龄"></el-input>
      </el-form-item>
      <el-form-item label="性别">
        <el-radio v-model="UserDataForm.sex" label="男" size="large">男</el-radio>
        <el-radio v-model="UserDataForm.sex" label="女" size="large">女</el-radio>
      </el-form-item>
      <el-form-item label="身份证号码">
        <el-input v-model="UserDataForm.cardId" placeholder="请输入身份证号码"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="UserDataForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="联系方式">
        <el-input v-model="UserDataForm.phone" placeholder="请输入联系方式"></el-input>
      </el-form-item>
      <el-form-item label="权限" prop="type">
        <el-radio v-model="UserDataForm.type" label="管理员" size="large">管理员</el-radio>
        <el-radio v-model="UserDataForm.type" label="家庭成员" size="large">家庭成员</el-radio>
      </el-form-item>
      <el-form-item label="电子邮箱">
        <el-input v-model="UserDataForm.email" placeholder="请输入电子邮箱"></el-input>
      </el-form-item>
      <el-form-item label="出生日期">
        <el-date-picker
          value-format="YYYY-MM-DD"
          v-model="UserDataForm.birthday"
          type="date"
          placeholder="请选择出生日期"
        ></el-date-picker>
      </el-form-item>

      <el-form-item>
        <el-button @click="changUserForm" color="#d3e4cd" type="primary" class="submit-btn">完成修改</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>
