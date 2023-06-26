/*
 Navicat Premium Data Transfer

 Source Server         : stu
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 25/06/2023 11:04:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `BookID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Title` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Author` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Publisher` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Category` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CoverImage` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`BookID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------

-- ----------------------------
-- Table structure for borrowrecord
-- ----------------------------
DROP TABLE IF EXISTS `borrowrecord`;
CREATE TABLE `borrowrecord`  (
  `RecordID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LibrarianID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ReaderID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `BookID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `BorrowDate` date NULL DEFAULT NULL,
  `ReturnDate` date NULL DEFAULT NULL,
  `BorrowStatus` enum('normal','overdue') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'normal',
  `FineAmount` decimal(5, 2) NULL,
  `BorrowDays` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`RecordID`) USING BTREE,
  INDEX `LibrarianID`(`LibrarianID`) USING BTREE,
  INDEX `ReaderID`(`ReaderID`) USING BTREE,
  INDEX `BookID`(`BookID`) USING BTREE,
  CONSTRAINT `borrowrecord_ibfk_1` FOREIGN KEY (`LibrarianID`) REFERENCES `librarian` (`AdminID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `borrowrecord_ibfk_2` FOREIGN KEY (`ReaderID`) REFERENCES `reader` (`ReaderID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `borrowrecord_ibfk_3` FOREIGN KEY (`BookID`) REFERENCES `book` (`BookID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrowrecord
-- ----------------------------

-- ----------------------------
-- Table structure for librarian
-- ----------------------------
DROP TABLE IF EXISTS `librarian`;
CREATE TABLE `librarian`  (
  `AdminID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PhoneNumber` char(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AdminName` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`AdminID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of librarian
-- ----------------------------

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `ReaderID` char(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ReaderType` enum('teacher','student') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PhoneNumber` char(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ReaderName` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ReaderID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------

-- ----------------------------
-- Table structure for systemadmin
-- ----------------------------
DROP TABLE IF EXISTS `systemadmin`;
CREATE TABLE `systemadmin`  (
  `AdminID` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PhoneNumber` char(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AdminName` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`AdminID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of systemadmin
-- ----------------------------

-- ----------------------------
-- Triggers structure for table borrowrecord
-- ----------------------------
DROP TRIGGER IF EXISTS `check_return_date`;
delimiter ;;
CREATE TRIGGER `check_return_date` BEFORE INSERT ON `borrowrecord` FOR EACH ROW BEGIN
  IF NEW.ReturnDate <= NEW.BorrowDate THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '还书时间必须在借书时间之后。';
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table borrowrecord
-- ----------------------------
DROP TRIGGER IF EXISTS `calculate_borrow_days`;
delimiter ;;
CREATE TRIGGER `calculate_borrow_days` BEFORE INSERT ON `borrowrecord` FOR EACH ROW BEGIN
  SET NEW.BorrowDays = DATEDIFF(NEW.ReturnDate, NEW.BorrowDate);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
