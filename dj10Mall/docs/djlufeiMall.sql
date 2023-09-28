/*
 Navicat Premium Data Transfer

 Source Server         : locX
 Source Server Type    : MySQL
 Source Server Version : 50743 (5.7.43)
 Source Host           : localhost:3306
 Source Schema         : djlufeiMall

 Target Server Type    : MySQL
 Target Server Version : 50743 (5.7.43)
 File Encoding         : 65001

 Date: 28/09/2023 20:45:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for 01-课程分类表
-- ----------------------------
DROP TABLE IF EXISTS `01-课程分类表`;
CREATE TABLE `01-课程分类表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 01-课程分类表
-- ----------------------------
BEGIN;
INSERT INTO `01-课程分类表` (`id`, `title`) VALUES (1, 'java');
INSERT INTO `01-课程分类表` (`id`, `title`) VALUES (2, 'nodejs');
INSERT INTO `01-课程分类表` (`id`, `title`) VALUES (3, 'python');
COMMIT;

-- ----------------------------
-- Table structure for 02-课程表
-- ----------------------------
DROP TABLE IF EXISTS `02-课程表`;
CREATE TABLE `02-课程表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `course_img` varchar(100) NOT NULL,
  `course_type` smallint(6) NOT NULL,
  `brief` varchar(1024) NOT NULL,
  `level` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `pub_date` date DEFAULT NULL,
  `order` int(11) NOT NULL,
  `study_num` int(11) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `degree_course_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `02-课程表_degree_course_id_91770740_fk_05-学位课程表_id` (`degree_course_id`),
  KEY `02-课程表_category_id_b71442be_fk_01-课程分类表_id` (`category_id`),
  CONSTRAINT `02-课程表_category_id_b71442be_fk_01-课程分类表_id` FOREIGN KEY (`category_id`) REFERENCES `01-课程分类表` (`id`),
  CONSTRAINT `02-课程表_degree_course_id_91770740_fk_05-学位课程表_id` FOREIGN KEY (`degree_course_id`) REFERENCES `05-学位课程表` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 02-课程表
-- ----------------------------
BEGIN;
INSERT INTO `02-课程表` (`id`, `title`, `course_img`, `course_type`, `brief`, `level`, `status`, `pub_date`, `order`, `study_num`, `category_id`, `degree_course_id`) VALUES (1, '课程1', 'course/2023-09/截屏2023-09-28_下午2.13.18.png', 0, '阿达发生地方', 1, 0, '2023-09-20', 1, 11, 1, 1);
INSERT INTO `02-课程表` (`id`, `title`, `course_img`, `course_type`, `brief`, `level`, `status`, `pub_date`, `order`, `study_num`, `category_id`, `degree_course_id`) VALUES (2, '课程2', 'course/2023-09/截屏2023-09-28_下午2.13.18_Kr83wPm.png', 0, '去为个v请问二v', 1, 0, '2023-09-14', 3, 33, 1, 2);
COMMIT;

-- ----------------------------
-- Table structure for 03-课程详细表
-- ----------------------------
DROP TABLE IF EXISTS `03-课程详细表`;
CREATE TABLE `03-课程详细表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hours` int(11) NOT NULL,
  `course_slogan` varchar(125) DEFAULT NULL,
  `video_brief_link` varchar(255) DEFAULT NULL,
  `summary` longtext NOT NULL,
  `why_study` longtext NOT NULL,
  `what_to_study_brief` longtext NOT NULL,
  `career_improvement` longtext NOT NULL,
  `prerequisite` longtext NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`),
  CONSTRAINT `03-课程详细表_course_id_1691e0c0_fk_02-课程表_id` FOREIGN KEY (`course_id`) REFERENCES `02-课程表` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 03-课程详细表
-- ----------------------------
BEGIN;
INSERT INTO `03-课程详细表` (`id`, `hours`, `course_slogan`, `video_brief_link`, `summary`, `why_study`, `what_to_study_brief`, `career_improvement`, `prerequisite`, `course_id`) VALUES (1, 7, '问题那问题内容', '全网让半球无人帮你', '我认同你 任特别', '色而已个官方', '阿文v额', '阿文日特惠 本', '收如何到', 1);
INSERT INTO `03-课程详细表` (`id`, `hours`, `course_slogan`, `video_brief_link`, `summary`, `why_study`, `what_to_study_brief`, `career_improvement`, `prerequisite`, `course_id`) VALUES (2, 7, '阿尔诺额', '恩人', '7i6，', '他也没', '5突然那样', '闰土', '闰耳环土你', 2);
COMMIT;

-- ----------------------------
-- Table structure for 03-课程详细表_recommend_courses
-- ----------------------------
DROP TABLE IF EXISTS `03-课程详细表_recommend_courses`;
CREATE TABLE `03-课程详细表_recommend_courses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coursedetail_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `D03-课程详细表_recommend_cours_coursedetail_id_course_i_56552bb1_uni` (`coursedetail_id`,`course_id`),
  KEY `03-课程详细表_recommend_courses_course_id_447b501e_fk_02-课程表_id` (`course_id`),
  CONSTRAINT `03-课程详细表_recommend_courses_course_id_447b501e_fk_02-课程表_id` FOREIGN KEY (`course_id`) REFERENCES `02-课程表` (`id`),
  CONSTRAINT `D03-课程详细表_recommend_c_coursedetail_id_5dd13865_fk_03-课程详细表` FOREIGN KEY (`coursedetail_id`) REFERENCES `03-课程详细表` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 03-课程详细表_recommend_courses
-- ----------------------------
BEGIN;
INSERT INTO `03-课程详细表_recommend_courses` (`id`, `coursedetail_id`, `course_id`) VALUES (1, 1, 2);
INSERT INTO `03-课程详细表_recommend_courses` (`id`, `coursedetail_id`, `course_id`) VALUES (2, 2, 2);
COMMIT;

-- ----------------------------
-- Table structure for 03-课程详细表_teachers
-- ----------------------------
DROP TABLE IF EXISTS `03-课程详细表_teachers`;
CREATE TABLE `03-课程详细表_teachers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coursedetail_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `03-课程详细表_teachers_coursedetail_id_teacher_id_98eb5792_uniq` (`coursedetail_id`,`teacher_id`),
  KEY `03-课程详细表_teachers_teacher_id_c6ab45a4_fk_04-教师表_id` (`teacher_id`),
  CONSTRAINT `03-课程详细表_teachers_coursedetail_id_bebc8482_fk_03-课程详细表_id` FOREIGN KEY (`coursedetail_id`) REFERENCES `03-课程详细表` (`id`),
  CONSTRAINT `03-课程详细表_teachers_teacher_id_c6ab45a4_fk_04-教师表_id` FOREIGN KEY (`teacher_id`) REFERENCES `04-教师表` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 03-课程详细表_teachers
-- ----------------------------
BEGIN;
INSERT INTO `03-课程详细表_teachers` (`id`, `coursedetail_id`, `teacher_id`) VALUES (1, 1, 2);
COMMIT;

-- ----------------------------
-- Table structure for 04-教师表
-- ----------------------------
DROP TABLE IF EXISTS `04-教师表`;
CREATE TABLE `04-教师表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `brief` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 04-教师表
-- ----------------------------
BEGIN;
INSERT INTO `04-教师表` (`id`, `name`, `brief`) VALUES (1, 'tea1', 'sertern');
INSERT INTO `04-教师表` (`id`, `name`, `brief`) VALUES (2, 'tea2', 'qebrtqw3ern');
COMMIT;

-- ----------------------------
-- Table structure for 05-学位课程表
-- ----------------------------
DROP TABLE IF EXISTS `05-学位课程表`;
CREATE TABLE `05-学位课程表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 05-学位课程表
-- ----------------------------
BEGIN;
INSERT INTO `05-学位课程表` (`id`, `title`) VALUES (1, '学位1');
INSERT INTO `05-学位课程表` (`id`, `title`) VALUES (2, '学位2');
INSERT INTO `05-学位课程表` (`id`, `title`) VALUES (3, '学位3');
COMMIT;

-- ----------------------------
-- Table structure for 06-课程章节表
-- ----------------------------
DROP TABLE IF EXISTS `06-课程章节表`;
CREATE TABLE `06-课程章节表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `chapter` smallint(6) NOT NULL,
  `title` varchar(32) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `06-课程章节表_course_id_chapter_384a55b8_uniq` (`course_id`,`chapter`),
  CONSTRAINT `06-课程章节表_course_id_0967bc4a_fk_02-课程表_id` FOREIGN KEY (`course_id`) REFERENCES `02-课程表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 06-课程章节表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 07-课程课时表
-- ----------------------------
DROP TABLE IF EXISTS `07-课程课时表`;
CREATE TABLE `07-课程课时表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `section_order` smallint(6) NOT NULL,
  `free_trail` tinyint(1) NOT NULL,
  `section_type` smallint(6) NOT NULL,
  `section_link` varchar(255) DEFAULT NULL,
  `chapter_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `07-课程课时表_chapter_id_section_link_ff544e9c_uniq` (`chapter_id`,`section_link`),
  CONSTRAINT `07-课程课时表_chapter_id_109c9cb3_fk_06-课程章节表_id` FOREIGN KEY (`chapter_id`) REFERENCES `06-课程章节表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 07-课程课时表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 08-价格策略表
-- ----------------------------
DROP TABLE IF EXISTS `08-价格策略表`;
CREATE TABLE `08-价格策略表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `valid_period` smallint(6) NOT NULL,
  `price` double NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `08-价格策略表_content_type_id_object_id_valid_period_0fd5e336_uniq` (`content_type_id`,`object_id`,`valid_period`),
  CONSTRAINT `08-价格策略表_content_type_id_d039ceea_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 08-价格策略表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 09-常见问题表
-- ----------------------------
DROP TABLE IF EXISTS `09-常见问题表`;
CREATE TABLE `09-常见问题表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `09-常见问题表_content_type_id_object_id_question_3d1442af_uniq` (`content_type_id`,`object_id`,`question`),
  CONSTRAINT `09-常见问题表_content_type_id_0cbac417_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 09-常见问题表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 10-评价表
-- ----------------------------
DROP TABLE IF EXISTS `10-评价表`;
CREATE TABLE `10-评价表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned DEFAULT NULL,
  `content` longtext NOT NULL,
  `date` datetime(6) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `10-评价表_account_id_e7abf3de_fk_11-用户表_id` (`account_id`),
  KEY `10-评价表_content_type_id_3b05582f_fk_django_content_type_id` (`content_type_id`),
  CONSTRAINT `10-评价表_account_id_e7abf3de_fk_11-用户表_id` FOREIGN KEY (`account_id`) REFERENCES `11-用户表` (`id`),
  CONSTRAINT `10-评价表_content_type_id_3b05582f_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 10-评价表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 11-用户表
-- ----------------------------
DROP TABLE IF EXISTS `11-用户表`;
CREATE TABLE `11-用户表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `pwd` varchar(32) NOT NULL,
  `balance` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 11-用户表
-- ----------------------------
BEGIN;
INSERT INTO `11-用户表` (`id`, `username`, `pwd`, `balance`) VALUES (1, 'user1', 'user1', 10);
INSERT INTO `11-用户表` (`id`, `username`, `pwd`, `balance`) VALUES (2, 'user2', 'user2', 20);
COMMIT;

-- ----------------------------
-- Table structure for 12-课程大纲表
-- ----------------------------
DROP TABLE IF EXISTS `12-课程大纲表`;
CREATE TABLE `12-课程大纲表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `order` smallint(5) unsigned NOT NULL,
  `content` longtext NOT NULL,
  `course_detail_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `12-课程大纲表_course_detail_id_title_9abc6c64_uniq` (`course_detail_id`,`title`),
  CONSTRAINT `12-课程大纲表_course_detail_id_28f74a69_fk_03-课程详细表_id` FOREIGN KEY (`course_detail_id`) REFERENCES `03-课程详细表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 12-课程大纲表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 13. 优惠券生成规则记录
-- ----------------------------
DROP TABLE IF EXISTS `13. 优惠券生成规则记录`;
CREATE TABLE `13. 优惠券生成规则记录` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `brief` longtext,
  `coupon_type` smallint(6) NOT NULL,
  `money_equivalent_value` int(11) DEFAULT NULL,
  `off_percent` smallint(5) unsigned DEFAULT NULL,
  `minimum_consume` int(10) unsigned DEFAULT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `open_date` date NOT NULL,
  `close_date` date NOT NULL,
  `valid_begin_date` date DEFAULT NULL,
  `valid_end_date` date DEFAULT NULL,
  `coupon_valid_days` int(10) unsigned DEFAULT NULL,
  `date` datetime(6) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `13. 优惠券生成规则记录_content_type_id_8e18a379_fk_django_content_type_id` (`content_type_id`),
  CONSTRAINT `13. 优惠券生成规则记录_content_type_id_8e18a379_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 13. 优惠券生成规则记录
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 14. 用户优惠券领取使用记录表
-- ----------------------------
DROP TABLE IF EXISTS `14. 用户优惠券领取使用记录表`;
CREATE TABLE `14. 用户优惠券领取使用记录表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` varchar(64) NOT NULL,
  `status` smallint(6) NOT NULL,
  `get_time` datetime(6) NOT NULL,
  `used_time` datetime(6) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  `coupon_id` bigint(20) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `14. 用户优惠券领取使用记录表_account_id_0a75bf05_fk_11-用户表_id` (`account_id`),
  KEY `14. 用户优惠券领取使用记录表_coupon_id_fd3a911d_fk_13. 优惠券生成规则记录_id` (`coupon_id`),
  KEY `14. 用户优惠券领取使用记录表_order_id_35a3a333_fk_15. 订单表_id` (`order_id`),
  CONSTRAINT `14. 用户优惠券领取使用记录表_account_id_0a75bf05_fk_11-用户表_id` FOREIGN KEY (`account_id`) REFERENCES `11-用户表` (`id`),
  CONSTRAINT `14. 用户优惠券领取使用记录表_coupon_id_fd3a911d_fk_13. 优惠券生成规则记录_id` FOREIGN KEY (`coupon_id`) REFERENCES `13. 优惠券生成规则记录` (`id`),
  CONSTRAINT `14. 用户优惠券领取使用记录表_order_id_35a3a333_fk_15. 订单表_id` FOREIGN KEY (`order_id`) REFERENCES `15. 订单表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 14. 用户优惠券领取使用记录表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 15. 订单表
-- ----------------------------
DROP TABLE IF EXISTS `15. 订单表`;
CREATE TABLE `15. 订单表` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_type` smallint(6) NOT NULL,
  `payment_number` varchar(128) DEFAULT NULL,
  `order_number` varchar(128) NOT NULL,
  `actual_amount` double NOT NULL,
  `status` smallint(6) NOT NULL,
  `date` datetime(6) NOT NULL,
  `pay_time` datetime(6) DEFAULT NULL,
  `cancel_time` datetime(6) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `15. 订单表_account_id_4ce30dc3_fk_11-用户表_id` (`account_id`),
  CONSTRAINT `15. 订单表_account_id_4ce30dc3_fk_11-用户表_id` FOREIGN KEY (`account_id`) REFERENCES `11-用户表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 15. 订单表
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 16. 订单详细
-- ----------------------------
DROP TABLE IF EXISTS `16. 订单详细`;
CREATE TABLE `16. 订单详细` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `original_price` double NOT NULL,
  `price` double NOT NULL,
  `valid_period_display` varchar(32) NOT NULL,
  `valid_period` int(10) unsigned NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `content_type_id` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `16. 订单详细_content_type_id_9380cdeb_fk_django_content_type_id` (`content_type_id`),
  KEY `16. 订单详细_order_id_31a3c61f_fk_15. 订单表_id` (`order_id`),
  CONSTRAINT `16. 订单详细_content_type_id_9380cdeb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `16. 订单详细_order_id_31a3c61f_fk_15. 订单表_id` FOREIGN KEY (`order_id`) REFERENCES `15. 订单表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 16. 订单详细
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for 17. 贝里交易记录
-- ----------------------------
DROP TABLE IF EXISTS `17. 贝里交易记录`;
CREATE TABLE `17. 贝里交易记录` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` int(11) NOT NULL,
  `balance` int(11) NOT NULL,
  `transaction_type` smallint(6) NOT NULL,
  `transaction_number` varchar(128) NOT NULL,
  `date` datetime(6) NOT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_number` (`transaction_number`),
  KEY `17. 贝里交易记录_account_id_0daf432a_fk_11-用户表_id` (`account_id`),
  CONSTRAINT `17. 贝里交易记录_account_id_0daf432a_fk_11-用户表_id` FOREIGN KEY (`account_id`) REFERENCES `11-用户表` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of 17. 贝里交易记录
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for UserInfo_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `UserInfo_userinfo`;
CREATE TABLE `UserInfo_userinfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `role_type` smallint(6) NOT NULL,
  `stu_id` bigint(20) DEFAULT NULL,
  `tea_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `stu_id` (`stu_id`),
  UNIQUE KEY `tea_id` (`tea_id`),
  CONSTRAINT `UserInfo_userinfo_stu_id_3a26fdba_fk_db_student_id` FOREIGN KEY (`stu_id`) REFERENCES `db_student` (`id`),
  CONSTRAINT `UserInfo_userinfo_tea_id_4971d806_fk_db_teacher_id` FOREIGN KEY (`tea_id`) REFERENCES `db_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of UserInfo_userinfo
-- ----------------------------
BEGIN;
INSERT INTO `UserInfo_userinfo` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `avatar`, `role_type`, `stu_id`, `tea_id`) VALUES (1, 'pbkdf2_sha256$390000$G1r3SgaaXjQOkPngcYGXcI$jr0wpyO8SjJp/KAV1Td61nEcd1RIEIp5RbkacchKDiU=', '2023-09-27 08:08:48.850230', 1, 'zwl', '', '', 'zwl@qq.com', 1, 1, '2023-09-27 08:08:40.062021', '/avatar/default.png', 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for UserInfo_userinfo_groups
-- ----------------------------
DROP TABLE IF EXISTS `UserInfo_userinfo_groups`;
CREATE TABLE `UserInfo_userinfo_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserInfo_userinfo_groups_userinfo_id_group_id_466206fa_uniq` (`userinfo_id`,`group_id`),
  KEY `UserInfo_userinfo_groups_group_id_79527e6d_fk_auth_group_id` (`group_id`),
  CONSTRAINT `UserInfo_userinfo_gr_userinfo_id_d8e7b853_fk_UserInfo_` FOREIGN KEY (`userinfo_id`) REFERENCES `UserInfo_userinfo` (`id`),
  CONSTRAINT `UserInfo_userinfo_groups_group_id_79527e6d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of UserInfo_userinfo_groups
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for UserInfo_userinfo_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `UserInfo_userinfo_user_permissions`;
CREATE TABLE `UserInfo_userinfo_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserInfo_userinfo_user_p_userinfo_id_permission_i_9dc173c9_uniq` (`userinfo_id`,`permission_id`),
  KEY `UserInfo_userinfo_us_permission_id_12811abc_fk_auth_perm` (`permission_id`),
  CONSTRAINT `UserInfo_userinfo_us_permission_id_12811abc_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `UserInfo_userinfo_us_userinfo_id_6d86fd1e_fk_UserInfo_` FOREIGN KEY (`userinfo_id`) REFERENCES `UserInfo_userinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of UserInfo_userinfo_user_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (21, 'Can add coupon', 6, 'add_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (22, 'Can change coupon', 6, 'change_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (23, 'Can delete coupon', 6, 'delete_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (24, 'Can view coupon', 6, 'view_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (25, 'Can add food', 7, 'add_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (26, 'Can change food', 7, 'change_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (27, 'Can delete food', 7, 'delete_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (28, 'Can view food', 7, 'view_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (29, 'Can add fruit', 8, 'add_fruit');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (30, 'Can change fruit', 8, 'change_fruit');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (31, 'Can delete fruit', 8, 'delete_fruit');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (32, 'Can view fruit', 8, 'view_fruit');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (33, 'Can add 11-用户表', 9, 'add_account');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (34, 'Can change 11-用户表', 9, 'change_account');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (35, 'Can delete 11-用户表', 9, 'delete_account');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (36, 'Can view 11-用户表', 9, 'view_account');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (37, 'Can add 01-课程分类表', 10, 'add_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (38, 'Can change 01-课程分类表', 10, 'change_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (39, 'Can delete 01-课程分类表', 10, 'delete_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (40, 'Can view 01-课程分类表', 10, 'view_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (41, 'Can add 02-课程表', 11, 'add_course');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (42, 'Can change 02-课程表', 11, 'change_course');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (43, 'Can delete 02-课程表', 11, 'delete_course');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (44, 'Can view 02-课程表', 11, 'view_course');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (45, 'Can add 06-课程章节表', 12, 'add_coursechapter');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (46, 'Can change 06-课程章节表', 12, 'change_coursechapter');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (47, 'Can delete 06-课程章节表', 12, 'delete_coursechapter');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (48, 'Can view 06-课程章节表', 12, 'view_coursechapter');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (49, 'Can add 05-学位课程表', 13, 'add_degreecourse');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (50, 'Can change 05-学位课程表', 13, 'change_degreecourse');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (51, 'Can delete 05-学位课程表', 13, 'delete_degreecourse');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (52, 'Can view 05-学位课程表', 13, 'view_degreecourse');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (53, 'Can add 04-教师表', 14, 'add_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (54, 'Can change 04-教师表', 14, 'change_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (55, 'Can delete 04-教师表', 14, 'delete_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (56, 'Can view 04-教师表', 14, 'view_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (57, 'Can add 03-课程详细表', 15, 'add_coursedetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (58, 'Can change 03-课程详细表', 15, 'change_coursedetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (59, 'Can delete 03-课程详细表', 15, 'delete_coursedetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (60, 'Can view 03-课程详细表', 15, 'view_coursedetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (61, 'Can add 10-评价表', 16, 'add_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (62, 'Can change 10-评价表', 16, 'change_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (63, 'Can delete 10-评价表', 16, 'delete_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (64, 'Can view 10-评价表', 16, 'view_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (65, 'Can add 08-价格策略表', 17, 'add_pricepolicy');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (66, 'Can change 08-价格策略表', 17, 'change_pricepolicy');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (67, 'Can delete 08-价格策略表', 17, 'delete_pricepolicy');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (68, 'Can view 08-价格策略表', 17, 'view_pricepolicy');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (69, 'Can add 09-常见问题表', 18, 'add_oftenaskedquestion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (70, 'Can change 09-常见问题表', 18, 'change_oftenaskedquestion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (71, 'Can delete 09-常见问题表', 18, 'delete_oftenaskedquestion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (72, 'Can view 09-常见问题表', 18, 'view_oftenaskedquestion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (73, 'Can add 07-课程课时表', 19, 'add_coursesection');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (74, 'Can change 07-课程课时表', 19, 'change_coursesection');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (75, 'Can delete 07-课程课时表', 19, 'delete_coursesection');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (76, 'Can view 07-课程课时表', 19, 'view_coursesection');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (77, 'Can add 12-课程大纲表', 20, 'add_courseoutline');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (78, 'Can change 12-课程大纲表', 20, 'change_courseoutline');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (79, 'Can delete 12-课程大纲表', 20, 'delete_courseoutline');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (80, 'Can view 12-课程大纲表', 20, 'view_courseoutline');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (81, 'Can add 13. 优惠券生成规则记录', 21, 'add_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (82, 'Can change 13. 优惠券生成规则记录', 21, 'change_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (83, 'Can delete 13. 优惠券生成规则记录', 21, 'delete_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (84, 'Can view 13. 优惠券生成规则记录', 21, 'view_coupon');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (85, 'Can add 15. 订单表', 22, 'add_order');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (86, 'Can change 15. 订单表', 22, 'change_order');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (87, 'Can delete 15. 订单表', 22, 'delete_order');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (88, 'Can view 15. 订单表', 22, 'view_order');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (89, 'Can add 17. 贝里交易记录', 23, 'add_transactionrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (90, 'Can change 17. 贝里交易记录', 23, 'change_transactionrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (91, 'Can delete 17. 贝里交易记录', 23, 'delete_transactionrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (92, 'Can view 17. 贝里交易记录', 23, 'view_transactionrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (93, 'Can add 16. 订单详细', 24, 'add_orderdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (94, 'Can change 16. 订单详细', 24, 'change_orderdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (95, 'Can delete 16. 订单详细', 24, 'delete_orderdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (96, 'Can view 16. 订单详细', 24, 'view_orderdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (97, 'Can add 14. 用户优惠券领取使用记录表', 25, 'add_couponrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (98, 'Can change 14. 用户优惠券领取使用记录表', 25, 'change_couponrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (99, 'Can delete 14. 用户优惠券领取使用记录表', 25, 'delete_couponrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (100, 'Can view 14. 用户优惠券领取使用记录表', 25, 'view_couponrecord');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (101, 'Can add 教室表', 26, 'add_classroom');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (102, 'Can change 教室表', 26, 'change_classroom');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (103, 'Can delete 教室表', 26, 'delete_classroom');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (104, 'Can view 教室表', 26, 'view_classroom');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (105, 'Can add 课程', 27, 'add_courseschool');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (106, 'Can change 课程', 27, 'change_courseschool');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (107, 'Can delete 课程', 27, 'delete_courseschool');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (108, 'Can view 课程', 27, 'view_courseschool');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (109, 'Can add 院系表', 28, 'add_schoolcategory');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (110, 'Can change 院系表', 28, 'change_schoolcategory');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (111, 'Can delete 院系表', 28, 'delete_schoolcategory');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (112, 'Can view 院系表', 28, 'view_schoolcategory');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (113, 'Can add 学生详情表', 29, 'add_studentdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (114, 'Can change 学生详情表', 29, 'change_studentdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (115, 'Can delete 学生详情表', 29, 'delete_studentdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (116, 'Can view 学生详情表', 29, 'view_studentdetail');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (117, 'Can add 教师表', 30, 'add_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (118, 'Can change 教师表', 30, 'change_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (119, 'Can delete 教师表', 30, 'delete_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (120, 'Can view 教师表', 30, 'view_teacher');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (121, 'Can add 学生表', 31, 'add_student');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (122, 'Can change 学生表', 31, 'change_student');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (123, 'Can delete 学生表', 31, 'delete_student');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (124, 'Can view 学生表', 31, 'view_student');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (125, 'Can add 班级表', 32, 'add_clas');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (126, 'Can change 班级表', 32, 'change_clas');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (127, 'Can delete 班级表', 32, 'delete_clas');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (128, 'Can view 班级表', 32, 'view_clas');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (129, 'Can add user', 33, 'add_userinfo');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (130, 'Can change user', 33, 'change_userinfo');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (131, 'Can delete user', 33, 'delete_userinfo');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (132, 'Can view user', 33, 'view_userinfo');
COMMIT;

-- ----------------------------
-- Table structure for crud_coupon
-- ----------------------------
DROP TABLE IF EXISTS `crud_coupon`;
CREATE TABLE `crud_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `object_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of crud_coupon
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for crud_food
-- ----------------------------
DROP TABLE IF EXISTS `crud_food`;
CREATE TABLE `crud_food` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of crud_food
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for crud_fruit
-- ----------------------------
DROP TABLE IF EXISTS `crud_fruit`;
CREATE TABLE `crud_fruit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of crud_fruit
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for db_class
-- ----------------------------
DROP TABLE IF EXISTS `db_class`;
CREATE TABLE `db_class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `honor_title` varchar(32) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `clas_course_id` bigint(20) NOT NULL,
  `class_room_id` bigint(20) NOT NULL,
  `class_teacher_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clas_course_id` (`clas_course_id`),
  UNIQUE KEY `class_room_id` (`class_room_id`),
  UNIQUE KEY `class_teacher_id` (`class_teacher_id`),
  KEY `db_class_category_id_eedf841b_fk_db_school_category_id` (`category_id`),
  CONSTRAINT `db_class_category_id_eedf841b_fk_db_school_category_id` FOREIGN KEY (`category_id`) REFERENCES `db_school_category` (`id`),
  CONSTRAINT `db_class_clas_course_id_9c8eea79_fk_db_course_school_id` FOREIGN KEY (`clas_course_id`) REFERENCES `db_course_school` (`id`),
  CONSTRAINT `db_class_class_room_id_8e2e1c46_fk_db_class_room_id` FOREIGN KEY (`class_room_id`) REFERENCES `db_class_room` (`id`),
  CONSTRAINT `db_class_class_teacher_id_c5f0641e_fk_db_teacher_id` FOREIGN KEY (`class_teacher_id`) REFERENCES `db_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_class
-- ----------------------------
BEGIN;
INSERT INTO `db_class` (`id`, `name`, `honor_title`, `category_id`, `clas_course_id`, `class_room_id`, `class_teacher_id`) VALUES (1, '班级11111', '娃儿不能为童年6金泰你', 1, 1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for db_class_room
-- ----------------------------
DROP TABLE IF EXISTS `db_class_room`;
CREATE TABLE `db_class_room` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `room_addr` varchar(32) NOT NULL,
  `capacity_num` int(11) NOT NULL,
  `isMedia_room` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_class_room
-- ----------------------------
BEGIN;
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (1, '教室111111', '企鹅温柔并且温饿去玩儿柔吧', 11, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (2, '百味堂', '天阙阁，一栋，五层', 20, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (3, '苹果堂', '天阙阁，一栋，一层', 21, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (4, '香蕉堂', '天阙阁，一栋，四层', 22, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (5, '手机堂', '天阙阁，一栋，三层', 23, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (6, '机关堂', '天阙阁，一栋，二层', 21, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (7, '沙河堂', '天阙阁，二栋，五层', 22, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (8, '兵甲堂', '天阙阁，二栋，四层', 23, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (9, '猛虎堂', '天阙阁，二栋，三层', 24, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (10, '平板堂', '天阙阁，二栋，二层', 25, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (11, '鞋子堂', '天阙阁，二栋，一层', 26, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (12, '裤子堂', '天阙阁，三栋，五层', 27, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (13, '衣服堂', '天阙阁，三栋，四层', 28, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (14, '眼镜堂', '天阙阁，三栋，三层', 29, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (15, '书包堂', '天阙阁，三栋，二层', 10, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (16, '椅子堂', '天阙阁，三栋，一层', 11, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (17, '桌子堂', '天阙阁，四栋，五层', 12, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (18, '月饼堂', '天阙阁，四栋，四层', 13, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (19, '线条堂', '天阙阁，四栋，三层', 14, 0);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (20, '显示器堂', '天阙阁，四栋，二层', 15, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (21, '转接头堂', '天阙阁，四栋，一层', 16, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (22, '水杯堂', '天阙阁，五栋，五层', 17, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (23, '纸巾堂', '天阙阁，五栋，四层', 18, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (24, '游戏堂', '天阙阁，五栋，三层', 19, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (25, '地铁堂', '天阙阁，五栋，二层', 20, 1);
INSERT INTO `db_class_room` (`id`, `name`, `room_addr`, `capacity_num`, `isMedia_room`) VALUES (26, '马路堂', '天阙阁，五栋，一层', 10, 1);
COMMIT;

-- ----------------------------
-- Table structure for db_course2room
-- ----------------------------
DROP TABLE IF EXISTS `db_course2room`;
CREATE TABLE `db_course2room` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `courseschool_id` bigint(20) NOT NULL,
  `classroom_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `db_course2room_courseschool_id_classroom_id_e0380df3_uniq` (`courseschool_id`,`classroom_id`),
  KEY `db_course2room_classroom_id_9c437186_fk_db_class_room_id` (`classroom_id`),
  CONSTRAINT `db_course2room_classroom_id_9c437186_fk_db_class_room_id` FOREIGN KEY (`classroom_id`) REFERENCES `db_class_room` (`id`),
  CONSTRAINT `db_course2room_courseschool_id_b38d84f4_fk_db_course_school_id` FOREIGN KEY (`courseschool_id`) REFERENCES `db_course_school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_course2room
-- ----------------------------
BEGIN;
INSERT INTO `db_course2room` (`id`, `courseschool_id`, `classroom_id`) VALUES (1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for db_course_school
-- ----------------------------
DROP TABLE IF EXISTS `db_course_school`;
CREATE TABLE `db_course_school` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `credit` int(11) NOT NULL,
  `course_week` varchar(32) NOT NULL,
  `course_start_time` time(6) NOT NULL,
  `course_stay_time` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_course_school
-- ----------------------------
BEGIN;
INSERT INTO `db_course_school` (`id`, `title`, `credit`, `course_week`, `course_start_time`, `course_stay_time`) VALUES (1, '课程111', 3, '1', '08:11:45.566994', 40);
COMMIT;

-- ----------------------------
-- Table structure for db_electives2clas
-- ----------------------------
DROP TABLE IF EXISTS `db_electives2clas`;
CREATE TABLE `db_electives2clas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) NOT NULL,
  `courseschool_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `db_electives2clas_student_id_courseschool_id_e1165909_uniq` (`student_id`,`courseschool_id`),
  KEY `db_electives2clas_courseschool_id_a0bf28e2_fk_db_course` (`courseschool_id`),
  CONSTRAINT `db_electives2clas_courseschool_id_a0bf28e2_fk_db_course` FOREIGN KEY (`courseschool_id`) REFERENCES `db_course_school` (`id`),
  CONSTRAINT `db_electives2clas_student_id_d828a110_fk_db_student_id` FOREIGN KEY (`student_id`) REFERENCES `db_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_electives2clas
-- ----------------------------
BEGIN;
INSERT INTO `db_electives2clas` (`id`, `student_id`, `courseschool_id`) VALUES (1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for db_school_category
-- ----------------------------
DROP TABLE IF EXISTS `db_school_category`;
CREATE TABLE `db_school_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_school_category
-- ----------------------------
BEGIN;
INSERT INTO `db_school_category` (`id`, `title`) VALUES (1, '经管学院');
COMMIT;

-- ----------------------------
-- Table structure for db_stu_detail
-- ----------------------------
DROP TABLE IF EXISTS `db_stu_detail`;
CREATE TABLE `db_stu_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(32) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `family_addr` varchar(32) NOT NULL,
  `birthday` datetime(6) NOT NULL,
  `father_name` varchar(32) NOT NULL,
  `mother_name` varchar(32) NOT NULL,
  `sex` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_stu_detail
-- ----------------------------
BEGIN;
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (1, '昵称987', '/avatar/default.png', '啊啊我说的v为', '2023-09-27 08:06:53.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (2, '昵称888', '/avatar/default.png', '阿尔滨个圈外人吧', '2023-09-22 19:59:28.000000', '华天', '就地', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (3, '昵称66', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼114号', '2002-09-12 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (4, '昵称67', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼115号', '2002-09-13 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (5, '昵称68', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼116号', '2002-09-14 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (6, '昵称69', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼117号', '2002-09-15 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (7, '昵称70', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼118号', '2002-09-16 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (8, '昵称71', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼119号', '2002-09-17 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (9, '昵称72', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼120号', '2002-09-18 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (10, '昵称11', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼121号', '2002-09-19 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (11, '昵称12', '/avatar/default.png', '北京市，海淀区，新中关村，中国电子大厦 1楼122号', '2002-09-20 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (12, '昵称13', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼321号', '2001-08-11 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (13, '昵称14', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼322号', '2001-08-12 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (14, '昵称15', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼323号', '2001-08-13 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (15, '昵称16', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼324号', '2001-08-14 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (16, '昵称17', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼325号', '2001-08-15 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (17, '昵称18', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼326号', '2001-08-16 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (18, '昵称19', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼327号', '2001-08-17 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (19, '昵称20', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼328号', '2001-08-18 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (20, '昵称88', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼329号', '2001-08-19 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (21, '昵称89', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼330号', '1999-12-30 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (22, '昵称90', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼331号', '1999-12-31 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (23, '昵称91', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼332号', '2000-01-01 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (24, '昵称92', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼333号', '2000-01-02 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (25, '昵称93', '/avatar/default.png', '北京市，朝阳区，红军营路，舞美大厦5楼334号', '2000-01-03 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (26, '昵称94', '/avatar/default.png', '北京市，唱片区，云霞路，创业大厦8楼666号', '2000-01-04 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (27, '昵称95', '/avatar/default.png', '北京市，唱片区，云霞路，创业大厦8楼667号', '2000-01-05 12:23:00.000000', '保密', '保密', 2);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (28, '昵称96', '/avatar/default.png', '北京市，唱片区，云霞路，创业大厦8楼668号', '2000-01-06 12:23:00.000000', '保密', '保密', 0);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (29, '昵称97', '/avatar/default.png', '北京市，唱片区，云霞路，创业大厦8楼669号', '2000-01-07 12:23:00.000000', '保密', '保密', 1);
INSERT INTO `db_stu_detail` (`id`, `nickname`, `avatar`, `family_addr`, `birthday`, `father_name`, `mother_name`, `sex`) VALUES (30, '昵称98', '/avatar/default.png', '北京市，唱片区，云霞路，创业大厦8楼670号', '2000-01-08 12:23:00.000000', '保密', '保密', 2);
COMMIT;

-- ----------------------------
-- Table structure for db_student
-- ----------------------------
DROP TABLE IF EXISTS `db_student`;
CREATE TABLE `db_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `mobile` varchar(12) NOT NULL,
  `stu_detail_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `stu_detail_id` (`stu_detail_id`),
  CONSTRAINT `db_student_stu_detail_id_e1609acd_fk_db_stu_detail_id` FOREIGN KEY (`stu_detail_id`) REFERENCES `db_stu_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_student
-- ----------------------------
BEGIN;
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (1, '学生987', '18479783236', 1);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (2, '学生888', '15123459876', 2);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (3, '学生姓名3', '18167894321', 3);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (4, '学生姓名4', '18167894322', 4);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (5, '学生姓名5', '18167894323', 5);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (6, '学生姓名6', '18167894324', 6);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (7, '学生姓名7', '18167894325', 7);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (8, '学生姓名8', '18167894326', 8);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (9, '学生姓名9', '18167894327', 9);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (10, '学生姓名10', '18167894328', 10);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (11, '学生姓名11', '18167894329', 11);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (12, '学生姓名12', '18167894330', 12);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (13, '学生姓名13', '18167894331', 13);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (14, '学生姓名14', '18167894332', 14);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (15, '学生姓名15', '18167894333', 15);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (16, '学生姓名16', '18167894334', 16);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (17, '学生姓名17', '18167894335', 17);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (18, '学生姓名18', '18167894336', 18);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (19, '学生姓名19', '18167894337', 19);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (20, '学生姓名20', '18167894338', 20);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (21, '学生姓名21', '18167894339', 21);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (22, '学生姓名22', '18167894340', 22);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (23, '学生姓名23', '18167894341', 23);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (24, '学生姓名24', '18167894342', 24);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (25, '学生姓名25', '18167894343', 25);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (26, '学生姓名26', '18167894344', 26);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (27, '学生姓名27', '18167894345', 27);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (28, '学生姓名28', '18167894346', 28);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (29, '学生姓名29', '18167894347', 29);
INSERT INTO `db_student` (`id`, `name`, `mobile`, `stu_detail_id`) VALUES (30, '学生姓名30', '18167894348', 30);
COMMIT;

-- ----------------------------
-- Table structure for db_teacher
-- ----------------------------
DROP TABLE IF EXISTS `db_teacher`;
CREATE TABLE `db_teacher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `sex` smallint(6) NOT NULL,
  `mobile` varchar(12) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `brief` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of db_teacher
-- ----------------------------
BEGIN;
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (1, '教师11', 2, '18479783236', '/avatar/default.png', '我认不清温柔把4曲棍球二哈5名6没有5年');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (2, '暮云', 1, '13512348766', '/avatar/default.png', '诸天神将，为我独尊');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (3, '小万', 2, '13512348767', '/avatar/default.png', '万年老鬼再次');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (4, '小枭', 1, '13512348768', '/avatar/default.png', '云走血雅间');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (5, '林风', 2, '13512348769', '/avatar/default.png', '一室独尊动漫小说任你看00');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (6, '秦晨', 1, '13512348770', '/avatar/default.png', '一室独尊动漫小说任你看11');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (7, '林浩', 2, '13512348771', '/avatar/default.png', '一室独尊动漫小说任你看22');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (8, '镊子云', 1, '13512348772', '/avatar/default.png', '一室独尊动漫小说任你看33');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (9, '飘雪', 2, '13512348773', '/avatar/default.png', '一室独尊动漫小说任你看44');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (10, '罗雅文', 1, '13512348774', '/avatar/default.png', '一室独尊动漫小说任你看55');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (11, '罗贯中', 2, '13512348775', '/avatar/default.png', '一室独尊动漫小说任你看66');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (12, '谢敏', 1, '13512348776', '/avatar/default.png', '一室独尊动漫小说任你看77');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (13, '妖神', 2, '13512348777', '/avatar/default.png', '一室独尊动漫小说任你看88');
INSERT INTO `db_teacher` (`id`, `name`, `sex`, `mobile`, `avatar`, `brief`) VALUES (14, '磨云腾', 0, '13512348778', '/avatar/default.png', '一室独尊动漫小说任你看99');
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_UserInfo_userinfo_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_UserInfo_userinfo_id` FOREIGN KEY (`user_id`) REFERENCES `UserInfo_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (1, '2023-09-27 08:10:16.550019', '1', '经管学院', 1, '[{\"added\": {}}]', 28, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (2, '2023-09-27 08:10:46.568898', '1', '昵称987', 1, '[{\"added\": {}}]', 29, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (3, '2023-09-27 08:11:42.301478', '1', '教室111111', 1, '[{\"added\": {}}]', 26, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (4, '2023-09-27 08:11:45.571707', '1', '课程111', 1, '[{\"added\": {}}]', 27, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (5, '2023-09-27 08:11:49.788804', '1', '学生987', 1, '[{\"added\": {}}]', 31, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (6, '2023-09-27 08:12:13.996036', '1', '教师11', 1, '[{\"added\": {}}]', 30, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (7, '2023-09-27 08:12:49.041396', '1', '班级11111', 1, '[{\"added\": {}}]', 32, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (8, '2023-09-28 06:00:35.265080', '1', 'user1', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (9, '2023-09-28 06:00:50.620110', '2', 'user2', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (10, '2023-09-28 06:01:18.678096', '1', 'java', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (11, '2023-09-28 06:01:24.306437', '2', 'nodejs', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (12, '2023-09-28 06:01:30.868194', '3', 'python', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (13, '2023-09-28 06:01:50.848020', '1', 'tea1', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (14, '2023-09-28 06:02:01.118849', '2', 'tea2', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (15, '2023-09-28 06:02:09.696628', '3', 'tea3', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (16, '2023-09-28 06:02:31.256114', '1', '学位1', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (17, '2023-09-28 06:02:38.787970', '2', '学位2', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (18, '2023-09-28 06:02:47.115121', '3', '学位3', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (19, '2023-09-28 06:15:26.372014', '1', '课程1', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (20, '2023-09-28 06:16:01.292587', '2', '课程2', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (21, '2023-09-28 06:17:06.173998', '1', '课程1', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (22, '2023-09-28 06:29:42.865727', '2', '课程2', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (23, '2023-09-28 06:30:44.564214', '3', 'tea3', 3, '', 14, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (10, 'Course', 'category');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (16, 'Course', 'comment');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (11, 'Course', 'course');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (12, 'Course', 'coursechapter');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (15, 'Course', 'coursedetail');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (20, 'Course', 'courseoutline');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (19, 'Course', 'coursesection');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (13, 'Course', 'degreecourse');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (18, 'Course', 'oftenaskedquestion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (17, 'Course', 'pricepolicy');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (14, 'Course', 'teacher');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (6, 'crud', 'coupon');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (7, 'crud', 'food');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (8, 'crud', 'fruit');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (9, 'Login', 'account');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (21, 'Shopping', 'coupon');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (25, 'Shopping', 'couponrecord');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (22, 'Shopping', 'order');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (24, 'Shopping', 'orderdetail');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (23, 'Shopping', 'transactionrecord');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (32, 'Student', 'clas');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (26, 'Student', 'classroom');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (27, 'Student', 'courseschool');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (28, 'Student', 'schoolcategory');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (31, 'Student', 'student');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (29, 'Student', 'studentdetail');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (30, 'Student', 'teacher');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (33, 'UserInfo', 'userinfo');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1, 'contenttypes', '0001_initial', '2023-09-27 08:06:59.203991');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2023-09-27 08:06:59.266445');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (3, 'Login', '0001_initial', '2023-09-27 08:06:59.292250');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (4, 'Course', '0001_initial', '2023-09-27 08:07:00.420089');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (5, 'Shopping', '0001_initial', '2023-09-27 08:07:00.945641');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (6, 'Student', '0001_initial', '2023-09-27 08:07:01.615987');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (7, 'auth', '0001_initial', '2023-09-27 08:07:01.931471');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (8, 'auth', '0002_alter_permission_name_max_length', '2023-09-27 08:07:01.989040');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (9, 'auth', '0003_alter_user_email_max_length', '2023-09-27 08:07:02.000663');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (10, 'auth', '0004_alter_user_username_opts', '2023-09-27 08:07:02.009812');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (11, 'auth', '0005_alter_user_last_login_null', '2023-09-27 08:07:02.017990');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (12, 'auth', '0006_require_contenttypes_0002', '2023-09-27 08:07:02.021924');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (13, 'auth', '0007_alter_validators_add_error_messages', '2023-09-27 08:07:02.030199');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (14, 'auth', '0008_alter_user_username_max_length', '2023-09-27 08:07:02.037597');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (15, 'auth', '0009_alter_user_last_name_max_length', '2023-09-27 08:07:02.045001');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (16, 'auth', '0010_alter_group_name_max_length', '2023-09-27 08:07:02.076468');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (17, 'auth', '0011_update_proxy_permissions', '2023-09-27 08:07:02.095744');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (18, 'auth', '0012_alter_user_first_name_max_length', '2023-09-27 08:07:02.102027');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (19, 'UserInfo', '0001_initial', '2023-09-27 08:07:02.474541');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (20, 'admin', '0001_initial', '2023-09-27 08:07:02.610507');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (21, 'admin', '0002_logentry_remove_auto_add', '2023-09-27 08:07:02.629101');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (22, 'admin', '0003_logentry_add_action_flag_choices', '2023-09-27 08:07:02.647803');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (23, 'crud', '0001_initial', '2023-09-27 08:07:02.756361');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (24, 'sessions', '0001_initial', '2023-09-27 08:07:02.834202');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (25, 'Student', '0002_alter_classroom_capacity_num_and_more', '2023-09-28 02:39:28.900172');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('ind8w75qjgzivczzw3ug068m6akwtkqu', '.eJxVjEEOwiAQRe_C2hAoOIhL9z0DGWZAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hYnEVWpx-t4j0THUH_MB6b5JaXeYpyl2RB-1ybJxet8P9OyjYy1aDjuTQsnImW7A6k81GObA-ajUwG800gDOKfIIze6INUsKLcj4rAPH5AtQON3E:1qlPbE:-c43DyJmBvNvRWMYuh-0TVSeztheE-5VDZUKYtATlVc', '2023-10-11 08:08:48.851190');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
