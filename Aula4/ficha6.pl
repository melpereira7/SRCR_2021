%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- dynamic vem_automovel/0.
:- dynamic vem_comboio/0.

:- dynamic ave/1.
:- dynamic mamifero/1.
:- dynamic canario/1.
:- dynamic periquito/1.
:- dynamic cao/1.
:- dynamic gato/1.
:- dynamic avestruz/1.
:- dynamic pinguim/1.
:- dynamic morcego/1.
:- dynamic '-'/1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% i

voa(X) :- ave(X), nao(excecao(voa(X))).

voa(X) :- excecao(-voa(X)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii

-voa(X):- mamifero(X), nao(excecao(-voa(X))).

-voa(X) :- excecao(voa(X)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii

-voa(tweety).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv

ave(pitigui).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v

ave(X) :- canario(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vi

ave(X) :- periquito(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii

canario(piupiu).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii

mamifero(silvestre).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix

mamifero(X) :- cao(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% x

mamifero(X) :- gato(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xi

cao(boby).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xii

ave(X) :- avestruz(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xiii

ave(X) :- pinguim(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xiv

avestruz(trux).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xv

pinguim(pingu).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xvi

mamifero(X) :- morcego(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix

morcego(batemene).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% plus

excecao(voa(X)) :- avestruz(X).
excecao(voa(X)) :- pinguim(X).
excecao(-voa(X)) :- morcego(X).

si(Questao,verdadeiro) :- Questao.
si(Questao,falso) :- -Questao.
si(Questao,desconhecido) :- nao(Questao), nao(-Questao).


% Extensao do predicado par: N -> {V,F,D}

par( 0 ).
par( X ) :-
    N is X-2,
    N >= 0,
    par( N ).
-par( X ) :-
    nao( par( X ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado impar: N -> {V,F,D}

impar( 1 ).
impar( X ) :-
    N is X-2,
    N >= 1,
    impar( N ).
-impar( 0 ).
-impar( X ) :-
    N is X-2,
    N >=0,
    -impar( N ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado arcoiris: Cor -> {V,F,D}




%--------------------------------- - - - - - - - - - -  -  -  -  -   -



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Atravessar a estrada?




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Atravessar a linha de caminho-de-ferro?




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado terminal: N -> {V,F,D}








%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao) :- Questao,!,fail.
nao(_).
