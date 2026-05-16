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
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Identificação` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos` (
  `idPedidos` INT NOT NULL,
  `Status do pedido` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Frete` FLOAT NULL,
  `Pagamentos_idPagamentos` INT NOT NULL,
  PRIMARY KEY (`idPedidos`, `Pagamentos_idPagamentos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos` (
  `idProdutos` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Valor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProdutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibilizando um produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disponibilizando um produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produtos_idProdutos`),
  INDEX `fk_Fornecedor_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produtos_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produtos_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos_has_Estoque` (
  `Produtos_idProdutos` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produtos_idProdutos`, `Estoque_idEstoque`),
  INDEX `fk_Produtos_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Estoque_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_has_Estoque_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relação de produto/pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relação de produto/pedido` (
  `Produtos_idProdutos` INT NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produtos_idProdutos`, `Pedidos_idPedidos`),
  INDEX `fk_Produtos_has_Pedidos_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Pedidos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_has_Pedidos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_has_Pedidos_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `mydb`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceiro - Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terceiro - Vendedor` (
  `idTerceiro - Vendedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro - Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos por vendedor (terceiro)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos por vendedor (terceiro)` (
  `Terceiro - Vendedor_idTerceiro - Vendedor` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`, `Produtos_idProdutos`),
  INDEX `fk_Terceiro - Vendedor_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Terceiro - Vendedor_has_Produtos_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro - Vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produtos_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`)
    REFERENCES `mydb`.`Terceiro - Vendedor` (`idTerceiro - Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa fisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa fisica` (
  `idPessoa fisica` INT NOT NULL,
  `CPF` VARCHAR(45) NULL,
  `Nome` VARCHAR(45) NULL,
  `Data de nascimento` DATE NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPessoa fisica`, `Cliente_idCliente`),
  INDEX `fk_Pessoa fisica_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa fisica_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa Juridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa Juridica` (
  `idPessoa Juridica` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPessoa Juridica`, `Cliente_idCliente`),
  INDEX `fk_Pessoa Juridica_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa Juridica_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamentos` (
  `idPagamentos` INT NOT NULL,
  `Tipos de pagamentos` ENUM('Cartão Crédito', 'Cartão Débito', 'Boleto', 'Pix') NULL,
  `Detalhes pagamentos` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamentos`, `Cliente_idCliente`),
  INDEX `fk_Pagamentos_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Status da entrega` ENUM('Em processamento', 'Postado', 'Em trânsito', 'Entregue', 'Cancelado') NULL,
  `Codigo de rastreio` VARCHAR(45) NULL,
  `Data de Envio` DATE NULL,
  `Previsão de entrega` DATE NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  PRIMARY KEY (`idEntrega`, `Pedidos_idPedidos`),
  INDEX `fk_Entrega_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `mydb`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
