USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_FATO_ENTREGA (@DATA_CARGA DATETIME) AS
BEGIN
	DECLARE @COD_ENTREGA BIGINT, @DIAS_ESTIMADOS INT, @DIAS_NECESSARIOS INT
	,@DATA_SAIDA DATETIME, @DATA_ENTREGA DATETIME, @FORA_DO_PRAZO CHAR(3),
	@FRETE NUMERIC(10,2), @COD_ORIGEM INT, @COD_DESTINO INT, @COD_STATUS INT,
	@COD_MODALIDADE INT, @COD_TRANSPORTADORA INT


	DECLARE C_ENTREGA CURSOR FOR SELECT 
	E.cod_entrega, E.diasEstimados, E.diasNecessarios,
	E.dataSaida, E.dataEntrega, E.foraDoPrazo,
	E.frete, E.cod_origem_bairro, E.cod_destino_bairro, E.cod_status,
	E.cod_modalidade, E.cod_transportadora
	FROM Aux_Entrega E
	WHERE E.DATA_CARGA = @DATA_CARGA

	DECLARE @DATA_SAIDA_ID BIGINT, @DATA_ENTREGA_ID BIGINT, 
	@ORIGEM_ID INT, @DESTINO_ID INT, @STATUS_ID INT,
	@MODALIDADE_ID INT, @TRANSPORTADORA_ID INT

	OPEN C_ENTREGA
	FETCH C_ENTREGA INTO @COD_ENTREGA, @DIAS_ESTIMADOS, @DIAS_NECESSARIOS
	,@DATA_SAIDA, @DATA_ENTREGA, @FORA_DO_PRAZO,
	@FRETE, @COD_ORIGEM, @COD_DESTINO, @COD_STATUS,
	@COD_MODALIDADE, @COD_TRANSPORTADORA
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		
		SET @DATA_SAIDA_ID = (SELECT id FROM DIM_TEMPO WHERE DATA = @DATA_SAIDA)
		SET @DATA_ENTREGA_ID = (SELECT id FROM DIM_TEMPO WHERE DATA = @DATA_ENTREGA)
		SET @ORIGEM_ID = (SELECT id FROM Dim_Localidade WHERE cod_bairro = @COD_ORIGEM)
		SET @DESTINO_ID = (SELECT id FROM Dim_Localidade WHERE cod_bairro = @COD_DESTINO)
		SET @STATUS_ID = (SELECT id FROM Dim_Status WHERE cod_status = @COD_STATUS)
		SET @MODALIDADE_ID = (SELECT id FROM Dim_Modalidade WHERE cod_modalidade = @COD_MODALIDADE)
		SET @TRANSPORTADORA_ID = (SELECT id FROM Dim_Transportadora WHERE cod_transportadora = @COD_TRANSPORTADORA)

		IF @DATA_SAIDA_ID IS NOT NULL AND
		@ORIGEM_ID IS NOT NULL AND
		@STATUS_ID IS NOT NULL AND
		@MODALIDADE_ID IS NOT NULL AND
		@TRANSPORTADORA_ID IS NOT NULL
		BEGIN
			IF ISNULL(@DESTINO_ID, 0) = @ORIGEM_ID
			BEGIN
				INSERT INTO Vio_Entrega(data_carga, cod_entrega, diasEstimados,
									diasNecessarios, dataSaida, dataEntrega,
									foraDoPrazo, frete, cod_origem_bairro, cod_destino_bairro,
									cod_status, cod_modalidade, cod_transportadora, data_erro,
									violacao)
						VALUES(@DATA_CARGA, @COD_ENTREGA, @DIAS_ESTIMADOS, @DIAS_NECESSARIOS,
							   @DATA_SAIDA, @DATA_ENTREGA, @FORA_DO_PRAZO, @FRETE, @COD_ORIGEM,
							   @COD_DESTINO, @COD_STATUS, @COD_MODALIDADE, @COD_TRANSPORTADORA, 
							   GETDATE(),'Destino e Origem com o mesmo o endereço.')
			END
			ELSE
			BEGIN
				IF @DATA_ENTREGA < @DATA_SAIDA
				BEGIN
					INSERT INTO Vio_Entrega(data_carga, cod_entrega, diasEstimados,
									diasNecessarios, dataSaida, dataEntrega,
									foraDoPrazo, frete, cod_origem_bairro, cod_destino_bairro,
									cod_status, cod_modalidade, cod_transportadora, data_erro,
									violacao)
						VALUES(@DATA_CARGA, @COD_ENTREGA, @DIAS_ESTIMADOS, @DIAS_NECESSARIOS,
							   @DATA_SAIDA, @DATA_ENTREGA, @FORA_DO_PRAZO, @FRETE, @COD_ORIGEM,
							   @COD_DESTINO, @COD_STATUS, @COD_MODALIDADE, @COD_TRANSPORTADORA, 
							   GETDATE(),'Data de Entrega anterior a data de saída.')
				END
				ELSE
				BEGIN
					IF @FRETE < 0
					BEGIN
						INSERT INTO Vio_Entrega(data_carga, cod_entrega, diasEstimados,
									diasNecessarios, dataSaida, dataEntrega,
									foraDoPrazo, frete, cod_origem_bairro, cod_destino_bairro,
									cod_status, cod_modalidade, cod_transportadora, data_erro,
									violacao)
						VALUES(@DATA_CARGA, @COD_ENTREGA, @DIAS_ESTIMADOS, @DIAS_NECESSARIOS,
							   @DATA_SAIDA, @DATA_ENTREGA, @FORA_DO_PRAZO, @FRETE, @COD_ORIGEM,
							   @COD_DESTINO, @COD_STATUS, @COD_MODALIDADE, @COD_TRANSPORTADORA, 
							   GETDATE(),'Valor de frete negativo.')
					END
					ELSE
					BEGIN
						-- UPDATE
						IF EXISTS (SELECT ID FROM Fato_Entrega WHERE cod_entrega = @COD_ENTREGA)
						BEGIN
							UPDATE Fato_Entrega SET data_saida = @DATA_SAIDA_ID, data_entrega = @DATA_ENTREGA_ID,
							origem = @ORIGEM_ID, destino = @DESTINO_ID, status = @STATUS_ID, modalidade = @MODALIDADE_ID,
							transportadora = @TRANSPORTADORA_ID, frete = @FRETE, diasEstimados = @DIAS_ESTIMADOS,
							diasNecessarios = @DIAS_NECESSARIOS, foraDoPrazo = @FORA_DO_PRAZO
							WHERE cod_entrega = @COD_ENTREGA
						END
						-- INSERT
						ELSE
						BEGIN
							INSERT INTO Fato_Entrega(data_saida, data_entrega, origem, destino,
													 status, modalidade, transportadora, frete,
													 diasEstimados, diasNecessarios, cod_entrega,
													 quantidade, foraDoPrazo)
										VALUES (@DATA_SAIDA_ID, @DATA_ENTREGA_ID, @ORIGEM_ID, @DESTINO_ID,
												@STATUS_ID, @MODALIDADE_ID, @TRANSPORTADORA_ID, @FRETE,
												@DIAS_ESTIMADOS, @DIAS_NECESSARIOS, @COD_ENTREGA,
												1,@FORA_DO_PRAZO)
						END
					END
				END
			END
		END
		ELSE
		BEGIN
			INSERT INTO Vio_Entrega(data_carga, cod_entrega, diasEstimados,
									diasNecessarios, dataSaida, dataEntrega,
									foraDoPrazo, frete, cod_origem_bairro, cod_destino_bairro,
									cod_status, cod_modalidade, cod_transportadora, data_erro,
									violacao)
						VALUES(@DATA_CARGA, @COD_ENTREGA, @DIAS_ESTIMADOS, @DIAS_NECESSARIOS,
							   @DATA_SAIDA, @DATA_ENTREGA, @FORA_DO_PRAZO, @FRETE, @COD_ORIGEM,
							   @COD_DESTINO, @COD_STATUS, @COD_MODALIDADE, @COD_TRANSPORTADORA, 
							   GETDATE(),'Data, Bairro, Status, Modalidade ou Transportadora não existem nas dimensões.')
		END

		FETCH C_ENTREGA INTO @COD_ENTREGA, @DIAS_ESTIMADOS, @DIAS_NECESSARIOS
		,@DATA_SAIDA, @DATA_ENTREGA, @FORA_DO_PRAZO,
		@FRETE, @COD_ORIGEM, @COD_DESTINO, @COD_STATUS,
		@COD_MODALIDADE, @TRANSPORTADORA_ID
	END
	CLOSE C_ENTREGA
	DEALLOCATE C_ENTREGA
END

EXEC SP_FATO_ENTREGA '20221106'
SELECT * FROM Vio_Entrega