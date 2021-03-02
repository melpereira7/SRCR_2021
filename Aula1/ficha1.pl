%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 1

:- discontiguous pai/2.
:- discontiguous avo/2.
:- discontiguous neto/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}
% i, ii, iii, iv, v, vi, vii, viii, ix, x, xi

filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).

filho(F,P) :- pai(P,F).

pai(paulo,filipe).
pai(paulo,maria).

avo(antonio,nadia).

neto(nuno,ana).

sexo(joao,masculino).
sexo(jose,masculino).
sexo(maria,feminino).
sexo(joana,feminino).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}
% xii

pai(P,F) :- filho(F,P).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}
% xiii, xiv

avo(A,N) :- filho(X,N) , pai(A,X).

neto(N,A) :- avo(A,N).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}
% xv

descendente(D,A) :- filho(D,A).
descendente(D,A) :- filho(D,Z), descendente(Z,A).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}
% xvi

descendente(D,A,1) :- filho(D,A).
descendente(D,A,N) :- filho(D,Z), descendente(Z,A,N1), N is N1+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xvii, xviii, xix, xx

avo(A,N) :- descendente(N,A,2).

bisavo(X,Y) :- descendente(Y,X,3).

trisavo(X,Y) :- descendente(Y,X,4).

tetraneto(X,Y) :- descendente(X,Y,5).

