-- MySQL Script generated by MySQL Workbench
-- Wed May 31 12:08:23 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica_cul_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica_cul_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica_cul_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `optica_cul_ampolla` ;

-- -----------------------------------------------------
-- Table `optica_cul_ampolla`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cul_ampolla`.`proveidor` (
  `id_proveidor` INT NOT NULL AUTO_INCREMENT,
  `proveidor_nom` VARCHAR(45) NOT NULL,
  `proveidor_telefon` INT(9) NOT NULL,
  `proveidor_fax` INT NULL,
  `proveidor_nif` INT NOT NULL,
  PRIMARY KEY (`id_proveidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_cul_ampolla`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cul_ampolla`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `client_nom` VARCHAR(45) NOT NULL,
  `client_apellido1` VARCHAR(45) NOT NULL,
  `client_apellido2` VARCHAR(45) NOT NULL,
  `client_telefon` INT(9) NOT NULL,
  `client_email` VARCHAR(45) NULL,
  `client_data` DATETIME NOT NULL COMMENT 'Data de registre del client a la base de dades',
  `client_id_recomendado` INT NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_client_client1_idx` (`client_id_recomendado` ASC) VISIBLE,
  CONSTRAINT `fk_client_client1`
    FOREIGN KEY (`client_id_recomendado`)
    REFERENCES `optica_cul_ampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_cul_ampolla`.`adreça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cul_ampolla`.`adreça` (
  `id_adreça` INT NOT NULL AUTO_INCREMENT,
  `adreça_carrer` VARCHAR(45) NOT NULL,
  `adreça_num` INT(3) NOT NULL,
  `adreça_pis` INT(2) NULL,
  `adreça_porta` INT(2) NULL,
  `adreça_ciutat` VARCHAR(45) NOT NULL,
  `adreça_cp` INT NOT NULL COMMENT 'Codi Postal',
  `adreça_pais` VARCHAR(45) NOT NULL,
  `proveidor_id_proveidor` INT NULL,
  `client_id_client` INT NULL,
  PRIMARY KEY (`id_adreça`),
  INDEX `fk_adreça_proveidor1_idx` (`proveidor_id_proveidor` ASC) VISIBLE,
  INDEX `fk_adreça_client1_idx` (`client_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_adreça_proveidor1`
    FOREIGN KEY (`proveidor_id_proveidor`)
    REFERENCES `optica_cul_ampolla`.`proveidor` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adreça_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `optica_cul_ampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_cul_ampolla`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cul_ampolla`.`gafas` (
  `id_gafas` INT NOT NULL AUTO_INCREMENT,
  `gafas_marca` VARCHAR(45) NOT NULL,
  `gafas_graduacio_L` INT NOT NULL,
  `gafas_graduacio_R` INT NOT NULL,
  `gafas_montura` VARCHAR(45) NOT NULL,
  `gafas_color_L` VARCHAR(45) NOT NULL,
  `gafas_color_R` VARCHAR(45) NOT NULL,
  `gafas_preu` DECIMAL(2) NOT NULL,
  `proveidor_id_proveidor` INT NOT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `fk_gafas_proveidor1_idx` (`proveidor_id_proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_proveidor1`
    FOREIGN KEY (`proveidor_id_proveidor`)
    REFERENCES `optica_cul_ampolla`.`proveidor` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_cul_ampolla`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cul_ampolla`.`empleat` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `empleat_nom` VARCHAR(45) NOT NULL,
  `empleat_apellido1` VARCHAR(45) NOT NULL,
  `empleat_apellido2` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica_cul_ampolla`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_cul_ampolla`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `venta_fecha` DATETIME NOT NULL,
  `empleat_id_empleat` INT NOT NULL,
  `client_id_client` INT NOT NULL,
  `gafas_id_gafas` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_venta_empleat1_idx` (`empleat_id_empleat` ASC) VISIBLE,
  INDEX `fk_venta_client1_idx` (`client_id_client` ASC) VISIBLE,
  INDEX `fk_venta_gafas1_idx` (`gafas_id_gafas` ASC) VISIBLE,
  CONSTRAINT `fk_venta_empleat1`
    FOREIGN KEY (`empleat_id_empleat`)
    REFERENCES `optica_cul_ampolla`.`empleat` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `optica_cul_ampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_gafas1`
    FOREIGN KEY (`gafas_id_gafas`)
    REFERENCES `optica_cul_ampolla`.`gafas` (`id_gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
