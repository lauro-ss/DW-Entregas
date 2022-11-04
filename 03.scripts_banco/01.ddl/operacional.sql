-- Scripts ddl para o ambiente operacional

USE bd_rede_entregas

DROP TABLE IF EXISTS Entrega
DROP TABLE IF EXISTS Endereco
DROP TABLE IF EXISTS Bairro
DROP TABLE IF EXISTS Cidade
DROP TABLE IF EXISTS Estado
DROP TABLE IF EXISTS Regiao
DROP TABLE IF EXISTS Modalidade
DROP TABLE IF EXISTS Transportadora
DROP TABLE IF EXISTS Status

CREATE TABLE Transportadora (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	transportadora VARCHAR(45) NOT NULL,
	CNPJ CHAR(20) NOT NULL
)

CREATE TABLE Modalidade (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	modalidade VARCHAR(30) NOT NULL,
	idTransportadora INT NOT NULL

	CONSTRAINT FK_idTransportadora FOREIGN KEY (idTransportadora) REFERENCES Transportadora (id)
)

CREATE TABLE Status (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	status VARCHAR(16) NOT NULL CHECK(status IN ('Entregue','Em transporte','Extraviado','Em processamento','Devolvido'))
)

INSERT INTO Status (status) VALUES('Entregue')
INSERT INTO Status (status) VALUES('Em transporte')
INSERT INTO Status (status) VALUES('Extraviado')
INSERT INTO Status (status) VALUES('Em processamento')
INSERT INTO Status (status) VALUES('Devolvido')

CREATE TABLE Regiao (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	regiao CHAR(12) NOT NULL
)

CREATE TABLE Estado (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	estado VARCHAR(45) NOT NULL,
	UF CHAR(2) NOT NULl,
	idRegiao INT NOT NULL

	CONSTRAINT FK_idRegiao FOREIGN KEY (idRegiao) REFERENCES Regiao (id)
)

CREATE TABLE Cidade (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cidade VARCHAR(50) NOT NULL,
	idEstado INT NOT NULL

	CONSTRAINT FK_idEstado FOREIGN KEY (idEstado) REFERENCES Estado (id)
)

CREATE TABLE Bairro (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	bairro VARCHAR(50) NOT NULL,
	idCidade INT NOT NULL

	CONSTRAINT FK_idCidade FOREIGN KEY (idCidade) REFERENCES Cidade (id)
)

CREATE TABLE Endereco (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	rua VARCHAR(75) NOT NULL,
	numero CHAR(5) NOT NULL,
	CEP CHAR(9) NOT NULL,
	complemento VARCHAR(100) NULL,
	idBairro INT NOT NULL

	CONSTRAINT FK_idBairro FOREIGN KEY (idBairro) REFERENCES Bairro (id)
)

CREATE TABLE Entrega (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	diasEstimados INT NOT NULL,
	diasNecessarios INT NOT NULL,
	dataSaida DATETIME NOT NULL,
	dataEntrega DATETIME NOT NULL,
	foraDoPrazo CHAR(3) NOT NULL CHECK(foraDoPrazo IN ('SIM','NAO')),
	frete NUMERIC(10,2) NOT NULL,
	idOrigem INT NOT NULL,
	idDestino INT NOT NULL,
	idStatus INT NOT NULL,
	idModalidade INT NOT NULL,

	CONSTRAINT FK_idOrigem FOREIGN KEY (idOrigem) REFERENCES Endereco (id),
	CONSTRAINT FK_idDestino FOREIGN KEY (idDestino) REFERENCES Endereco (id),
	CONSTRAINT FK_idStatus FOREIGN KEY (idStatus) REFERENCES Status (id),
	CONSTRAINT FK_idModalidade FOREIGN KEY (idModalidade) REFERENCES Modalidade (id)
)

CREATE INDEX IX_Entrega_Origem ON Entrega (idOrigem)
CREATE INDEX IX_Entrega_Destino ON Entrega (idDestino)
CREATE INDEX IX_Entrega_Status ON Entrega (idStatus)
CREATE INDEX IX_Entrega_Modalidade ON Entrega (idModalidade)





                          