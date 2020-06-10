-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`domain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`domain` (
  `Domain_Name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Domain_Name`),
  UNIQUE INDEX `Domain_Name_UNIQUE` (`Domain_Name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agenda` (
  `Agenda_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Agenda_Body` VARCHAR(6000) NULL DEFAULT NULL,
  `Agenda_Title` VARCHAR(1000) NULL DEFAULT NULL,
  `Agenda_Date` VARCHAR(45) NULL DEFAULT NULL,
  `Agenda_Domain` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Agenda_ID`),
  UNIQUE INDEX `Agenda_ID_UNIQUE` (`Agenda_ID` ASC) ,
  INDEX `Agenda_Domain_idx` (`Agenda_Domain` ASC) ,
  CONSTRAINT `Agenda_Domain`
    FOREIGN KEY (`Agenda_Domain`)
    REFERENCES `mydb`.`domain` (`Domain_Name`))
ENGINE = InnoDB
AUTO_INCREMENT = 10510
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`article` (
  `Article_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Article_title` VARCHAR(255) NULL DEFAULT NULL,
  `Article_Body` VARCHAR(255) NULL DEFAULT NULL,
  `Article_Date` VARCHAR(45) NULL DEFAULT NULL,
  `Article_Link` VARCHAR(255) NULL DEFAULT NULL,
  `Domain_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Article_Agenda` INT(11) NULL DEFAULT NULL,
  `Article_Keyword` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Article_ID`),
  UNIQUE INDEX `idArticle_UNIQUE` (`Article_ID` ASC) ,
  INDEX `Domain_Name_idx` (`Domain_Name` ASC) ,
  INDEX `Article_Agenda_idx` (`Article_Agenda` ASC) ,
  CONSTRAINT `Article_Agenda`
    FOREIGN KEY (`Article_Agenda`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `Domain_Name`
    FOREIGN KEY (`Domain_Name`)
    REFERENCES `mydb`.`domain` (`Domain_Name`))
ENGINE = InnoDB
AUTO_INCREMENT = 8761
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`party`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`party` (
  `Party_Name` CHAR(45) NOT NULL,
  `Floor_leader` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Party_Name`),
  UNIQUE INDEX `Party_Name_UNIQUE` (`Party_Name` ASC) ,
  UNIQUE INDEX `Floor_leader_UNIQUE` (`Floor_leader` ASC) ,
  CONSTRAINT `Floor_leader`
    FOREIGN KEY (`Floor_leader`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`member_of_congress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`member_of_congress` (
  `Member_of_Congress_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Member_of_Congress_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Member_of_Congress_Party` CHAR(45) NULL DEFAULT NULL,
  `Member_of_Congress_region` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Member_of_Congress_ID`),
  UNIQUE INDEX `Member_of_Congress_ID_UNIQUE` (`Member_of_Congress_ID` ASC) ,
  INDEX `Member_of_Congress_Party_idx` (`Member_of_Congress_Party` ASC) ,
  CONSTRAINT `Member_of_Congress_Party`
    FOREIGN KEY (`Member_of_Congress_Party`)
    REFERENCES `mydb`.`party` (`Party_Name`))
