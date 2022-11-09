USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_OLTP_ENTREGA (@DATA_CARGA DATETIME) AS
BEGIN
	DELETE Aux_Entrega WHERE DATA_CARGA = @DATA_CARGA

	INSERT INTO Aux_Entrega
	SELECT @DATA_CARGA, E.id, E.diasEstimados,
		   E.diasNecessarios, E.dataSaida, E.dataEntrega,
		   E.foraDoPrazo, E.frete,
		   BO.id, BD.id,
		   E.idStatus, E.idModalidade
		   FROM Entrega E INNER JOIN ENDERECO EO
		   ON(E.idOrigem = EO.id) INNER JOIN Bairro BO
		   ON(EO.idBairro = BO.id) INNER JOIN ENDERECO ED
		   ON(E.idDestino = ED.id) INNER JOIN Bairro BD
		   ON(ED.idBairro = BD.id)
END