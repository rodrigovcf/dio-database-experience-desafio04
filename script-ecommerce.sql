-- Criando o Banco de dados - Ordem de Servicos
create database os;

-- Criando Tabelas

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS `os`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`)
);

-- Tabela Veiculo
CREATE TABLE IF NOT EXISTS `os`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `Modelo` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Ano` INT NULL,
  `Problema` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veiculo_Cliente_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `os`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Tabela TipoServico
CREATE TABLE IF NOT EXISTS `os`.`TipoServico` (
  `idTipoServico` INT NOT NULL AUTO_INCREMENT,
  `Tipo` ENUM('') NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Veiculo_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idTipoServico`, `Veiculo_idVeiculo`, `Veiculo_Cliente_idCliente`),
  INDEX `fk_TipoServico_Veiculo1_idx` (`Veiculo_idVeiculo` ASC, `Veiculo_Cliente_idCliente` ASC),
  CONSTRAINT `fk_TipoServico_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo` , `Veiculo_Cliente_idCliente`)
    REFERENCES `os`.`Veiculo` (`idVeiculo` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Tabela Ordem de Servicos
CREATE TABLE IF NOT EXISTS `os`.`Ordem_Servicos` (
  `idOrdem_Servicos` INT NOT NULL AUTO_INCREMENT,
  `Numero` INT NULL,
  `DataEmissao` DATE NULL,
  `DataConclusao` VARCHAR(45) NULL,
  `Total` DECIMAL(10) NULL,
  `Autorizacao` TINYINT DEFAULT 0,
  `StatusOS` ENUM('Iniciada', 'Andamento', 'Concluida', 'Aguardando Peças') DEFAULT 'Iniciada',
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Servicos`, `Cliente_idCliente`),
  UNIQUE INDEX `Numero_UNIQUE` (`Numero` ASC),
  INDEX `fk_Ordem_Servicos_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Ordem_Servicos_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `os`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Tabela Mecanico
CREATE TABLE IF NOT EXISTS `os`.`Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `Codigo` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idMecanico`),
  UNIQUE INDEX `Codigo_UNIQUE` (`Codigo` ASC)
);

-- Tabela Especialidades
CREATE TABLE IF NOT EXISTS `os`.`Especialidades` (
  `Especialidades` INT NOT NULL AUTO_INCREMENT,
  `Especialidade` VARCHAR(45) NULL,
  `Mecanico_idMecanico` INT NOT NULL,
  PRIMARY KEY (`Especialidades`, `Mecanico_idMecanico`),
  INDEX `fk_Especialidades_Mecanico1_idx` (`Mecanico_idMecanico` ASC),
  CONSTRAINT `fk_Especialidades_Mecanico1`
    FOREIGN KEY (`Mecanico_idMecanico`)
    REFERENCES `os`.`Mecanico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Tabela Equipe
CREATE TABLE IF NOT EXISTS `os`.`Equipe` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `TipoEquipe` VARCHAR(45) NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Veiculo_Cliente_idCliente` INT NOT NULL,
  `Mecanico_idMecanico` INT NOT NULL,
  `Ordem_idOrdem_Servicos` INT NOT NULL,
  PRIMARY KEY (`idEquipe`, `Veiculo_idVeiculo`, `Veiculo_Cliente_idCliente`, `Mecanico_idMecanico`, `Ordem_idOrdem_Servicos`),
  INDEX `fk_Equipe_Veiculo1_idx` (`Veiculo_idVeiculo` ASC, `Veiculo_Cliente_idCliente` ASC),
  INDEX `fk_Equipe_Mecanico1_idx` (`Mecanico_idMecanico` ASC),
  INDEX `fk_Equipe_Ordem_Servicos1_idx` (`Ordem_idOrdem_Servicos` ASC),
  CONSTRAINT `fk_Equipe_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo` , `Veiculo_Cliente_idCliente`)
    REFERENCES `os`.`Veiculo` (`idVeiculo` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Mecanico1`
    FOREIGN KEY (`Mecanico_idMecanico`)
    REFERENCES `os`.`Mecanico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Ordem_Servicos1`
    FOREIGN KEY (`Ordem_idOrdem_Servicos`)
    REFERENCES `os`.`Ordem_Servicos` (`idOrdem_Servicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Tabela Servicos
CREATE TABLE IF NOT EXISTS `os`.`Servicos` (
  `idServicos` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `Valor` DECIMAL(10) NULL,
  `Ordem_Servicos_idOrdem_Servicos` INT NOT NULL,
  PRIMARY KEY (`idServicos`, `Ordem_Servicos_idOrdem_Servicos`),
  INDEX `fk_Servicos_Ordem_de_Servicos1_idx` (`Ordem_Servicos_idOrdem_Servicos` ASC),
  CONSTRAINT `fk_Servicos_Ordem_de_Servicos1`
    FOREIGN KEY (`Ordem_Servicos_idOrdem_Servicos`)
    REFERENCES `os`.`Ordem_Servicos` (`idOrdem_Servicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Tabela Pecas
CREATE TABLE IF NOT EXISTS `os`.`Pecas` (
  `idPecas` INT NOT NULL AUTO_INCREMENT,
  `REF` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` DECIMAL(10) NULL,
  `Ordem_Servicos_idOrdem_Servicos` INT NOT NULL,
  PRIMARY KEY (`idPecas`, `Ordem_Servicos_idOrdem_Servicos`),
  INDEX `fk_Pecas_Ordem_de_Servicos1_idx` (`Ordem_Servicos_idOrdem_Servicos` ASC),
  CONSTRAINT `fk_Pecas_Ordem_de_Servicos1`
    FOREIGN KEY (`Ordem_Servicos_idOrdem_Servicos`)
    REFERENCES `os`.`Ordem_Servicos` (`idOrdem_Servicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);








