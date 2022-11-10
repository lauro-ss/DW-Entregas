USE bd_rede_entregas

-- Qual o número de entregas por região e período?
SELECT SUM(E.quantidade) 'Quantidade', L.regiao, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.regiao, T.nome_mes

-- Qual o número de entregas por estado e período?
SELECT SUM(E.quantidade) 'Quantidade', L.estado, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.estado, T.nome_mes

-- Qual o número de entregas por cidade e período?
SELECT SUM(E.quantidade) 'Quantidade', L.cidade, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.cidade, T.nome_mes

-- Qual o número de entregas por bairro e período?
SELECT SUM(E.quantidade) 'Quantidade', L.bairro, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.bairro, T.nome_mes

-- Qual o número de entregas por transportadora e período?
SELECT SUM(E.quantidade) 'Quantidade', TR.transportadora, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Transportadora TR ON (E.transportadora = TR.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY TR.transportadora, T.nome_mes

-- Qual a média de entregas por transportadora?
SELECT AVG(E.quantidade) 'Média', TR.transportadora, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Transportadora TR ON (E.transportadora = TR.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY TR.transportadora, T.nome_mes

-- Qual a média de entregas por região?
SELECT AVG(E.quantidade) 'Média', L.regiao, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.regiao, T.nome_mes

-- Qual a média de entregas por estado?
SELECT AVG(E.quantidade) 'Média', L.estado, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.estado, T.nome_mes

-- Qual a média de entregas por cidade?
SELECT AVG(E.quantidade) 'Média', L.cidade, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.cidade, T.nome_mes

-- Qual a média de entregas por bairro?
SELECT AVG(E.quantidade) 'Média', L.bairro, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.bairro, T.nome_mes

-- Qual a média de dias necessários por região?
SELECT AVG(E.diasNecessarios) 'Média', L.regiao, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY L.regiao, T.nome_mes

-- Qual o número de entregas fora do prazo por região?
SELECT SUM(E.quantidade) 'Quantidade', L.regiao, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Localidade L ON(E.destino = L.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2 AND E.foraDoPrazo = 'SIM'
GROUP BY L.regiao, T.nome_mes

-- Qual o número de entregas por status e período?
SELECT SUM(E.quantidade) 'Quantidade', S.status, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY S.status, T.nome_mes

-- Qual o total de frete para entregas extraviadas?
SELECT SUM(E.quantidade) 'Quantidade', S.status, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY S.status, T.nome_mes

-- Qual o total de frete para entregas devolvidas?
SELECT SUM(E.frete) 'Frete', S.status, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2 AND S.status = 'Devolvido'
GROUP BY S.status, T.nome_mes

-- Qual o número de entregas extraviadas por transportadoras?
SELECT SUM(E.quantidade) 'Quantidade', TR.transportadora, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Transportadora TR ON (E.transportadora = TR.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2 AND S.status = 'Extraviado'
GROUP BY TR.transportadora, T.nome_mes

-- Qual o número de entregas devolvidas por transportadoras?
SELECT SUM(E.quantidade) 'Quantidade', TR.transportadora, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Transportadora TR ON (E.transportadora = TR.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2 AND S.status = 'Devolvido'
GROUP BY TR.transportadora, T.nome_mes

-- Qual o número de entregas fora do prazo por transportadoras e modalidades?
SELECT SUM(E.quantidade) 'Quantidade', TR.transportadora, M.modalidade, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Transportadora TR ON (E.transportadora = TR.id)
INNER JOIN Dim_Modalidade M ON (E.modalidade = M.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2 AND E.foraDoPrazo = 'SIM'
GROUP BY TR.transportadora, M.modalidade, T.nome_mes

-- Qual o número de entregas por transportadora, por status e período?
SELECT SUM(E.quantidade) 'Quantidade', S.status, TR.transportadora, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Transportadora TR ON (E.transportadora = TR.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY TR.transportadora, S.status, T.nome_mes

-- Qual o número de entregas por modalidade, por status e período?
SELECT SUM(E.quantidade) 'Quantidade', S.status, M.modalidade, T.nome_mes FROM Fato_Entrega E 
INNER JOIN Dim_Status S ON (E.status = S.id)
INNER JOIN Dim_Modalidade M ON(E.modalidade = M.id)
INNER JOIN Dim_Tempo T ON (E.data_saida = T.id)
WHERE T.semestre = 2
GROUP BY M.modalidade, S.status, T.nome_mes

