-- Scripts ddl para a área de staging

USE bd_rede_entregas

DROP TABLE IF EXISTS Aux_Entrega
DROP TABLE IF EXISTS Vio_Entrega
DROP TABLE IF EXISTS Aux_Status
DROP TABLE IF EXISTS Aux_Transportadora
DROP TABLE IF EXISTS Aux_Modalidade
DROP TABLE IF EXISTS Aux_Localidade
DROP TABLE IF EXISTS Aux_Bairro


CREATE TABLE Aux_Entrega (
	data_carga DATETIME NOT NULL,
	cod_entrega BIGINT NOT NULL,
	diasEstimados INT NOT NULL,
	diasNecessarios INT NULL,
	dataSaida DATETIME NOT NULL,
	dataEntrega DATETIME NULL,
	foraDoPrazo CHAR(3) NULL CHECK(foraDoPrazo IN ('SIM','NAO')),
	frete NUMERIC(10,2) NOT NULL,
	cod_origem INT NOT NULL,
	cod_destino INT NOT NULL,
	cod_status INT NOT NULL,
	cod_modalidade INT NOT NULL,
)

CREATE INDEX IX_Aux_Entrega ON Aux_Entrega(data_carga)

CREATE TABLE Vio_Entrega (
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	data_carga DATETIME NOT NULL,
	cod_entrega BIGINT NOT NULL,
	diasEstimados INT NOT NULL,
	diasNecessarios INT NOT NULL,
	dataSaida DATETIME NOT NULL,
	dataEntrega DATETIME NOT NULL,
	foraDoPrazo CHAR(3) NOT NULL CHECK(foraDoPrazo IN ('SIM','NAO')),
	frete NUMERIC(10,2) NOT NULL,
	cod_origem INT NOT NULL,
	cod_destino INT NOT NULL,
	cod_status INT NOT NULL,
	cod_modalidade INT NOT NULL,
	data_erro DATETIME NOT NULL,
	violacao VARCHAR(150) NOT NULL
)

CREATE INDEX IX_Vio_Entrega ON Vio_Entrega(data_carga)

CREATE TABLE Aux_Status (
	data_carga DATETIME NOT NULL,
	cod_status INT NOT NULL,
	status VARCHAR(16) NOT NULL CHECK(status IN ('Entregue','Em transporte','Extraviado','Em processamento','Devolvido'))
)

CREATE INDEX IX_Aux_Status ON Aux_Status(data_carga)

CREATE TABLE Aux_Transportadora (
	data_carga DATETIME NOT NULL,
	cod_transportadora INT NOT NULL,
	transportadora VARCHAR(45) NOT NULL,
	CNPJ CHAR(20) NOT NULL
)

CREATE INDEX IX_Aux_Transportadora ON Aux_Transportadora(data_carga)

CREATE TABLE Aux_Modalidade (
	data_carga DATETIME NOT NULL,
	cod_modalidade INT NOT NULL,
	modalidade VARCHAR(30) NOT NULL,
	cod_transportadora INT NOT NULL,
)

CREATE INDEX IX_Aux_Modalidade ON Aux_Modalidade(data_carga)

CREATE TABLE Aux_Localidade (
	data_carga DATETIME NOT NULL,
	cod_regiao INT NOT NULL,
	regiao CHAR(12) NOT NULL,
	cod_estado INT NOT NULL,
	estado VARCHAR(45) NOT NULL,
	UF CHAR(2) NOT NULL,
	cod_cidade INT NOT NULL,
	cidade VARCHAR(50) NOT NULL,
	cod_bairro INT NOT NULL,
	bairro VARCHAR(100) NOT NULL
)

CREATE INDEX IX_Aux_Localidade ON Aux_Localidade(data_carga)