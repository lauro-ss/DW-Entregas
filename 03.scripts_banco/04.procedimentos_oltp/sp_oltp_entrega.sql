USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_OLTP_ENTREGA (@DATA_CARGA DATETIME) AS
BEGIN
	DELETE Aux_Entrega WHERE DATA_CARGA = @DATA_CARGA

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
END