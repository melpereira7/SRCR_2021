%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 1

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).

sexo(joao,masculino).
sexo(jose,masculino).
sexo(maria,feminino).
sexo(joana,feminino).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai(paulo,filipe).
pai(paulo,maria).

pai(P,F) :- filho(F,P).
filho(F,P) :- pai(P,F).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(antonio,nadia).
avo(ana,nuno).

avo(A,N) :- filho(X,N) , pai(A,X).

neto(nuno,ana).

neto(N,A) :- avo(A,N).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo(B,N) :- pai(B,A), avo(A.N).
bisavo(B,N) :- filho(A,B), neto(N,A).

bisneto(B,A) :- bisavo(A,B).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

descendente(D,A) :- filho(D,A).
descendente(D,A) :- filho(D,Z), descendente(Z,A).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D,A,1) :- filho(D,A).
descendente(D,A,2) :- neto(D,A).
descendente(D,A,3) :- bisneto(D,A).

