-- MySQL Script generated by MySQL Workbench
-- Sat Jul 25 10:36:43 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tpanalytics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tpanalytics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tpanalytics` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `tpanalytics` ;

-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_funcao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `senha` VARCHAR(40) NOT NULL,
  `funcao` INT NOT NULL,
  `ativo` TINYINT(1) NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`id`, `matricula`),
  INDEX `LOGIN` (`id` ASC, `senha` ASC),
  INDEX `fk_tb_usuarios_1_idx` (`funcao` ASC),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC),
  CONSTRAINT `fk_tb_usuarios_1`
    FOREIGN KEY (`funcao`)
    REFERENCES `tpanalytics`.`tb_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_linha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_linha` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_rota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_rota` (
  `rota` VARCHAR(10) NOT NULL,
  `linha` INT NOT NULL,
  PRIMARY KEY (`rota`),
  INDEX `fk_tb_rotas_1_idx` (`linha` ASC),
  CONSTRAINT `fk_tb_rotas_1`
    FOREIGN KEY (`linha`)
    REFERENCES `tpanalytics`.`tb_linha` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_empresa` (
  `id` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_onibus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_onibus` (
  `numero` INT NOT NULL,
  `empresa` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_tb_onibus_1_idx` (`empresa` ASC),
  CONSTRAINT `fk_tb_onibus_1`
    FOREIGN KEY (`empresa`)
    REFERENCES `tpanalytics`.`tb_empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_ponto_de_fiscalizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_ponto_de_fiscalizacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_status_escala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_status_escala` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_escala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_escala` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mes` INT NOT NULL,
  `ano` INT NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_escala_2_idx` (`status` ASC),
  CONSTRAINT `fk_tb_escala_2`
    FOREIGN KEY (`status`)
    REFERENCES `tpanalytics`.`tb_status_escala` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_turno_escala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_turno_escala` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `turno` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_alocacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_alocacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_ponto_fiscalizacao` INT NOT NULL,
  `dia` INT NOT NULL,
  `id_escala` INT NOT NULL,
  `id_turno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_alocacoes_2_idx` (`id_ponto_fiscalizacao` ASC),
  INDEX `fk_tb_alocacoes_3_idx` (`id_escala` ASC),
  INDEX `fk_tb_alocacoes_1_idx` (`id_usuario` ASC),
  INDEX `fk_tb_alocacao_1_idx` (`id_turno` ASC),
  CONSTRAINT `fk_tb_alocacoes_2`
    FOREIGN KEY (`id_ponto_fiscalizacao`)
    REFERENCES `tpanalytics`.`tb_ponto_de_fiscalizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_alocacoes_3`
    FOREIGN KEY (`id_escala`)
    REFERENCES `tpanalytics`.`tb_escala` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_alocacoes_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `tpanalytics`.`tb_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_alocacoes_4`
    FOREIGN KEY (`id_turno`)
    REFERENCES `tpanalytics`.`tb_turno_escala` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_bilhetagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_bilhetagem` (
  `id` VARCHAR(15) NOT NULL,
  `passageiros` INT NOT NULL,
  `estudantes` INT NOT NULL,
  `gratuitos` INT NOT NULL,
  `equivalencia` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_viagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rota` VARCHAR(10) NOT NULL,
  `data` DATE NOT NULL,
  `saida` TIME NOT NULL,
  `chegada` TIME NOT NULL,
  `duracao` INT NOT NULL,
  `numero_onibus` INT NOT NULL,
  `operador` VARCHAR(45) NOT NULL,
  `id_bilhetagem` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `numero_idx` (`numero_onibus` ASC),
  INDEX `rota_idx` (`rota` ASC),
  INDEX `fk_tb_viagem_1_idx` (`id_bilhetagem` ASC),
  CONSTRAINT `numero`
    FOREIGN KEY (`numero_onibus`)
    REFERENCES `tpanalytics`.`tb_onibus` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rota`
    FOREIGN KEY (`rota`)
    REFERENCES `tpanalytics`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_viagem_1`
    FOREIGN KEY (`id_bilhetagem`)
    REFERENCES `tpanalytics`.`tb_bilhetagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_tipo_dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_tipo_dia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_dia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_quadro_horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_quadro_horario` (
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
    REFERENCES `tpanalytics`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horario_proposto_2`
    FOREIGN KEY (`tipo_dia`)
    REFERENCES `tpanalytics`.`tb_tipo_dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_shape`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_shape` (
  `id` INT(11) NOT NULL,
  `id_rota` VARCHAR(10) NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `sequencia` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_shape_1_idx` (`id_rota` ASC),
  CONSTRAINT `fk_tb_shape_1`
    FOREIGN KEY (`id_rota`)
    REFERENCES `tpanalytics`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_quadro_horario_2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_quadro_horario_2` (
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
    REFERENCES `tpanalytics`.`tb_rota` (`rota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horario_proposto_20`
    FOREIGN KEY (`tipo_dia`)
    REFERENCES `tpanalytics`.`tb_tipo_dia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_parada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_parada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpanalytics`.`tb_horario_quadro_horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpanalytics`.`tb_horario_quadro_horario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_quadro_horario` INT NOT NULL,
  `hora_onibus` TIME NOT NULL,
  `id_parada` INT NOT NULL,
  `indice_viagem` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_horario_quadro_horario_1_idx` (`id_quadro_horario` ASC),
  INDEX `fk_tb_horario_quadro_horario_2_idx` (`id_parada` ASC),
  CONSTRAINT `fk_horario_quadro_horario_1`
    FOREIGN KEY (`id_quadro_horario`)
    REFERENCES `tpanalytics`.`tb_quadro_horario_2` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_horario_quadro_horario_2`
    FOREIGN KEY (`id_parada`)
    REFERENCES `tpanalytics`.`tb_parada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;