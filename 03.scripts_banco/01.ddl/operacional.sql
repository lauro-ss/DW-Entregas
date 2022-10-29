-- Scripts ddl para o ambiente operacional

use bd_rede_postos

DROP TABLE IF EXISTS TB_VENDA
DROP TABLE IF EXISTS TB_LOJA_FUNCIONARIO
DROP TABLE IF EXISTS TB_LOJA
DROP TABLE IF EXISTS TB_FUNCIONARIO
DROP TABLE IF EXISTS TB_CARGO
DROP TABLE IF EXISTS TB_PRODUTO
DROP TABLE IF EXISTS TB_SUBCATEGORIA
DROP TABLE IF EXISTS TB_CATEGORIA
DROP TABLE IF EXISTS TB_CIDADE
DROP TABLE IF EXISTS TB_ESTADO
DROP TABLE IF EXISTS TB_TIPO_PAGAMENTO

CREATE TABLE TB_CATEGORIA (
   COD_CATEGORIA INT NOT NULL PRIMARY KEY,
   CATEGORIA VARCHAR(100) NOT NULL
)

INSERT INTO TB_CATEGORIA (COD_CATEGORIA,CATEGORIA) 
VALUES (1,'COMBUSTÍVEL')
INSERT INTO TB_CATEGORIA (COD_CATEGORIA,CATEGORIA) 
VALUES (2,'LUBRIFICANTE')

CREATE TABLE TB_SUBCATEGORIA (
	COD_SUBCATEGORIA INT NOT NULL PRIMARY KEY,
	SUBCATEGORIA VARCHAR(100) NOT NULL,
	COD_CATEGORIA INT NOT NULL REFERENCES TB_CATEGORIA
)

INSERT INTO TB_SUBCATEGORIA (COD_SUBCATEGORIA, SUBCATEGORIA, COD_CATEGORIA)
VALUES (1, 'GASOLINA', 1)
INSERT INTO TB_SUBCATEGORIA (COD_SUBCATEGORIA, SUBCATEGORIA, COD_CATEGORIA)
VALUES (2, 'ETANOL', 1)
INSERT INTO TB_SUBCATEGORIA (COD_SUBCATEGORIA, SUBCATEGORIA, COD_CATEGORIA)
VALUES (3, 'DIESEL', 1)
INSERT INTO TB_SUBCATEGORIA (COD_SUBCATEGORIA, SUBCATEGORIA, COD_CATEGORIA)
VALUES (4, 'LUBRIFICANTE SINTÉTICO', 2)
INSERT INTO TB_SUBCATEGORIA (COD_SUBCATEGORIA, SUBCATEGORIA, COD_CATEGORIA)
VALUES (5, 'LUBRIFICANTE SEMISSINTÉTICO', 2)

CREATE TABLE TB_PRODUTO (
   COD_PRODUTO INT NOT NULL PRIMARY KEY,
   PRODUTO VARCHAR(100) NOT NULL,
   COD_SUBCATEGORIA INT NOT NULL REFERENCES TB_SUBCATEGORIA,
   VALOR NUMERIC(10,2) NOT NULL
)

INSERT INTO TB_PRODUTO (COD_PRODUTO, PRODUTO, COD_SUBCATEGORIA, VALOR)
VALUES (1, 'GASOLINA COMUM', 1, 7.33)
INSERT INTO TB_PRODUTO (COD_PRODUTO, PRODUTO, COD_SUBCATEGORIA,VALOR)
VALUES (2, 'GASOLINA ADITIVADA', 1, 7.40)
INSERT INTO TB_PRODUTO (COD_PRODUTO, PRODUTO, COD_SUBCATEGORIA, VALOR)
VALUES (3, 'ETANOL', 2, 5.69)
INSERT INTO TB_PRODUTO (COD_PRODUTO, PRODUTO, COD_SUBCATEGORIA, VALOR)
VALUES (4, 'DIESEL', 3, 6.45)
INSERT INTO TB_PRODUTO (COD_PRODUTO, PRODUTO, COD_SUBCATEGORIA, VALOR)
VALUES (5, '5W 30', 4, 48.00)
INSERT INTO TB_PRODUTO (COD_PRODUTO, PRODUTO, COD_SUBCATEGORIA, VALOR)
VALUES (6, '5W 40', 4, 36.00)


CREATE TABLE TB_ESTADO (
	COD_ESTADO INT NOT NULL PRIMARY KEY,
	ESTADO VARCHAR(100) NOT NULL,
	SIGLA VARCHAR(2) NOT NULL
)

