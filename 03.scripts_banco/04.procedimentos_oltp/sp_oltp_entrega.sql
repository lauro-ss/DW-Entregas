USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_OLTP_ENTREGA (@DATA_CARGA DATETIME) AS
BEGIN
	DELETE Aux_Entrega WHERE DATA_CARGA = @DATA_CARGA

	INSERT INTO Aux_Entrega
	SELECT @DATA_CARGA, E.id, E.diasEstimados,
		   E.diasNecessarios, E.dataSaida, E.dataEntrega,
		   E.foraDoPrazo, E.frete,
		   E.idOrigem, E.idDestino,
		   E.idStatus, E.idModalidade
		   FROM Entrega E
END