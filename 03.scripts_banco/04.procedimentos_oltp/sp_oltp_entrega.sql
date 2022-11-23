USE bd_rede_entregas

DROP PROCEDURE IF EXISTS SP_OLTP_ENTREGA

CREATE OR ALTER PROCEDURE SP_OLTP_ENTREGA (@DATA_CARGA DATETIME, 
										   @DATA_INICIAL DATETIME,
										   @DATA_FINAL DATETIME) AS
BEGIN
	DELETE Aux_Entrega WHERE DATA_CARGA = @DATA_CARGA

	IF @DATA_INICIAL = @DATA_FINAL
	BEGIN
		SET @DATA_FINAL = DATEADD(dd, 1, @DATA_FINAL)
	END

	INSERT INTO Aux_Entrega
	SELECT @DATA_CARGA, E.id, E.diasEstimados,
		   E.diasNecessarios, E.dataSaida, E.dataEntrega,
		   E.foraDoPrazo, E.frete,
		   EO.idBairro, ED.idBairro,
		   E.idStatus, E.idModalidade, M.idTransportadora
		   FROM Entrega E 
		   INNER JOIN ENDERECO EO ON(E.idOrigem = EO.id) 
		   INNER JOIN ENDERECO ED ON(E.idDestino = ED.id)
		   INNER JOIN Modalidade M ON(E.idModalidade = M.id)
		   WHERE E.dataAtualizacao >= @DATA_INICIAL 
		   AND 
		   E.dataAtualizacao < @DATA_FINAL
END