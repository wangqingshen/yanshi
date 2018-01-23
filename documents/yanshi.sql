/*
Navicat MySQL Data Transfer

Source Server         : yanshi
Source Server Version : 50637
Source Host           : 120.132.49.203:3306
Source Database       : yanshi_test

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2017-08-14 15:46:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ys_ad`
-- ----------------------------
DROP TABLE IF EXISTS `ys_ad`;
CREATE TABLE `ys_ad` (
  `ad_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `ad_name` varchar(255) NOT NULL COMMENT '广告名称',
  `ad_content` text COMMENT '广告内容',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`ad_id`),
  KEY `ad_name` (`ad_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_ad
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_address`
-- ----------------------------
DROP TABLE IF EXISTS `ys_address`;
CREATE TABLE `ys_address` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `member_id` int(4) DEFAULT NULL,
  `receive_name` varchar(50) NOT NULL COMMENT '订餐人',
  `receive_mobile` varchar(11) NOT NULL COMMENT '订餐人手机号',
  `d_id` int(4) DEFAULT NULL COMMENT '送餐学校id',
  `t_id` int(4) DEFAULT NULL COMMENT '取餐点id',
  `receive_address` text COMMENT '送餐地址信息',
  `is_default` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否默认地址',
  PRIMARY KEY (`id`,`receive_mobile`),
  KEY `index_member` (`member_id`,`is_default`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_address
-- ----------------------------
INSERT INTO `ys_address` VALUES ('9', '9', '发的说法是', '18628062001', '1', '2', '西南财大柳江校区西门取餐', '1');
INSERT INTO `ys_address` VALUES ('10', '9', '很关键', '18628062001', '1', '1', '西南财大柳江校区东门取餐', '0');
INSERT INTO `ys_address` VALUES ('12', '11', '王大锤', '13438347003', '1', '2', '西南财大柳江校区西门取餐', '0');
INSERT INTO `ys_address` VALUES ('13', '11', '万象网管', '15984433567', '2', '7', '西南财大研究院教学楼', '0');
INSERT INTO `ys_address` VALUES ('14', '11', '万象网管', '15983322121', '1', '4', '西南财大柳江校区女生宿舍内', '1');
INSERT INTO `ys_address` VALUES ('15', '9', '第三方', '18628062001', '1', '1', '西南财大柳江校区东门取餐', '0');
INSERT INTO `ys_address` VALUES ('16', '9', '打高分', '18628062001', '2', '7', '西南财大研究院教学楼', '0');
INSERT INTO `ys_address` VALUES ('18', '21', '冯先生', '13880600394', '1', '4', '西南财大柳江校区女生宿舍内', '1');
INSERT INTO `ys_address` VALUES ('20', '30', '李想', '18628062001', '1', '4', '西南财大柳江校区女生宿舍内', '0');
INSERT INTO `ys_address` VALUES ('21', '26', '李德生', '17612834679', '1', '1', '西南财大柳江校区东门取餐', '1');
INSERT INTO `ys_address` VALUES ('22', '31', '武帅', '18581835277', '1', '4', '西南财大柳江校区女生宿舍内', '1');
INSERT INTO `ys_address` VALUES ('25', '10', '晚霞', '13438347005', '3', '9', '电子科大西门', '0');
INSERT INTO `ys_address` VALUES ('26', '10', '我很好', '15985225444', '3', '9', '电子科大西门', '0');
INSERT INTO `ys_address` VALUES ('30', '30', '李想', '18628062001', '1', '1', '西南财大柳江校区东门取餐', '1');
INSERT INTO `ys_address` VALUES ('31', '33', '旺达', '13438345678', '1', '10', '西南财大柳江校区附属幼儿园', '1');
INSERT INTO `ys_address` VALUES ('32', '34', '晚霞', '13438340788', '3', '8', '电子科大东门', '1');
INSERT INTO `ys_address` VALUES ('33', '10', '李大钊', '13436456666', '1', '10', '西南财大柳江校区附属幼儿园', '1');

-- ----------------------------
-- Table structure for `ys_asset`
-- ----------------------------
DROP TABLE IF EXISTS `ys_asset`;
CREATE TABLE `ys_asset` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `key` varchar(50) NOT NULL COMMENT '资源 key',
  `filename` varchar(50) DEFAULT NULL COMMENT '文件名',
  `filesize` int(11) DEFAULT NULL COMMENT '文件大小,单位Byte',
  `filepath` varchar(200) NOT NULL COMMENT '文件路径，相对于 upload 目录，可以为 url',
  `uploadtime` int(11) NOT NULL COMMENT '上传时间',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1：可用，0：删除，不可用',
  `meta` text COMMENT '其它详细信息，JSON格式',
  `suffix` varchar(50) DEFAULT NULL COMMENT '文件后缀名，不包括点',
  `download_times` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of ys_asset
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_auth_access`
-- ----------------------------
DROP TABLE IF EXISTS `ys_auth_access`;
CREATE TABLE `ys_auth_access` (
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(255) NOT NULL COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) DEFAULT NULL COMMENT '权限规则分类，请加应用前缀,如admin_',
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of ys_auth_access
-- ----------------------------
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/edit_meal_place', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/add_delivery_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/add_delivery', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/delivery_list', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/voucher/bind_goods_list', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/member/member_list', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/voucher/get_voucher_qr_img', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/voucher/add_voucher_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/voucher/add_voucher', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/voucher/voucher_list', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/export_today_amount', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/order_info', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/export_today_order_excel', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/change_order_state_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/batch_change_order_state', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/change_order_state', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/order/index', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/get_recommend_list', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/edit_goods_spu', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/edit_sku', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/edit_sku_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/recommend_goods', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/add_recommend_goods_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/edit_goods_spu_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/goods_info', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/add_goods_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/add_goods', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/goods_list', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/add_spec_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/cancelban', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/index', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/goods_spec', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/goods/del_spec_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/ban', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/add', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/add_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/edit_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/edit', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/delete', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/roleadd_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/user/index', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/roleadd', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/roledelete', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/roleedit_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/roleedit', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/authorize_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/authorize', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/member', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/rbac/index', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'user/indexadmin/default', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/setting/default', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/setting/clearcache', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/del_tak_place_post', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/add_meal_place', 'admin_url');
INSERT INTO `ys_auth_access` VALUES ('2', 'admin/fooddelivery/add_meal_place_post', 'admin_url');

-- ----------------------------
-- Table structure for `ys_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `ys_auth_rule`;
CREATE TABLE `ys_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '1' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(255) DEFAULT NULL COMMENT '额外url参数',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

-- ----------------------------
-- Records of ys_auth_rule
-- ----------------------------
INSERT INTO `ys_auth_rule` VALUES ('1', 'Admin', 'admin_url', 'admin/content/default', null, '内容管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('2', 'Api', 'admin_url', 'api/guestbookadmin/index', null, '所有留言', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('3', 'Api', 'admin_url', 'api/guestbookadmin/delete', null, '删除网站留言', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('4', 'Comment', 'admin_url', 'comment/commentadmin/index', null, '评论管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('5', 'Comment', 'admin_url', 'comment/commentadmin/delete', null, '删除评论', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('6', 'Comment', 'admin_url', 'comment/commentadmin/check', null, '评论审核', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('7', 'Portal', 'admin_url', 'portal/adminpost/index', null, '文章管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('8', 'Portal', 'admin_url', 'portal/adminpost/listorders', null, '文章排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('9', 'Portal', 'admin_url', 'portal/adminpost/top', null, '文章置顶', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('10', 'Portal', 'admin_url', 'portal/adminpost/recommend', null, '文章推荐', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('11', 'Portal', 'admin_url', 'portal/adminpost/move', null, '批量移动', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('12', 'Portal', 'admin_url', 'portal/adminpost/check', null, '文章审核', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('13', 'Portal', 'admin_url', 'portal/adminpost/delete', null, '删除文章', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('14', 'Portal', 'admin_url', 'portal/adminpost/edit', null, '编辑文章', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('15', 'Portal', 'admin_url', 'portal/adminpost/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('16', 'Portal', 'admin_url', 'portal/adminpost/add', null, '添加文章', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('17', 'Portal', 'admin_url', 'portal/adminpost/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('18', 'Portal', 'admin_url', 'portal/adminterm/index', null, '分类管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('19', 'Portal', 'admin_url', 'portal/adminterm/listorders', null, '文章分类排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('20', 'Portal', 'admin_url', 'portal/adminterm/delete', null, '删除分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('21', 'Portal', 'admin_url', 'portal/adminterm/edit', null, '编辑分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('22', 'Portal', 'admin_url', 'portal/adminterm/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('23', 'Portal', 'admin_url', 'portal/adminterm/add', null, '添加分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('24', 'Portal', 'admin_url', 'portal/adminterm/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('25', 'Portal', 'admin_url', 'portal/adminpage/index', null, '页面管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('26', 'Portal', 'admin_url', 'portal/adminpage/listorders', null, '页面排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('27', 'Portal', 'admin_url', 'portal/adminpage/delete', null, '删除页面', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('28', 'Portal', 'admin_url', 'portal/adminpage/edit', null, '编辑页面', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('29', 'Portal', 'admin_url', 'portal/adminpage/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('30', 'Portal', 'admin_url', 'portal/adminpage/add', null, '添加页面', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('31', 'Portal', 'admin_url', 'portal/adminpage/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('32', 'Admin', 'admin_url', 'admin/recycle/default', null, '回收站', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('33', 'Portal', 'admin_url', 'portal/adminpost/recyclebin', null, '文章回收', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('34', 'Portal', 'admin_url', 'portal/adminpost/restore', null, '文章还原', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('35', 'Portal', 'admin_url', 'portal/adminpost/clean', null, '彻底删除', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('36', 'Portal', 'admin_url', 'portal/adminpage/recyclebin', null, '页面回收', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('37', 'Portal', 'admin_url', 'portal/adminpage/clean', null, '彻底删除', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('38', 'Portal', 'admin_url', 'portal/adminpage/restore', null, '页面还原', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('39', 'Admin', 'admin_url', 'admin/extension/default', null, '扩展工具', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('40', 'Admin', 'admin_url', 'admin/backup/default', null, '备份管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('41', 'Admin', 'admin_url', 'admin/backup/restore', null, '数据还原', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('42', 'Admin', 'admin_url', 'admin/backup/index', null, '数据备份', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('43', 'Admin', 'admin_url', 'admin/backup/index_post', null, '提交数据备份', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('44', 'Admin', 'admin_url', 'admin/backup/download', null, '下载备份', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('45', 'Admin', 'admin_url', 'admin/backup/del_backup', null, '删除备份', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('46', 'Admin', 'admin_url', 'admin/backup/import', null, '数据备份导入', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('47', 'Admin', 'admin_url', 'admin/plugin/index', null, '插件管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('48', 'Admin', 'admin_url', 'admin/plugin/toggle', null, '插件启用切换', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('49', 'Admin', 'admin_url', 'admin/plugin/setting', null, '插件设置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('50', 'Admin', 'admin_url', 'admin/plugin/setting_post', null, '插件设置提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('51', 'Admin', 'admin_url', 'admin/plugin/install', null, '插件安装', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('52', 'Admin', 'admin_url', 'admin/plugin/uninstall', null, '插件卸载', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('53', 'Admin', 'admin_url', 'admin/slide/default', null, '幻灯片', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('54', 'Admin', 'admin_url', 'admin/slide/index', null, '幻灯片管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('55', 'Admin', 'admin_url', 'admin/slide/listorders', null, '幻灯片排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('56', 'Admin', 'admin_url', 'admin/slide/toggle', null, '幻灯片显示切换', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('57', 'Admin', 'admin_url', 'admin/slide/delete', null, '删除幻灯片', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('58', 'Admin', 'admin_url', 'admin/slide/edit', null, '编辑幻灯片', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('59', 'Admin', 'admin_url', 'admin/slide/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('60', 'Admin', 'admin_url', 'admin/slide/add', null, '添加幻灯片', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('61', 'Admin', 'admin_url', 'admin/slide/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('62', 'Admin', 'admin_url', 'admin/slidecat/index', null, '幻灯片分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('63', 'Admin', 'admin_url', 'admin/slidecat/delete', null, '删除分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('64', 'Admin', 'admin_url', 'admin/slidecat/edit', null, '编辑分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('65', 'Admin', 'admin_url', 'admin/slidecat/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('66', 'Admin', 'admin_url', 'admin/slidecat/add', null, '添加分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('67', 'Admin', 'admin_url', 'admin/slidecat/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('68', 'Admin', 'admin_url', 'admin/ad/index', null, '网站广告', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('69', 'Admin', 'admin_url', 'admin/ad/toggle', null, '广告显示切换', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('70', 'Admin', 'admin_url', 'admin/ad/delete', null, '删除广告', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('71', 'Admin', 'admin_url', 'admin/ad/edit', null, '编辑广告', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('72', 'Admin', 'admin_url', 'admin/ad/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('73', 'Admin', 'admin_url', 'admin/ad/add', null, '添加广告', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('74', 'Admin', 'admin_url', 'admin/ad/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('75', 'Admin', 'admin_url', 'admin/link/index', null, '友情链接', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('76', 'Admin', 'admin_url', 'admin/link/listorders', null, '友情链接排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('77', 'Admin', 'admin_url', 'admin/link/toggle', null, '友链显示切换', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('78', 'Admin', 'admin_url', 'admin/link/delete', null, '删除友情链接', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('79', 'Admin', 'admin_url', 'admin/link/edit', null, '编辑友情链接', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('80', 'Admin', 'admin_url', 'admin/link/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('81', 'Admin', 'admin_url', 'admin/link/add', null, '添加友情链接', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('82', 'Admin', 'admin_url', 'admin/link/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('83', 'Api', 'admin_url', 'api/oauthadmin/setting', null, '第三方登陆', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('84', 'Api', 'admin_url', 'api/oauthadmin/setting_post', null, '提交设置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('85', 'Admin', 'admin_url', 'admin/menu/default', null, '菜单管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('86', 'Admin', 'admin_url', 'admin/navcat/default1', null, '前台菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('87', 'Admin', 'admin_url', 'admin/nav/index', null, '菜单管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('88', 'Admin', 'admin_url', 'admin/nav/listorders', null, '前台导航排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('89', 'Admin', 'admin_url', 'admin/nav/delete', null, '删除菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('90', 'Admin', 'admin_url', 'admin/nav/edit', null, '编辑菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('91', 'Admin', 'admin_url', 'admin/nav/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('92', 'Admin', 'admin_url', 'admin/nav/add', null, '添加菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('93', 'Admin', 'admin_url', 'admin/nav/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('94', 'Admin', 'admin_url', 'admin/navcat/index', null, '菜单分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('95', 'Admin', 'admin_url', 'admin/navcat/delete', null, '删除分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('96', 'Admin', 'admin_url', 'admin/navcat/edit', null, '编辑分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('97', 'Admin', 'admin_url', 'admin/navcat/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('98', 'Admin', 'admin_url', 'admin/navcat/add', null, '添加分类', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('99', 'Admin', 'admin_url', 'admin/navcat/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('100', 'Admin', 'admin_url', 'admin/menu/index', null, '后台菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('101', 'Admin', 'admin_url', 'admin/menu/add', null, '添加菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('102', 'Admin', 'admin_url', 'admin/menu/add_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('103', 'Admin', 'admin_url', 'admin/menu/listorders', null, '后台菜单排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('104', 'Admin', 'admin_url', 'admin/menu/export_menu', null, '菜单备份', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('105', 'Admin', 'admin_url', 'admin/menu/edit', null, '编辑菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('106', 'Admin', 'admin_url', 'admin/menu/edit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('107', 'Admin', 'admin_url', 'admin/menu/delete', null, '删除菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('108', 'Admin', 'admin_url', 'admin/menu/lists', null, '所有菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('109', 'Admin', 'admin_url', 'admin/setting/default', null, '系统管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('110', 'Admin', 'admin_url', 'admin/setting/userdefault', null, '个人信息', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('111', 'Admin', 'admin_url', 'admin/user/userinfo', null, '修改信息', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('112', 'Admin', 'admin_url', 'admin/user/userinfo_post', null, '修改信息提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('113', 'Admin', 'admin_url', 'admin/setting/password', null, '修改密码', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('114', 'Admin', 'admin_url', 'admin/setting/password_post', null, '提交修改', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('115', 'Admin', 'admin_url', 'admin/setting/site', null, '网站信息', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('116', 'Admin', 'admin_url', 'admin/setting/site_post', null, '提交修改', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('117', 'Admin', 'admin_url', 'admin/route/index', null, '路由列表', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('118', 'Admin', 'admin_url', 'admin/route/add', null, '路由添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('119', 'Admin', 'admin_url', 'admin/route/add_post', null, '路由添加提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('120', 'Admin', 'admin_url', 'admin/route/edit', null, '路由编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('121', 'Admin', 'admin_url', 'admin/route/edit_post', null, '路由编辑提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('122', 'Admin', 'admin_url', 'admin/route/delete', null, '路由删除', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('123', 'Admin', 'admin_url', 'admin/route/ban', null, '路由禁止', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('124', 'Admin', 'admin_url', 'admin/route/open', null, '路由启用', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('125', 'Admin', 'admin_url', 'admin/route/listorders', null, '路由排序', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('126', 'Admin', 'admin_url', 'admin/mailer/default', null, '邮箱配置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('127', 'Admin', 'admin_url', 'admin/mailer/index', null, 'SMTP配置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('128', 'Admin', 'admin_url', 'admin/mailer/index_post', null, '提交配置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('129', 'Admin', 'admin_url', 'admin/mailer/active', null, '注册邮件模板', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('130', 'Admin', 'admin_url', 'admin/mailer/active_post', null, '提交模板', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('131', 'Admin', 'admin_url', 'admin/setting/clearcache', null, '清除缓存', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('132', 'User', 'admin_url', 'user/indexadmin/default', null, '权限管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('133', 'User', 'admin_url', 'user/indexadmin/default1', null, '用户组', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('134', 'User', 'admin_url', 'user/indexadmin/index', null, '本站用户', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('135', 'User', 'admin_url', 'user/indexadmin/ban', null, '拉黑会员', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('136', 'User', 'admin_url', 'user/indexadmin/cancelban', null, '启用会员', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('137', 'User', 'admin_url', 'user/oauthadmin/index', null, '第三方用户', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('138', 'User', 'admin_url', 'user/oauthadmin/delete', null, '第三方用户解绑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('139', 'User', 'admin_url', 'user/indexadmin/default3', null, '管理组', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('140', 'Admin', 'admin_url', 'admin/rbac/index', null, '角色管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('141', 'Admin', 'admin_url', 'admin/rbac/member', null, '成员管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('142', 'Admin', 'admin_url', 'admin/rbac/authorize', null, '权限设置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('143', 'Admin', 'admin_url', 'admin/rbac/authorize_post', null, '提交设置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('144', 'Admin', 'admin_url', 'admin/rbac/roleedit', null, '编辑角色', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('145', 'Admin', 'admin_url', 'admin/rbac/roleedit_post', null, '提交编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('146', 'Admin', 'admin_url', 'admin/rbac/roledelete', null, '删除角色', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('147', 'Admin', 'admin_url', 'admin/rbac/roleadd', null, '添加角色', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('148', 'Admin', 'admin_url', 'admin/rbac/roleadd_post', null, '提交添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('149', 'Admin', 'admin_url', 'admin/user/index', null, '管理员', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('150', 'Admin', 'admin_url', 'admin/user/delete', null, '删除管理员', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('151', 'Admin', 'admin_url', 'admin/user/edit', null, '管理员编辑', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('152', 'Admin', 'admin_url', 'admin/user/edit_post', null, '编辑提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('153', 'Admin', 'admin_url', 'admin/user/add', null, '管理员添加', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('154', 'Admin', 'admin_url', 'admin/user/add_post', null, '添加提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('155', 'Admin', 'admin_url', 'admin/plugin/update', null, '插件更新', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('156', 'Admin', 'admin_url', 'admin/storage/index', null, '文件存储', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('157', 'Admin', 'admin_url', 'admin/storage/setting_post', null, '文件存储设置提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('158', 'Admin', 'admin_url', 'admin/slide/ban', null, '禁用幻灯片', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('159', 'Admin', 'admin_url', 'admin/slide/cancelban', null, '启用幻灯片', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('160', 'Admin', 'admin_url', 'admin/user/ban', null, '禁用管理员', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('161', 'Admin', 'admin_url', 'admin/user/cancelban', null, '启用管理员', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('162', 'Demo', 'admin_url', 'demo/adminindex/index', null, '', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('163', 'Demo', 'admin_url', 'demo/adminindex/last', null, '', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('166', 'Admin', 'admin_url', 'admin/mailer/test', null, '测试邮件', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('167', 'Admin', 'admin_url', 'admin/setting/upload', null, '上传设置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('168', 'Admin', 'admin_url', 'admin/setting/upload_post', null, '上传设置提交', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('169', 'Portal', 'admin_url', 'portal/adminpost/copy', null, '文章批量复制', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('170', 'Admin', 'admin_url', 'admin/menu/backup_menu', null, '备份菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('171', 'Admin', 'admin_url', 'admin/menu/export_menu_lang', null, '导出后台菜单多语言包', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('172', 'Admin', 'admin_url', 'admin/menu/restore_menu', null, '还原菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('173', 'Admin', 'admin_url', 'admin/menu/getactions', null, '导入新菜单', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('174', 'Admin', 'admin_url', 'admin/goods/index', null, '商品管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('175', 'Admin', 'admin_url', 'admin/order/index', null, '订单管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('176', 'Admin', 'admin_url', 'admin/voucher/voucher_list', null, '优惠券管理', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('177', 'Admin', 'admin_url', 'admin/member/member_list', null, '用户信息', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('178', 'Admin', 'admin_url', 'admin/goods/goods_spec', null, '商品规格', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('179', 'Admin', 'admin_url', 'admin/goods/goods_list', null, '商品列表', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('180', 'Admin', 'admin_url', 'admin/fooddelivery/delivery_list', null, '送餐配置', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('181', 'Admin', 'admin_url', 'admin/fooddelivery/add_delivery', null, '添加送餐点', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('182', 'Admin', 'admin_url', 'admin/fooddelivery/edit_meal_place', null, '编辑送餐地点', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('183', 'Admin', 'admin_url', 'admin/fooddelivery/del_tak_place_post', null, '删除取餐点', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('184', 'Admin', 'admin_url', 'admin/fooddelivery/add_meal_place', null, '添加取餐点', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('185', 'Admin', 'admin_url', 'admin/fooddelivery/add_meal_place_post', null, '取餐点post方法', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('186', 'Admin', 'admin_url', 'admin/voucher/add_voucher', null, '添加优惠券', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('187', 'Admin', 'admin_url', 'admin/voucher/bind_goods_list', null, '指定商品', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('188', 'Admin', 'admin_url', 'admin/voucher/get_voucher_qr_img', null, '查看二维码', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('189', 'Admin', 'admin_url', 'admin/voucher/add_voucher_post', null, '添加优惠券post方法', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('190', 'Admin', 'admin_url', 'admin/goods/del_spec_post', null, '删除商品规格', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('191', 'Admin', 'admin_url', 'admin/goods/add_spec_post', null, '添加份量', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('192', 'Admin', 'admin_url', 'admin/goods/add_goods', null, '添加商品', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('193', 'Admin', 'admin_url', 'admin/goods/add_goods_post', null, '添加商品post方法', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('194', 'Admin', 'admin_url', 'admin/goods/goods_info', null, '查看spu商品信息', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('195', 'Admin', 'admin_url', 'admin/goods/edit_goods_spu', null, '编辑spu商品信息', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('196', 'Admin', 'admin_url', 'admin/goods/edit_sku', null, '编辑sku商品', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('197', 'Admin', 'admin_url', 'admin/goods/recommend_goods', null, '添加编辑推荐商品', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('198', 'Admin', 'admin_url', 'admin/goods/get_recommend_list', null, '查看推荐商品', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('199', 'Admin', 'admin_url', 'admin/goods/add_recommend_goods_post', null, '选中推荐商品', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('200', 'Admin', 'admin_url', 'admin/goods/edit_sku_post', null, '修改sku商品方法', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('201', 'Admin', 'admin_url', 'admin/goods/edit_goods_spu_post', null, '编辑spu商品post方法', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('202', 'Admin', 'admin_url', 'admin/order/change_order_state', null, '变更订单状态', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('203', 'Admin', 'admin_url', 'admin/order/order_info', null, '查看订单详情', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('204', 'Admin', 'admin_url', 'admin/order/export_today_order_excel', null, '当日订单下载', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('205', 'Admin', 'admin_url', 'admin/order/export_today_amount', null, '当日配送金额下载', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('206', 'Admin', 'admin_url', 'admin/order/change_order_state_post', null, '变更订单状态post方法', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('207', 'Admin', 'admin_url', 'admin/order/batch_change_order_state', null, '批量变更订单状态', '1', '');
INSERT INTO `ys_auth_rule` VALUES ('208', 'Admin', 'admin_url', 'admin/fooddelivery/add_delivery_post', null, '添加送餐点post方法', '1', '');

-- ----------------------------
-- Table structure for `ys_cart`
-- ----------------------------
DROP TABLE IF EXISTS `ys_cart`;
CREATE TABLE `ys_cart` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `member_id` int(4) NOT NULL,
  `sku_id` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_cart
-- ----------------------------
INSERT INTO `ys_cart` VALUES ('5', '32', '19');

-- ----------------------------
-- Table structure for `ys_comments`
-- ----------------------------
DROP TABLE IF EXISTS `ys_comments`;
CREATE TABLE `ys_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_table` varchar(100) NOT NULL COMMENT '评论内容所在表，不带表前缀',
  `post_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `url` varchar(255) DEFAULT NULL COMMENT '原文地址',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_uid` int(11) NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `full_name` varchar(50) DEFAULT NULL COMMENT '评论者昵称',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `createtime` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '评论时间',
  `content` text NOT NULL COMMENT '评论内容',
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `parentid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `path` varchar(500) DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核',
  PRIMARY KEY (`id`),
  KEY `comment_post_ID` (`post_id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parentid`),
  KEY `table_id_status` (`post_table`,`post_id`,`status`),
  KEY `createtime` (`createtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of ys_comments
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_common_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `ys_common_action_log`;
CREATE TABLE `ys_common_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` bigint(20) DEFAULT '0' COMMENT '用户id',
  `object` varchar(100) DEFAULT NULL COMMENT '访问对象的id,格式：不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) DEFAULT NULL COMMENT '操作名称；格式规定为：应用名+控制器+操作名；也可自己定义格式只要不发生冲突且惟一；',
  `count` int(11) DEFAULT '0' COMMENT '访问次数',
  `last_time` int(11) DEFAULT '0' COMMENT '最后访问的时间戳',
  `ip` varchar(15) DEFAULT NULL COMMENT '访问者最后访问ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user`,`object`,`action`),
  KEY `user_object_action_ip` (`user`,`object`,`action`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='访问记录表';

-- ----------------------------
-- Records of ys_common_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_delivery_info`
-- ----------------------------
DROP TABLE IF EXISTS `ys_delivery_info`;
CREATE TABLE `ys_delivery_info` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `order_id` int(4) DEFAULT NULL COMMENT '订单id',
  `delivery_time` int(11) DEFAULT NULL COMMENT '送餐时间',
  `delivery_people` varchar(50) DEFAULT NULL COMMENT '送餐人',
  `delivery_contact_mobile` varchar(20) DEFAULT NULL COMMENT '送餐人联系电话',
  PRIMARY KEY (`id`),
  KEY `index_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_delivery_info
-- ----------------------------
INSERT INTO `ys_delivery_info` VALUES ('28', '335', '1501855225', '小平', '321321231');
INSERT INTO `ys_delivery_info` VALUES ('29', '361', '1502634111', '武帅', '18581835277');

-- ----------------------------
-- Table structure for `ys_food_delivery`
-- ----------------------------
DROP TABLE IF EXISTS `ys_food_delivery`;
CREATE TABLE `ys_food_delivery` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_food_delivery
-- ----------------------------
INSERT INTO `ys_food_delivery` VALUES ('1', '西南财大柳江校区');
INSERT INTO `ys_food_delivery` VALUES ('2', '西南财大研究院');
INSERT INTO `ys_food_delivery` VALUES ('3', '电子科大');

-- ----------------------------
-- Table structure for `ys_goods_sku`
-- ----------------------------
DROP TABLE IF EXISTS `ys_goods_sku`;
CREATE TABLE `ys_goods_sku` (
  `sku_id` int(4) NOT NULL AUTO_INCREMENT,
  `spu_id` int(4) NOT NULL,
  `sku_price` decimal(10,2) NOT NULL COMMENT 'sku商品单价',
  `sku_2_price` decimal(10,2) DEFAULT NULL COMMENT '二人拼团价',
  `sku_4_price` decimal(10,2) DEFAULT NULL COMMENT '四人拼团价',
  `delivery_num` int(4) NOT NULL DEFAULT '0' COMMENT '送餐次数',
  `spec` varchar(100) DEFAULT NULL COMMENT '规格值',
  PRIMARY KEY (`sku_id`),
  KEY `index_spu` (`spu_id`),
  KEY `index_spec` (`spec`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_goods_sku
-- ----------------------------
INSERT INTO `ys_goods_sku` VALUES ('1', '1', '8.00', '7.00', '6.00', '5', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('2', '1', '10.00', '9.00', '8.00', '9', '超大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('3', '2', '0.01', '18.00', '7.00', '5', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('4', '2', '0.01', '38.00', '45.00', '10', '大份|3天');
INSERT INTO `ys_goods_sku` VALUES ('5', '2', '0.01', '15.00', '14.00', '7', '小份|1天');
INSERT INTO `ys_goods_sku` VALUES ('6', '2', '0.01', '23.00', '21.00', '14', '小份|3天');
INSERT INTO `ys_goods_sku` VALUES ('7', '3', '13.00', '12.00', '10.00', '5', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('8', '4', '12.00', '11.00', '5.00', '2', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('9', '4', '18.00', '16.00', '14.00', '8', '大份|3天');
INSERT INTO `ys_goods_sku` VALUES ('10', '5', '0.01', '0.02', '0.01', '12', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('11', '6', '12.00', '8.00', '6.00', '3', '大份|5天');
INSERT INTO `ys_goods_sku` VALUES ('12', '7', '12.00', '11.00', '10.00', '1', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('13', '7', '5.00', '2.51', '3.00', '1', '小份|1天');
INSERT INTO `ys_goods_sku` VALUES ('14', '8', '0.01', '0.01', '0.01', '5', '大份|1天');
INSERT INTO `ys_goods_sku` VALUES ('15', '8', '0.01', '0.01', '0.01', '5', '小份|1天');
INSERT INTO `ys_goods_sku` VALUES ('16', '9', '0.02', '0.01', '0.01', '6', '大份|3天');
INSERT INTO `ys_goods_sku` VALUES ('17', '11', '22.00', '20.00', '18.00', '1', '大份|一餐');
INSERT INTO `ys_goods_sku` VALUES ('18', '12', '26.00', '24.00', '22.00', '1', '大份|一餐');
INSERT INTO `ys_goods_sku` VALUES ('19', '13', '24.00', '22.00', '20.00', '0', '大份|一餐');
INSERT INTO `ys_goods_sku` VALUES ('20', '14', '26.00', '24.00', '22.00', '0', '大份|一餐');
INSERT INTO `ys_goods_sku` VALUES ('21', '15', '2400.00', '2380.00', '2350.00', '48', '男生|月订');
INSERT INTO `ys_goods_sku` VALUES ('22', '15', '1800.00', '1780.00', '1750.00', '48', '女生|月订');
INSERT INTO `ys_goods_sku` VALUES ('23', '16', '240.00', '235.00', '220.00', '12', '大份|周订');
INSERT INTO `ys_goods_sku` VALUES ('24', '16', '216.00', '210.00', '200.00', '12', '小份|周订');
INSERT INTO `ys_goods_sku` VALUES ('25', '17', '960.00', '930.00', '900.00', '48', '大份|月订');
INSERT INTO `ys_goods_sku` VALUES ('26', '17', '860.00', '830.00', '800.00', '48', '小份|月订');
INSERT INTO `ys_goods_sku` VALUES ('27', '18', '40.00', '39.90', '39.80', '2', '大份|日订');
INSERT INTO `ys_goods_sku` VALUES ('28', '18', '36.00', '35.90', '35.80', '2', '小份|日订');
INSERT INTO `ys_goods_sku` VALUES ('29', '19', '28.00', '27.80', '27.50', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('30', '20', '28.00', '27.80', '27.50', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('31', '21', '28.00', '27.80', '27.50', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('32', '22', '16.00', '15.80', '15.50', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('33', '23', '10.00', '9.90', '9.80', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('34', '24', '10.00', '9.90', '9.80', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('35', '25', '10.00', '9.90', '9.80', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('36', '26', '8.00', '7.90', '7.80', '1', '标准|一餐');
INSERT INTO `ys_goods_sku` VALUES ('37', '27', '22.00', '21.50', '21.00', '1', '标准|一餐');

-- ----------------------------
-- Table structure for `ys_goods_spec`
-- ----------------------------
DROP TABLE IF EXISTS `ys_goods_spec`;
CREATE TABLE `ys_goods_spec` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) NOT NULL COMMENT '1.份量，2.周期',
  `spec_value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_goods_spec
-- ----------------------------
INSERT INTO `ys_goods_spec` VALUES ('8', '1', '大份');
INSERT INTO `ys_goods_spec` VALUES ('17', '2', '日订');
INSERT INTO `ys_goods_spec` VALUES ('18', '2', '周订');
INSERT INTO `ys_goods_spec` VALUES ('19', '2', '月订');
INSERT INTO `ys_goods_spec` VALUES ('20', '2', '一餐');
INSERT INTO `ys_goods_spec` VALUES ('21', '1', '小份');
INSERT INTO `ys_goods_spec` VALUES ('22', '1', '标准');
INSERT INTO `ys_goods_spec` VALUES ('23', '1', '男生');
INSERT INTO `ys_goods_spec` VALUES ('24', '1', '女生');

-- ----------------------------
-- Table structure for `ys_goods_spu`
-- ----------------------------
DROP TABLE IF EXISTS `ys_goods_spu`;
CREATE TABLE `ys_goods_spu` (
  `spu_id` int(4) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_class` tinyint(2) NOT NULL COMMENT '商品分类：1.健康餐，2.健身餐，3.沙拉，4.饮品，5.零食',
  `delivery_explain` varchar(500) DEFAULT NULL COMMENT '送餐说明',
  `goods_img1` varchar(200) DEFAULT NULL COMMENT '商品主图',
  `goods_slide_img` text COMMENT '商品轮播图片序列化地址',
  `goods_spu_img` text COMMENT '商品详情图序列化地址',
  `spu_spec` varchar(500) DEFAULT NULL COMMENT 'spu商品选中的规格',
  `recommend` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否推荐，1.否，2.是',
  `recommend_img` varchar(200) DEFAULT NULL COMMENT '推荐图片地址',
  `delivery_time` varchar(30) DEFAULT NULL,
  `recommend_sku_ids` varchar(150) DEFAULT NULL COMMENT '推荐商品skuid集合',
  `state` tinyint(2) NOT NULL DEFAULT '1' COMMENT '商品上架状态,1.上架，2.下架',
  PRIMARY KEY (`spu_id`),
  KEY `index_class` (`goods_class`,`state`),
  KEY `index_delivery` (`delivery_time`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_goods_spu
-- ----------------------------
INSERT INTO `ys_goods_spu` VALUES ('1', '凯撒鸡排套餐', '1', '每日中餐中午12点之前送达', 'default/20170723/5974a1e28d2d3.jpg', 'a:4:{i:0;s:34:\"default/20170723/5974a1ec9085b.jpg\";i:1;s:34:\"default/20170723/5974a23281b00.jpg\";i:2;s:34:\"default/20170723/5974a1fd79713.jpg\";i:3;s:34:\"default/20170723/5974a205cd71e.jpg\";}', 'a:1:{i:0;s:34:\"default/20170723/5974a20e9998a.jpg\";}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:9:\"超大份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"1天\";}}', '2', 'default/20170723/5974a23bb217c.jpg', 'a:1:{i:0;s:1:\"1\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('2', '儿童营养套餐', '1', '每日中餐中午12点之前送达', 'default/20170723/5974a2d1b0f7d.jpg', 'a:2:{i:0;s:34:\"default/20170723/5974a2d925ea1.jpg\";i:1;s:34:\"default/20170723/5974a2e009e66.jpg\";}', 'a:2:{i:0;s:34:\"default/20170723/5974a2e8ae91f.jpg\";i:1;s:34:\"default/20170723/5974a2f0bc0a4.jpg\";}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:6:\"小份\";}s:5:\"cycle\";a:2:{i:0;s:4:\"1天\";i:1;s:4:\"3天\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('3', '凯撒鸡排套餐', '2', '每日中餐中午12点之前送达', 'default/20170723/5974a34ed90f9.jpg', 'a:2:{i:0;s:34:\"default/20170723/5974a356912cb.jpg\";i:1;s:34:\"default/20170723/5974a35cbdf1b.jpg\";}', 'a:2:{i:0;s:34:\"default/20170723/5974a3645bbda.jpg\";i:1;s:34:\"default/20170723/5974a36996205.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"1天\";}}', '2', 'default/20170723/5974a370473a6.jpg', 's:0:\"\";', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('4', '新动力营养搭配餐', '2', '每日中餐中午12点之前送达', 'default/20170723/5974a3a195271.jpg', 'a:3:{i:0;s:34:\"default/20170723/5974a3afecbde.jpg\";i:1;s:34:\"default/20170723/5974a3ba2bb34.jpg\";i:2;s:34:\"default/20170723/5974a3c5f3aec.jpg\";}', 'a:2:{i:0;s:34:\"default/20170723/5974a3cc6c329.jpg\";i:1;s:34:\"default/20170723/5974a3d1b033e.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:2:{i:0;s:4:\"1天\";i:1;s:4:\"3天\";}}', '1', '', 'a:1:{i:0;s:1:\"1\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('5', '凯撒鸡排套餐', '3', '每日中餐中午12点之前送达', 'default/20170723/5974a4046f06a.jpg', 'a:2:{i:0;s:34:\"default/20170723/5974a40d36bf7.jpg\";i:1;s:34:\"default/20170723/5974a4143a476.jpg\";}', 'a:2:{i:0;s:34:\"default/20170723/5974a41a0ee4b.jpg\";i:1;s:34:\"default/20170723/5974a420122a9.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"1天\";}}', '2', 'default/20170723/5974a42d1f61f.jpg', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('6', '凯撒鸡排套餐', '4', '每日中餐中午12点之前送达', 'default/20170723/5974a45570566.jpg', 'a:2:{i:0;s:34:\"default/20170723/5974a488c3901.jpg\";i:1;s:34:\"default/20170723/5974a48f2ba20.jpg\";}', 'a:2:{i:0;s:34:\"default/20170723/5974a4998c2f3.jpg\";i:1;s:34:\"default/20170723/5974a49eb5a16.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"5天\";}}', '2', 'default/20170723/5974a4a799b96.jpg', 'a:1:{i:0;s:1:\"1\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('7', '猫咪健身餐', '1', '下单后默认第二天配送', 'default/20170728/597b408324b59.jpg', 'a:4:{i:0;s:34:\"default/20170728/597b408a95f5e.jpg\";i:1;s:32:\"$spu_info[\'goods_slide_img\'][1]}\";i:2;s:34:\"default/20170728/597b44761f4c0.jpg\";i:3;s:34:\"default/20170728/597b447e201a4.jpg\";}', 'a:2:{i:0;s:34:\"default/20170728/597b4092947bc.jpg\";i:1;s:34:\"default/20170728/597b4098675dd.jpg\";}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:6:\"小份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"1天\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('8', '测试健康餐1', '2', '下单后第二天开始配送', 'default/20170729/597c4fe12c43c.jpg', 'a:1:{i:0;s:34:\"default/20170729/597c4fece118b.jpg\";}', 'a:1:{i:0;s:34:\"default/20170729/597c4ff6e1bf0.jpg\";}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:6:\"小份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"1天\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'a:1:{i:0;s:1:\"5\";}', '2');
INSERT INTO `ys_goods_spu` VALUES ('9', '验证商品', '1', '每天中午12点\r\n每天晚上7点送到指定地点', 'default/20170730/597d7c3727d09.jpg', 'a:4:{i:0;s:34:\"default/20170730/597d7c4f5b6a2.jpg\";i:1;s:34:\"default/20170730/597d7c531f765.png\";i:2;s:34:\"default/20170730/597d7c5c6e50e.jpg\";i:3;s:34:\"default/20170730/597d7c67c006f.jpg\";}', 'a:2:{i:0;s:34:\"default/20170730/597d7c7ee7c32.jpg\";i:1;s:34:\"default/20170730/597d7c97e7543.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:4:\"3天\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'a:1:{i:0;s:1:\"2\";}', '2');
INSERT INTO `ys_goods_spu` VALUES ('11', '烤南瓜藜麦沙拉', '3', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ffe4cc5cb1.jpg', 'a:4:{i:0;s:34:\"default/20170813/598ffe52a354f.jpg\";i:1;s:34:\"default/20170813/598ffe594b260.jpg\";i:2;s:34:\"default/20170813/598ffe5f39d78.jpg\";i:3;s:34:\"default/20170813/598ffe637c582.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '2', 'default/20170813/5990000d28e2c.jpg', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('12', '经典考伯沙拉', '3', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ffe179b7a7.jpg', 'a:4:{i:0;s:34:\"default/20170803/59820ed5664dd.jpg\";i:1;s:34:\"default/20170803/59820eddd3dee.jpg\";i:2;s:34:\"default/20170803/59820ee89f4e6.jpg\";i:3;s:34:\"default/20170803/59820ef014ad1.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('13', '鲜虾意面沙拉', '3', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ffdb77bf4c.jpg', 'a:4:{i:0;s:34:\"default/20170813/598ffdbfa1735.jpg\";i:1;s:34:\"default/20170813/598ffdc41fbef.jpg\";i:2;s:34:\"default/20170813/598ffdc9e6cf5.jpg\";i:3;s:34:\"default/20170813/598ffdcdd246c.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('14', '皇极虾套餐', '2', '下单即可配送', 'default/20170803/5982797dd7bc8.jpg', 'a:4:{i:0;s:34:\"default/20170803/5982798b73377.jpg\";i:1;s:34:\"default/20170803/5982799443e66.jpg\";i:2;s:34:\"default/20170803/5982768870e9a.jpg\";i:3;s:34:\"default/20170803/59827690a7632.jpg\";}', 'a:2:{i:2;s:34:\"default/20170803/598276a322458.jpg\";i:3;s:34:\"default/20170803/598276a6d91c3.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"大份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '2');
INSERT INTO `ys_goods_spu` VALUES ('15', '专业2对1减脂营', '1', '待定', 'default/20170813/59905ecfcde19.jpg', 'a:1:{i:0;s:34:\"default/20170808/5989217732a28.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"男生\";i:1;s:6:\"女生\";}s:5:\"cycle\";a:1:{i:0;s:6:\"月订\";}}', '2', 'default/20170813/59905ea4b43bd.jpg', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('16', '一周清体套餐', '1', '当日下单\r\n次日开始配送\r\n每天包含午餐及晚餐两餐', 'default/20170813/598ffba76cc25.jpg', 'a:1:{i:0;s:34:\"default/20170808/5989221f50e98.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:6:\"小份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"周订\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('17', '一月轻体套餐', '1', '当日下单\r\n次日开始配送\r\n每天包含午餐及晚餐两餐', 'default/20170813/598ffbc4c5641.jpg', 'a:1:{i:0;s:34:\"default/20170808/598925c3bbecb.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:6:\"小份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"月订\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('18', '一日体验套餐', '1', '当日下单\r\n次日开始配送\r\n每天包含午餐及晚餐两餐', 'default/20170813/598ffb7fd578e.jpg', 'a:1:{i:0;s:34:\"default/20170808/5989269eb3582.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:2:{i:0;s:6:\"大份\";i:1;s:6:\"小份\";}s:5:\"cycle\";a:1:{i:0;s:6:\"日订\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('19', '卤牛肉套餐', '2', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff81dc00a4.jpg', 'a:4:{i:0;s:34:\"default/20170813/598ff823680d1.jpg\";i:1;s:34:\"default/20170813/598ff829a1d69.jpg\";i:2;s:34:\"default/20170813/598ff82de17f6.jpg\";i:3;s:34:\"default/20170813/598ff831e58c1.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '2', 'default/20170813/598ff83e16095.jpg', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('20', '皇极虾套餐', '2', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff7b52d5c1.jpg', 'a:4:{i:0;s:34:\"default/20170813/598ff7bde29fb.jpg\";i:1;s:34:\"default/20170813/598ff7c1bd706.jpg\";i:2;s:34:\"default/20170813/598ff7c7b284d.jpg\";i:3;s:34:\"default/20170813/598ff7cbe03de.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('21', '嫩烤鸡胸套餐', '2', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff750da3d8.jpg', 'a:3:{i:0;s:34:\"default/20170813/598ff75b9fa1b.jpg\";i:1;s:34:\"default/20170813/598ff763c1b32.jpg\";i:2;s:34:\"default/20170813/598ff768da825.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('22', '公司三明治', '5', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff6c5e4fa8.jpg', 'a:4:{i:0;s:34:\"default/20170813/598ff6cd02925.jpg\";i:1;s:34:\"default/20170813/598ff6d487816.jpg\";i:2;s:34:\"default/20170813/598ff6dc87c13.jpg\";i:3;s:34:\"default/20170813/598ff6e21f320.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '2', 'default/20170813/598ff6f466e5b.jpg', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('23', '鸡胸肉丝', '5', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff66f48122.jpg', 'a:1:{i:0;s:34:\"default/20170808/59892c5520940.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('24', '嫩烤鸡胸肉150g', '5', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff64b559b3.jpg', 'a:1:{i:0;s:34:\"default/20170808/59892c8d64f9f.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('25', '猕猴桃汁', '4', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff57c1d625.jpg', 'a:4:{i:0;s:34:\"default/20170813/598ff5860a132.jpg\";i:1;s:34:\"default/20170813/598ff58a50eea.jpg\";i:2;s:34:\"default/20170813/598ff58ec1804.jpg\";i:3;s:34:\"default/20170813/598ff59268248.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('26', '胡萝卜苹果汁', '4', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/598ff4f61cedf.jpg', 'a:3:{i:0;s:34:\"default/20170813/598ff50842977.jpg\";i:1;s:34:\"default/20170813/598ff50eb4da9.jpg\";i:2;s:34:\"default/20170813/598ff5136bcf7.jpg\";}', 'a:0:{}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');
INSERT INTO `ys_goods_spu` VALUES ('27', '增肌餐', '1', '默认次日配送\r\n需立即配送请拨打店内电话 028-67273707直接下单', 'default/20170813/59905f7560eb1.jpg', 'a:4:{i:0;s:34:\"default/20170813/59905f7cca31c.jpg\";i:1;s:34:\"default/20170813/59905f8cae47a.jpg\";i:2;s:34:\"default/20170813/59905f922ce14.jpg\";i:3;s:34:\"default/20170813/59905f9607437.jpg\";}', 'a:1:{i:0;s:34:\"default/20170813/59905fb093c41.jpg\";}', 'a:2:{s:7:\"portion\";a:1:{i:0;s:6:\"标准\";}s:5:\"cycle\";a:1:{i:0;s:6:\"一餐\";}}', '1', '', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, '1');

-- ----------------------------
-- Table structure for `ys_goods_stat`
-- ----------------------------
DROP TABLE IF EXISTS `ys_goods_stat`;
CREATE TABLE `ys_goods_stat` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `spu_id` int(4) NOT NULL,
  `order_count` int(11) DEFAULT '0' COMMENT '下单数量统计',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_goods_stat
-- ----------------------------
INSERT INTO `ys_goods_stat` VALUES ('1', '1', '0');
INSERT INTO `ys_goods_stat` VALUES ('2', '2', '0');
INSERT INTO `ys_goods_stat` VALUES ('3', '3', '0');
INSERT INTO `ys_goods_stat` VALUES ('4', '4', '0');
INSERT INTO `ys_goods_stat` VALUES ('5', '5', '0');
INSERT INTO `ys_goods_stat` VALUES ('6', '6', '0');
INSERT INTO `ys_goods_stat` VALUES ('7', '7', '0');
INSERT INTO `ys_goods_stat` VALUES ('8', '8', '0');
INSERT INTO `ys_goods_stat` VALUES ('9', '9', '0');
INSERT INTO `ys_goods_stat` VALUES ('10', '11', '0');
INSERT INTO `ys_goods_stat` VALUES ('11', '12', '0');
INSERT INTO `ys_goods_stat` VALUES ('12', '13', '0');
INSERT INTO `ys_goods_stat` VALUES ('13', '14', '0');
INSERT INTO `ys_goods_stat` VALUES ('14', '15', '0');
INSERT INTO `ys_goods_stat` VALUES ('15', '16', '0');
INSERT INTO `ys_goods_stat` VALUES ('16', '17', '0');
INSERT INTO `ys_goods_stat` VALUES ('17', '18', '0');
INSERT INTO `ys_goods_stat` VALUES ('18', '19', '0');
INSERT INTO `ys_goods_stat` VALUES ('19', '20', '0');
INSERT INTO `ys_goods_stat` VALUES ('20', '21', '0');
INSERT INTO `ys_goods_stat` VALUES ('21', '22', '0');
INSERT INTO `ys_goods_stat` VALUES ('22', '23', '0');
INSERT INTO `ys_goods_stat` VALUES ('23', '24', '0');
INSERT INTO `ys_goods_stat` VALUES ('24', '25', '0');
INSERT INTO `ys_goods_stat` VALUES ('25', '26', '0');
INSERT INTO `ys_goods_stat` VALUES ('26', '27', '0');

-- ----------------------------
-- Table structure for `ys_guestbook`
-- ----------------------------
DROP TABLE IF EXISTS `ys_guestbook`;
CREATE TABLE `ys_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL COMMENT '留言者姓名',
  `email` varchar(100) NOT NULL COMMENT '留言者邮箱',
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `msg` text NOT NULL COMMENT '留言内容',
  `createtime` datetime NOT NULL COMMENT '留言时间',
  `status` smallint(2) NOT NULL DEFAULT '1' COMMENT '留言状态，1：正常，0：删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Records of ys_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_links`
-- ----------------------------
DROP TABLE IF EXISTS `ys_links`;
CREATE TABLE `ys_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL COMMENT '友情链接地址',
  `link_name` varchar(255) NOT NULL COMMENT '友情链接名称',
  `link_image` varchar(255) DEFAULT NULL COMMENT '友情链接图标',
  `link_target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '友情链接打开方式',
  `link_description` text NOT NULL COMMENT '友情链接描述',
  `link_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `link_rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `link_rel` varchar(255) DEFAULT NULL COMMENT '链接与网站的关系',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of ys_links
-- ----------------------------
INSERT INTO `ys_links` VALUES ('1', 'http://www.thinkcmf.com', 'ThinkCMF', '', '_blank', '', '1', '0', '', '0');

-- ----------------------------
-- Table structure for `ys_member`
-- ----------------------------
DROP TABLE IF EXISTS `ys_member`;
CREATE TABLE `ys_member` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `wechat_openid` varchar(50) NOT NULL COMMENT '微信用户openid',
  `mobile` char(11) DEFAULT NULL COMMENT '用户手机号',
  `nick_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '用户昵称',
  `sex` tinyint(2) DEFAULT '2' COMMENT '用户性别，1.男，2女',
  `reg_time` int(11) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_openid` (`wechat_openid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_member
-- ----------------------------
INSERT INTO `ys_member` VALUES ('10', 'oomDVwIXqbPE65apwYB_27HKR-0g', '13438347004', '嘿！大叔', '1', '1501318793', 'http://wx.qlogo.cn/mmopen/Sp4t18TG2ynONE93nXwqrk90PWvjFaQ2hPDlKibiarEOd9yHPoSR06hJTaCODKgUezx0NQJyanAD2jvDzptwV1EhibKlyiaReNUw/');
INSERT INTO `ys_member` VALUES ('15', 'oomDVwKt1vPhthTpn6GQ7e_vQGEU', '18123368783', '之名', '1', '1501417405', 'http://wx.qlogo.cn/mmopen/ePhSMBcFjpt3ErWgdiaOHD6f4vBDhMOhQJLHfmmAMlBDPJTTIOVu1gkONjPIuj9JZzktxVX5aA2EkFV21mNvLeHg2FPcrNASN/');
INSERT INTO `ys_member` VALUES ('21', 'oomDVwNVxadvkquKiaQoh_lQ42jU', '13880600394', '&想々像&', '1', '1501423493', 'http://wx.qlogo.cn/mmopen/AOTZHM0n4SCoKVuYHgUuChticam8QSYy0piakibvg82jzx5b5ia2ScYUhUicEDfxsARrKIx5xuzSeN6LdWQtibF6Mia9tKd9FrwZcCj/');
INSERT INTO `ys_member` VALUES ('26', 'oomDVwDq4zOqQ8InBpK-3keaByPo', '17612834679', '德生', '1', '1501426759', 'http://wx.qlogo.cn/mmopen/Sp4t18TG2ynD3NV0Mj0qUVqovLgsa4tMeWRzVpcVyNunvyJX38V05V2dAFGNdUIHWZAgQ60PxdCx8VYYm5d4uz2wg6EXmD57/');
INSERT INTO `ys_member` VALUES ('30', 'oomDVwNzFwq4BR62P6T2O70TSN8s', '18628062001', '风之想', '1', '1501479411', 'http://wx.qlogo.cn/mmopen/Sp4t18TG2ynlPoE1KYTxPEV3snOlFI2mTz2CIben7rorN3ibqZ7c8cibTGO5iabHOo59u3sPxWmQT5csSR4Kxwia1IyLDSMa5voT/');
INSERT INTO `ys_member` VALUES ('31', 'oomDVwHLke0VFfxZSUZlKM0c7lww', '18581835277', '武帅餍食', '1', '1501479468', 'http://wx.qlogo.cn/mmopen/Sp4t18TG2ykwpncLxwm4eaXfuKpqBibvMomOicrgzFEibeKVeap2iciaew28IMmmRUj0Grib873JkTXfh9LSAsNoa7PNPR5icsSrm63/');
INSERT INTO `ys_member` VALUES ('32', 'oomDVwKEZgjClBMY9f6rgvLKOKWs', '15228827904', 'Dayang', '2', '1501728704', 'http://wx.qlogo.cn/mmopen/ePhSMBcFjptmzFofEPUwHricD7fu2F9PsTdgp5S7icIL0CxOTTf7spaZoCCyLRSgyZJIDrHmgTygibE99eBuApqxeibMBbibVqVfk/');
INSERT INTO `ys_member` VALUES ('35', 'oomDVwBUpBcVUHa-MLtkluvtOpqk', '18683562355', '啊呜', '2', '1502094959', 'http://wx.qlogo.cn/mmopen/ePhSMBcFjpufbmbgPNDczL2eZjo1lNngj70RtiauyR0ZoWibP2UffV01uMlM4xYyicDYSKhmow75yCCiat3lXy3K043pZqsS3LTX/');
INSERT INTO `ys_member` VALUES ('36', 'oomDVwJUfkLrskWxSFAzppmEnSzk', '13258242368', '章诗涵', '1', '1502248637', 'http://wx.qlogo.cn/mmopen/PiajxSqBRaEK4UZD4icbibJia8IWd9Vfrn72ETH8sj3dFnc2jMV9Bv9g1PqqK7tQzmLF2rPFMxDoBBchWBbrrpox8KoDCdVehtaDE5qZYbUnPIo/');
INSERT INTO `ys_member` VALUES ('37', 'oomDVwB4Qpe8H-nwEKkDbDoYdwc8', '15226067931', '笑着流泪', '1', '1502443329', 'http://wx.qlogo.cn/mmopen/Sp4t18TG2ynib3Z7cltXH7FUQDD0byp9zXxvxibeGFL6Fhx1uOBVIgY7jvM0nsbF1ogLIrUic5kh4R1o8EgENdaUsELic2RTibiblu/');

-- ----------------------------
-- Table structure for `ys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `ys_menu`;
CREATE TABLE `ys_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `app` varchar(30) NOT NULL DEFAULT '' COMMENT '应用名称app',
  `model` varchar(30) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称',
  `data` varchar(50) NOT NULL DEFAULT '' COMMENT '额外参数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '菜单类型  1：权限认证+菜单；0：只作为菜单',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1显示，0不显示',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parentid`),
  KEY `model` (`model`)
) ENGINE=MyISAM AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Records of ys_menu
-- ----------------------------
INSERT INTO `ys_menu` VALUES ('1', '0', 'Admin', 'Content', 'default', '', '0', '0', '内容管理', 'th', '', '0');
INSERT INTO `ys_menu` VALUES ('2', '1', 'Api', 'Guestbookadmin', 'index', '', '1', '1', '所有留言', '', '', '0');
INSERT INTO `ys_menu` VALUES ('3', '2', 'Api', 'Guestbookadmin', 'delete', '', '1', '0', '删除网站留言', '', '', '0');
INSERT INTO `ys_menu` VALUES ('4', '1', 'Comment', 'Commentadmin', 'index', '', '1', '1', '评论管理', '', '', '0');
INSERT INTO `ys_menu` VALUES ('5', '4', 'Comment', 'Commentadmin', 'delete', '', '1', '0', '删除评论', '', '', '0');
INSERT INTO `ys_menu` VALUES ('6', '4', 'Comment', 'Commentadmin', 'check', '', '1', '0', '评论审核', '', '', '0');
INSERT INTO `ys_menu` VALUES ('7', '1', 'Portal', 'AdminPost', 'index', '', '1', '1', '文章管理', '', '', '1');
INSERT INTO `ys_menu` VALUES ('8', '7', 'Portal', 'AdminPost', 'listorders', '', '1', '0', '文章排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('9', '7', 'Portal', 'AdminPost', 'top', '', '1', '0', '文章置顶', '', '', '0');
INSERT INTO `ys_menu` VALUES ('10', '7', 'Portal', 'AdminPost', 'recommend', '', '1', '0', '文章推荐', '', '', '0');
INSERT INTO `ys_menu` VALUES ('11', '7', 'Portal', 'AdminPost', 'move', '', '1', '0', '批量移动', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('12', '7', 'Portal', 'AdminPost', 'check', '', '1', '0', '文章审核', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('13', '7', 'Portal', 'AdminPost', 'delete', '', '1', '0', '删除文章', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('14', '7', 'Portal', 'AdminPost', 'edit', '', '1', '0', '编辑文章', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('15', '14', 'Portal', 'AdminPost', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('16', '7', 'Portal', 'AdminPost', 'add', '', '1', '0', '添加文章', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('17', '16', 'Portal', 'AdminPost', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('18', '1', 'Portal', 'AdminTerm', 'index', '', '0', '1', '分类管理', '', '', '2');
INSERT INTO `ys_menu` VALUES ('19', '18', 'Portal', 'AdminTerm', 'listorders', '', '1', '0', '文章分类排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('20', '18', 'Portal', 'AdminTerm', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('21', '18', 'Portal', 'AdminTerm', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('22', '21', 'Portal', 'AdminTerm', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('23', '18', 'Portal', 'AdminTerm', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('24', '23', 'Portal', 'AdminTerm', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('25', '1', 'Portal', 'AdminPage', 'index', '', '1', '1', '页面管理', '', '', '3');
INSERT INTO `ys_menu` VALUES ('26', '25', 'Portal', 'AdminPage', 'listorders', '', '1', '0', '页面排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('27', '25', 'Portal', 'AdminPage', 'delete', '', '1', '0', '删除页面', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('28', '25', 'Portal', 'AdminPage', 'edit', '', '1', '0', '编辑页面', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('29', '28', 'Portal', 'AdminPage', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('30', '25', 'Portal', 'AdminPage', 'add', '', '1', '0', '添加页面', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('31', '30', 'Portal', 'AdminPage', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('32', '1', 'Admin', 'Recycle', 'default', '', '1', '1', '回收站', '', '', '4');
INSERT INTO `ys_menu` VALUES ('33', '32', 'Portal', 'AdminPost', 'recyclebin', '', '1', '1', '文章回收', '', '', '0');
INSERT INTO `ys_menu` VALUES ('34', '33', 'Portal', 'AdminPost', 'restore', '', '1', '0', '文章还原', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('35', '33', 'Portal', 'AdminPost', 'clean', '', '1', '0', '彻底删除', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('36', '32', 'Portal', 'AdminPage', 'recyclebin', '', '1', '1', '页面回收', '', '', '1');
INSERT INTO `ys_menu` VALUES ('37', '36', 'Portal', 'AdminPage', 'clean', '', '1', '0', '彻底删除', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('38', '36', 'Portal', 'AdminPage', 'restore', '', '1', '0', '页面还原', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('39', '0', 'Admin', 'Extension', 'default', '', '0', '0', '扩展工具', 'cloud', '', '0');
INSERT INTO `ys_menu` VALUES ('40', '39', 'Admin', 'Backup', 'default', '', '1', '0', '备份管理', '', '', '0');
INSERT INTO `ys_menu` VALUES ('41', '40', 'Admin', 'Backup', 'restore', '', '1', '1', '数据还原', '', '', '0');
INSERT INTO `ys_menu` VALUES ('42', '40', 'Admin', 'Backup', 'index', '', '1', '1', '数据备份', '', '', '0');
INSERT INTO `ys_menu` VALUES ('43', '42', 'Admin', 'Backup', 'index_post', '', '1', '0', '提交数据备份', '', '', '0');
INSERT INTO `ys_menu` VALUES ('44', '40', 'Admin', 'Backup', 'download', '', '1', '0', '下载备份', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('45', '40', 'Admin', 'Backup', 'del_backup', '', '1', '0', '删除备份', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('46', '40', 'Admin', 'Backup', 'import', '', '1', '0', '数据备份导入', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('47', '39', 'Admin', 'Plugin', 'index', '', '1', '1', '插件管理', '', '', '0');
INSERT INTO `ys_menu` VALUES ('48', '47', 'Admin', 'Plugin', 'toggle', '', '1', '0', '插件启用切换', '', '', '0');
INSERT INTO `ys_menu` VALUES ('49', '47', 'Admin', 'Plugin', 'setting', '', '1', '0', '插件设置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('50', '49', 'Admin', 'Plugin', 'setting_post', '', '1', '0', '插件设置提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('51', '47', 'Admin', 'Plugin', 'install', '', '1', '0', '插件安装', '', '', '0');
INSERT INTO `ys_menu` VALUES ('52', '47', 'Admin', 'Plugin', 'uninstall', '', '1', '0', '插件卸载', '', '', '0');
INSERT INTO `ys_menu` VALUES ('53', '39', 'Admin', 'Slide', 'default', '', '1', '1', '幻灯片', '', '', '1');
INSERT INTO `ys_menu` VALUES ('54', '53', 'Admin', 'Slide', 'index', '', '1', '1', '幻灯片管理', '', '', '0');
INSERT INTO `ys_menu` VALUES ('55', '54', 'Admin', 'Slide', 'listorders', '', '1', '0', '幻灯片排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('56', '54', 'Admin', 'Slide', 'toggle', '', '1', '0', '幻灯片显示切换', '', '', '0');
INSERT INTO `ys_menu` VALUES ('57', '54', 'Admin', 'Slide', 'delete', '', '1', '0', '删除幻灯片', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('58', '54', 'Admin', 'Slide', 'edit', '', '1', '0', '编辑幻灯片', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('59', '58', 'Admin', 'Slide', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('60', '54', 'Admin', 'Slide', 'add', '', '1', '0', '添加幻灯片', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('61', '60', 'Admin', 'Slide', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('62', '53', 'Admin', 'Slidecat', 'index', '', '1', '1', '幻灯片分类', '', '', '0');
INSERT INTO `ys_menu` VALUES ('63', '62', 'Admin', 'Slidecat', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('64', '62', 'Admin', 'Slidecat', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('65', '64', 'Admin', 'Slidecat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('66', '62', 'Admin', 'Slidecat', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('67', '66', 'Admin', 'Slidecat', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('68', '39', 'Admin', 'Ad', 'index', '', '1', '1', '网站广告', '', '', '2');
INSERT INTO `ys_menu` VALUES ('69', '68', 'Admin', 'Ad', 'toggle', '', '1', '0', '广告显示切换', '', '', '0');
INSERT INTO `ys_menu` VALUES ('70', '68', 'Admin', 'Ad', 'delete', '', '1', '0', '删除广告', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('71', '68', 'Admin', 'Ad', 'edit', '', '1', '0', '编辑广告', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('72', '71', 'Admin', 'Ad', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('73', '68', 'Admin', 'Ad', 'add', '', '1', '0', '添加广告', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('74', '73', 'Admin', 'Ad', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('75', '39', 'Admin', 'Link', 'index', '', '0', '1', '友情链接', '', '', '3');
INSERT INTO `ys_menu` VALUES ('76', '75', 'Admin', 'Link', 'listorders', '', '1', '0', '友情链接排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('77', '75', 'Admin', 'Link', 'toggle', '', '1', '0', '友链显示切换', '', '', '0');
INSERT INTO `ys_menu` VALUES ('78', '75', 'Admin', 'Link', 'delete', '', '1', '0', '删除友情链接', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('79', '75', 'Admin', 'Link', 'edit', '', '1', '0', '编辑友情链接', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('80', '79', 'Admin', 'Link', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('81', '75', 'Admin', 'Link', 'add', '', '1', '0', '添加友情链接', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('82', '81', 'Admin', 'Link', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('83', '39', 'Api', 'Oauthadmin', 'setting', '', '1', '1', '第三方登陆', 'leaf', '', '4');
INSERT INTO `ys_menu` VALUES ('84', '83', 'Api', 'Oauthadmin', 'setting_post', '', '1', '0', '提交设置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('85', '109', 'Admin', 'Menu', 'default', '', '1', '1', '菜单管理', 'list', '', '20');
INSERT INTO `ys_menu` VALUES ('100', '85', 'Admin', 'Menu', 'index', '', '1', '1', '后台菜单', '', '', '0');
INSERT INTO `ys_menu` VALUES ('101', '100', 'Admin', 'Menu', 'add', '', '1', '0', '添加菜单', '', '', '0');
INSERT INTO `ys_menu` VALUES ('102', '101', 'Admin', 'Menu', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('103', '100', 'Admin', 'Menu', 'listorders', '', '1', '0', '后台菜单排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('104', '100', 'Admin', 'Menu', 'export_menu', '', '1', '0', '菜单备份', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('105', '100', 'Admin', 'Menu', 'edit', '', '1', '0', '编辑菜单', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('106', '105', 'Admin', 'Menu', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('107', '100', 'Admin', 'Menu', 'delete', '', '1', '0', '删除菜单', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('108', '100', 'Admin', 'Menu', 'lists', '', '1', '0', '所有菜单', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('109', '0', 'Admin', 'Setting', 'default', '', '0', '1', '系统管理', 'cogs', '', '0');
INSERT INTO `ys_menu` VALUES ('110', '109', 'Admin', 'Setting', 'userdefault', '', '0', '0', '个人信息', '', '', '0');
INSERT INTO `ys_menu` VALUES ('111', '110', 'Admin', 'User', 'userinfo', '', '1', '1', '修改信息', '', '', '0');
INSERT INTO `ys_menu` VALUES ('112', '111', 'Admin', 'User', 'userinfo_post', '', '1', '0', '修改信息提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('113', '110', 'Admin', 'Setting', 'password', '', '1', '1', '修改密码', '', '', '0');
INSERT INTO `ys_menu` VALUES ('114', '113', 'Admin', 'Setting', 'password_post', '', '1', '0', '提交修改', '', '', '0');
INSERT INTO `ys_menu` VALUES ('115', '109', 'Admin', 'Setting', 'site', '', '1', '0', '网站信息', '', '', '0');
INSERT INTO `ys_menu` VALUES ('116', '115', 'Admin', 'Setting', 'site_post', '', '1', '0', '提交修改', '', '', '0');
INSERT INTO `ys_menu` VALUES ('117', '115', 'Admin', 'Route', 'index', '', '1', '0', '路由列表', '', '', '0');
INSERT INTO `ys_menu` VALUES ('118', '115', 'Admin', 'Route', 'add', '', '1', '0', '路由添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('119', '118', 'Admin', 'Route', 'add_post', '', '1', '0', '路由添加提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('120', '115', 'Admin', 'Route', 'edit', '', '1', '0', '路由编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('121', '120', 'Admin', 'Route', 'edit_post', '', '1', '0', '路由编辑提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('122', '115', 'Admin', 'Route', 'delete', '', '1', '0', '路由删除', '', '', '0');
INSERT INTO `ys_menu` VALUES ('123', '115', 'Admin', 'Route', 'ban', '', '1', '0', '路由禁止', '', '', '0');
INSERT INTO `ys_menu` VALUES ('124', '115', 'Admin', 'Route', 'open', '', '1', '0', '路由启用', '', '', '0');
INSERT INTO `ys_menu` VALUES ('125', '115', 'Admin', 'Route', 'listorders', '', '1', '0', '路由排序', '', '', '0');
INSERT INTO `ys_menu` VALUES ('126', '109', 'Admin', 'Mailer', 'default', '', '1', '0', '邮箱配置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('127', '126', 'Admin', 'Mailer', 'index', '', '1', '1', 'SMTP配置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('128', '127', 'Admin', 'Mailer', 'index_post', '', '1', '0', '提交配置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('129', '126', 'Admin', 'Mailer', 'active', '', '1', '1', '注册邮件模板', '', '', '0');
INSERT INTO `ys_menu` VALUES ('130', '129', 'Admin', 'Mailer', 'active_post', '', '1', '0', '提交模板', '', '', '0');
INSERT INTO `ys_menu` VALUES ('131', '109', 'Admin', 'Setting', 'clearcache', '', '1', '1', '清除缓存', '', '', '1');
INSERT INTO `ys_menu` VALUES ('132', '109', 'User', 'Indexadmin', 'default', '', '1', '1', '权限管理', 'group', '', '10');
INSERT INTO `ys_menu` VALUES ('187', '0', 'Admin', 'Goods', 'index', '', '1', '1', '商品管理', 'shopping-cart', '', '30');
INSERT INTO `ys_menu` VALUES ('188', '0', 'Admin', 'Order', 'index', '', '1', '1', '订单管理', 'list', '', '40');
INSERT INTO `ys_menu` VALUES ('189', '0', 'Admin', 'Voucher', 'voucher_list', '', '1', '1', '优惠券管理', 'gift', '', '20');
INSERT INTO `ys_menu` VALUES ('190', '0', 'Admin', 'Member', 'member_list', '', '1', '1', '用户信息', 'users', '', '50');
INSERT INTO `ys_menu` VALUES ('140', '132', 'Admin', 'Rbac', 'index', '', '1', '1', '角色管理', '', '', '0');
INSERT INTO `ys_menu` VALUES ('141', '140', 'Admin', 'Rbac', 'member', '', '1', '0', '成员管理', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('142', '140', 'Admin', 'Rbac', 'authorize', '', '1', '0', '权限设置', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('143', '142', 'Admin', 'Rbac', 'authorize_post', '', '1', '0', '提交设置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('144', '140', 'Admin', 'Rbac', 'roleedit', '', '1', '0', '编辑角色', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('145', '144', 'Admin', 'Rbac', 'roleedit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `ys_menu` VALUES ('146', '140', 'Admin', 'Rbac', 'roledelete', '', '1', '1', '删除角色', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('147', '140', 'Admin', 'Rbac', 'roleadd', '', '1', '1', '添加角色', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('148', '147', 'Admin', 'Rbac', 'roleadd_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `ys_menu` VALUES ('149', '132', 'Admin', 'User', 'index', '', '1', '1', '管理员', '', '', '0');
INSERT INTO `ys_menu` VALUES ('150', '149', 'Admin', 'User', 'delete', '', '1', '0', '删除管理员', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('151', '149', 'Admin', 'User', 'edit', '', '1', '0', '管理员编辑', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('152', '151', 'Admin', 'User', 'edit_post', '', '1', '0', '编辑提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('153', '149', 'Admin', 'User', 'add', '', '1', '0', '管理员添加', '', '', '1000');
INSERT INTO `ys_menu` VALUES ('154', '153', 'Admin', 'User', 'add_post', '', '1', '0', '添加提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('155', '47', 'Admin', 'Plugin', 'update', '', '1', '0', '插件更新', '', '', '0');
INSERT INTO `ys_menu` VALUES ('156', '109', 'Admin', 'Storage', 'index', '', '1', '0', '文件存储', '', '', '0');
INSERT INTO `ys_menu` VALUES ('157', '156', 'Admin', 'Storage', 'setting_post', '', '1', '0', '文件存储设置提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('158', '54', 'Admin', 'Slide', 'ban', '', '1', '0', '禁用幻灯片', '', '', '0');
INSERT INTO `ys_menu` VALUES ('159', '54', 'Admin', 'Slide', 'cancelban', '', '1', '0', '启用幻灯片', '', '', '0');
INSERT INTO `ys_menu` VALUES ('160', '149', 'Admin', 'User', 'ban', '', '1', '0', '禁用管理员', '', '', '0');
INSERT INTO `ys_menu` VALUES ('161', '149', 'Admin', 'User', 'cancelban', '', '1', '0', '启用管理员', '', '', '0');
INSERT INTO `ys_menu` VALUES ('166', '127', 'Admin', 'Mailer', 'test', '', '1', '0', '测试邮件', '', '', '0');
INSERT INTO `ys_menu` VALUES ('167', '109', 'Admin', 'Setting', 'upload', '', '1', '0', '上传设置', '', '', '0');
INSERT INTO `ys_menu` VALUES ('168', '167', 'Admin', 'Setting', 'upload_post', '', '1', '0', '上传设置提交', '', '', '0');
INSERT INTO `ys_menu` VALUES ('169', '7', 'Portal', 'AdminPost', 'copy', '', '1', '0', '文章批量复制', '', '', '0');
INSERT INTO `ys_menu` VALUES ('174', '100', 'Admin', 'Menu', 'backup_menu', '', '1', '0', '备份菜单', '', '', '0');
INSERT INTO `ys_menu` VALUES ('175', '100', 'Admin', 'Menu', 'export_menu_lang', '', '1', '0', '导出后台菜单多语言包', '', '', '0');
INSERT INTO `ys_menu` VALUES ('176', '100', 'Admin', 'Menu', 'restore_menu', '', '1', '0', '还原菜单', '', '', '0');
INSERT INTO `ys_menu` VALUES ('177', '100', 'Admin', 'Menu', 'getactions', '', '1', '0', '导入新菜单', '', '', '0');
INSERT INTO `ys_menu` VALUES ('191', '187', 'Admin', 'Goods', 'goods_spec', '', '1', '1', '商品规格', '', '', '0');
INSERT INTO `ys_menu` VALUES ('192', '187', 'Admin', 'Goods', 'goods_list', '', '1', '1', '商品列表', '', '', '0');
INSERT INTO `ys_menu` VALUES ('193', '0', 'Admin', 'FoodDelivery', 'delivery_list', '', '1', '1', '送餐配置', 'plane', '', '10');
INSERT INTO `ys_menu` VALUES ('194', '193', 'Admin', 'FoodDelivery', 'add_delivery', '', '0', '0', '添加送餐点', '', '', '0');
INSERT INTO `ys_menu` VALUES ('195', '193', 'Admin', 'FoodDelivery', 'edit_meal_place', '', '0', '0', '编辑送餐地点', '', '', '0');
INSERT INTO `ys_menu` VALUES ('196', '193', 'Admin', 'FoodDelivery', 'del_tak_place_post', '', '0', '0', '删除取餐点', '', '', '0');
INSERT INTO `ys_menu` VALUES ('197', '193', 'Admin', 'FoodDelivery', 'add_meal_place', '', '0', '0', '添加取餐点', '', '', '0');
INSERT INTO `ys_menu` VALUES ('198', '197', 'Admin', 'FoodDelivery', 'add_meal_place_post', '', '0', '0', '取餐点post方法', '', '', '0');
INSERT INTO `ys_menu` VALUES ('199', '189', 'Admin', 'Voucher', 'add_voucher', '', '0', '0', '添加优惠券', '', '', '0');
INSERT INTO `ys_menu` VALUES ('200', '189', 'Admin', 'Voucher', 'bind_goods_list', '', '0', '0', '指定商品', '', '', '0');
INSERT INTO `ys_menu` VALUES ('201', '189', 'Admin', 'Voucher', 'get_voucher_qr_img', '', '0', '0', '查看二维码', '', '', '0');
INSERT INTO `ys_menu` VALUES ('202', '199', 'Admin', 'Voucher', 'add_voucher_post', '', '0', '0', '添加优惠券post方法', '', '', '0');
INSERT INTO `ys_menu` VALUES ('203', '191', 'Admin', 'Goods', 'del_spec_post', '', '0', '0', '删除商品规格', '', '', '0');
INSERT INTO `ys_menu` VALUES ('204', '191', 'Admin', 'Goods', 'add_spec_post', '', '0', '0', '添加份量', '', '', '0');
INSERT INTO `ys_menu` VALUES ('205', '192', 'Admin', 'Goods', 'add_goods', '', '0', '0', '添加商品', '', '', '0');
INSERT INTO `ys_menu` VALUES ('206', '205', 'Admin', 'Goods', 'add_goods_post', '', '0', '0', '添加商品post方法', '', '', '0');
INSERT INTO `ys_menu` VALUES ('207', '192', 'Admin', 'Goods', 'goods_info', '', '0', '0', '查看spu商品信息', '', '', '0');
INSERT INTO `ys_menu` VALUES ('208', '192', 'Admin', 'Goods', 'edit_goods_spu', '', '0', '0', '编辑spu商品信息', '', '', '0');
INSERT INTO `ys_menu` VALUES ('209', '192', 'Admin', 'Goods', 'edit_sku', '', '0', '0', '编辑sku商品', '', '', '0');
INSERT INTO `ys_menu` VALUES ('210', '192', 'Admin', 'Goods', 'recommend_goods', '', '0', '0', '添加编辑推荐商品', '', '', '0');
INSERT INTO `ys_menu` VALUES ('211', '192', 'Admin', 'Goods', 'get_recommend_list', '', '0', '0', '查看推荐商品', '', '', '0');
INSERT INTO `ys_menu` VALUES ('212', '210', 'Admin', 'Goods', 'add_recommend_goods_post', '', '0', '0', '选中推荐商品', '', '', '0');
INSERT INTO `ys_menu` VALUES ('213', '209', 'Admin', 'Goods', 'edit_sku_post', '', '0', '0', '修改sku商品方法', '', '', '0');
INSERT INTO `ys_menu` VALUES ('214', '207', 'Admin', 'Goods', 'edit_goods_spu_post', '', '0', '0', '编辑spu商品post方法', '', '', '0');
INSERT INTO `ys_menu` VALUES ('215', '188', 'Admin', 'Order', 'change_order_state', '', '0', '0', '变更订单状态', '', '', '0');
INSERT INTO `ys_menu` VALUES ('216', '188', 'Admin', 'Order', 'order_info', '', '0', '0', '查看订单详情', '', '', '0');
INSERT INTO `ys_menu` VALUES ('217', '188', 'Admin', 'Order', 'export_today_order_excel', '', '0', '0', '当日订单下载', '', '', '0');
INSERT INTO `ys_menu` VALUES ('218', '188', 'Admin', 'Order', 'export_today_amount', '', '0', '0', '当日配送金额下载', '', '', '0');
INSERT INTO `ys_menu` VALUES ('219', '215', 'Admin', 'Order', 'change_order_state_post', '', '1', '0', '变更订单状态post方法', '', '', '0');
INSERT INTO `ys_menu` VALUES ('220', '215', 'Admin', 'Order', 'batch_change_order_state', '', '1', '0', '批量变更订单状态', '', '', '0');
INSERT INTO `ys_menu` VALUES ('221', '194', 'Admin', 'FoodDelivery', 'add_delivery_post', '', '1', '0', '添加送餐点post方法', '', '', '0');

-- ----------------------------
-- Table structure for `ys_nav`
-- ----------------------------
DROP TABLE IF EXISTS `ys_nav`;
CREATE TABLE `ys_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT '导航分类 id',
  `parentid` int(11) NOT NULL COMMENT '导航父 id',
  `label` varchar(255) NOT NULL COMMENT '导航标题',
  `target` varchar(50) DEFAULT NULL COMMENT '打开方式',
  `href` varchar(255) NOT NULL COMMENT '导航链接',
  `icon` varchar(255) NOT NULL COMMENT '导航图标',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `listorder` int(6) DEFAULT '0' COMMENT '排序',
  `path` varchar(255) NOT NULL DEFAULT '0' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='前台导航表';

-- ----------------------------
-- Records of ys_nav
-- ----------------------------
INSERT INTO `ys_nav` VALUES ('1', '1', '0', '首页', '', 'home', '', '1', '0', '0-1');
INSERT INTO `ys_nav` VALUES ('2', '1', '0', '列表演示', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"1\";}}', '', '1', '0', '0-2');
INSERT INTO `ys_nav` VALUES ('3', '1', '0', '瀑布流', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"2\";}}', '', '1', '0', '0-3');

-- ----------------------------
-- Table structure for `ys_nav_cat`
-- ----------------------------
DROP TABLE IF EXISTS `ys_nav_cat`;
CREATE TABLE `ys_nav_cat` (
  `navcid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '导航分类名',
  `active` int(1) NOT NULL DEFAULT '1' COMMENT '是否为主菜单，1是，0不是',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`navcid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='前台导航分类表';

-- ----------------------------
-- Records of ys_nav_cat
-- ----------------------------
INSERT INTO `ys_nav_cat` VALUES ('1', '主导航', '1', '主导航');

-- ----------------------------
-- Table structure for `ys_oauth_user`
-- ----------------------------
DROP TABLE IF EXISTS `ys_oauth_user`;
CREATE TABLE `ys_oauth_user` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `from` varchar(20) NOT NULL COMMENT '用户来源key',
  `name` varchar(30) NOT NULL COMMENT '第三方昵称',
  `head_img` varchar(200) NOT NULL COMMENT '头像',
  `uid` int(20) NOT NULL COMMENT '关联的本站用户id',
  `create_time` datetime NOT NULL COMMENT '绑定时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `login_times` int(6) NOT NULL COMMENT '登录次数',
  `status` tinyint(2) NOT NULL,
  `access_token` varchar(512) NOT NULL,
  `expires_date` int(11) NOT NULL COMMENT 'access_token过期时间',
  `openid` varchar(40) NOT NULL COMMENT '第三方用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='第三方用户表';

-- ----------------------------
-- Records of ys_oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_options`
-- ----------------------------
DROP TABLE IF EXISTS `ys_options`;
CREATE TABLE `ys_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='全站配置表';

-- ----------------------------
-- Records of ys_options
-- ----------------------------
INSERT INTO `ys_options` VALUES ('1', 'member_email_active', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `ys_options` VALUES ('6', 'site_options', '            {\n            		\"site_name\":\"魇食\",\n            		\"site_host\":\"http://local.yanshi.com/\",\n            		\"site_root\":\"\",\n            		\"site_icp\":\"\",\n            		\"site_admin_email\":\"aa@dd.com\",\n            		\"site_tongji\":\"\",\n            		\"site_copyright\":\"\",\n            		\"site_seo_title\":\"魇食\",\n            		\"site_seo_keywords\":\"ThinkCMF,php,内容管理框架,cmf,cms,简约风, simplewind,framework\",\n            		\"site_seo_description\":\"魇食\"\n        }', '1');

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
  `pin_order_sn` varchar(30) DEFAULT NULL,
  `order_type` tinyint(2) NOT NULL COMMENT '购买类型，1.单买，2.2人拼团，3.4人拼团',
  `order_state` int(11) NOT NULL DEFAULT '0' COMMENT '订单状态。0.临时订单状态，1.待付款，2.已付款，3.配送中，4.已送达，5.交易完成,6.拼团待付款,7.拼团个人已付款，8.拼团付款完成',
  `delivery_num` int(4) DEFAULT '0' COMMENT '订单总共配送次数',
  `delivery_surplus_num` int(4) DEFAULT '0' COMMENT '剩余送餐次数',
  `delivery_time` varchar(30) DEFAULT NULL COMMENT '订单送餐时间',
  `time_area` varchar(50) DEFAULT NULL,
  `voucher_price` int(4) DEFAULT NULL,
  `pin_youhui` decimal(10,2) DEFAULT NULL,
  `receive_name` varchar(50) DEFAULT NULL,
  `receive_mobile` varchar(11) DEFAULT NULL,
  `d_id` int(4) DEFAULT NULL,
  `t_id` int(4) DEFAULT NULL,
  `receive_address` text,
  `delivery_date` int(11) DEFAULT NULL COMMENT '送餐日期',
  `order_content` text COMMENT '订单备注',
  PRIMARY KEY (`order_id`),
  KEY `index_sn` (`order_sn`),
  KEY `index_pin` (`pin_order_sn`),
  KEY `index_state` (`order_state`),
  KEY `index_delivery` (`delivery_time`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_order
-- ----------------------------
INSERT INTO `ys_order` VALUES ('359', '2017080810149505', '30', '1502194174', '4000002001201708085200660651', '1502194199', null, '0.01', '2017080810149505', '2', '7', '0', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'N;', null, '0.00', '李想', '18628062001', '1', '1', '西南财大柳江校区东门取餐', '1502121600', null);
INSERT INTO `ys_order` VALUES ('360', '2017080810149509', '10', '1502194174', null, null, null, '0.01', '2017080810149505', '2', '6', '0', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', null, null, '0.00', null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('361', '2017080999975199', '31', '1502250668', '4005502001201708095289684472', '1502250744', null, '0.01', null, '1', '3', '5', '4', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'a:2:{i:0;s:13:\"11点~11点30\";i:1;s:11:\"4点30~5点\";}', null, null, '武帅', '18581835277', '1', '4', '西南财大柳江校区女生宿舍内', '1502208000', null);
INSERT INTO `ys_order` VALUES ('362', '2017080910155975', '26', '1502250734', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('363', '2017080949501005', '26', '1502250785', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('364', '2017080910099100', '31', '1502250813', '4005502001201708095292508874', '1502250875', null, '0.01', '2017080910099100', '2', '8', '0', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'N;', null, '0.00', '武帅', '18581835277', '1', '4', '西南财大柳江校区女生宿舍内', '1501948800', null);
INSERT INTO `ys_order` VALUES ('365', '2017080910099101', '26', '1502250813', '4006252001201708095291316070', '1502251001', null, '0.01', '2017080910099100', '2', '8', '0', '0', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'N;', null, '0.00', '李德生', '17612834679', '1', '1', '西南财大柳江校区东门取餐', '1502294400', null);
INSERT INTO `ys_order` VALUES ('366', '2017080910052985', '26', '1502250893', '4006252001201708095291255339', '1502250935', null, '0.01', null, '1', '2', '5', '5', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'a:2:{i:0;s:13:\"12点~12点30\";i:1;s:11:\"5点~5点30\";}', null, null, '李德生', '17612834679', '1', '1', '西南财大柳江校区东门取餐', '1502294400', '4米修炼');
INSERT INTO `ys_order` VALUES ('367', '2017080954514855', '31', '1502251366', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('368', '2017081150549751', '37', '1502443458', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('369', '2017081210256481', '31', '1502504415', '4005502001201708125789971753', '1502504588', null, '0.02', null, '1', '2', '6', '6', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', 'a:2:{i:0;s:13:\"11点~11点30\";i:1;s:11:\"4点30~5点\";}', null, null, '武帅', '18581835277', '1', '4', '西南财大柳江校区女生宿舍内', '1502553600', null);
INSERT INTO `ys_order` VALUES ('370', '2017081255984999', '31', '1502504743', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('371', '2017081210210051', '31', '1502505007', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ys_order` VALUES ('372', '2017081299561025', '10', '1502530780', null, null, null, '0.00', null, '1', '0', '0', '0', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `ys_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ys_order_goods`;
CREATE TABLE `ys_order_goods` (
  `og_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '订单商品id',
  `order_sn` varchar(30) NOT NULL COMMENT '订单主表id',
  `sku_id` int(4) NOT NULL COMMENT 'sku_id',
  `spu_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `sku_spec` varchar(100) DEFAULT NULL COMMENT 'sku商品规格值',
  `goods_price` decimal(10,2) DEFAULT NULL,
  `order_type` int(2) NOT NULL COMMENT '购买类型，1.单买，2.2人拼团，3.4人拼团',
  `goods_img` varchar(200) DEFAULT NULL COMMENT '商品主图',
  PRIMARY KEY (`og_id`),
  KEY `index_sn` (`order_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_order_goods
-- ----------------------------
INSERT INTO `ys_order_goods` VALUES ('182', '2017080450555710', '3', '儿童营养套餐', '大份|1天', '0.01', '1', 'default/20170723/5974a2d1b0f7d.jpg');
INSERT INTO `ys_order_goods` VALUES ('183', '2017080499501029', '4', '儿童营养套餐', '大份|3天', '0.01', '1', 'default/20170723/5974a2d1b0f7d.jpg');
INSERT INTO `ys_order_goods` VALUES ('184', '2017080450985299', '2', '凯撒鸡排套餐', '超大份|1天', '9.00', '2', 'default/20170723/5974a1e28d2d3.jpg');
INSERT INTO `ys_order_goods` VALUES ('185', '2017080450985348', '2', '凯撒鸡排套餐', '超大份|1天', '9.00', '2', 'default/20170723/5974a1e28d2d3.jpg');
INSERT INTO `ys_order_goods` VALUES ('186', '2017080549504897', '16', '验证商品', '大份|3天', '0.01', '2', 'default/20170730/597d7c3727d09.jpg');
INSERT INTO `ys_order_goods` VALUES ('187', '2017080549504810', '16', '验证商品', '大份|3天', '0.01', '2', 'default/20170730/597d7c3727d09.jpg');
INSERT INTO `ys_order_goods` VALUES ('188', '2017080555579710', '10', '凯撒鸡排套餐', '大份|1天', '0.01', '1', 'default/20170723/5974a4046f06a.jpg');
INSERT INTO `ys_order_goods` VALUES ('189', '2017080597529810', '3', '儿童营养套餐', '大份|1天', '18.00', '2', 'default/20170723/5974a2d1b0f7d.jpg');
INSERT INTO `ys_order_goods` VALUES ('190', '2017080597529950', '3', '儿童营养套餐', '大份|1天', '18.00', '2', 'default/20170723/5974a2d1b0f7d.jpg');
INSERT INTO `ys_order_goods` VALUES ('191', '2017080850511011', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('192', '2017080850511024', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('193', '2017080857555198', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('194', '2017080857555110', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('195', '2017080850101489', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('196', '2017080850101494', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('197', '2017080810149505', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('198', '2017080810149509', '14', '测试健康餐1', '大份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('199', '2017080999975199', '14', '测试健康餐1', '大份|1天', '0.01', '1', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('200', '2017080910099100', '15', '测试健康餐1', '小份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('201', '2017080910099101', '15', '测试健康餐1', '小份|1天', '0.01', '2', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('202', '2017080910052985', '15', '测试健康餐1', '小份|1天', '0.01', '1', 'default/20170729/597c4fe12c43c.jpg');
INSERT INTO `ys_order_goods` VALUES ('203', '2017081210256481', '16', '验证商品', '大份|3天', '0.02', '1', 'default/20170730/597d7c3727d09.jpg');

-- ----------------------------
-- Table structure for `ys_plugins`
-- ----------------------------
DROP TABLE IF EXISTS `ys_plugins`;
CREATE TABLE `ys_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) NOT NULL COMMENT '插件名，英文',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '插件名称',
  `description` text COMMENT '插件描述',
  `type` tinyint(2) DEFAULT '0' COMMENT '插件类型, 1:网站；8;微信',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态；1开启；',
  `config` text COMMENT '插件配置',
  `hooks` varchar(255) DEFAULT NULL COMMENT '实现的钩子;以“，”分隔',
  `has_admin` tinyint(2) DEFAULT '0' COMMENT '插件是否有后台管理界面',
  `author` varchar(50) DEFAULT '' COMMENT '插件作者',
  `version` varchar(20) DEFAULT '' COMMENT '插件版本号',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `listorder` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of ys_plugins
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_posts`
-- ----------------------------
DROP TABLE IF EXISTS `ys_posts`;
CREATE TABLE `ys_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned DEFAULT '0' COMMENT '发表者id',
  `post_keywords` varchar(150) NOT NULL COMMENT 'seo keywords',
  `post_source` varchar(150) DEFAULT NULL COMMENT '转载文章的来源',
  `post_date` datetime DEFAULT '2000-01-01 00:00:00' COMMENT 'post发布日期',
  `post_content` longtext COMMENT 'post内容',
  `post_title` text COMMENT 'post标题',
  `post_excerpt` text COMMENT 'post摘要',
  `post_status` int(2) DEFAULT '1' COMMENT 'post状态，1已审核，0未审核,3删除',
  `comment_status` int(2) DEFAULT '1' COMMENT '评论状态，1允许，0不允许',
  `post_modified` datetime DEFAULT '2000-01-01 00:00:00' COMMENT 'post更新时间，可在前台修改，显示给用户',
  `post_content_filtered` longtext,
  `post_parent` bigint(20) unsigned DEFAULT '0' COMMENT 'post的父级post id,表示post层级关系',
  `post_type` int(2) DEFAULT '1' COMMENT 'post类型，1文章,2页面',
  `post_mime_type` varchar(100) DEFAULT '',
  `comment_count` bigint(20) DEFAULT '0',
  `smeta` text COMMENT 'post的扩展字段，保存相关扩展属性，如缩略图；格式为json',
  `post_hits` int(11) DEFAULT '0' COMMENT 'post点击数，查看数',
  `post_like` int(11) DEFAULT '0' COMMENT 'post赞数',
  `istop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶 1置顶； 0不置顶',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐 1推荐 0不推荐',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`id`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `post_date` (`post_date`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Portal文章表';

-- ----------------------------
-- Records of ys_posts
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_questionnaire`
-- ----------------------------
DROP TABLE IF EXISTS `ys_questionnaire`;
CREATE TABLE `ys_questionnaire` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `member_id` int(4) NOT NULL,
  `q1` tinyint(2) DEFAULT NULL,
  `q2` tinyint(2) DEFAULT NULL,
  `q3` tinyint(2) DEFAULT NULL,
  `q4` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_questionnaire
-- ----------------------------
INSERT INTO `ys_questionnaire` VALUES ('1', '0', null, null, null, null);
INSERT INTO `ys_questionnaire` VALUES ('2', '2', null, null, null, null);
INSERT INTO `ys_questionnaire` VALUES ('3', '3', '2', '1', '2', '3');
INSERT INTO `ys_questionnaire` VALUES ('4', '4', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('5', '6', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('6', '7', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('7', '8', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('8', '9', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('9', '10', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('10', '11', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('11', '12', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('12', '13', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('13', '14', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('14', '15', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('15', '16', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('16', '17', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('17', '18', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('18', '19', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('19', '20', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('20', '21', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('21', '22', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('22', '23', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('23', '24', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('24', '25', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('25', '26', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('26', '27', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('27', '28', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('28', '29', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('29', '30', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('30', '31', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('31', '32', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('32', '33', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('33', '34', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('34', '35', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('35', '36', '2', '1', '1', '3');
INSERT INTO `ys_questionnaire` VALUES ('36', '1', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('37', '2', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('38', '1', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('39', '2', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('40', '3', '1', '5', '2', '2');
INSERT INTO `ys_questionnaire` VALUES ('41', '4', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('42', '5', '3', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('43', '6', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('44', '7', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('45', '8', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('46', '9', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('47', '10', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('48', '11', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('49', '12', '2', '4', '2', '3');
INSERT INTO `ys_questionnaire` VALUES ('50', '13', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('51', '14', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('52', '15', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('53', '16', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('54', '17', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('55', '18', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('56', '19', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('57', '20', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('58', '21', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('59', '22', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('60', '23', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('61', '24', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('62', '25', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('63', '26', '1', '5', '1', '2');
INSERT INTO `ys_questionnaire` VALUES ('64', '27', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('65', '28', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('66', '29', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('67', '30', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('68', '31', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('69', '32', '5', '5', '2', '3');
INSERT INTO `ys_questionnaire` VALUES ('70', '33', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('71', '34', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('72', '35', '1', '5', '2', '1');
INSERT INTO `ys_questionnaire` VALUES ('73', '36', '1', '1', '1', '1');
INSERT INTO `ys_questionnaire` VALUES ('74', '37', '5', '5', '1', '3');

-- ----------------------------
-- Table structure for `ys_role`
-- ----------------------------
DROP TABLE IF EXISTS `ys_role`;
CREATE TABLE `ys_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of ys_role
-- ----------------------------
INSERT INTO `ys_role` VALUES ('1', '超级管理员', '0', '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0');
INSERT INTO `ys_role` VALUES ('2', '系统管理员', null, '1', '', '1498378303', '0', '0');

-- ----------------------------
-- Table structure for `ys_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `ys_role_user`;
CREATE TABLE `ys_role_user` (
  `role_id` int(11) unsigned DEFAULT '0' COMMENT '角色 id',
  `user_id` int(11) DEFAULT '0' COMMENT '用户id',
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Records of ys_role_user
-- ----------------------------
INSERT INTO `ys_role_user` VALUES ('2', '2');
INSERT INTO `ys_role_user` VALUES ('2', '3');

-- ----------------------------
-- Table structure for `ys_route`
-- ----------------------------
DROP TABLE IF EXISTS `ys_route`;
CREATE TABLE `ys_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `listorder` int(5) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='url路由表';

-- ----------------------------
-- Records of ys_route
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_slide`
-- ----------------------------
DROP TABLE IF EXISTS `ys_slide`;
CREATE TABLE `ys_slide` (
  `slide_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slide_cid` int(11) NOT NULL COMMENT '幻灯片分类 id',
  `slide_name` varchar(255) NOT NULL COMMENT '幻灯片名称',
  `slide_pic` varchar(255) DEFAULT NULL COMMENT '幻灯片图片',
  `slide_url` varchar(255) DEFAULT NULL COMMENT '幻灯片链接',
  `slide_des` varchar(255) DEFAULT NULL COMMENT '幻灯片描述',
  `slide_content` text COMMENT '幻灯片内容',
  `slide_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `listorder` int(10) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`slide_id`),
  KEY `slide_cid` (`slide_cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='幻灯片表';

-- ----------------------------
-- Records of ys_slide
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_slide_cat`
-- ----------------------------
DROP TABLE IF EXISTS `ys_slide_cat`;
CREATE TABLE `ys_slide_cat` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL COMMENT '幻灯片分类',
  `cat_idname` varchar(255) NOT NULL COMMENT '幻灯片分类标识',
  `cat_remark` text COMMENT '分类备注',
  `cat_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`cid`),
  KEY `cat_idname` (`cat_idname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='幻灯片分类表';

-- ----------------------------
-- Records of ys_slide_cat
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_take_meal_place`
-- ----------------------------
DROP TABLE IF EXISTS `ys_take_meal_place`;
CREATE TABLE `ys_take_meal_place` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `d_id` int(4) NOT NULL COMMENT '送餐地点id',
  `name` varchar(20) NOT NULL COMMENT '取餐点名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_take_meal_place
-- ----------------------------
INSERT INTO `ys_take_meal_place` VALUES ('1', '1', '东门取餐');
INSERT INTO `ys_take_meal_place` VALUES ('2', '1', '西门取餐');
INSERT INTO `ys_take_meal_place` VALUES ('3', '1', '男生宿舍口');
INSERT INTO `ys_take_meal_place` VALUES ('5', '2', '南门');
INSERT INTO `ys_take_meal_place` VALUES ('6', '2', '北门');
INSERT INTO `ys_take_meal_place` VALUES ('7', '2', '教学楼');
INSERT INTO `ys_take_meal_place` VALUES ('8', '3', '东门');
INSERT INTO `ys_take_meal_place` VALUES ('9', '3', '西门');
INSERT INTO `ys_take_meal_place` VALUES ('10', '1', '附属幼儿园');

-- ----------------------------
-- Table structure for `ys_term_relationships`
-- ----------------------------
DROP TABLE IF EXISTS `ys_term_relationships`;
CREATE TABLE `ys_term_relationships` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`tid`),
  KEY `term_taxonomy_id` (`term_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Portal 文章分类对应表';

-- ----------------------------
-- Records of ys_term_relationships
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_terms`
-- ----------------------------
DROP TABLE IF EXISTS `ys_terms`;
CREATE TABLE `ys_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `slug` varchar(200) DEFAULT '',
  `taxonomy` varchar(32) DEFAULT NULL COMMENT '分类类型',
  `description` longtext COMMENT '分类描述',
  `parent` bigint(20) unsigned DEFAULT '0' COMMENT '分类父id',
  `count` bigint(20) DEFAULT '0' COMMENT '分类文章数',
  `path` varchar(500) DEFAULT NULL COMMENT '分类层级关系路径',
  `seo_title` varchar(500) DEFAULT NULL,
  `seo_keywords` varchar(500) DEFAULT NULL,
  `seo_description` varchar(500) DEFAULT NULL,
  `list_tpl` varchar(50) DEFAULT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT NULL COMMENT '分类文章页模板',
  `listorder` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Portal 文章分类表';

-- ----------------------------
-- Records of ys_terms
-- ----------------------------
INSERT INTO `ys_terms` VALUES ('1', '列表演示', '', 'article', '', '0', '0', '0-1', '', '', '', 'list', 'article', '0', '1');
INSERT INTO `ys_terms` VALUES ('2', '瀑布流', '', 'article', '', '0', '0', '0-2', '', '', '', 'list_masonry', 'article', '0', '1');

-- ----------------------------
-- Table structure for `ys_user_favorites`
-- ----------------------------
DROP TABLE IF EXISTS `ys_user_favorites`;
CREATE TABLE `ys_user_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL COMMENT '用户 id',
  `title` varchar(255) DEFAULT NULL COMMENT '收藏内容的标题',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) DEFAULT NULL COMMENT '收藏内容的描述',
  `table` varchar(50) DEFAULT NULL COMMENT '收藏实体以前所在表，不带前缀',
  `object_id` int(11) DEFAULT NULL COMMENT '收藏内容原来的主键id',
  `createtime` int(11) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of ys_user_favorites
-- ----------------------------

-- ----------------------------
-- Table structure for `ys_users`
-- ----------------------------
DROP TABLE IF EXISTS `ys_users`;
CREATE TABLE `ys_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `user_nicename` varchar(50) NOT NULL DEFAULT '' COMMENT '用户美名',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网站',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像，相对于upload/avatar目录',
  `sex` smallint(1) DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date DEFAULT '2000-01-01' COMMENT '生日',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `last_login_ip` varchar(16) DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '最后登录时间',
  `create_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '注册时间',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `user_status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `user_type` smallint(1) DEFAULT '1' COMMENT '用户类型，1:admin ;2:会员',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '金币',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ys_users
-- ----------------------------
INSERT INTO `ys_users` VALUES ('1', 'admin', '###fce6f866db8198eabf1a9ac878e7c9a8', 'admin', 'aa@dd.com', '', null, '0', '2000-01-01', null, '171.221.137.9', '2017-08-13 15:43:39', '2017-06-25 02:40:11', '', '1', '0', '1', '0', '');
INSERT INTO `ys_users` VALUES ('2', 'test', '###8672413f2ac72ea28c5b2ad70d8f9b26', '', 'ddds@aa.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-06-27 23:39:35', '', '1', '0', '1', '0', '');
INSERT INTO `ys_users` VALUES ('3', 'wushuai', '###8672413f2ac72ea28c5b2ad70d8f9b26', '', 'dsd@dsad.com', '', null, '0', '2000-01-01', null, '223.87.199.102', '2017-08-13 14:40:05', '2017-07-31 14:18:14', '', '1', '0', '1', '0', '');

-- ----------------------------
-- Table structure for `ys_voucher`
-- ----------------------------
DROP TABLE IF EXISTS `ys_voucher`;
CREATE TABLE `ys_voucher` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `voucher_name` varchar(50) NOT NULL COMMENT '优惠券名称',
  `voucher_price` int(4) NOT NULL COMMENT '优惠券面值',
  `type` tinyint(4) NOT NULL COMMENT '优惠券类型，1.全场，2.指定商品',
  `bind_g_ids` varchar(100) DEFAULT NULL COMMENT '绑定的商品id,序列化格式',
  `start_time` int(11) NOT NULL COMMENT '有效期开始时间',
  `end_time` int(11) NOT NULL COMMENT '有效期结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_voucher
-- ----------------------------
INSERT INTO `ys_voucher` VALUES ('1', '测试全场优惠券1', '10', '1', null, '1500739200', '1509379200');
INSERT INTO `ys_voucher` VALUES ('2', '测试全场优惠券2', '10', '1', null, '1500739200', '1509379200');
INSERT INTO `ys_voucher` VALUES ('3', '测试指定商品优惠券1', '2', '2', 'a:2:{i:0;s:1:\"2\";i:1;s:1:\"1\";}', '1500739200', '1509379200');
INSERT INTO `ys_voucher` VALUES ('4', '测试全场优惠券2', '5', '2', 'a:3:{i:0;s:1:\"3\";i:1;s:1:\"2\";i:2;s:1:\"1\";}', '1500739200', '1509379200');
INSERT INTO `ys_voucher` VALUES ('5', '失效优惠券', '12', '1', null, '1501084800', '1501171200');
INSERT INTO `ys_voucher` VALUES ('6', '测试雅正1', '2', '1', null, '1501344000', '1501862400');
INSERT INTO `ys_voucher` VALUES ('7', '测试哦验证输入', '3', '2', 'a:4:{i:0;s:1:\"8\";i:1;s:1:\"7\";i:2;s:1:\"6\";i:3;s:1:\"5\";}', '1501430400', '1501862400');
INSERT INTO `ys_voucher` VALUES ('8', '刚刚好', '0', '2', 'a:1:{i:0;s:1:\"9\";}', '1501344000', '1501862400');
INSERT INTO `ys_voucher` VALUES ('9', '测试权限优惠券', '1', '1', null, '1501603200', '1501689600');

-- ----------------------------
-- Table structure for `ys_voucher_bind`
-- ----------------------------
DROP TABLE IF EXISTS `ys_voucher_bind`;
CREATE TABLE `ys_voucher_bind` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `v_id` int(4) NOT NULL COMMENT '优惠券id',
  `member_id` int(4) NOT NULL COMMENT '用户id',
  `voucher_name` varchar(50) NOT NULL COMMENT '优惠券名称',
  `voucher_price` int(4) NOT NULL COMMENT '优惠券面额',
  `type` tinyint(2) NOT NULL COMMENT '优惠券类型，1.全场，2.指定商品',
  `bind_g_ids` varchar(100) DEFAULT NULL COMMENT '绑定的商品id,序列化格式',
  `start_time` int(11) NOT NULL COMMENT '有效期开始时间',
  `end_time` int(11) NOT NULL COMMENT '有效期结束时间',
  `bind_time` int(11) NOT NULL COMMENT '绑定优惠券的时间',
  `state` tinyint(2) NOT NULL COMMENT '1.未使用，2.已使用，3.已过期',
  PRIMARY KEY (`id`),
  KEY `index_vid` (`v_id`),
  KEY `index_member` (`member_id`,`state`) USING BTREE,
  KEY `index_time` (`start_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ys_voucher_bind
-- ----------------------------
INSERT INTO `ys_voucher_bind` VALUES ('3', '1', '9', '测试全场优惠券1', '10', '1', null, '1500739200', '1509379200', '1501333219', '1');
INSERT INTO `ys_voucher_bind` VALUES ('4', '1', '10', '测试全场优惠券1', '10', '1', null, '1500739200', '1509379200', '1501333917', '1');
INSERT INTO `ys_voucher_bind` VALUES ('5', '3', '9', '测试指定商品优惠券1', '2', '2', 'a:2:{i:0;s:1:\"2\";i:1;s:1:\"1\";}', '1500739200', '1509379200', '1501337290', '3');
INSERT INTO `ys_voucher_bind` VALUES ('6', '5', '9', '失效优惠券', '12', '1', null, '1501084800', '1501171200', '1501337348', '2');
INSERT INTO `ys_voucher_bind` VALUES ('7', '6', '11', '测试雅正1', '2', '1', null, '1501344000', '1501862400', '1501395412', '1');
INSERT INTO `ys_voucher_bind` VALUES ('8', '7', '11', '测试哦验证输入', '3', '2', 'a:4:{i:0;s:1:\"8\";i:1;s:1:\"7\";i:2;s:1:\"6\";i:3;s:1:\"5\";}', '1501430400', '1501862400', '1501395649', '1');
INSERT INTO `ys_voucher_bind` VALUES ('9', '8', '11', '刚刚好', '0', '2', 'a:1:{i:0;s:1:\"9\";}', '1501344000', '1501862400', '1501396978', '1');
