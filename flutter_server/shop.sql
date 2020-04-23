/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : shop

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 21/04/2020 15:06:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_url` varchar(255) DEFAULT NULL,
  `type` bigint DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `goods_id` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of banners
-- ----------------------------
BEGIN;
INSERT INTO `banners` VALUES (1, 'http://127.0.0.1:8000/images/banner/1.jpeg', 0, '2020-02-18 05:12:21', '2020-02-18 05:12:21', NULL);
INSERT INTO `banners` VALUES (2, 'http://127.0.0.1:8000/images/banner/2.jpeg', 0, '2020-02-18 05:12:33', '2020-02-18 05:12:33', NULL);
INSERT INTO `banners` VALUES (3, 'http://127.0.0.1:8000/images/banner/3.jpeg', 0, '2020-02-18 05:12:36', '2020-02-18 05:12:36', NULL);
INSERT INTO `banners` VALUES (4, 'http://127.0.0.1:8000/images/banner/4.jpeg', 0, '2020-02-18 05:12:40', '2020-02-18 05:12:40', NULL);
INSERT INTO `banners` VALUES (5, 'http://127.0.0.1:8000/images/advert/ad01.png', 1, '2020-02-18 05:13:18', '2020-02-18 05:13:18', NULL);
INSERT INTO `banners` VALUES (6, 'http://127.0.0.1:8000/images/advert/ad02.png', 1, '2020-02-18 05:13:23', '2020-02-18 05:13:23', NULL);
INSERT INTO `banners` VALUES (7, 'http://127.0.0.1:8000/images/category/1.png', 2, '2020-02-18 06:54:38', '2020-02-18 06:54:38', NULL);
INSERT INTO `banners` VALUES (8, 'http://127.0.0.1:8000/images/category/2.png', 2, '2020-02-18 06:54:44', '2020-02-18 06:54:44', NULL);
INSERT INTO `banners` VALUES (9, 'http://127.0.0.1:8000/images/category/3.png', 2, '2020-02-18 06:54:47', '2020-02-18 06:54:47', NULL);
INSERT INTO `banners` VALUES (10, 'http://127.0.0.1:8000/images/category/4.png', 2, '2020-02-18 06:54:52', '2020-02-18 06:54:52', NULL);
INSERT INTO `banners` VALUES (11, 'http://127.0.0.1:8000/images/category/5.png', 2, '2020-02-18 06:54:56', '2020-02-18 06:54:56', NULL);
INSERT INTO `banners` VALUES (12, 'http://127.0.0.1:8000/images/category/6.png', 2, '2020-02-18 06:54:59', '2020-02-18 06:54:59', NULL);
INSERT INTO `banners` VALUES (13, 'http://127.0.0.1:8000/images/category/7.png', 2, '2020-02-18 06:55:02', '2020-02-18 06:55:02', NULL);
INSERT INTO `banners` VALUES (14, 'http://127.0.0.1:8000/images/category/8.png', 2, '2020-02-18 06:55:07', '2020-02-18 06:55:07', NULL);
INSERT INTO `banners` VALUES (15, 'http://127.0.0.1:8000/images/category/9.png', 2, '2020-02-18 06:55:13', '2020-02-18 06:55:13', NULL);
INSERT INTO `banners` VALUES (16, 'http://127.0.0.1:8000/images/category/10.png', 2, '2020-02-18 06:55:16', '2020-02-18 06:55:16', NULL);
INSERT INTO `banners` VALUES (18, 'http://127.0.0.1:8000/images/floor/1.png', 3, '2020-04-16 00:51:01', '2020-04-16 00:51:01', NULL);
INSERT INTO `banners` VALUES (19, 'http://127.0.0.1:8000/images/floor/2.png', 3, '2020-04-16 00:51:27', '2020-04-16 00:51:27', NULL);
INSERT INTO `banners` VALUES (20, 'http://127.0.0.1:8000/images/floor/3.png', 3, '2020-04-16 00:51:33', '2020-04-16 00:51:33', NULL);
INSERT INTO `banners` VALUES (21, 'http://127.0.0.1:8000/images/floor/4.png', 3, '2020-04-16 00:51:38', '2020-04-16 00:51:38', NULL);
INSERT INTO `banners` VALUES (22, 'http://127.0.0.1:8000/images/floor/5.png', 3, '2020-04-16 00:51:45', '2020-04-16 00:51:45', NULL);
INSERT INTO `banners` VALUES (23, 'http://127.0.0.1:8000/images/floor/6.png', 3, '2020-04-16 00:51:50', '2020-04-16 00:51:50', NULL);
INSERT INTO `banners` VALUES (24, 'http://127.0.0.1:8000/images/floor/7.png', 3, '2020-04-16 00:51:56', '2020-04-16 00:51:56', NULL);
COMMIT;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `g_name` varchar(255) DEFAULT NULL,
  `pre_price` bigint DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `categroy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sub_categroy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `s_img` varchar(255) DEFAULT NULL,
  `s_imgs` varchar(2555) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` bigint DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `create_id` varchar(255) DEFAULT NULL,
  `g_size` varchar(255) DEFAULT NULL,
  `g_try` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `goods_id` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of goods
-- ----------------------------
BEGIN;
INSERT INTO `goods` VALUES (3, '法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙', 21, 20, '4', '42', 'http://127.0.0.1:8000/images/goods/001/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/001/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/001/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/001/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/001/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/001/5.jpg\" />', 1, '长裙', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:17:33', '2020-04-15 14:17:33', '001');
INSERT INTO `goods` VALUES (4, '柔美而精致~高贵而优雅~圆领金银丝春季毛衣羊毛开衫女短款白外套', 21, 20, '1', '11', 'http://127.0.0.1:8000/images/goods/002/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/002/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/002/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/002/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/002/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/002/5.jpg\" />', 1, '毛衣', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:18:15', '2020-04-15 14:18:15', '002');
INSERT INTO `goods` VALUES (5, '明星同款高端西服2019春装新款韩版英伦风短款格子小西装女外套潮', 21, 20, '2', '21', 'http://127.0.0.1:8000/images/goods/003/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/003/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/003/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/003/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/003/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/003/5.jpg\" />', 1, '西装', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:18:31', '2020-04-15 14:18:31', '003');
INSERT INTO `goods` VALUES (6, '复古廓形机车进口绵羊皮衣真皮外套女E142', 21, 20, '3', '31', 'http://127.0.0.1:8000/images/goods/004/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/004/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/004/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/004/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/004/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/004/5.jpg\" />', 1, '外套', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:18:37', '2020-04-15 14:18:37', '004');
INSERT INTO `goods` VALUES (7, '单排扣高腰牛仔裤女春夏薄款紧身弹力小脚裤显瘦百搭网红浅色长裤', 21, 20, '5', '52', 'http://127.0.0.1:8000/images/goods/005/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/005/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/005/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/005/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/005/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/005/5.jpg\" />', 1, '牛仔裤', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:18:41', '2020-04-15 14:18:41', '005');
INSERT INTO `goods` VALUES (8, 'MIUCO女装夏季重工星星烫钻圆领短袖宽松显瘦百搭T恤上衣k', 21, 20, '6', '61', 'http://127.0.0.1:8000/images/goods/006/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/006/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/006/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/006/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/006/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/006/5.jpg\" />', 1, 'T恤', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:18:48', '2020-04-15 14:18:48', '006');
INSERT INTO `goods` VALUES (9, '春夏一步裙包臀裙开叉弹力修身显瘦短裙黑色高腰职业半身裙', 21, 20, '4', '41', 'http://127.0.0.1:8000/images/goods/007/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/5.jpg\" />', 1, '短裙', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:18:54', '2020-04-15 14:18:54', '007');
INSERT INTO `goods` VALUES (10, '夏季新款短袖圆领紧身小黑超短裙开叉包臀性感连衣裙夜店女装', 21, 20, '8', '82', 'http://127.0.0.1:8000/images/goods/008/cover.jpg', '<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:8000/images/goods/007/5.jpg\" />', 1, '连衣裙', 'FE23424234', '2323', 'wefewfewf', '2020-04-15 14:19:01', '2020-04-15 14:19:01', '008');
COMMIT;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tags
-- ----------------------------
BEGIN;
INSERT INTO `tags` VALUES (1, '2', '[\"毛衣\", \"西服\", \"皮衣\", \"连衣裙\", \"牛仔裤\", \"T恤\", \"运动裤\", \"短裤\", \"礼服\", \"风衣\"]', '2020-04-21 05:38:27', '2020-04-21 05:38:27');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_id` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `cart` varchar(2555) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '[]',
  `paied` varchar(2555) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '[]',
  `received` varchar(2555) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, '12312433553', '111', 'http://127.0.0.1:8000/images/headerImgs/boy.jpg', 'sdcsvsdf', 'efwaevw', '12312433553', '2020-04-17 15:23:36', '2020-04-21 06:56:28', '[{\"goodsId\":\"004\",\"goodsName\":\"复古廓形机车进口绵羊皮衣真皮外套女E142\",\"count\":2,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/004/cover.jpg\",\"isCheck\":true},{\"goodsId\":\"006\",\"goodsName\":\"MIUCO女装夏季重工星星烫钻圆领短袖宽松显瘦百搭T恤上衣k\",\"count\":1,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/006/cover.jpg\",\"isCheck\":true},{\"goodsId\":\"004\",\"goodsName\":\"复古廓形机车进口绵羊皮衣真皮外套女E142\",\"count\":2,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/004/cover.jpg\",\"isCheck\":true},{\"goodsId\":\"006\",\"goodsName\":\"MIUCO女装夏季重工星星烫钻圆领短袖宽松显瘦百搭T恤上衣k\",\"count\":1,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/006/cover.jpg\",\"isCheck\":true}]', '[[{\"goodsId\":\"003\",\"goodsName\":\"明星同款高端西服2019春装新款韩版英伦风短款格子小西装女外套潮\",\"count\":1,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/003/cover.jpg\",\"isCheck\":true}],[{\"goodsId\":\"005\",\"goodsName\":\"单排扣高腰牛仔裤女春夏薄款紧身弹力小脚裤显瘦百搭网红浅色长裤\",\"count\":1,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/005/cover.jpg\",\"isCheck\":true}]]', '[[{\"goodsId\":\"006\",\"goodsName\":\"MIUCO女装夏季重工星星烫钻圆领短袖宽松显瘦百搭T恤上衣k\",\"count\":1,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/006/cover.jpg\",\"isCheck\":true},{\"goodsId\":\"002\",\"goodsName\":\"柔美而精致~高贵而优雅~圆领金银丝春季毛衣羊毛开衫女短款白外套\",\"count\":2,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/002/cover.jpg\",\"isCheck\":true}]]');
INSERT INTO `users` VALUES (2, '53234234343', '222', 'http://127.0.0.1:8000/images/headerImgs/girl.jpeg', 'edsf', 'dvsa', '53234234343', '2020-04-17 15:31:13', '2020-04-21 05:22:45', '[{\"goodsId\":\"005\",\"goodsName\":\"单排扣高腰牛仔裤女春夏薄款紧身弹力小脚裤显瘦百搭网红浅色长裤\",\"count\":1,\"price\":20,\"images\":\"http://127.0.0.1:8000/images/goods/005/cover.jpg\",\"isCheck\":true}]', '[]', '[]');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
