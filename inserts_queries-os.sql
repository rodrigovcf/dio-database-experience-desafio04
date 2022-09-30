-- Inserindo Clientes
INSERT INTO Cliente (Nome, Endereco, Telefone) 
	VALUES ('Maria', 'Rua Silva da prata 29, Sto Antonio - Mossoro','84999900123'), 
		   ('Pedro', 'Rua Sao Jose 139, Centro - Mossoro', '84999902310'),
           ('Jose', 'Rua do Prado 23, Liberdade - Mossoro', '84999904321'),
           ('Rosa', 'Rua Augusto dos Anjos 45, Jatoba - Patos', '84999904567'),
           ('Isabela', 'Rua Alberto Maranhao 27, Maternidade - Patos', '84999908975'),
           ('Rafael', 'Rua Antonio Vieira 234, Sto Antonio - Patos', '84999904455');
           

SELECT * FROM Cliente;

-- Inserindo Veiculos
INSERT INTO Veiculo (Modelo,Marca,Ano,Problema,Cliente_idCliente) 
	VALUES  ('S10','CHEVROLET',2020,'Nao da partida', 1),
			('Duster','RENAUL',2022,'Suspensao Batendo', 2),
			('Duster','RENAUL',2020,'Bateria descarregando', 3),
			('Uno','FIAT',2008,'Carburador vazando', 4),
			('Civic','HONDA',2021,'Nao da partida', 5),
			('HB20','HYUNDAI',2020,'Carburador vazando', 6);

SELECT * FROM Veiculo;

-- Inserindo Mecanico
INSERT INTO Mecanico (Codigo, Nome, Endereco) 
	VALUES (10,'Mario Frade', 'Rua Antonio Vieira 234, Sto Antonio'), 
		   (20,'Juliano Pereira', 'Rua Junior Silva 123, Centro'),
           (30,'Alexandre', 'Rua do Prado 45, Centro'),
		   (40,'Ricardo Silva', 'Rua Nabuco 67, Abolicao I'),
           (50,'Monica Cavalcante', 'Rua do Meio 87, Abolicao I'),
           (60,'Mariana Duarte', 'Rua Jatoba 98, Abolicao II'),
           (70,'Henrique Miller', 'Rua Presidente Dutra 123, Sto Antonio');
           
SELECT * FROM Mecanico;

-- Inserindo Especialidades
INSERT INTO Especialidades (Especialidade, Mecanico_idMecanico) 
	VALUES ('Motor', 1), 
		   ('Carburador', 2),
           ('Eletrica', 3),
		   ('Suspensao', 4),
           ('Suspensao', 5),
           ('Carburador', 6),
           ('Carburador', 7);
           
SELECT * FROM Especialidades;

-- Inserindo Ordem_Servicos
INSERT INTO Ordem_Servicos(Numero,DataEmissao,DataConclusao,Total,Autorizacao,StatusOS,Cliente_idCliente)
	VALUES  (111,DATE '2022-09-17',NULL, 0, 0, NULL, 1),
			(112,DATE '2022-09-17',NULL, 0, 0, NULL, 2),
            (211,DATE '2022-09-19',NULL, 0, 0, NULL, 3),
            (212,DATE '2022-09-19',NULL, 0, 0, NULL, 4),
            (311,DATE '2022-09-20',NULL, 0, 0, NULL, 5),
            (411,DATE '2022-09-21',NULL, 0, 0, NULL, 6);
            
SELECT * FROM Ordem_Servicos;
            
-- Vinculando Pecas, Servicos e Equipe as Ordens de Servico
INSERT INTO Pecas (REF,Descricao,Valor,Ordem_Servicos_idOrdem_Servicos)
	VALUES  ('MOT2022', 'Pecas do Motor da Marca TALTAL', 800, 1),
			('MOT2022', 'Pecas do Motor da Marca TALTAL', 800, 5),
			('CARB2022', 'Carburador da Marca TALTAL', 150, 4),
			-- ('PARA2022', 'Parafusos da Marca TALTAL', 10, 4),
            ('CARB2022', 'Carburador da Marca TALTAL', 150, 6),
            ('AMORT2022', 'Amortecedores da Marca TALTAL', 500, 2),
            ('BAT2022', 'Bateria da Marca TALTAL', 350, 3);
            
SELECT * FROM Pecas;
            
INSERT INTO Servicos (Descricao,Valor,Ordem_Servicos_idOrdem_Servicos)
	VALUES  ('Reparo do Motor', 300, 1),
			('Reparo do Motor', 300, 5),
			('Substituicao do Carburador', 200, 4),			
            ('Substituicao do Carburador', 200, 6),
            ('Substituicao dos Amortecedores', 150, 2),
            ('Substituicao da Bateria', 80, 3);
            
SELECT * FROM Servicos;

INSERT INTO Equipe (TipoEquipe,Veiculo_idVeiculo,Veiculo_Cliente_idCliente,Mecanico_idMecanico,Ordem_idOrdem_Servicos)
	VALUES ('Especializada Terceirizada', 1, 1, 1,1),
			('Especializada Terceirizada', 2, 2, 2,2),
            ('Interna', 3, 3, 3,3),
            ('Interna', 4, 4, 4,4),
            ('Interna', 5, 5, 5,5),
            ('Interna', 6, 6, 6,6);

 SELECT * FROM Equipe;
 

-- Atualizando as Ordens de Servico

