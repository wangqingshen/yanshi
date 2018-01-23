/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : yanshi

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-07-24 22:11:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ys_order`
-- ----------------------------
DROP TABLE IF EXISTS `ys_order`;
CREATE TABLE `ys_order` (
  `order_id` int(4) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(30) NOT NULL COMMENT '订单编号',
  `member_id` int(4) NOT NULL,
  `create_time` int(11) NOT NULL,
  `pay_sn` varchar(40) DEFAULT NULL COMMENT '支付单号',
  `pay_time` int(11) DEFAULT NULL COMMENT '支付时间',
  `finish_time` int(11) DEFAULT NULL COMMENT '订单完成、结束时间',
  `order_amount` decimal(10,2) DEFAULT '0.00' COMMENT '订单总价',
  `order_type` tinyint(2) NOT NULL COMMENT '购买类型，1.单买，2.2人拼团，3.4人拼团',
  `order_state` int(11) NOT NULL DEFAULT '1' COMMENT '订单状态。1.待付款，2.已付款，3.配送中，4.已送达，5.交易完成',
  `delivery_num` int(4) DEFAULT '0' COMMENT '订单总共配送次数',
  `delivery_time` varchar(30) DEFAULT NULL COMMENT '订单送餐时间',
  `voucher_price` int(4) DEFAULT NULL,
  `receive_name` varchar(50) DEFAULT NULL,
  `receive_mobile` varchar(11) DEFAULT NULL,
  `d_id` int(4) DEFAULT NULL,
  `t_id` int(4) DEFAULT NULL,
  `receive_address` text,
  PRIMARY KEY (`order_id`),
  KEY `index_sn` (`order_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_order
-- ----------------------------
INSERT INTO `ys_order` VALUES ('3', '2017072448995051', '1', '1500860272', null, null, null, '0.01', '1', '1', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '李想', '18628062001', '2', '5', '西南财大研究院南门');
INSERT INTO `ys_order` VALUES ('7', '2017072448485251', '1', '1500895904', null, null, null, '0.01', '1', '1', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '李想', '18628062001', '2', '5', '西南财大研究院南门');
INSERT INTO `ys_order` VALUES ('8', '2017072449485698', '2', '1500895905', null, null, null, '0.01', '1', '1', '0', 'a:1:{i:0;s:1:\"1\";}', null, '王大锤', '13438347045', '2', '7', '西南财大研究院教学楼');
INSERT INTO `ys_order` VALUES ('9', '2017072449579710', '2', '1500896001', null, null, null, '0.01', '1', '1', '0', 'a:1:{i:0;s:1:\"1\";}', null, '王大锤', '13438347045', '2', '7', '西南财大研究院教学楼');
INSERT INTO `ys_order` VALUES ('10', '2017072456495448', '1', '1500896008', null, null, null, '0.01', '1', '1', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '李想', '18628062001', '2', '5', '西南财大研究院南门');
INSERT INTO `ys_order` VALUES ('11', '2017072452564949', '2', '1500896132', null, null, null, '0.01', '1', '1', '0', 'a:1:{i:0;s:1:\"1\";}', null, '王大锤', '13438347045', '2', '7', '西南财大研究院教学楼');
INSERT INTO `ys_order` VALUES ('12', '2017072451101524', '2', '1500896227', null, null, null, '0.01', '1', '1', '0', 'a:1:{i:0;s:1:\"1\";}', null, '王大锤', '13438347045', '2', '7', '西南财大研究院教学楼');
INSERT INTO `ys_order` VALUES ('13', '2017072410197509', '2', '1500896350', null, null, null, '0.01', '1', '1', '0', 'a:1:{i:0;s:1:\"1\";}', null, '王大锤', '13438347045', '2', '7', '西南财大研究院教学楼');
