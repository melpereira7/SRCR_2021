import pandas as pd
import re
import math


dfs = pd.read_excel('dataset.xlsx', sheet_name=None)

folha = dfs.get('Folha1')


def distance(lat1, lon1, lat2, lon2):
    if (lat1 == lat2) and (lon1 == lon2):
        return 0
    else:
        theta = lon1-lon2
        dist = math.sin(math.radians(lat1)) * math.sin(math.radians(lat2)) + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.cos(math.radians(theta))
        dist = math.acos(dist)
        dist = math.degrees(dist)
        miles = dist * 60 * 1.1515;
       

        return miles


def getAllPlaces():
	global dfs 
	global folha
	simple = open("finalbc.pl", "w")
	contentores = {}
	for linha in range(len(folha)):
		ruaOrigem = folha.iloc[linha].PONTO_RECOLHA_LOCAL
		lat = folha.iloc[linha].Latitude
		longitude = folha.iloc[linha].Longitude
		idcontentor = folha.iloc[linha].OBJECTID
		tipolixo = folha.iloc[linha].CONTENTOR_RESÍDUO
		capacidade = folha.iloc[linha].CONTENTOR_TOTAL_LITROS
		if ':' in ruaOrigem.split(':',1)[1]:
			idlocalizacao = ruaOrigem.split(':')[0]
			ruaOrigem = ruaOrigem.split(':')[1].split('(')[0].split(',')[0]

			ligacaoraw = folha.iloc[linha].PONTO_RECOLHA_LOCAL	
			ligacao1 = ligacaoraw.split(':')[2].split('-')[0]
			contentores[idcontentor] = (idlocalizacao,ruaOrigem,ligacao1,lat,longitude,capacidade,idcontentor,tipolixo)
		else:
			pass
	#(idlocalizacao,ruaOrigem,ligacao1,lat,longitude,capacidade,tipolixo)

	simple.write("% edge(idorigem,idestino,distancia,capacidade)\n")
	for info in contentores:
		for others in contentores:

			if (contentores[others][2] == contentores[info][1]  and contentores[info][0]!=contentores[others][0] and contentores[info][6]!=contentores[others][6]):
				mod = distance(float(contentores[info][3]),float(contentores[info][4]),float(contentores[others][3]),float(contentores[others][4]))*1000*1.609344
				edge = f"arco({contentores[info][6]},{contentores[others][6]},{mod},{contentores[others][5]},'{contentores[others][7]}')"
				#edge(idorigem,idestino,distancia,capacidade,tipolixo)
				simple.write(edge+'.\n')
	print("Done.")	


		
		
		



getAllPlaces()








