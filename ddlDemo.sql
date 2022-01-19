/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : 0x1

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 19/01/2022 12:31:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_address_list
-- ----------------------------
DROP TABLE IF EXISTS `t_address_list`;
CREATE TABLE `t_address_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `c_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_last_height` double DEFAULT NULL,
  `c_last_transaction` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_last_application` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_last_action` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_basic_assets_address_list
-- ----------------------------
DROP TABLE IF EXISTS `t_basic_assets_address_list`;
CREATE TABLE `t_basic_assets_address_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` int DEFAULT NULL,
  `c_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_basic_assets_address_record
-- ----------------------------
DROP TABLE IF EXISTS `t_basic_assets_address_record`;
CREATE TABLE `t_basic_assets_address_record` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_height` double DEFAULT NULL,
  `c_tx_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_tx_role` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_basic_assets_balance
-- ----------------------------
DROP TABLE IF EXISTS `t_basic_assets_balance`;
CREATE TABLE `t_basic_assets_balance` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_last_height` double DEFAULT NULL,
  `c_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_assets` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_assets_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_assets_symbol` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_amount` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_basic_assets_list
-- ----------------------------
DROP TABLE IF EXISTS `t_basic_assets_list`;
CREATE TABLE `t_basic_assets_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_req_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_tx_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_symbol` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_supply` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_increasable` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_meta_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_meta_signature` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_issued_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_issued_signature` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_issue_to` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_basic_assets_selling_list
-- ----------------------------
DROP TABLE IF EXISTS `t_basic_assets_selling_list`;
CREATE TABLE `t_basic_assets_selling_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_start_transaction` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_stop_transaction` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_seller` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_buyer` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_selling_assets` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_payment_assets` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_price` decimal(10,2) DEFAULT NULL,
  `c_status` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_start_time` datetime DEFAULT NULL,
  `c_stop_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_basic_assets_transfers
-- ----------------------------
DROP TABLE IF EXISTS `t_basic_assets_transfers`;
CREATE TABLE `t_basic_assets_transfers` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_req_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_tx_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_from` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_to` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_assets_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_amount` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_transaction_type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_transaction_memo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_block_list
-- ----------------------------
DROP TABLE IF EXISTS `t_block_list`;
CREATE TABLE `t_block_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_signer` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_signature` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_prev_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  `c_tx_root` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_tx_count` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_payload` text COLLATE utf8mb4_bin,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_block_requests
-- ----------------------------
DROP TABLE IF EXISTS `t_block_requests`;
CREATE TABLE `t_block_requests` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_sender` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_signature` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_application` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_action` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_payload` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_packed` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_result` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_memo_address_list
-- ----------------------------
DROP TABLE IF EXISTS `t_memo_address_list`;
CREATE TABLE `t_memo_address_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_memo_list
-- ----------------------------
DROP TABLE IF EXISTS `t_memo_list`;
CREATE TABLE `t_memo_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_req_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_recorder` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_data` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_signature` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_size` double DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_smart_assets_address_list
-- ----------------------------
DROP TABLE IF EXISTS `t_smart_assets_address_list`;
CREATE TABLE `t_smart_assets_address_list` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_balance` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_update_height` double DEFAULT NULL,
  `c_update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_smart_assets_contract
-- ----------------------------
DROP TABLE IF EXISTS `t_smart_assets_contract`;
CREATE TABLE `t_smart_assets_contract` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_tx_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_sequence_number` int DEFAULT NULL,
  `c_creator` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_creation_data` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_contract_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_contract_data` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_memo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_smart_assets_contract_call
-- ----------------------------
DROP TABLE IF EXISTS `t_smart_assets_contract_call`;
CREATE TABLE `t_smart_assets_contract_call` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_tx_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_sequence_number` int DEFAULT NULL,
  `c_caller` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_contract_address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_data` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_result` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_value` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_smart_assets_transaction
-- ----------------------------
DROP TABLE IF EXISTS `t_smart_assets_transaction`;
CREATE TABLE `t_smart_assets_transaction` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_type` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_from` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_to` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_value` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_data` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_memo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_serial_number` int DEFAULT NULL,
  `c_sequence_number` int DEFAULT NULL,
  `c_tx_data_seal` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_result` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for t_smart_assets_transfer
-- ----------------------------
DROP TABLE IF EXISTS `t_smart_assets_transfer`;
CREATE TABLE `t_smart_assets_transfer` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_height` double DEFAULT NULL,
  `c_tx_hash` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_sequence_number` int DEFAULT NULL,
  `c_from` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_to` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_value` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_memo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `c_time` datetime DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

SET FOREIGN_KEY_CHECKS = 1;
