import pandas as pd
import numpy as nd

csv = 'estados.csv'

linhas = pd.read_csv(csv, sep=';').values

estado = linhas[:, :1].flatten().tolist()
uf = linhas[:, 1:2].flatten().tolist()
regiao = linhas[:, 2:3].flatten().tolist()

# print(linhas.flatten())


# INSERT INTO Regiao(regiao)VALUES($"Variable")
# Removendo nomes iguais
regiao = list(set(regiao))

f = open("teste.txt", "w+")
for i in range(len(regiao)):
    e = regiao[i]
    f.write("INSERT INTO Regiao(regiao)VALUES('" + e + "')" + "\n")

aux = ""
linha_estado = ""
linha_UF = ""
idRegiao = 0
for i in range(len(linhas)):
    linha = linhas[i].tolist()
    if (linha[2] != aux):
        idRegiao = idRegiao + 1
    f.write("INSERT INTO Estado(estado, UF, idRegiao)VALUES('" +
            linha[0] + "," + linha[1] + "," + str(idRegiao) + "')" + "\n")
    aux = linha[2]