ENGINE = InnoDB
AUTO_INCREMENT = 300
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`exist_member_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`exist_member_article` (
  `Member_ID` INT(11) NOT NULL,
  `Article_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Member_ID`, `Article_ID`),
  INDEX `Article_ID_idx` (`Article_ID` ASC) ,
  CONSTRAINT `EMA_Article_ID_`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`article` (`Article_ID`),
  CONSTRAINT `EMA_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`include_member_agenda_`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`include_member_agenda_` (
  `Member_ID` INT(11) NOT NULL,
  `Agenda_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Member_ID`, `Agenda_ID`),
  INDEX `Agenda_ID_idx` (`Agenda_ID` ASC) ,
  CONSTRAINT `IMA_Agenda_ID_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `IMA_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_agenda_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_agenda_article` (
  `Agenda_ID` INT(11) NOT NULL,
  `Article_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `Article_ID`),
  INDEX `Article_ID_idx` (`Article_ID` ASC) ,
  CONSTRAINT `MAA_Agenda_ID_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `MAA_Article_ID_`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`article` (`Article_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_agenda_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_agenda_member` (
  `Agenda_ID` INT(11) NOT NULL,
  `Member_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `Member_ID`),
  INDEX `Member_ID_idx` (`Member_ID` ASC) ,
  CONSTRAINT `MAM_Agenda_ID_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `MAM_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`petition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`petition` (
  `Petition_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Petition_Name` VARCHAR(2000) NULL DEFAULT NULL,
  `Petition_Agenda` INT(11) NULL DEFAULT NULL,
  `Petition_Agree_Number` INT(11) NOT NULL,
  `Petition_Body` VARCHAR(2000) NULL DEFAULT NULL,
  PRIMARY KEY (`Petition_ID`),
  UNIQUE INDEX `Petition_Number_UNIQUE` (`Petition_ID` ASC) ,
  UNIQUE INDEX `Petition_Agenda_UNIQUE` (`Petition_Agenda` ASC) ,
  CONSTRAINT `Petition_Agenda`
    FOREIGN KEY (`Petition_Agenda`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 21774
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_agenda_petition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_agenda_petition` (
  `Agenda_ID` INT(11) NOT NULL,
  `Petition_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `Petition_ID`),
  INDEX `Petition_ID_idx` (`Petition_ID` ASC) ,
  CONSTRAINT `MAP_Agenda_ID_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `MAP_Petition_ID_`
    FOREIGN KEY (`Petition_ID`)
    REFERENCES `mydb`.`petition` (`Petition_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_domain_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_domain_article` (
  `Domain_Name` VARCHAR(45) NOT NULL,
  `Article_Number` INT(11) NOT NULL,
  PRIMARY KEY (`Domain_Name`, `Article_Number`),
  INDEX `Article_Number_idx` (`Article_Number` ASC) ,
  CONSTRAINT `MDA_Article_Number_ID`
    FOREIGN KEY (`Article_Number`)
    REFERENCES `mydb`.`article` (`Article_ID`),
  CONSTRAINT `MDA_Domain_Name_`
    FOREIGN KEY (`Domain_Name`)
    REFERENCES `mydb`.`domain` (`Domain_Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_domain_agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_domain_agenda` (
  `Domain_Name` VARCHAR(45) NOT NULL,
  `Agenda_Number` INT(11) NOT NULL,
  PRIMARY KEY (`Domain_Name`, `Agenda_Number`),
  INDEX `MDP_Agenda_Number_idx` (`Agenda_Number` ASC) ,
  CONSTRAINT `MDP_Domain_Name`
    FOREIGN KEY (`Domain_Name`)
    REFERENCES `mydb`.`domain` (`Domain_Name`),
  CONSTRAINT `MDP_Agenda_Number`
    FOREIGN KEY (`Agenda_Number`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_member_agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_member_agenda` (
  `Member_ID` INT(11) NOT NULL,
  `Agenda_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Member_ID`, `Agenda_ID`),
  INDEX `MMA_Agenda_idx` (`Agenda_ID` ASC) ,
  CONSTRAINT `MMAgen_Agenda_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `MMAgen_Member_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_member_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_member_article` (
  `Member_ID` INT(11) NOT NULL,
  `Article_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Member_ID`, `Article_ID`),
  INDEX `Article_ID_idx` (`Article_ID` ASC) ,
  CONSTRAINT `MMA_Article_ID_`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`article` (`Article_ID`),
  CONSTRAINT `MMA_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`mva_party_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mva_party_member` (
  `Party_Name` VARCHAR(45) NOT NULL,
  `Member_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Party_Name`, `Member_ID`),
  INDEX `Member_ID_idx` (`Member_ID` ASC) ,
  CONSTRAINT `MPM_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`),
  CONSTRAINT `MPM_Party_Name_`
    FOREIGN KEY (`Party_Name`)
    REFERENCES `mydb`.`party` (`Party_Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `User_ID` INT(11) NOT NULL,
  `User_Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE INDEX `User_Id_UNIQUE` (`User_ID` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`save_user_agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`save_user_agenda` (
  `Agenda_ID` INT(11) NOT NULL,
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) ,
  CONSTRAINT `SUA_Agenda_ID_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `SUA_User_ID_`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`save_user_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`save_user_article` (
  `Article_ID` INT(11) NOT NULL,
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Article_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) ,
  CONSTRAINT `SUAr_Article_ID_`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`article` (`Article_ID`),
  CONSTRAINT `SUAr_User_ID_`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`save_user_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`save_user_member` (
  `Member_ID` INT(11) NOT NULL,
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Member_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) ,
  CONSTRAINT `SaveUM_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`),
  CONSTRAINT `SaveUM_User_ID_`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`search_user_agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`search_user_agenda` (
  `Agenda_ID` INT(11) NOT NULL,
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Agenda_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) ,
  CONSTRAINT `SearchUA_Agenda_ID_`
    FOREIGN KEY (`Agenda_ID`)
    REFERENCES `mydb`.`agenda` (`Agenda_ID`),
  CONSTRAINT `SearchUA_User_ID_`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`search_user_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`search_user_article` (
  `Article_ID` INT(11) NOT NULL,
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Article_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) ,
  CONSTRAINT `SUArti_Ariticle_ID_`
    FOREIGN KEY (`Article_ID`)
    REFERENCES `mydb`.`article` (`Article_ID`),
  CONSTRAINT `SUArti_User_ID_`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`search_user_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`search_user_member` (
  `Member_ID` INT(11) NOT NULL,
  `User_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Member_ID`, `User_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC) ,
  CONSTRAINT `SUM_Member_ID_`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`member_of_congress` (`Member_of_Congress_ID`),
  CONSTRAINT `SUM_User_ID_`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
