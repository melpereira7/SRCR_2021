aresta(s,a,2).   
aresta(a,b,2).
aresta(b,c,2).
aresta(c,d,3).
aresta(d,t,3).
aresta(s,e,2).
aresta(e,f,5).
aresta(f,g,2).
aresta(g,t,2).

aresta(c,t,2).
aresta(s,d,3).
aresta(b,f,5).

inicial(s).

final(t).

adjacente(A,B,C) :- aresta(A,B,C).
adjacente(A,B,C) :- aresta(B,A,C).

resolve_pp(Nodo,[Nodo|Caminho]) :- profundidadeprimeiro1(Nodo,[Nodo],Caminho).

profundidadeprimeiro1(Nodo,_,[]) :- final(Nodo).

profundidadeprimeiro1(Nodo,Historico,[ProxNodo|Caminho]) :-
    adjacente(Nodo,ProxNodo),
    \+ membro(ProxNodo,Historico),
    profundidadeprimeiro1(ProxNodo,[ProxNodo|Historico],Caminho).

adjacente(Nodo,ProxNodo) :- aresta(Nodo,ProxNodo,_).
adjacente(Nodo,ProxNodo) :- aresta(ProxNodo,Nodo,_).


%--------------------------------- - - - - - - - - - -  -  -  -  -   - 

resolve_pp_h(Origem,Destino,Caminho) :- profundidade(Origem,Destino,[Origem],Caminho).

profundidade(Destino,Destino,H,D) :- inverso(H,D).

profundidade(Origem,Destino,His,C) :-
    adjacente_h(Origem,Prox),
    \+ member(Prox,His),
    profundidade(Prox,Destino,[Prox|Hist],C).

adjacente_h(Nodo,ProxNodo) :- aresta(Nodo,ProxNodo,_).
adjacente_h(Nodo,ProxNodo) :- aresta(ProxNodo,Nodo,_).



resolve_pp_custo(Nodo,[Nodo|Caminho],C) :- ppCusto(Nodo,[Nodo],Caminho,C).

ppCusto(Nodo,_,[],0) :- final(Nodo).

ppCusto(Nodo,Historico,[ProxNodo|Caminho],CustoFinal) :-
    adjacenteCusto(Nodo,ProxNodo,C),
    \+ member(Prox,His),
    profundidadeprimeiro2(ProxNodo,[ProxNodo|Historico],Caminho,Custo),
    CustoFinal is C+Custo.

profundidadeprimeiro2(Nodo,_,[],0) :- final(Nodo).

profundidadeprimeiro1(Nodo,Historico,[ProxNodo|Caminho],CustoFinal) :-
    adjacenteCusto(Nodo,ProxNodo,CustoAresta),
    \+ membro(ProxNodo,Historico),
    profundidadeprimeiro1(ProxNodo,[ProxNodo|Historico],Caminho,Custo),
    CustoFinal is CustoAresta+Custo.

adjacenteCusto(Nodo,ProxNodo,Custo) :- aresta(Nodo,ProxNodo,Custo).
adjacenteCusto(Nodo,ProxNodo,Custo) :- aresta(ProxNodo,Nodo,Custo).


todos(R) :- solucoes((S,C),(resolve_pp_custo(S),length(S,C)),R).

melhor(S,Custo) :- todos(R), menor(R,(S,Custo)).

menor([(P,X)],(P,X)).
menor([(Px,X)|L],(Py,Y)) :- menor(L,(Py,Y)), X>Y.
menor([(Px,X)|L],(Px,X)) :- menor(L,(Py,Y)), X=<Y.