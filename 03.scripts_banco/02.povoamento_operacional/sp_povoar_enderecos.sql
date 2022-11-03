-- Scripts para povoar o ambiente operacional


USE bd_rede_entregas

-- Insere um endereco para cada bairro
CREATE OR ALTER PROCEDURE SP_POVOAR_ENDERECO AS
BEGIN
	
	DECLARE @id_bairro INT
	DECLARE C_BAIRRO CURSOR FOR SELECT id FROM Bairro
	OPEN C_BAIRRO
	FETCH C_BAIRRO INTO @id_bairro
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO Endereco(rua, numero, cep, complemento, idBairro)
		VALUES ('Rua Nº ' + str(@id_bairro),'106','90909-000', null, @id_bairro)
		FETCH C_BAIRRO INTO @id_bairro
	END
	CLOSE C_BAIRRO
	DEALLOCATE C_BAIRRO

END

EXEC SP_POVOAR_ENDERECO
SELECT * FROM ENDERECO
