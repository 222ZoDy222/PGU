-- MySQL Script generated by MySQL Workbench
-- Fri Nov 11 10:05:11 2022
-- Model: New Model    Version: 1.0
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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `idusers` INT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(255) NULL,
  `raiting` INT NULL,
  PRIMARY KEY (`idusers`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idusers_UNIQUE` ON `mydb`.`users` (`idusers` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subject` (
  `idSubject` INT NOT NULL AUTO_INCREMENT,
  `ThemeName` VARCHAR(255) NULL,
  PRIMARY KEY (`idSubject`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Task` (
  `idTask` INT NULL AUTO_INCREMENT,
  `TaskName` VARCHAR(255) NULL,
  `Charactiristic` JSON NULL,
  `Subject_idSubject` INT NOT NULL,
  PRIMARY KEY (`idTask`),
  CONSTRAINT `fk_subject_Subject1`
    FOREIGN KEY (`Subject_idSubject`)
    REFERENCES `mydb`.`Subject` (`idSubject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_subject_Subject1_idx` ON `mydb`.`Task` (`Subject_idSubject` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`files` (
  `file` VARCHAR(255) NULL,
  `date` DATETIME NULL,
  `comment` VARCHAR(300) NULL,
  `filescol` VARCHAR(45) NULL,
  `users_idusers` INT NOT NULL,
  `Task_idTask` INT NOT NULL,
  `id_file` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_file`),
  CONSTRAINT `fk_files_users1`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `mydb`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_files_Task1`
    FOREIGN KEY (`Task_idTask`)
    REFERENCES `mydb`.`Task` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_files_users1_idx` ON `mydb`.`files` (`users_idusers` ASC);

CREATE INDEX `fk_files_Task1_idx` ON `mydb`.`files` (`Task_idTask` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`questions` (
  `questionText` VARCHAR(255) NULL,
  `QuestionID` INT NOT NULL AUTO_INCREMENT,
  `Task_idTask` INT NOT NULL,
  `users_idusers1` INT NOT NULL,
  PRIMARY KEY (`QuestionID`),
  CONSTRAINT `fk_questions_Task1`
    FOREIGN KEY (`Task_idTask`)
    REFERENCES `mydb`.`Task` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_questions_users1`
    FOREIGN KEY (`users_idusers1`)
    REFERENCES `mydb`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_questions_Task1_idx` ON `mydb`.`questions` (`Task_idTask` ASC);

CREATE INDEX `fk_questions_users1_idx` ON `mydb`.`questions` (`users_idusers1` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`answers` (
  `answerText` VARCHAR(300) NULL,
  `questions_idquestions` INT NOT NULL,
  `questions_users_idusers` INT NOT NULL,
  `users_idusers` INT NOT NULL,
  `questions_users_idusers1` INT NOT NULL,
  PRIMARY KEY (`users_idusers`, `questions_users_idusers1`),
  CONSTRAINT `fk_answers_users1`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `mydb`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answers_questions1`
    FOREIGN KEY (`questions_users_idusers1`)
    REFERENCES `mydb`.`questions` (`QuestionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_answers_users1_idx` ON `mydb`.`answers` (`users_idusers` ASC);

CREATE INDEX `fk_answers_questions1_idx` ON `mydb`.`answers` (`questions_users_idusers1` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`completeData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`completeData` (
  `subject_idsubject` INT NOT NULL,
  `users_idusers` INT NOT NULL,
  `mark` INT NULL,
  `date` DATETIME NULL,
  `completeData` DATETIME NULL,
  PRIMARY KEY (`subject_idsubject`, `users_idusers`),
  CONSTRAINT `fk_completeData_subject1`
    FOREIGN KEY (`subject_idsubject`)
    REFERENCES `mydb`.`Task` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_completeData_users1`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `mydb`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_completeData_users1_idx` ON `mydb`.`completeData` (`users_idusers` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
