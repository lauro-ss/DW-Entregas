USE bd_rede_entregas

CREATE OR ALTER FUNCTION dbo.dif_dias(@DATA_INICIO DATETIME, @DIAS INT)
RETURNS DATETIME
AS
BEGIN
	DECLARE @DATA_FIM DATETIME
	DECLARE @I INT
	SET @I = 0
	SET @DATA_FIM = @DATA_INICIO
	WHILE(@I < @DIAS)
	BEGIN
		IF(DATENAME(dw,@DATA_FIM) = 'Sábado')
		BEGIN
			SET @DATA_FIM = DATEADD(dd,2,@DATA_FIM)
		END
		IF(DATENAME(dw,@DATA_FIM) = 'Domingo')
		BEGIN
			SET @DATA_FIM = DATEADD(dd,1,@DATA_FIM)
		END
			SET @DATA_FIM = DATEADD(dd,1,@DATA_FIM)
			SET @I = @I + 1
	END
	RETURN @DATA_FIM
END


CREATE OR ALTER FUNCTION dbo.aleatorio(@RAND FLOAT, @MAIOR INT, @MENOR INT)
RETURNS INT
AS
BEGIN
    RETURN (SELECT FLOOR(@RAND*(@MAIOR-@MENOR+1)+@MENOR))
END

CREATE OR ALTER FUNCTION dbo.ex_aleatorio(@RAND FLOAT, @MAIOR INT, @MENOR INT, @EX INT)
RETURNS INT
AS
BEGIN
	DECLARE @ALE INT, @CONT INT
	SET @ALE = (SELECT FLOOR(@RAND*(@MAIOR-@MENOR+1)+@MENOR))
	SET @CONT = 0
	WHILE(@ALE = @EX)
	BEGIN
		SET @ALE = (SELECT FLOOR(@RAND*(@MAIOR-@MENOR+1)+@MENOR))
		IF(@CONT = 10)
			SET @ALE = @EX + 1
		SET @CONT = @CONT + 1
	END
    RETURN @ALE
END

CREATE OR ALTER FUNCTION dbo.calcula_frete(@DIAS INT)
RETURNS NUMERIC(10,2)
AS
BEGIN
	RETURN IIF(@DIAS >= 12, 5 * (@DIAS * 0.8), (10 * (@DIAS * 0.1))+(5 * 10))
END

-- VERIFICA A DATA PARA QUE NAO EXISTA ENTREGAS COM DATA DE ORIGEM
-- EM FINAIS DE SEMANA
CREATE OR ALTER FUNCTION dbo.verifica_data(@DATA DATETIME)
RETURNS DATETIME
AS
BEGIN
	IF(DATENAME(dw,@DATA) = 'Sábado')
	BEGIN
		SET @DATA= DATEADD(dd,2,@DATA)
	END
	IF(DATENAME(dw,@DATA) = 'Domingo')
	BEGIN
		SET @DATA = DATEADD(dd,1,@DATA)
	END

	RETURN @DATA
END