-- Autorizando Servicos
UPDATE Ordem_Servicos
SET
  Autorizacao = 1,
  StatusOS = 'Iniciada'
WHERE
  idOrdem_Servicos = 2;

-- Autorizando Todos os Servicos de uma so vez
UPDATE Ordem_Servicos
SET
  Autorizacao = 1,
  StatusOS = 'Iniciada'
WHERE
  Autorizacao = 0;

SELECT * FROM Ordem_Servicos;

-- Atualizando OS 1 totalizando Pecas e Servicos e mudando StatusOS para Concluida
UPDATE Ordem_Servicos
SET
  Total = (SELECT Valor FROM Pecas WHERE Ordem_Servicos_idOrdem_Servicos = 1) + (SELECT Valor FROM Servicos WHERE Ordem_Servicos_idOrdem_Servicos = 1),
  DataConclusao = DATE '2022-09-19',
  StatusOS = 'Concluida'
WHERE
  idOrdem_Servicos = 1;

SELECT * FROM Ordem_Servicos;

-- Atualizando OS 2 totalizando Pecas e Servicos e mudando StatusOS para Concluida
UPDATE Ordem_Servicos
SET
  Total = (SELECT Valor FROM Pecas WHERE Ordem_Servicos_idOrdem_Servicos = 2) + (SELECT Valor FROM Servicos WHERE Ordem_Servicos_idOrdem_Servicos = 2),
  DataConclusao = DATE '2022-09-19',
  StatusOS = 'Concluida'
WHERE
  idOrdem_Servicos = 2;

SELECT * FROM Ordem_Servicos;

-- Atualizando OS 3 totalizando Pecas e Servicos e mudando StatusOS para Concluida
UPDATE Ordem_Servicos
SET
  Total = (SELECT Valor FROM Pecas WHERE Ordem_Servicos_idOrdem_Servicos = 3) + (SELECT Valor FROM Servicos WHERE Ordem_Servicos_idOrdem_Servicos = 3),
  DataConclusao = DATE '2022-09-22',
  StatusOS = 'Concluida'
WHERE
  idOrdem_Servicos = 3;

SELECT * FROM Ordem_Servicos;

-- Atualizando OS 4 totalizando Pecas e Servicos e mudando StatusOS para Concluida
UPDATE Ordem_Servicos
SET
  Total = (SELECT Valor FROM Pecas WHERE Ordem_Servicos_idOrdem_Servicos = 4) + (SELECT Valor FROM Servicos WHERE Ordem_Servicos_idOrdem_Servicos = 4),
  DataConclusao = DATE '2022-09-24',
  StatusOS = 'Concluida'
WHERE
  idOrdem_Servicos = 4;

SELECT * FROM Ordem_Servicos;

-- Atualizando OS 5 totalizando Pecas e Servicos e mudando StatusOS para Concluida
UPDATE Ordem_Servicos
SET
  Total = (SELECT Valor FROM Pecas WHERE Ordem_Servicos_idOrdem_Servicos = 5) + (SELECT Valor FROM Servicos WHERE Ordem_Servicos_idOrdem_Servicos = 5),
  DataConclusao = DATE '2022-09-25',
  StatusOS = 'Concluida'
WHERE
  idOrdem_Servicos = 5;

SELECT * FROM Ordem_Servicos;

-- Atualizando OS 6 totalizando Pecas e Servicos e mudando StatusOS para Concluida
UPDATE Ordem_Servicos
SET
  Total = (SELECT Valor FROM Pecas WHERE Ordem_Servicos_idOrdem_Servicos = 6) + (SELECT Valor FROM Servicos WHERE Ordem_Servicos_idOrdem_Servicos = 6),
  DataConclusao = DATE '2022-09-27',
  StatusOS = 'Concluida'
WHERE
  idOrdem_Servicos = 6;

SELECT * FROM Ordem_Servicos;


-- Algumas consultas
 SELECT count(*) FROM Ordem_Servicos;
 SELECT * FROM Cliente c, Ordem_Servicos o WHERE c.idCliente = o.Cliente_idCliente;
 SELECT Nome,Endereco,idOrdem_Servicos FROM Cliente c, Ordem_Servicos o WHERE c.idCliente = idOrdem_Servicos;
 SELECT concat(Marca,' ',Modelo,' ', Ano) FROM Veiculo WHERE Cliente_idCliente = 2;
 SELECT Nome, concat(Marca,' ',Modelo,' ', Ano) AS Veiculo, Problema FROM Cliente c, Veiculo v WHERE c.idCliente = v.Cliente_idCliente;  	
 
 SELECT * FROM Cliente c, Ordem_Servicos o 
	WHERE c.idCliente = o.Cliente_idCliente
    ORDER BY c.Nome;
     
 SELECT * FROM Pecas p, Servicos s 
 	WHERE p.idPecas = s.idServicos
     ORDER BY p.Descricao;
 
 SELECT * FROM Cliente INNER JOIN Ordem_Servicos ON  
 		idCliente = Cliente_idCliente;
 
 SELECT * FROM Cliente c INNER JOIN Veiculo v INNER JOIN Ordem_Servicos o WHERE  
 		c.idCliente = 6 AND v.Cliente_idCliente = 6 AND o.Cliente_idCliente = 6;
        
 SELECT * FROM Ordem_Servicos WHERE DataEmissao > DATE '2022-09-19';
 
 SELECT TipoEquipe, StatusOS FROM Equipe e, Ordem_Servicos o WHERE o.Numero = 111;