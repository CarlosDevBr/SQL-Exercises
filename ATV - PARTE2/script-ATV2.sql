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
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `usu_emaill` VARCHAR(45) NOT NULL,
  `usu_nome` VARCHAR(45) NOT NULL,
  `usu_sobrenome` VARCHAR(45) NOT NULL,
  `usu_dtNasc` DATETIME NOT NULL,
  `usu_genero` VARCHAR(20) NOT NULL,
  `usu_senha` VARCHAR(45) NOT NULL,
  `usu_numTel` INT(11) NOT NULL,
  `usu_fotoPerfil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`avaliacao` (
  `idavaliacao` INT NOT NULL AUTO_INCREMENT,
  `avali_idAvaliacao` INT NOT NULL,
  `avali_idOpinador` INT NOT NULL,
  `avali_idAvaliado` INT NOT NULL,
  `avali_estrelas` INT NOT NULL,
  `avali_comentario` VARCHAR(300) NOT NULL,
  `avali_dtAvaliacao` DATETIME NOT NULL,
  `avaliacaocol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idavaliacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`viagem` (
  `idviagem` INT NOT NULL AUTO_INCREMENT,
  `viag_origem` VARCHAR(45) NOT NULL,
  `viag_destino` VARCHAR(45) NOT NULL,
  `viag_dtViagem` DATE NOT NULL,
  `viag_hrSaida` TIME NOT NULL,
  `viag_hrChegada` TIME NOT NULL,
  `viag_passageiroAtras` INT NOT NULL,
  `viag_maxPassageiro` INT NOT NULL,
  `viag_aprovReserva` TINYINT(1) NOT NULL,
  `viag_vlrCarona` DECIMAL(8,2) NOT NULL,
  `viag_infoAdicional` VARCHAR(300) NOT NULL,
  `viag_carroModelo` VARCHAR(50) NOT NULL,
  `viag_carroCor` VARCHAR(45) NOT NULL,
  `viag_carroPlaca` VARCHAR(45) NOT NULL,
  `avaliacao_idavaliacao` INT NOT NULL,
  PRIMARY KEY (`idviagem`),
  INDEX `fk_viagem_avaliacao1_idx` (`avaliacao_idavaliacao` ASC) VISIBLE,
  CONSTRAINT `fk_viagem_avaliacao1`
    FOREIGN KEY (`avaliacao_idavaliacao`)
    REFERENCES `mydb`.`avaliacao` (`idavaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario_has_viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario_has_viagem` (
  `usuario_idusuario` INT NOT NULL,
  `viagem_idviagem` INT NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `viagem_idviagem`),
  INDEX `fk_usuario_has_viagem_viagem1_idx` (`viagem_idviagem` ASC) VISIBLE,
  INDEX `fk_usuario_has_viagem_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_viagem_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_viagem_viagem1`
    FOREIGN KEY (`viagem_idviagem`)
    REFERENCES `mydb`.`viagem` (`idviagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacao_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`avaliacao_has_usuario` (
  `avaliacao_idavaliacao` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`avaliacao_idavaliacao`, `usuario_idusuario`),
  INDEX `fk_avaliacao_has_usuario_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_avaliacao_has_usuario_avaliacao1_idx` (`avaliacao_idavaliacao` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_has_usuario_avaliacao1`
    FOREIGN KEY (`avaliacao_idavaliacao`)
    REFERENCES `mydb`.`avaliacao` (`idavaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_has_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
