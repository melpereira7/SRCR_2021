%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 4


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao) :- Questao, !, fail.
nao(_).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado par: N -> {V,F}

par(0) :- !.
par(X) :- N is X-2, N >= 0, par(N).
	
%par(N):- N mod 2 =:= 0.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado impar: N -> {V,F}

impar(1) :- !.
impar(X) :- N is X-2, N >= 1, impar(N).

%impar(N):- N mod 2 =:= 1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii

natural(X) :- X>=0, I is floor(X), F is X-I, F==0.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv

inteiro(X) :- I is floor(X), F is X-I, F==0.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v

divisores(X, [X|Div]) :- XX is X//2, divisores(X,XX,[1],Div). 

divisores(_,1,L,L). 
divisores(X,Y,[H|T],[Y|L]) :- Y>1, X mod Y =:= 0, YY is Y-1, divisores(X,YY,[H|T],L),!.
divisores(X,Y,[H|T],L) :- Y>1, X mod Y =\= 0, YY is Y-1, divisores(X,YY,[H|T],L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vi

primo(X) :- divisores(X,[X,1]),!.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii

mdc(X,Y,Mdc) :- X>Y, Z is X-Y, !, mdc(Z,Y,Mdc).
mdc(X,Y,Mdc) :- X<Y, Z is Y-X, !, mdc(X,Z,Mdc).
mdc(X,X,X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii

mmc(X,Y,Mmc) :- X>=Y, mmc(X,Y,X,Mmc),!.
mmc(X,Y,Mmc) :- X<Y, mmc(Y,X,Y,Mmc),!.
mmc(X,Y,Mmc,Res) :- Mmc mod Y =\= 0, Z is X+Mmc, mmc(X,Y,Z,Res).
mmc(_,Y,Mmc,Mmc) :- Mmc mod Y =:= 0.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix

fib(0,0).
fib(1,1).
fib(X,Fib) :- X>1, Y is X-2, fib(Y,R1), Z is X-1, fib(Z,R2), Fib is R1+R2,!.


