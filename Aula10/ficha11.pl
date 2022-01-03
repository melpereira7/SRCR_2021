:- style_check(-discontiguous).
:- style_check(-singleton).


aresta(s,a,2).   
aresta(a,b,2).
aresta(b,c,2).
aresta(c,d,3).
aresta(d,t,3).
aresta(s,e,2).
aresta(e,f,5).
aresta(f,g,2).
aresta(g,t,2).

%aresta(c,t,2).
%aresta(s,d,3).
%aresta(b,f,5).

estima(a, 5).
estima(b, 4).
estima(c, 4).
estima(d, 3).
estima(e, 7).
estima(f, 4).
estima(g, 2).
estima(s, 10).
estima(t, 0).


inicial(s).

goal(t).

adjacente(A,B,C) :- aresta(A,B,C).
adjacente(A,B,C) :- aresta(B,A,C).

resolve_pp(Nodo,[Nodo|Caminho]) :- profundidadeprimeiro1(Nodo,[Nodo],Caminho).

profundidadeprimeiro1(Nodo,_,[]) :- goal(Nodo).

profundidadeprimeiro1(Nodo,Historico,[ProxNodo|Caminho]) :-
    adjacente(Nodo,ProxNodo),
    nao(membro(ProxNodo,Historico)),
    profundidadeprimeiro1(ProxNodo,[ProxNodo|Historico],Caminho).

adjacente(Nodo,ProxNodo) :- aresta(Nodo,ProxNodo,_).
adjacente(Nodo,ProxNodo) :- aresta(ProxNodo,Nodo,_).


%--------------------------------- - - - - - - - - - -  -  -  -  -   - 

resolve_pp_h(Origem,Destino,Caminho) :- profundidade(Origem,Destino,[Origem],Caminho).

profundidade(Destino,Destino,H,D) :- inverso(H,D).

profundidade(Origem,Destino,His,C) :-
    adjacente_h(Origem,Prox),
    nao(membro(Prox,His)),
    profundidade(Prox,Destino,[Prox|Hist],C).

adjacente_h(Nodo,ProxNodo) :- aresta(Nodo,ProxNodo,_).
adjacente_h(Nodo,ProxNodo) :- aresta(ProxNodo,Nodo,_).


resolve_pp_custo(Nodo,[Nodo|Caminho],C) :- ppCusto(Nodo,[Nodo],Caminho,C).

ppCusto(Nodo,_,[],0) :- goal(Nodo).

ppCusto(Nodo,Historico,[ProxNodo|Caminho],Custogoal) :-
    adjacenteCusto(Nodo,ProxNodo,C),
    nao(membro(ProxNodo,Historico)),
    profundidadeprimeiroCusto(ProxNodo,[ProxNodo|Historico],Caminho,Custo),
    Custogoal is C+Custo.

profundidadeprimeiroCusto(Nodo,_,[],0):- goal(Nodo).

profundidadeprimeiroCusto(Nodo,Historico,[ProxNodo|Caminho],Custo) :-
    adjacenteCusto(Nodo,ProxNodo,C),
    nao(membro(ProxNodo,Historico)),
    profundidadeprimeiroCusto(ProxNodo,[ProxNodo|Historico],Caminho,Custo1),
    Custo is C+Custo1.

adjacenteCusto(Nodo,ProxNodo,Custo) :- aresta(Nodo,ProxNodo,Custo).
adjacenteCusto(Nodo,ProxNodo,Custo) :- aresta(ProxNodo,Nodo,Custo).


todos(R) :- solucoes((S,C),(resolve_pp_custo(Nodo,S,C),length(S,C)),R).

melhor(S,Custo) :- todos(R), menor(R,(S,Custo)).

menor([(P,X)],(P,X)).
menor([(Px,X)|L],(Py,Y)) :- menor(L,(Py,Y)), X>Y.
menor([(Px,X)|L],(Px,X)) :- menor(L,(Py,Y)), X=<Y.




resolve_gulosa(Nodo,Caminho/Custo) :-
    estima(Nodo,Estima),
    gulosa([[Nodo]/0/Estima],InvCaminho/Custo/_),
    inverso(InvCaminho,Caminho).

gulosa(Caminhos,Caminho) :- 
    obtem_melhor_g(Caminhos,Caminho),
    Caminho = ([Nodo|_]/_/_),goal(Nodo).

gulosa(Caminhos,SolucaoCaminho) :-
    obtem_melhor_g(Caminhos,MelhorCaminho),
    seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
    expande_gulosa(MelhorCaminho,ExpCaminhos),
    append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
    gulosa(NovoCaminhos,SolucaoCaminho).

obtem_melhor_g([Caminho],Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho) :- 
    Est1 =< Est2, !,
    obtem_melhor_g([Caminho1,Custo1,Est1|Caminhos],MelhorCaminho).

obtem_melhor_g([_|Caminhos],MelhorCaminho) :- 
    obtem_melhor_g(Caminhos,MelhorCaminho).

expande_gulosa(Caminho,ExpCaminhos) :- 
    findall(NovoCaminho,adjacente3(Caminho,NovoCaminho),ExpCaminhos).


%resolve_gulosa(Origem,Origem,[],0).
%resolve_gulosa(Origem,Destino,[Nodo|Caminho1],Custo) :-
%    findall((D,Custo),(adjacente(Origem,D,_),estima(D,Custo)),S), menor(S,(Nodo,CustoNodo)), resolve_gulosa(D,Destino,Caminho1,Custo1), Custo is CustoNodo+Custo1 .



resolve_aestrela(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverso(InvCaminho, Caminho).

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
	obtem_melhor(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        aestrela(NovoCaminhos, SolucaoCaminho).

obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor([_|Caminhos], MelhorCaminho) :-
	obtem_melhor(Caminhos, MelhorCaminho).

expande_aestrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente3(Caminho,NovoCaminho), ExpCaminhos).






adjacente3([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	aresta(Nodo, ProxNodo, PassoCusto),\+ membro(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

solucoes(X,Y,Z) :- findall(X,Y,Z).

inverso(Xs, Ys):-
	inverso(Xs, [], Ys).
inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

membro(X,[X|_]).
membro(X,[_|Xs]) :- 
    membro(X,Xs).