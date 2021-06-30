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

:- consult(adjacencias).
:- consult(contentores).




inicial(' R do Alecrim ').

final(' Pc São Paulo ').


ruas(S) :- findall(R,rua(R,Lat,Lon),S).

estima(Rua,Estima) :- final(X), rua(X,LatI,LongI), rua(Rua,LatF,LongF), Estima is sqrt((LatI-LatF)^2 + (LongI-LongF)^2)*1000.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Algoritmo de Procura não informada em profundidade (DFS - Depth-First Search)

resolvedf([Nodo|Caminho],C,Contentores) :- inicial(Nodo), df(Nodo,[Nodo],Caminho,C,Contentores).

df(Nodo,_,[],0,[]) :- final(Nodo).

df(Nodo,Historico,[ProxNodo|Caminho],CustoFinal,Cont) :-
    adjacente(Nodo,ProxNodo,C),
    nao(membro(ProxNodo,Historico)),
    contentores(ProxNodo,ContentoresNovo),
    df(ProxNodo,[ProxNodo|Historico],Caminho,Custo,Contentores),
    append(ContentoresNovo,Contentores,Cont),
    CustoFinal is C+Custo.


todosCusto(R) :- solucoes((S,C),(resolvedf(S,C,Contentores)),R).
todosContentor(R) :- solucoes((S,C,Contentores),(resolvedf(S,C,Contentores)),R).

melhorCusto(S,Custo) :- todosCusto(R), menorCusto(R,(S,Custo)).

melhorRecolha(S,Custo,Contentores) :- todosContentor(R), menorRecolha(R,(S,Custo,Contentores)).

menorCusto([(P,X)],(P,X)).
menorCusto([(Px,X)|L],(Py,Y)) :- menorCusto(L,(Py,Y)), X>Y.
menorCusto([(Px,X)|L],(Px,X)) :- menorCusto(L,(Py,Y)), X=<Y.

menorRecolha([(P,X,C)],(P,X,C)).
menorRecolha([(Px,X,Cx)|L],(Py,Y,Cy)) :- menorRecolha(L,(Py,Y,Cy)), length(Cx,TamCx), length(Cy,TamCy), TamCx<TamCy.
menorRecolha([(Px,X,Cx)|L],(Px,X,Cx)) :- menorRecolha(L,(Py,Y,Cy)), length(Cx,TamCx), length(Cy,TamCy), TamCx>=TamCy.

remove(_,[],[]).
remove(X,[X|T],T).
remove(X,[H|T],[H|Res]) :- X\=H, remove(X,T,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Algoritmo de procura informada Gulosa


resolveGulosa(Caminho/Custo) :-
    inicial(Nodo),
    estima(Nodo, Estimativa),
    agulosa([[Nodo]/0/Estimativa], CaminhoInverso/Custo/_),
    inverso(CaminhoInverso, Caminho).

agulosa(Caminhos, Caminho) :-
    obtem_melhor_g(Caminhos, Caminho),
    Caminho = [Nodo|_]/_/_,final(Nodo).

agulosa(Caminhos, SolucaoCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expandeGulosa(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    agulosa(NovoCaminhos, SolucaoCaminho).

obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_g(Caminhos, MelhorCaminho).

expandeGulosa(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacenteG(Caminho,NovoCaminho), ExpCaminhos).

adjacenteG([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	adjacente(Nodo, ProxNodo, PassoCusto),\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).


inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Algoritmo de procura informada A* (A Estrela)

resolveAEstrela(Caminho/Custo) :-
    inicial(Nodo),
    estima(Nodo, Estimativa),
    aestrela([[Nodo]/0/Estima], CaminhoInverso/Custo/_),
    inverso(CaminhoInverso, Caminho).

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,final(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expandeAEstrela(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    aestrela(NovoCaminhos, SolucaoCaminho).

obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).
    
expandeAEstrela(Caminho, ExpCaminhos) :-
findall(NovoCaminho, adjacenteG(Caminho,NovoCaminho), ExpCaminhos).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Auxiliares

escrever([]) :- write('\n').
escrever([H|T]) :- write(H), write('\n'), escrever(T).

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

solucoes(X,Y,Z) :- findall(X,Y,Z).