INSERT INTO TB_ESTADO VALUES (01, 'ALAGOAS', 'AL')
INSERT INTO TB_ESTADO VALUES (02, 'BAHIA', 'BA')
INSERT INTO TB_ESTADO VALUES (03, 'CEARA', 'CE')
INSERT INTO TB_ESTADO VALUES (04, 'MARANHAO', 'MA')
INSERT INTO TB_ESTADO VALUES (05, 'PARAIBA', 'PB')
INSERT INTO TB_ESTADO VALUES (06, 'PERNAMBUCO', 'PE')
INSERT INTO TB_ESTADO VALUES (07, 'PIAUI', 'PI')
INSERT INTO TB_ESTADO VALUES (08, 'RIO GRANDE DO NORTE', 'RN')
INSERT INTO TB_ESTADO VALUES (09, 'SERGIPE', 'SE')

CREATE TABLE TB_CIDADE (
	COD_CIDADE INT NOT NULL PRIMARY KEY,
	CIDADE VARCHAR(100) NOT NULL,
	COD_ESTADO INT NOT NULL
	CONSTRAINT FK_ESTADO FOREIGN KEY (COD_ESTADO) REFERENCES TB_ESTADO (COD_ESTADO)
)

INSERT INTO TB_CIDADE VALUES (0001, 'MACEIO', 01)
INSERT INTO TB_CIDADE VALUES (0002, 'SALVADOR', 02)
INSERT INTO TB_CIDADE VALUES (0003, 'FORTALEZA', 03)
INSERT INTO TB_CIDADE VALUES (0004, 'SAO LUIS', 04)
INSERT INTO TB_CIDADE VALUES (0005, 'JOAO PESSOA', 05)
INSERT INTO TB_CIDADE VALUES (0006, 'RECIFE', 06)
INSERT INTO TB_CIDADE VALUES (0007, 'TERESINA', 07)
INSERT INTO TB_CIDADE VALUES (0008, 'NATAL', 08)
INSERT INTO TB_CIDADE VALUES (0009, 'ARACAJU', 09)

CREATE TABLE TB_CARGO (
    COD_CARGO INT NOT NULL PRIMARY KEY,
	NM_CARGO VARCHAR(100) NOT NULL
)

INSERT INTO TB_CARGO VALUES (01, 'FRENTISTA')
INSERT INTO TB_CARGO VALUES (02, 'GERENTE')

CREATE TABLE TB_FUNCIONARIO (
    COD_FUNCIONARIO INT NOT NULL PRIMARY KEY,
	NM_FUNCIONARIO VARCHAR(100) NOT NULL,
	CPF VARCHAR(15) NOT NULL,
	TELEFONE VARCHAR(15) NOT NULL,
	COD_CARGO INT NOT NULL,
	CONSTRAINT FK_CARGO FOREIGN KEY (COD_CARGO) REFERENCES TB_CARGO (COD_CARGO)
)

INSERT INTO TB_FUNCIONARIO
VALUES (001, 'JOSÉ AGUSTO','825.522.361-46', '(79)96848-7766',01)
INSERT INTO TB_FUNCIONARIO
VALUES (002, 'MARIO JOSÉ','949.463.731-36', '(79)97885-7649',01)
INSERT INTO TB_FUNCIONARIO
VALUES (003, 'CARLOS NASCIMENTO','265.940.319-88', '(79)98756-2353',01)
INSERT INTO TB_FUNCIONARIO
VALUES (004, 'PATRICIA ROBERTA','884.227.228-01', '(79)95696-2785',02)

INSERT INTO TB_FUNCIONARIO
VALUES (005, 'JOSEFA SANTOS','856.777.871-91', '(71)97848-5566',01)
INSERT INTO TB_FUNCIONARIO
VALUES (006, 'MANUEL SILVA','556.958.037-99', '(71)98502-8469',01)
INSERT INTO TB_FUNCIONARIO
VALUES (007, 'CARLA SANTOS','443.784.426-20', '(71)98695-3944',01)
INSERT INTO TB_FUNCIONARIO
VALUES (008, 'JOAO RICARDO','509.563.728-64', '(71)90827-9585',02)

