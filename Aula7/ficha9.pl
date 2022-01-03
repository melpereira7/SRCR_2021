%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Grafos (Ficha 9)

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diferentes representacaoes de grafos
%
%lista de adjacencias: [n(b,[c,g,h]), n(c,[b,d,f,h]), n(d,[c,f]), ...]
%
%termo-grafo: grafo([b,c,d,f,g,h,k],[e(b,c),e(b,g),e(b,h), ...]) or
%            digrafo([r,s,t,u],[a(r,s),a(r,t),a(s,t), ...])
%
%clausula-aresta: aresta(a,b)


%---------------------------------

grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
  [aresta(madrid, corboda, a4, 400),
   aresta(braga, guimaraes,a11, 25),
   aresta(braga, vilareal, a11, 107),
   aresta(guimaraes, viseu, a24, 174),
   aresta(vilareal, lamego, a24, 37),
   aresta(viseu, lamego,a24, 61),
   aresta(viseu, coimbra, a25, 119),
   aresta(viseu,guarda, a25, 75)]
 ).


%--------------------------------- 
%alinea 1)

adjacente(X,Y,E,K, grafo(_,Es)) :- member(aresta(X,Y,E,K),Es).
adjacente(X,Y,E,K, grafo(_,Es)) :- member(aresta(Y,X,E,K),Es).

%--------------------------------- 
%alinea 2)

caminho(G,A,B,P) :- caminho1(G,A,[B],P).
caminho1(G,A,[A|P1],[A|P1]).
caminho1(G,A,[Y|P1],P) :- adjacente(X,Y,_,_,G), nao(member(X,[Y|P1])), caminho1(G,A,[X,Y|P1],P).


%--------------------------------- 
% alinea 3)

ciclo(G,A,[A|P]) :- adjacente(A,X,_,_,G), caminho(G,X,A,P), length(P,L), L>2.


%--------------------------------- 
%alinea 4)

caminhoK(G,A,B,P,Km,Es) :- caminho1K(G,A,[B],P,Km,Es).
caminho1K(G,A,[A|P1],[A|P1],0,[]).
caminho1K(G,A,[Y|P1],P,Km,EsT) :- adjacente(X,Y,E,KmA,G), nao(member(X,[Y|P1])), caminho1K(G,A,[X,Y|P1],P,K,Es), Km is K+KmA, reverse([E|Es],EsT).
 

%--------------------------------- 
%alinea 5)

cicloK(G,A,[A|P],Km,[E|Es]) :- adjacente(A,X,E,KmA,G), caminhoK(G,X,A,P,K,Es), length(P,L), L>2, Km is K+KmA.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).