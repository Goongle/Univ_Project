-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema os_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema os_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `os_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `os_db` ;

-- -----------------------------------------------------
-- Table `os_db`.`naver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`naver` (
  `Naver_ID` INT(11) NOT NULL,
  `Naver_Name` VARCHAR(6000) NULL DEFAULT NULL,
  `Naver_Text` VARCHAR(6000) NULL DEFAULT NULL,
  `Naver_Date` VARCHAR(100) NULL DEFAULT NULL,
  `Naver_Link` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`Naver_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `os_db`.`twitter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`twitter` (
  `Twitter_ID` INT(11) NOT NULL,
  `Twitter_Name` VARCHAR(6000) NULL DEFAULT NULL,
  `Twitter_Link` VARCHAR(6000) NULL DEFAULT NULL,
  `Twitter_Date` VARCHAR(100) NULL DEFAULT NULL,
  `Twitter_Text` VARCHAR(6000) NULL DEFAULT NULL,
  PRIMARY KEY (`Twitter_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `os_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`user` (
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `os_db`.`user_naver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`user_naver` (
  `User_ID` INT(11) NOT NULL,
  `Naver_ID` INT(11) NOT NULL,
  PRIMARY KEY (`User_ID`, `Naver_ID`),
  INDEX `UN_Naver_idx` (`Naver_ID` ASC) ,
  CONSTRAINT `UN_Naver`
    FOREIGN KEY (`Naver_ID`)
    REFERENCES `os_db`.`naver` (`Naver_ID`),
  CONSTRAINT `UN_user`
    FOREIGN KEY (`User_ID`)
    REFERENCES `os_db`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `os_db`.`user_twitter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`user_twitter` (
  `User_ID` INT(11) NOT NULL,
  `Twitter_ID` INT(11) NOT NULL,
  PRIMARY KEY (`User_ID`, `Twitter_ID`),
  INDEX `UT_twitter_idx` (`Twitter_ID` ASC) ,
  CONSTRAINT `UT_twitter`
    FOREIGN KEY (`Twitter_ID`)
    REFERENCES `os_db`.`twitter` (`Twitter_ID`),
  CONSTRAINT `UT_user`
    FOREIGN KEY (`User_ID`)
    REFERENCES `os_db`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `os_db`.`youtube`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`youtube` (
  `Youtube_ID` INT(11) NOT NULL,
  `Youtube_Text` VARCHAR(12000) NULL DEFAULT NULL,
  `Youtube_Name` VARCHAR(6000) NULL DEFAULT NULL,
  `Youtube_Date` VARCHAR(100) NULL DEFAULT NULL,
  `Youtube_Link` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`Youtube_ID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `os_db`.`user_youtube`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os_db`.`user_youtube` (
  `User_ID` INT(11) NOT NULL,
  `Youtube_ID` INT(11) NOT NULL,
  PRIMARY KEY (`User_ID`, `Youtube_ID`),
  INDEX `UY_youtube_idx` (`Youtube_ID` ASC) ,
  CONSTRAINT `UY_user`
    FOREIGN KEY (`User_ID`)
    REFERENCES `os_db`.`user` (`User_ID`),
  CONSTRAINT `UY_youtube`
    FOREIGN KEY (`Youtube_ID`)
    REFERENCES `os_db`.`youtube` (`Youtube_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
