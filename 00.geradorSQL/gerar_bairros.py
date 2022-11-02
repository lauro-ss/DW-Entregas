import pandas as pd

csv_bairros = 'bairros.csv'
csv_municipios = 'municipios.csv'

linhas_bairros = pd.read_csv(csv_bairros, sep=';').values
linhas_municipio = pd.read_csv(csv_municipios, sep=';').values


bairros_sql = open("insert_bairros.sql", "w+")
idCidade = 0
for i in range(len(linhas_municipio)):
    linha_municipio = linhas_municipio[i].tolist()
    idCidade = idCidade + 1
    aux = 1
    for i in range(len(linhas_bairros)):
        linha_bairro = linhas_bairros[i].tolist()
        uf = str(linha_bairro[0])
        municipio = str(linha_bairro[1])
        bairro = str(linha_bairro[2])
        bairro = bairro.replace("'", "''")
        if (linha_municipio[0] == uf and linha_municipio[1] == municipio):
            bairros_sql.write("INSERT INTO Bairro(bairro, idCidade)VALUES('" +
                              bairro + "'" + "," + str(idCidade) + ")" + "\n")
            aux = 0
    if (aux == 1):
        bairros_sql.write("INSERT INTO Bairro(bairro, idCidade)VALUES('" +
                          "Centro" + "'" + "," + str(idCidade) + ")" + "\n")

bairros_sql.close()
print("Terminou")
