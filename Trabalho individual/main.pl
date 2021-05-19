%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%Trabaho prático individual - SRCR - MIEI 20/21


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Dados a considerar:
    %A capacidade de carga do veículo coletor de lixo é de 15 m3
    %Considere que existe, em cada ponto de recolha, informação sobre a quantidade existente de resíduos
%Estratégias de procura que deverão implementar:
%Não informada
    %Profundidade (DFS - Depth-First Search)
    %Largura (BFS - Breadth-First Search)
    %Busca Iterativa Limitada em Profundidade
%Informada        
    %Gulosa
    %A* (A estrela)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Declarações iniciais
:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).
:- set_prolog_flag(encoding,utf8).

:- consult(base_conhecimento).





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Gerar os circuitos de recolha tanto indiferenciada como seletiva, caso existam, que cubram um determinado território;





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Identificar quais os circuitos com mais pontos de recolha (por tipo de resíduo a recolher);





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Comparar circuitos de recolha tendo em conta os indicadores de produtividade:
    %A quantidade de resíduos recolhidos durante o circuito;
    %A distância média percorrida entre pontos de recolha.





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Escolher o circuito mais rápido (usando o critério da distância);





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Escolher o circuito mais eficiente (usando um critério de eficiência à escolha);




