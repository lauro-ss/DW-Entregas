-- Scripts ddl para o ambiente dimensional

USE bd_rede_entregas

DROP TABLE IF EXISTS Fato_Entrega
DROP TABLE IF EXISTS Dim_Status
DROP TABLE IF EXISTS Dim_Modalidade
DROP TABLE IF EXISTS Dim_Transportadora
DROP TABLE IF EXISTS Dim_Regiao
DROP TABLE IF EXISTS Dim_Estado
DROP TABLE IF EXISTS Dim_Cidade
DROP TABLE IF EXISTS Dim_Bairro
DROP TABLE IF EXISTS Dim_Tempo

CREATE TABLE Dim_Status (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_status INT NOT NULL,
	status VARCHAR(15) NOT NULL CHECK(status IN ('Entregue','Em transporte','Extraviado','Em processamento','Devolvido'))
)
CREATE INDEX IX_Dim_Status ON Dim_Status(cod_status)

CREATE TABLE Dim_Modalidade (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_modalidade INT NOT NULL,
	modalidade VARCHAR(45) NOT NULL,
	cod_transportadora INT NOT NULL
)
CREATE INDEX IX_Dim_Modalidade ON Dim_Modalidade(cod_modalidade)

CREATE TABLE Dim_Transportadora (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_transportadora INT NOT NULL,
	transportadora VARCHAR(45) NOT NULL,
	CNPJ CHAR(20) NOT NULL
)
CREATE INDEX IX_Dim_Transportadora ON Dim_Transportadora(cod_transportadora)

CREATE TABLE Dim_Regiao (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_regiao INT NOT NULL,
	regiao CHAR(12) NOT NULL
)
CREATE INDEX IX_Dim_Regiao ON Dim_Regiao(cod_regiao)

CREATE TABLE Dim_Estado (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_estado INT NOT NULL,
	estado VARCHAR(45) NOT NULL,
	UF CHAR(2) NOT NULl,
	cod_regiao INT NOT NULL
)
CREATE INDEX IX_Dim_Estado ON Dim_Estado(cod_estado)

CREATE TABLE Dim_Cidade (
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_cidade INT NOT NULL,
	cidade VARCHAR(50) NOT NULL,
	cod_estado INT NOT NULL
)
CREATE INDEX IX_Dim_Cidade ON Dim_Cidade(cod_cidade)

CREATE TABLE Dim_Bairro(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_bairro INT NOT NULL,
	bairro VARCHAR(50) NOT NULL,
	cod_cidade INT NOT NULL
)
CREATE INDEX IX_Dim_Bairro_cod ON Dim_Bairro(cod_bairro)
CREATE INDEX IX_Dim_Bairro_bairro ON Dim_Bairro(bairro)

CREATE TABLE Dim_Tempo (
	id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nivel CHAR(3) NOT NULL CHECK(nivel IN ('DIA','MES','ANO')),
	data DATETIME NULL,
	dia INT NULL,
	nome_dia VARCHAR(20) NULL,
	fim_semana CHAR(3) NULL CHECK(fim_semana IN ('SIM','NAO')),
	mes INT  NULL,
	nome_mes VARCHAR(15)  NULL,
	trimestre INT  NULL,
	nome_trimestre VARCHAR(45)  NULL,
	semestre INT  NULL,
	nome_semestre VARCHAR(45)  NULL,
	ano INT NOT NULL
)
CREATE INDEX IX_Dim_Tempo ON Dim_Tempo(data)
CREATE INDEX IX_Dim_Tempo_mes ON DIM_TEMPO (nivel, mes)
CREATE INDEX IX_Dim_Tempo_ano ON DIM_TEMPO (nivel, ano)

CREATE TABLE Fato_Entrega (
	id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	data_saida BIGINT NOT NULL,
	data_entrega BIGINT NULL,
	regiao INT NOT NULL,
	estado INT NOT NULL,
	cidade INT NOT NULL,
	bairro INT NOT NULL,
	status INT NOT NULL,
	modalidade INT NOT NULL,
	transportadora INT NOT NULL,
	frete NUMERIC(10,2),
	diasEstimados INT NOT NULL,
	diasNecessarios INT NOT NULL,
	cod_entrega BIGINT NOT NULL,
	quantidade INT NOT NULL DEFAULT (1),
	foraDoPrazo CHAR(3) NOT NULL CHECK(foraDoPrazo IN ('SIM','NAO'))

	CONSTRAINT FK_Dim_Status FOREIGN KEY (status) REFERENCES Dim_Status (id),
	CONSTRAINT FK_Dim_Modalidade FOREIGN KEY (modalidade) REFERENCES Dim_Modalidade(id),
	CONSTRAINT FK_Dim_Transportadora FOREIGN KEY (transportadora) REFERENCES Dim_Transportadora (id),
	CONSTRAINT FK_Dim_Regiao FOREIGN KEY (regiao) REFERENCES Dim_Regiao (id),
	CONSTRAINT FK_Dim_Estado FOREIGN KEY (estado) REFERENCES Dim_Estado (id),
	CONSTRAINT FK_Dim_Cidade FOREIGN KEY (cidade) REFERENCES Dim_Cidade (id),
	CONSTRAINT FK_Dim_Bairro FOREIGN KEY (bairro) REFERENCES Dim_Bairro (id),
	CONSTRAINT FK_data_saida FOREIGN KEY (data_saida) REFERENCES Dim_Tempo (id),
	CONSTRAINT FK_data_entrega FOREIGN KEY (data_entrega) REFERENCES Dim_Tempo (id)
)

CREATE INDEX IX_FATO_data_saida ON Fato_Entrega(data_saida)
CREATE INDEX IX_FATO_data_entrega ON Fato_Entrega(data_entrega)
CREATE INDEX IX_FATO_regiao ON Fato_Entrega(regiao)
CREATE INDEX IX_FATO_estado ON Fato_Entrega(estado)
CREATE INDEX IX_FATO_cidade ON Fato_Entrega(cidade)
CREATE INDEX IX_FATO_bairro ON Fato_Entrega(bairro)
CREATE INDEX IX_FATO_status ON Fato_Entrega(status)
CREATE INDEX IX_FATO_modalidade ON Fato_Entrega(modalidade)
CREATE INDEX IX_FATO_transportadora ON Fato_Entrega(transportadora)


