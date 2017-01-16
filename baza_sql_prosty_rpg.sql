-- MySQL Script generated by MySQL Workbench
-- 12/30/16 16:17:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`userCharacter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userCharacter` (
  `userCharacterID` INT NOT NULL,
  `characterName` VARCHAR(45) NOT NULL,
  `characterHP` INT NULL DEFAULT 10,
  `characterMana` INT NULL DEFAULT 10,
  `characterGold` INT NULL DEFAULT 0,
  `characterLvl` INT NULL DEFAULT 1,
  `characterAtc` INT NULL DEFAULT 1,
  `characterDef` INT NULL DEFAULT 1,
  PRIMARY KEY (`userCharacterID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `iduser` INT NOT NULL,
  `userName` VARCHAR(45) NOT NULL,
  `userPassword` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `characterID` INT NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC),
  UNIQUE INDEX `userPassword_UNIQUE` (`userPassword` ASC),
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC),
  INDEX `characterID_idx` (`characterID` ASC),
  CONSTRAINT `characterID`
    FOREIGN KEY (`characterID`)
    REFERENCES `mydb`.`userCharacter` (`userCharacterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dungeonRoom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dungeonRoom` (
  `roomID` INT NOT NULL,
  `roomName` VARCHAR(45) NOT NULL,
  `monsterID` INT NULL,
  `chestID` INT NULL,
  `eventID` INT NULL,
  PRIMARY KEY (`roomID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`monster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`monster` (
  `monsterID` INT NOT NULL,
  `monsterName` VARCHAR(45) NOT NULL,
  `goldLoot` INT NOT NULL,
  `expLoot` INT NOT NULL,
  `monsterHP` INT NULL,
  `monsterAtk` INT NULL,
  `monsterDef` INT NULL,
  INDEX `fk_monster_dungeonRoom1_idx` (`monsterID` ASC),
  PRIMARY KEY (`monsterID`),
  CONSTRAINT `fk_monster_dungeonRoom1`
    FOREIGN KEY (`monsterID`)
    REFERENCES `mydb`.`dungeonRoom` (`monsterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`chest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`chest` (
  `chestID` INT NOT NULL,
  `chestGold` INT NOT NULL,
  PRIMARY KEY (`chestID`),
  CONSTRAINT `fk_chest_dungeonRoom1`
    FOREIGN KEY (`chestID`)
    REFERENCES `mydb`.`dungeonRoom` (`chestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`event` (
  `eventID` INT NOT NULL,
  `eventName` VARCHAR(45) NOT NULL,
  `eventDescription` VARCHAR(45) NOT NULL COMMENT 'przechowuje link do opisu tekstowego',
  `eventReactionID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eventID`),
  CONSTRAINT `fk_event_dungeonRoom1`
    FOREIGN KEY (`eventID`)
    REFERENCES `mydb`.`dungeonRoom` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`eventReaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eventReaction` (
  `eventReactionID` INT NOT NULL,
  `reactionDescription` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eventReactionID`),
  CONSTRAINT `fk_eventReaction_event1`
    FOREIGN KEY (`eventReactionID`)
    REFERENCES `mydb`.`event` (`eventReactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'admin' IDENTIFIED BY 'admin';

GRANT ALL ON `mydb`.* TO 'admin';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;