/*
 Navicat Premium Data Transfer

 Source Server         : system
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : ffms

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 11/02/2022 17:25:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bank_account
-- ----------------------------
DROP TABLE IF EXISTS `bank_account`;
CREATE TABLE `bank_account`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '银行账户编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行卡名',
  `password` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '6位银行密码',
  `card_number` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '19位银行卡号',
  `card_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行卡类型',
  `account_opening_time` date NULL DEFAULT NULL COMMENT '开户时间',
  `account_opening_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开户地址',
  `balance` decimal(10, 2) NULL DEFAULT NULL COMMENT '账户余额',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `card_number`(`card_number`) USING BTREE,
  INDEX `fk_accounts_user_id`(`uid`) USING BTREE,
  CONSTRAINT `fk_accounts_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行账户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '债务编号',
  `aid` bigint UNSIGNED NOT NULL COMMENT '银行账户编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '债务名',
  `creditor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '债权人',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '债务类型',
  `borrowing_amount` decimal(10, 0) NULL DEFAULT NULL COMMENT '借款金额',
  `repayment_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '还款金额',
  `end_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '剩余还款金额',
  `borrowing_time` datetime NULL DEFAULT NULL COMMENT '借款时间',
  `repayment_time` datetime NULL DEFAULT NULL COMMENT '还款时间',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录修改次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_dept_user_id`(`uid`) USING BTREE,
  INDEX `fk_dept_accounts_id`(`aid`) USING BTREE,
  CONSTRAINT `fk_dept_accounts_id` FOREIGN KEY (`aid`) REFERENCES `bank_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_dept_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '债务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for expenditure
-- ----------------------------
DROP TABLE IF EXISTS `expenditure`;
CREATE TABLE `expenditure`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '支出编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `aid` bigint UNSIGNED NOT NULL COMMENT '银行账户编号',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '支出金额',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易地址',
  `transaction_organization` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易组织',
  `transaction_hour` datetime NULL DEFAULT NULL COMMENT '交易时间',
  `transaction_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `merchant_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商户单号',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易类型',
  `commodity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易商品',
  `status` int NULL DEFAULT NULL COMMENT '交易状态，0代表交易成功，1代表交易失败',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_expenditure_user_id`(`uid`) USING BTREE,
  INDEX `fk_expenditure_accounts_id`(`aid`) USING BTREE,
  CONSTRAINT `fk_expenditure_accounts_id` FOREIGN KEY (`aid`) REFERENCES `bank_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_expenditure_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '支出表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for income
-- ----------------------------
DROP TABLE IF EXISTS `income`;
CREATE TABLE `income`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '支出编号',
  `aid` bigint UNSIGNED NOT NULL COMMENT '银行账户编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '支出金额',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易地址',
  `transaction_organization` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易组织',
  `transaction_hour` datetime NULL DEFAULT NULL COMMENT '交易时间',
  `transaction_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `merchant_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商户单号',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易类型',
  `commodity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易商品',
  `status` int NULL DEFAULT NULL COMMENT '交易状态，0代表交易成功，1代表交易失败',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_income_user_id`(`uid`) USING BTREE,
  INDEX `fk_income_accounts_id`(`aid`) USING BTREE,
  CONSTRAINT `fk_income_accounts_id` FOREIGN KEY (`aid`) REFERENCES `bank_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_income_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收入表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for investment
-- ----------------------------
DROP TABLE IF EXISTS `investment`;
CREATE TABLE `investment`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '投资信息编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `aid` bigint UNSIGNED NOT NULL COMMENT '银行账户编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '投资名',
  `investment_time` datetime NULL DEFAULT NULL COMMENT '投资时间',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '投资类型',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '投资金额',
  `interest_rate` double NULL DEFAULT NULL COMMENT '利率',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_investment_user_id`(`uid`) USING BTREE,
  INDEX `fk_investment_accounts_id`(`aid`) USING BTREE,
  CONSTRAINT `fk_investment_accounts_id` FOREIGN KEY (`aid`) REFERENCES `bank_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_investment_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '投资表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for monthly_statistics
-- ----------------------------
DROP TABLE IF EXISTS `monthly_statistics`;
CREATE TABLE `monthly_statistics`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '月统计编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `monthly_expenses` decimal(10, 2) NULL DEFAULT NULL COMMENT '月支出',
  `monthly_income` decimal(10, 2) NULL DEFAULT NULL COMMENT '月收入',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_monthly_user_id`(`uid`) USING BTREE,
  CONSTRAINT `fk_monthly_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '月统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '家庭成员编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭成员姓名',
  `password` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录系统密码',
  `card_id` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭成员身份证',
  `age` int NULL DEFAULT NULL COMMENT '家庭成员年龄',
  `sex` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭成员性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭成员手机号',
  `birthday` date NULL DEFAULT NULL COMMENT '家庭成员生日',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭成员邮箱',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '该账户类型',
  `status` int NULL DEFAULT NULL COMMENT '账户状态，0为注销，1为正常',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '账户创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该账户最后操作时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `card_id`(`card_id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '家庭成员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for year_statistics
-- ----------------------------
DROP TABLE IF EXISTS `year_statistics`;
CREATE TABLE `year_statistics`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '月统计编号',
  `uid` bigint UNSIGNED NOT NULL COMMENT '家庭成员编号',
  `year_expenses` decimal(10, 2) NULL DEFAULT NULL COMMENT '月支出',
  `year_income` decimal(10, 2) NULL DEFAULT NULL COMMENT '月收入',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '该记录创建时间',
  `last_modify_time` datetime NULL DEFAULT NULL COMMENT '该记录最后更新时间',
  `version` int NULL DEFAULT NULL COMMENT '该记录更新次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_year_user_id`(`uid`) USING BTREE,
  CONSTRAINT `fk_year_user_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '年统计表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