CREATE OR ALTER PROCEDURE SP_POVOAR_ENTREGAS(@DATA DATETIME)
AS
BEGIN
	set language Brazilian
	DECLARE @diasEstimados INT, @diasNecessarios INT, @dataSaida DATETIME,
	@dataEntrega DATETIME, @foraDoPrazo CHAR(3), @frete NUMERIC(10,2), @idStatus INT

	DECLARE @TOTAL_END BIGINT
	SET @TOTAL_END = (SELECT COUNT(ID) FROM Endereco)

	DECLARE @CONT_DIAS INT
	SET @CONT_DIAS = 0

	DECLARE @id_ENDERECO INT
	DECLARE C_ENDERECO CURSOR FOR SELECT ID FROM ENDERECO
	OPEN C_ENDERECO
	FETCH C_ENDERECO INTO @id_ENDERECO
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SET @idStatus = dbo.aleatorio(RAND(), 5, 1)
		-- ENTREGUE
		IF @idStatus = 1
		BEGIN
			SET @diasEstimados = dbo.aleatorio(RAND(), 15, 7)
			SET @diasNecessarios = dbo.aleatorio(RAND(), 17, 5)
			SET @dataSaida = dbo.verifica_data(@DATA)
			SET @dataEntrega = dbo.dif_dias(@dataSaida, @diasNecessarios)
			SET @foraDoPrazo = IIF(@diasNecessarios > @diasEstimados, 'SIM', 'NAO')
			SET @frete = dbo.calcula_frete(@diasEstimados)
			INSERT INTO Entrega(diasEstimados, 
							diasNecessarios, 
							dataSaida,
							dataEntrega,
							foraDoPrazo,
							frete,
							idOrigem,
							idDestino,
							idStatus,
							idModalidade)
			VALUES (@diasEstimados,
					@diasNecessarios,
					@dataSaida,
					@dataEntrega,
					@foraDoPrazo,
					@frete,
					@id_ENDERECO,
					dbo.ex_aleatorio(RAND(), @TOTAL_END, 1, @id_ENDERECO),
					@idStatus,
					dbo.aleatorio(RAND(), 8, 1))
		END
		-- EM TRANSPORTE
		IF @idStatus = 2
		BEGIN
			SET @diasEstimados = dbo.aleatorio(RAND(), 15, 7)
			SET @diasNecessarios = null
			SET @dataSaida = dbo.verifica_data(@DATA)
			SET @dataEntrega = null
			SET @foraDoPrazo = null
			SET @frete = dbo.calcula_frete(@diasEstimados)
			INSERT INTO Entrega(diasEstimados, 
							diasNecessarios, 
							dataSaida,
							dataEntrega,
							foraDoPrazo,
							frete,
							idOrigem,
							idDestino,
							idStatus,
							idModalidade)
			VALUES (@diasEstimados,
					@diasNecessarios,
					@dataSaida,
					@dataEntrega,
					@foraDoPrazo,
					@frete,
					@id_ENDERECO,
					dbo.ex_aleatorio(RAND(), @TOTAL_END, 1, @id_ENDERECO),
					@idStatus,
					dbo.aleatorio(RAND(), 8, 1))
		END
		-- EXTRAVIADO
		IF @idStatus = 3
		BEGIN
			SET @diasEstimados = dbo.aleatorio(RAND(), 15, 7)
			SET @diasNecessarios = null
			SET @dataSaida = dbo.verifica_data(@DATA)
			SET @dataEntrega = null
			SET @foraDoPrazo = null
			SET @frete = dbo.calcula_frete(@diasEstimados)
			INSERT INTO Entrega(diasEstimados, 
							diasNecessarios, 
							dataSaida,
							dataEntrega,
							foraDoPrazo,
							frete,
							idOrigem,
							idDestino,
							idStatus,
							idModalidade)
			VALUES (@diasEstimados,
					@diasNecessarios,
					@dataSaida,
					@dataEntrega,
					@foraDoPrazo,
					@frete,
					@id_ENDERECO,
					dbo.ex_aleatorio(RAND(), @TOTAL_END, 1, @id_ENDERECO),
					@idStatus,
					dbo.aleatorio(RAND(), 8, 1))
		END
		-- EM PROCESSAMENTO
		IF @idStatus = 4
		BEGIN
			SET @diasEstimados = dbo.aleatorio(RAND(), 15, 7)
			SET @diasNecessarios = null
			SET @dataSaida = dbo.verifica_data(@DATA)
			SET @dataEntrega = null
			SET @foraDoPrazo = null
			SET @frete = dbo.calcula_frete(@diasEstimados)
			INSERT INTO Entrega(diasEstimados, 
							diasNecessarios, 
							dataSaida,
							dataEntrega,
							foraDoPrazo,
							frete,
							idOrigem,
							idDestino,
							idStatus,
							idModalidade)
			VALUES (@diasEstimados,
					@diasNecessarios,
					@dataSaida,
					@dataEntrega,
					@foraDoPrazo,
					@frete,
					@id_ENDERECO,
					dbo.ex_aleatorio(RAND(), @TOTAL_END, 1, @id_ENDERECO),
					@idStatus,
					dbo.aleatorio(RAND(), 8, 1))
		END
		-- DEVOLVIDO
		IF @idStatus = 5
		BEGIN
			SET @diasEstimados = dbo.aleatorio(RAND(), 15, 7)
			SET @diasNecessarios = dbo.aleatorio(RAND(), 17, 5)
			SET @dataSaida = dbo.verifica_data(@DATA)
			SET @dataEntrega = dbo.dif_dias(@dataSaida, @diasNecessarios)
			SET @foraDoPrazo = IIF(@diasNecessarios > @diasEstimados, 'SIM', 'NAO')
			SET @frete = dbo.calcula_frete(@diasEstimados)
			INSERT INTO Entrega(diasEstimados, 
							diasNecessarios, 
							dataSaida,
							dataEntrega,
							foraDoPrazo,
							frete,
							idOrigem,
							idDestino,
							idStatus,
							idModalidade)
			VALUES (@diasEstimados,
					@diasNecessarios,
					@dataSaida,
					@dataEntrega,
					@foraDoPrazo,
					@frete,
					@id_ENDERECO,
					dbo.ex_aleatorio(RAND(), @TOTAL_END, 1, @id_ENDERECO),
					@idStatus,
					dbo.aleatorio(RAND(), 8, 1))
		END
		
		
		IF(@CONT_DIAS = 1000)
		BEGIN
			SET @DATA = DATEADD(dd,1,@DATA)
			SET @CONT_DIAS = 0
		END

		SET @CONT_DIAS = @CONT_DIAS + 1
		FETCH C_ENDERECO INTO @id_ENDERECO
	END
	CLOSE C_ENDERECO
	DEALLOCATE C_ENDERECO
END

EXEC SP_POVOAR_ENTREGAS '20221001'

SELECT * FROM Entrega


