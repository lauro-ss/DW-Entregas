import pandas as pd

csv_estados = 'estados.csv'

linhas_estado = pd.read_csv(csv_estados, sep=';').values

regiao = linhas_estado[:, 2:3].flatten().tolist()


# INSERT INTO Regiao(regiao)VALUES($"Variable")
# Removendo nomes iguais
regiao = list(set(regiao))

regiao_sql = open("insert_regioes.sql", "w+")
for i in range(len(regiao)):
    e = regiao[i]
    regiao_sql.write("INSERT INTO Regiao(regiao)VALUES('" + e + "')" + "\n")

regiao_sql.close()


estados_sql = open("insert_estados.sql", "w+")
aux_regiao = ""
idRegiao = 0
for i in range(len(linhas_estado)):
    linha_estado = linhas_estado[i].tolist()
    if (linha_estado[2] != aux_regiao):
        idRegiao = idRegiao + 1
    estados_sql.write("INSERT INTO Estado(estado, UF, idRegiao)VALUES('" +
                      linha_estado[0] + "'" + "," + "'" + linha_estado[1] + "'" + "," + str(idRegiao) + ")" + "\n")
    aux_regiao = linha_estado[2]

estados_sql.close()
