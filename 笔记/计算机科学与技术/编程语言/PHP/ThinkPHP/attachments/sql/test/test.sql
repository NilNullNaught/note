/*
 Navicat MySQL Data Transfer

 Source Server         : 8.131.72.52
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 8.131.72.52:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 24/03/2021 17:40:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` smallint(6) NOT NULL,
  `gender` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES (1, '张三', 18, 1);
INSERT INTO `person` VALUES (2, '李四', 18, 0);
INSERT INTO `person` VALUES (3, '王二', 19, 1);
INSERT INTO `person` VALUES (4, '麻子', 20, 0);
INSERT INTO `person` VALUES (5, '麻子', 20, 0);

SET FOREIGN_KEY_CHECKS = 1;
