/*
 Navicat Premium Data Transfer

 Source Server         : stu
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : librarymanagesystem

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 29/06/2023 16:27:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `BookID` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Publisher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CateGory` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Status` enum('空闲在册','已借出') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CoverImage` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`BookID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('0000001', '《西游记》', '吴承恩', '人民文学出版社', '小说', '空闲在册', NULL);
INSERT INTO `book` VALUES ('0000002', '《傲慢与偏见》', '简·奥斯汀', '上海人民出版社', '小说', '已借出', NULL);
INSERT INTO `book` VALUES ('0000003', '《战争与和平》', '列夫·托尔斯泰', '外语教学与研究出版社', '小说', '空闲在册', NULL);
INSERT INTO `book` VALUES ('0000004', '《鲁宾逊漂流记》', '丹尼尔·笛福', '北京大学出版社', '小说', '空闲在册', NULL);
INSERT INTO `book` VALUES ('0000005', '《诗经》', '佚名', '华东师范大学出版社', '诗歌', '空闲在册', NULL);
INSERT INTO `book` VALUES ('0000006', '《长恨歌》', ' 白居易', '作家出版社', '诗歌', '已借出', NULL);
INSERT INTO `book` VALUES ('0000007', '《维也纳的秋天》', '张曙光', '长江文艺出版社', '诗歌', '已借出', NULL);
INSERT INTO `book` VALUES ('0000008', '《哈姆雷特》', '威廉·莎士比亚', '外语教学与研究出版社', '戏剧', '空闲在册', NULL);
INSERT INTO `book` VALUES ('0000009', '《茶花女》', '亚历山大·小仲马', '外语教学与研究出版社', '戏剧', '空闲在册', NULL);

-- ----------------------------
-- Table structure for borrowrecord
-- ----------------------------
DROP TABLE IF EXISTS `borrowrecord`;
CREATE TABLE `borrowrecord`  (
  `RecordID` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ReaderID` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BookID` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `BorrowDate` date NULL DEFAULT NULL,
  `ReturnDate` date NULL DEFAULT NULL,
  `BorrowStatus` enum('空闲在册','已借出') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FineAmount` decimal(5, 2) NULL DEFAULT NULL,
  `BorrowDays` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`RecordID`) USING BTREE,
  INDEX `ReaderID`(`ReaderID`) USING BTREE,
  INDEX `BookID`(`BookID`) USING BTREE,
  CONSTRAINT `borrowrecord_ibfk_1` FOREIGN KEY (`ReaderID`) REFERENCES `reader` (`ReaderID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `borrowrecord_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `book` (`BookID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrowrecord
-- ----------------------------
INSERT INTO `borrowrecord` VALUES ('1', 'S0000002', '0000006', '2023-06-01', '2023-06-03', '已借出', 0.00, 2);
INSERT INTO `borrowrecord` VALUES ('2', 'T0000001', '0000007', '2023-04-01', '2023-06-03', '已借出', 0.40, 63);
INSERT INTO `borrowrecord` VALUES ('3', 'S0000007', '0000002', '2023-05-02', '2023-06-01', '已借出', 0.10, 30);

-- ----------------------------
-- Table structure for librarian
-- ----------------------------
DROP TABLE IF EXISTS `librarian`;
CREATE TABLE `librarian`  (
  `AdminID` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PhoneNumber` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `AdminName` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`AdminID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of librarian
-- ----------------------------
INSERT INTO `librarian` VALUES ('00001', 'tXFqyKae5bg6DwE0k1nDTA==', '13728882736', '程鑫');
INSERT INTO `librarian` VALUES ('00002', 'tXFqyKae5bg6DwE0k1nDTA==', '15388882938', '王雅琪');
INSERT INTO `librarian` VALUES ('00003', 'tXFqyKae5bg6DwE0k1nDTA==', '18349492358', '陈天佑');
INSERT INTO `librarian` VALUES ('00004', 'tXFqyKae5bg6DwE0k1nDTA==', '19123847382', '钱晨晖');

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `ReaderID` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ReaderType` enum('教师','学生') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PhoneNumber` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ReaderName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ReaderID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` VALUES ('S0000002', '学生', 'tXFqyKae5bg6DwE0k1nDTA==', '15860437295', '李宇航');
INSERT INTO `reader` VALUES ('S0000006', '学生', 'tXFqyKae5bg6DwE0k1nDTA==', '15881437292', '周婉婷');
INSERT INTO `reader` VALUES ('S0000007', '学生', 'tXFqyKae5bg6DwE0k1nDTA==', '17788899999', '刘佳怡');
INSERT INTO `reader` VALUES ('S0000008', '学生', 'tXFqyKae5bg6DwE0k1nDTA==', '15036925807', '杨文静');
INSERT INTO `reader` VALUES ('T0000001', '教师', 'tXFqyKae5bg6DwE0k1nDTA==', '15928371678', '范雨');
INSERT INTO `reader` VALUES ('T0000003', '教师', 'tXFqyKae5bg6DwE0k1nDTA==', '13855578904', '刘晨光');
INSERT INTO `reader` VALUES ('T0000004', '教师', 'tXFqyKae5bg6DwE0k1nDTA==', '13624681353', '李雨婷');
INSERT INTO `reader` VALUES ('T0000005', '教师', 'tXFqyKae5bg6DwE0k1nDTA==', '18845678901', '钱鹏飞');

-- ----------------------------
-- Table structure for systemadmin
-- ----------------------------
DROP TABLE IF EXISTS `systemadmin`;
CREATE TABLE `systemadmin`  (
  `AdminID` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PhoneNumber` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `AdminName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`AdminID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of systemadmin
-- ----------------------------
INSERT INTO `systemadmin` VALUES ('00001', 'tXFqyKae5bg6DwE0k1nDTA==', '13758946210', '张筱雨');
INSERT INTO `systemadmin` VALUES ('00002', 'tXFqyKae5bg6DwE0k1nDTA==', '15842679038', '李晓芳');
INSERT INTO `systemadmin` VALUES ('00003', 'tXFqyKae5bg6DwE0k1nDTA==', '18673852941', '李璐');
INSERT INTO `systemadmin` VALUES ('00004', 'tXFqyKae5bg6DwE0k1nDTA==', '13964108572', '陈晓宇');
INSERT INTO `systemadmin` VALUES ('00005', 'tXFqyKae5bg6DwE0k1nDTA==', '15290834761', '刘阳明');
INSERT INTO `systemadmin` VALUES ('00006', 'tXFqyKae5bg6DwE0k1nDTA==', '17735296408', '杨佳欣');
INSERT INTO `systemadmin` VALUES ('00007', 'tXFqyKae5bg6DwE0k1nDTA==', '13170542896', '黄子涵');

-- ----------------------------
-- Triggers structure for table borrowrecord
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_borrowrecord`;
delimiter ;;
CREATE TRIGGER `trigger_borrowrecord` BEFORE INSERT ON `borrowrecord` FOR EACH ROW BEGIN
    DECLARE diff INT;
    IF NEW.BorrowDate IS NOT NULL AND NEW.ReturnDate IS NOT NULL THEN
        SET diff = DATEDIFF(NEW.ReturnDate, NEW.BorrowDate);
        SET NEW.BorrowDays = diff;
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
