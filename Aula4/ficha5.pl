%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic avo/2.
:- dynamic neto/2.
:- dynamic descendente/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai(P,F) :- filho(F,P).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A,N) :- filho(X,N) , pai(A,X).

neto(N,A) :- avo(A,N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D,A,1) :- filho(D,A).
descendente(D,A,N) :- filho(D,Z), descendente(Z,A,N1), N is N1+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido
% i

%V F1,P1 : filho(F1,P1) and filho(F2,P2) and F1=F2 and P1=P2 --> não há reetidos

+filho(F,P) :: (solucoes((F,P),(filho(F,P)),S),
                comprimento(S,N), 
                N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii

+pai(P,F) :: (solucoes((P,F),(pai(P,F)),S),
                comprimento(S,N),
                N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii

+neto(N,A) :: (solucoes((N,A),(neto(N,A)),S),
                comprimento(S,N),
                N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv

+avo(A,N) :: (solucoes((A,N),(avo(A,N)),S),
                comprimento(S,N),
                N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v

+descendente(D,A,G) :: (solucoes((D,A,G),(descendente(D,A,G)),S),
                        comprimento(S,N),
                        N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo
% vi

+filho(F,P) :: (solucoes(Ps,(filho(F,Ps)),S),
                comprimento(S,N), 
                N=<2).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii

+pai(P,F) :: (solucoes(Ps,(pai(Ps,F)),S),
                comprimento(S,N), 
                N=<2).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii

+neto(N,A) :: (solucoes(As,(avo(N,As)),S),
                comprimento(S,N), 
                N=<4).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix

+avo(A,N) :: (solucoes(As,(avo(As,N)),S),
                comprimento(S,N), 
                N=<4).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% x

natural(X) :- X>=0, I is floor(X), F is X-I, F==0.

+descendente(D,A,G) :: natural(G).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Referencial: nao admitir mais do que 1 filho
%                         para um mesmo individuo

+filho(F,P) :: (solucoes(Fs,(filho(Fs,P)),S),
                comprimento(S,N),
                N=<1).


idade(paulo,50).

-filho(F,P) :: (solucoes(Fs,(filho(Fs,P),idade(Fs,I)),S),
                comprimento(S,N),
                N==0).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao(Termo) :- solucoes(Invariante,+Termo::Invariante, Lista),
                            insercao(Termo),
                            teste(Lista).

involucao(Termo) :- solucoes(Invariante,-Termo::Invariante, Lista),
                            remocao(Termo),
                            teste(Lista).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo),!,fail.

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo),!,fail.

teste([]).
teste([R|Lr]) :- R, teste(Lr).

solucoes(X,P,S) :- findall(X,P,S).

comprimento(S,N) :- length(S,N).