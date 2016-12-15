-- MySQL Script generated by MySQL Workbench
-- Sex 10 Jun 2016 11:46:37 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tpcuritiba
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tpcuritiba
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tpcuritiba` DEFAULT CHARACTER SET utf8 ;
USE `tpcuritiba` ;

-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_funcao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_funcao` ;

CREATE  TABLE IF NOT EXISTS `tpcuritiba`.`tb_funcao` (
 `id` INT NOT NULL AUTO_INCREMENT ,
 `nome` VARCHAR(45) NOT NULL ,
 PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_usuario` ;

CREATE  TABLE IF NOT EXISTS `tpcuritiba`.`tb_usuario` (
 `id` INT NOT NULL AUTO_INCREMENT ,
 `matricula` VARCHAR(20) NOT NULL ,
 `nome` VARCHAR(60) NOT NULL ,
 `senha` VARCHAR(40) NOT NULL ,
 `funcao` INT NOT NULL ,
 `ativo` TINYINT(1) NOT NULL DEFAULT TRUE ,
 PRIMARY KEY (`id`, `matricula`) ,
 INDEX `LOGIN` (`id` ASC, `senha` ASC) ,
 INDEX `fk_tb_usuarios_1_idx` (`funcao` ASC) ,
 UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC) ,
 CONSTRAINT `fk_tb_usuarios_1`
   FOREIGN KEY (`funcao` )
   REFERENCES `tpanalytics`.`tb_funcao` (`id` )
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_linha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_linha` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_linha` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_rota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_rota` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_rota` (
  `rota` VARCHAR(10) NOT NULL,
  `linha` INT NOT NULL,
  PRIMARY KEY (`rota`),
  INDEX `fk_tb_rotas_1_idx` (`linha` ASC),
  CONSTRAINT `fk_tb_rotas_1`
    FOREIGN KEY (`linha`)
    REFERENCES `tpcuritiba`.`tb_linha` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_empresa` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_empresa` (
  `id` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_onibus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_onibus` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_onibus` (
  `numero` VARCHAR(10) NOT NULL,
  `empresa` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_tb_onibus_1_idx` (`empresa` ASC),
  CONSTRAINT `fk_tb_onibus_1`
    FOREIGN KEY (`empresa`)
    REFERENCES `tpcuritiba`.`tb_empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_bilhetagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_bilhetagem` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_bilhetagem` (
  `id` VARCHAR(15) NOT NULL,
  `passageiros` INT NOT NULL,
  `estudantes` INT NOT NULL,
  `gratuitos` INT NOT NULL,
  `equivalencia` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_viagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_viagem` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_viagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rota` VARCHAR(10) NOT NULL,
  `data` DATE NOT NULL,
  `saida` TIME NOT NULL,
  `chegada` TIME NOT NULL,
  `duracao` INT NOT NULL,
  `numero_onibus` VARCHAR(10) NOT NULL,
  `operador` VARCHAR(45) NOT NULL,
  `id_bilhetagem` VARCHAR(15) NOT NULL,
  `initial_stop_id` INT,
  `stop_lat` FLOAT,
  `stop_lon` FLOAT,
  PRIMARY KEY (`id`),
  INDEX `numero_idx` (`numero_onibus` ASC),
  INDEX `rota_idx` (`rota` ASC),
  INDEX `fk_tb_viagem_1_idx` (`id_bilhetagem` ASC),
  CONSTRAINT `numero`
    FOREIGN KEY (`numero_onibus`)
    REFERENCES `tpcuritiba`.`tb_onibus` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rota`
    FOREIGN KEY (`rota`)
    REFERENCES `tpcuritiba`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_viagem_1`
    FOREIGN KEY (`id_bilhetagem`)
    REFERENCES `tpcuritiba`.`tb_bilhetagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_tipo_dia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_tipo_dia` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_tipo_dia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_dia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_quadro_horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_quadro_horario` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_quadro_horario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_dia` INT NOT NULL,
  `saida` TIME NOT NULL,
  `chegada` TIME NOT NULL,
  `local_saida` VARCHAR(100) NOT NULL,
  `local_chegada` VARCHAR(100) NOT NULL,
  `duracao` INT NOT NULL,
  `tamanho_da_viagem` FLOAT NOT NULL,
  `id_rota` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_horario_proposto_1_idx` (`id_rota` ASC),
  INDEX `fk_tb_horario_proposto_2_idx` (`tipo_dia` ASC),
  CONSTRAINT `fk_tb_horario_proposto_1`
    FOREIGN KEY (`id_rota`)
    REFERENCES `tpcuritiba`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horario_proposto_2`
    FOREIGN KEY (`tipo_dia`)
    REFERENCES `tpcuritiba`.`tb_tipo_dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_quadro_horario_2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_quadro_horario_2` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_quadro_horario_2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_dia` INT NOT NULL,
  `tamanho_da_viagem` FLOAT NOT NULL,
  `id_rota` VARCHAR(10) NOT NULL,
  `duracao` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_horario_proposto_1_idx` (`id_rota` ASC),
  INDEX `fk_tb_horario_proposto_2_idx` (`tipo_dia` ASC),
  CONSTRAINT `fk_tb_horario_proposto_10`
    FOREIGN KEY (`id_rota`)
    REFERENCES `tpcuritiba`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horario_proposto_20`
    FOREIGN KEY (`tipo_dia`)
    REFERENCES `tpcuritiba`.`tb_tipo_dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_parada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_parada` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_parada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_horario_quadro_horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_horario_quadro_horario` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_horario_quadro_horario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_quadro_horario` INT NOT NULL,
  `hora_onibus` TIME NOT NULL,
  `id_parada` INT NOT NULL,
  `indice_viagem` INT NOT NULL,
  `stop_lat` FLOAT,
  `stop_lon` FLOAT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_horario_quadro_horario_1_idx` (`id_quadro_horario` ASC),
  INDEX `fk_tb_horario_quadro_horario_2_idx` (`id_parada` ASC),
  CONSTRAINT `fk_horario_quadro_horario_1`
    FOREIGN KEY (`id_quadro_horario`)
    REFERENCES `tpcuritiba`.`tb_quadro_horario_2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horario_quadro_horario_2`
    FOREIGN KEY (`id_parada`)
    REFERENCES `tpcuritiba`.`tb_parada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpcuritiba`.`tb_data_rota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tpcuritiba`.`tb_data_rota` ;

CREATE TABLE IF NOT EXISTS `tpcuritiba`.`tb_data_rota` (
  `data` DATE NOT NULL,
  `rota` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`rota`))
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
