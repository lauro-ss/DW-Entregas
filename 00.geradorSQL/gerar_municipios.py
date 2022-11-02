import pandas as pd

csv_municipios = 'municipios.csv'

linhas_municipio = pd.read_csv(csv_municipios, sep=';').values

municipios_sql = open("insert_municipios.sql", "w+")
aux_estado = ""
idEstado = 0
for i in range(len(linhas_municipio)):
    linha_municipio = linhas_municipio[i].tolist()
    if (linha_municipio[0] != aux_estado):
        idEstado = idEstado + 1
    municipios_sql.write("INSERT INTO Cidade(cidade, idEstado)VALUES('" +
                         linha_municipio[1] + "'" + "," + str(idEstado) + ")" + "\n")
    aux_estado = linha_municipio[0]

municipios_sql.close()
