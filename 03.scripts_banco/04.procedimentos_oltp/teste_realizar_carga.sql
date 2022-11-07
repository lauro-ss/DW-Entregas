USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_OLTP_REALIZAR_CARGA (@DATA_CARGA DATETIME) AS
BEGIN
	EXEC SP_OLTP_ENTREGA @DATA_CARGA
	EXEC SP_OLTP_LOCALIDADE @DATA_CARGA
	EXEC SP_OLTP_MODALIDADE @DATA_CARGA
	EXEC SP_OLTP_STATUS @DATA_CARGA
	EXEC SP_OLTP_TRANSPORTADORA @DATA_CARGA
END

EXEC SP_OLTP_REALIZAR_CARGA '20221106'
SELECT * FROM Aux_Entrega
SELECT * FROM Aux_Localidade
SELECT * FROM Aux_Modalidade
SELECT * FROM Aux_Status
SELECT * FROM Aux_Transportadora