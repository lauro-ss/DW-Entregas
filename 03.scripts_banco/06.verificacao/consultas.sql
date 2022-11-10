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
-- Qual a média de entregas por transportadora?
-- Qual a média de entregas por região?
-- Qual a média de entregas por estado?
-- Qual a média de entregas por cidade?
-- Qual a média de entregas por bairro?
-- Qual a média de dias necessários por região?
-- Qual o número de entregas fora do prazo por região?
-- Qual o número de entregas por status e período?
-- Qual o total de frete para entregas extraviadas?
-- Qual o total de frete para entregas devolvidas?
-- Qual o número de entregas extraviadas por transportadoras?
-- Qual o número de entregas devolvidas por transportadoras?
-- Qual o número de entregas fora do prazo por transportadoras e modalidades?
-- Qual o número de entregas por região de origem?
-- Qual a média de entregas por região de origem?