INSERT INTO TB_FUNCIONARIO
VALUES (009, 'ALECIO DOS SANTOS','763.226.821-99', '(82)99475-1929',01)
INSERT INTO TB_FUNCIONARIO
VALUES (010, 'JOAQUIM SILVEIRA','600.608.378-70', '(82)98537-9473',01)
INSERT INTO TB_FUNCIONARIO
VALUES (011, 'RAFAELA ANDRADE','156.298.695-31', '(82)90848-9384',01)
INSERT INTO TB_FUNCIONARIO
VALUES (012, 'SILVANIO NASCIMENTO','254.755.535-21', '(82)90404-0438',02)
       
	   		 	  
CREATE TABLE TB_LOJA (
	COD_LOJA INT NOT NULL PRIMARY KEY,
	NM_LOJA VARCHAR(100) NOT NULL,
	COD_CIDADE INT NOT NULL,
	COD_GERENTE INT NOT NULL,
	CONSTRAINT FK_CIDADE FOREIGN KEY (COD_CIDADE) REFERENCES TB_CIDADE (COD_CIDADE),
	CONSTRAINT FK_GERENTE FOREIGN KEY (COD_GERENTE) REFERENCES TB_FUNCIONARIO (COD_FUNCIONARIO)
)

INSERT INTO TB_LOJA VALUES (001, 'SHELL', 0009, 004)
INSERT INTO TB_LOJA VALUES (002, 'PETROX',0002, 008)
INSERT INTO TB_LOJA VALUES (003, 'BR', 0001, 012)


CREATE TABLE TB_LOJA_FUNCIONARIO (
	COD_LOJA INT NOT NULL,
	COD_FUNCIONARIO INT NOT NULL,
	PRIMARY KEY (COD_LOJA, COD_FUNCIONARIO),
	CONSTRAINT FK_LOJA_FUNC_LOJA FOREIGN KEY (COD_LOJA) REFERENCES TB_LOJA (COD_LOJA),
	CONSTRAINT FK_LOJA_FUNC_FUNC FOREIGN KEY (COD_FUNCIONARIO) REFERENCES TB_FUNCIONARIO (COD_FUNCIONARIO)
)

INSERT INTO TB_LOJA_FUNCIONARIO VALUES (001,1)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (001,2)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (001,3)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (001,4)

INSERT INTO TB_LOJA_FUNCIONARIO VALUES (002,5)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (002,6)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (002,7)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (002,8)


INSERT INTO TB_LOJA_FUNCIONARIO VALUES (003,9)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (003,10)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (003,11)
INSERT INTO TB_LOJA_FUNCIONARIO VALUES (003,12)


CREATE TABLE TB_TIPO_PAGAMENTO (
	COD_TIPO_PAGAMENTO INT NOT NULL PRIMARY KEY,
	TIPO_PAGAMENTO VARCHAR(100) NOT NULL
)

INSERT INTO TB_TIPO_PAGAMENTO VALUES (01, 'A VISTA')
INSERT INTO TB_TIPO_PAGAMENTO VALUES (02, 'CARTAO')
INSERT INTO TB_TIPO_PAGAMENTO VALUES (03, 'VIA PIX')

CREATE TABLE TB_VENDA (
	COD_VENDA BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_LOJA INT NOT NULL,
	COD_FUNCIONARIO INT NOT NULL,
	COD_PRODUTO INT NOT NULL,
	COD_TIPO_PAGAMENTO INT NOT NULL,
	DATA_VENDA DATETIME NOT NULL,
	VOLUME NUMERIC(10,2),
	VALOR NUMERIC(10,2),
	CONSTRAINT FK_LOJA FOREIGN KEY (COD_LOJA) REFERENCES TB_LOJA (COD_LOJA),
	CONSTRAINT FK_FUNCIONARIO FOREIGN KEY (COD_FUNCIONARIO) REFERENCES TB_FUNCIONARIO(COD_FUNCIONARIO),
	CONSTRAINT FK_PRODUTO FOREIGN KEY (COD_PRODUTO) REFERENCES TB_PRODUTO (COD_PRODUTO),
	CONSTRAINT FK_TIPO_PAGAMENTO FOREIGN KEY (COD_TIPO_PAGAMENTO) REFERENCES TB_TIPO_PAGAMENTO (COD_TIPO_PAGAMENTO)
)

CREATE INDEX IX_VENDA_LOJA ON TB_VENDA (COD_LOJA)
CREATE INDEX IX_PRODUTO_LOJA ON TB_VENDA (COD_PRODUTO)
CREATE INDEX IX_TIPO_PAGAMENTO ON TB_VENDA (COD_TIPO_PAGAMENTO)
CREATE INDEX IX_DATA_VENDA ON TB_VENDA (DATA_VENDA)





                          