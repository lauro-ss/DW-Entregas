import pandas as pd
import numpy as nd

csv = 'estados.csv'

linhas = pd.read_csv(csv, sep=';').values

estado = linhas[:, :1].flatten().tolist()
uf = linhas[:, 1:2].flatten().tolist()
regiao = linhas[:, 2:3].flatten().tolist()

f = open("teste.txt", "w+")

for i in range(1):
    e = estado[i]
    # print(e)
    f.write(e)
