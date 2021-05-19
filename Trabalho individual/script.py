import pandas as pd
import unidecode as und

df = pd.read_excel (r'dataset.xlsx')

"""
f = open("base_conhecimento.pl", "a")
for index, row in df.iterrows():
    f.write('data(')
    for i in range(9):
        f.write(str(row[i])+',')
    f.write(str(row[i+1])+').\n')
f.close()
"""

f = open("base_conhecimento.pl", "a")
for index, row in df.iterrows():
    f.write(und.unidecode(str(row['CONTENTOR_RESÍDUO']).replace(" ", "").lower())+'(')
    for i in range(9):
        if i == 3 or i==4 or i==6 : f.write('\''+str(row[i])+'\''+',')
        elif i != 5 : f.write(str(row[i])+',')
    f.write(str(row[i+1])+').\n')
f.close()
