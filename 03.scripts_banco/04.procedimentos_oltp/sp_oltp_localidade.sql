USE bd_rede_entregas

DROP PROCEDURE IF EXISTS SP_OLTP_LOCALIDADE

CREATE OR ALTER PROCEDURE SP_OLTP_LOCALIDADE (@DATA_CARGA DATETIME) AS
BEGIN
	DELETE Aux_Localidade WHERE DATA_CARGA = @DATA_CARGA

	INSERT INTO Aux_Localidade
	SELECT @DATA_CARGA, 
		   R.id, R.regiao,
		   E.id, E.estado, E.UF,
		   C.id, C.cidade,
		   B.id, B.bairro
	FROM Regiao R INNER JOIN Estado E
	ON(R.id = E.idRegiao) INNER JOIN Cidade C
	ON(E.id = C.idEstado) INNER JOIN Bairro B
	ON(C.id = B.idCidade)
END