/*
Navicat MySQL Data Transfer

Source Server         : sa
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : ceptp

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-01-20 15:03:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ceptp_accessory
-- ----------------------------
DROP TABLE IF EXISTS `ceptp_accessory`;
CREATE TABLE `ceptp_accessory` (
  `accessory_name` varchar(20) NOT NULL,
  `task_id` varchar(20) NOT NULL,
  `accessory_path` varchar(255) NOT NULL,
  `accessory_kind` int(4) NOT NULL,
  `delete_flg` bit(1) NOT NULL,
  `creater` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `updater` varchar(20) NOT NULL,
  `update_time` datetime NOT NULL,
  KEY `courseId` (`accessory_path`),
  KEY `taskid` (`task_id`),
  CONSTRAINT `taskid` FOREIGN KEY (`task_id`) REFERENCES `ceptp_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceptp_accessory
-- ----------------------------

-- ----------------------------
-- Table structure for ceptp_course
-- ----------------------------
DROP TABLE IF EXISTS `ceptp_course`;
CREATE TABLE `ceptp_course` (
  `invitation_code` varchar(100) NOT NULL,
  `course_id` varchar(20) NOT NULL,
  `course_name` varchar(20) NOT NULL,
  `publisher_id` varchar(20) NOT NULL,
  `course_lable` varchar(50) NOT NULL,
  `course_img` longblob NOT NULL,
  `course_notes` text,
  `application_pro` varchar(20) DEFAULT NULL,
  `delete_flg` bit(1) NOT NULL,
  `creater` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `updater` varchar(20) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceptp_course
-- ----------------------------

-- ----------------------------
-- Table structure for ceptp_cv
-- ----------------------------
DROP TABLE IF EXISTS `ceptp_cv`;
CREATE TABLE `ceptp_cv` (
  `course_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `delete_flg` bit(1) NOT NULL,
  `create_user` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_user` varchar(20) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`course_id`,`user_id`),
  KEY `role_id` (`course_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `ceptp_user` (`user_id`),
  CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `ceptp_course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceptp_cv
-- ----------------------------

-- ----------------------------
-- Table structure for ceptp_task
-- ----------------------------
DROP TABLE IF EXISTS `ceptp_task`;
CREATE TABLE `ceptp_task` (
  `task_id` varchar(20) NOT NULL,
  `task_name` varchar(20) NOT NULL,
  `course_id` varchar(20) NOT NULL,
  `task_details` text NOT NULL,
  `evaluate_id` varchar(20) NOT NULL,
  `evaluate_kind` varchar(30) NOT NULL,
  `delete_flg` bit(1) NOT NULL,
  `creater` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `updater` varchar(20) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`task_id`),
  KEY `courseId` (`course_id`),
  CONSTRAINT `courseId` FOREIGN KEY (`course_id`) REFERENCES `ceptp_course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceptp_task
-- ----------------------------

-- ----------------------------
-- Table structure for ceptp_upload_task
-- ----------------------------
DROP TABLE IF EXISTS `ceptp_upload_task`;
CREATE TABLE `ceptp_upload_task` (
  `task_id` varchar(20) NOT NULL,
  `uploader` varchar(20) NOT NULL,
  `uploadTask_details` text NOT NULL,
  `grade` int(4) NOT NULL,
  `delete_flg` bit(1) NOT NULL,
  `creater` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `updater` varchar(20) NOT NULL,
  `update_time` datetime NOT NULL,
  KEY `task_id` (`task_id`),
  KEY `uploader_id` (`uploader`),
  CONSTRAINT `task_id` FOREIGN KEY (`task_id`) REFERENCES `ceptp_task` (`task_id`),
  CONSTRAINT `uploader_id` FOREIGN KEY (`uploader`) REFERENCES `ceptp_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceptp_upload_task
-- ----------------------------

-- ----------------------------
-- Table structure for ceptp_user
-- ----------------------------
DROP TABLE IF EXISTS `ceptp_user`;
CREATE TABLE `ceptp_user` (
  `user_id` varchar(20) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `sex` bit(1) NOT NULL,
  `password` varchar(50) NOT NULL,
  `class_name` varchar(9) DEFAULT NULL,
  `professional_title` varchar(20) DEFAULT NULL,
  `degree` varchar(20) DEFAULT NULL,
  `detail` text,
  `face` longblob NOT NULL,
  `pro` varchar(9) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `mobile` varchar(50) NOT NULL,
  `college` varchar(20) NOT NULL DEFAULT '',
  `sec_college` varchar(20) DEFAULT NULL,
  `delete_flg` bit(1) NOT NULL,
  `create_user` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_user` varchar(20) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`college`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceptp_user
-- ----------------------------
