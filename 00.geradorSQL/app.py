import pandas as pd

csv_estados = 'estados.csv'
csv_municipios = 'municipios.csv'

linhas_estado = pd.read_csv(csv_estados, sep=';').values
linhas_municipio = pd.read_csv(csv_municipios, sep=';').values

#estado = linhas[:, :1].flatten().tolist()
#uf = linhas[:, 1:2].flatten().tolist()
regiao = linhas_estado[:, 2:3].flatten().tolist()

# print(linhas.flatten())


# INSERT INTO Regiao(regiao)VALUES($"Variable")
# Removendo nomes iguais
regiao = list(set(regiao))

f = open("teste.txt", "w+")
for i in range(len(regiao)):
    e = regiao[i]
    f.write("INSERT INTO Regiao(regiao)VALUES('" + e + "')" + "\n")

aux_regiao = ""
idRegiao = 0
for i in range(len(linhas_estado)):
    linha_estado = linhas_estado[i].tolist()
    if (linha_estado[2] != aux_regiao):
        idRegiao = idRegiao + 1
    f.write("INSERT INTO Estado(estado, UF, idRegiao)VALUES('" +
            linha_estado[0] + "," + linha_estado[1] + "," + str(idRegiao) + "')" + "\n")
    aux_regiao = linha_estado[2]

aux_estado = ""
idEstado = 0
for i in range(len(linhas_municipio)):
    linha_municipio = linhas_municipio[i].tolist()
    if (linha_municipio[0] != aux_estado):
        idEstado = idEstado + 1
    f.write("INSERT INTO Cidade(cidade, idEstado)VALUES('" +
            linha_municipio[1] + "," + str(idEstado) + "')" + "\n")
    aux_estado = linha_municipio[0]
