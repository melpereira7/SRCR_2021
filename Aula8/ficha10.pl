%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Resolução de problemas de pesquisa (Ficha 10)

:- style_check(-discontiguous).
:- style_check(-singleton).

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 
% a)

% Problema de estado único

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 
% b)

% estado inicial - jarros vazios
inicial(jarros(0, 0)).

% estados finais - um dos jarros com exatamente 4 litros
final(jarros(4, _)).
final(jarros(_, 4)).

% operadores:
	% - esvaziar um balde,
	% - encher um balde, 
	% - transferir de um balde para outro até que o segundo fique cheio ou o primeiro vazio

% transições possíveis 
transicao(jarros(V1, V2), encher(1), jarros(8, V2)) :- V1 < 8.
transicao(jarros(V1, V2), encher(2), jarros(V1, 5)) :- V2 < 5.

transicao(jarros(V1, V2), encher(1, 2), jarros(NV1, NV2)):- 
	V1 > 0,
	NV1 is max(V1 - 5 + V2, 0), 
	NV1 < V1, 
	NV2 is V2 + V1 - NV1.
transicao(jarros(V1, V2), encher(2, 1), jarros(NV1, NV2)):- 
	V2 > 0,
	NV2 is max(V2 - 8 + V1, 0), 
	NV2 < V2, 
	NV1 is V1 + V2 - NV2.

transicao(jarros(V1, V2), vazio(1), jarros(0, V2)) :- V1 > 0.
transicao(jarros(V1, V2), vazio(2), jarros(V1, 0)) :- V2 > 0.

%custo - cada ação custa 1 unidade

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 
% c)

% encher jarro 2 (+5 litros) - jarros(0,5)
% transferir para jarro 1 (transfere 5 litros) - jarros(5,0)
% encher jarro 2 (+5 litros) - jarros(5,5)
% transferir para jarro 1 (transfere 3 litros) - jarros(8,2)
% esvaziar jarro 1 - jarros(0,2)
% transferir para jarro 1 (2 litros) - jarros(2,0)
% encher jarro 2 - jarros(2,5)
% transferir para jarro 1 (5 litros) - jarros(7,0)
% encher jarro 2 - jarros (7,5)
% transferir para jarro 1 (1 litro) - jarros(8,4)

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 
% d)

resolvedf(Solucao) :- 
		inicial(InicialEstado), 
		resolvedf(InicialEstado,[InicialEstado],Solucao).

resolvedf(Estado,_,[]) :- final(Estado),!.

resolvedf(Estado,Historico,[Move|Solucao]) :- 
		transicao(Estado,Move,Estado1),
		nao(membro(Estado1,Historico)),
		resolvedf(Estado1,[Estado1|Historico],Solucao).

todos(R) :- solucoes((S,C),(resolvedf(S),length(S,C)),R).

melhor(S,Custo) :- todos(R), menor(R,(S,Custo)).

menor([(P,X)],(P,X)).
menor([(Px,X)|L],(Py,Y)) :- menor(L,(Py,Y)), X>Y.
menor([(Px,X)|L],(Px,X)) :- menor(L,(Py,Y)), X=<Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   - 
% e)
% [a,b,c|X]-X = L-[]
% A-B = [a,b,c|X]-X, B-C = [d,e,f|Y]-Y, A-C = Z 

resolvebf(Solucao) :- 
		inicial(InicialEstado),
		resolvebf([(InicialEstado,[])|Xs],-Xs,[],Solucao).
resolvebf([(Estado,Vs)|_]-_,_.Rs) :- final(Estado),!,inverso(Vs,Rs).
resolvebf([(Estado,_)|Xs]-Ys,Historico,Solucao) :-
		membro(Etsado,Historico),!,
		resolvebf(Xs-Ys,Historico,Solucao).
resolvebf([(Estado,Vs)|Xs]-Ys,Historico,Solucao) :-
		setof((Move,Estado1),transicao(Estado,Move,Estado1),Ls),
		atualizar(Ls,Vs,[Estado|Historico],Ys-Zs),
		resolvebf(Xs-Zs,[Estado|Historico],Solucao).

atualizar([],_,_,X-X).
atualizar([(_,Estado)|Ls],Vs,Historico,Xs-Ys) :- 
		membro(Estado,Historico),!,
		atualizar(Ls,Vs,Historico,Xs-Ys).
atualizar([(Move,Estado)|Ls],Vs,Historico,[(Estado,[Move|Vs])|Xs]-Ys) :- 
		atualizar(Ls,Vs,Historico,Xs-Ys).


%--------------------------------- - - - - - - - - - -  -  -  -  -   - 

escrever([]) :- write('\n').
escrever([H|T]) :- write(H), write('\n'), escrever(T).

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

solucoes(X,Y,Z) :- findall(X,Y,Z).

