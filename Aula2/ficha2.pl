%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 2

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}
% i

soma( X,Y,Soma ) :-
    Soma is X+Y.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii

soma(X,Y,Z,Soma) :- Soma is X+Y+Z.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii

soma([],0).
soma([H|T],Soma) :- soma(T,Acc), Soma is H+Acc.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv

op(+,X,Y,Add) :- Add is X+Y.
op(-,X,Y,Sub) :- Sub is X-Y.
op(*,X,Y,Mul) :- Mul is X*Y.
op(/,X,Y,Div) :- Y\=0, Div is X/Y.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v

opL(_,[],0).
opL(+,[H|T],Add) :- opL(+,T,Acc), Add is H+Acc.
opL(*,[H|T],Mul) :- opL(*,T,Acc), Mul is H*Acc.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vi

maior(X,Y,X) :- X>=Y.
maior(X,Y,Y) :- X<Y.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii

maior(X,Y,Z,Res) :- maior(X,Y,Acc), maior(Acc,Z,Final), Res is Final.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii

maior([],0).
maior([H|T],Res) :- maior(T,Acc), maior(H,Acc,R), Res is R. 


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix

menor(X,Y,X) :- X=<Y.
menor(X,Y,Y) :- Y<X.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% x

menor(X,Y,Z,Res) :- menor(X,Y,Acc), menor(Acc,Z,Final), Res is Final.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xi

menor([],0).
menor([H|T],Res) :- accmenor([H|T],H,Acc), Res is Acc. 

accmenor([],X,X).
accmenor([H|T],X,Acc) :- accmenor(T,X,R), menor(R,H,Res), Acc is Res. 


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xii

media([],0).
media([H|T],Med) :- soma([H|T],Soma), length([H|T],Len), Med is Soma/Len.

% -- ou --
%media([],0).
%media([H|T],Med) :- accmedia([H|T],Soma,Len), Med is Soma/Len.

%accmedia([],0,0).
%accmedia([H|T],Soma,Len) :- accmedia(T,Auxsoma,Auxlen), Soma is Auxsoma+H, Len is Auxlen+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xiii

apagatudo(_,[],[]).
apagatudo(X,[X|T],Res) :- apagatudo(X,T,Res).
apagatudo(X,[H|T],[H|Res]) :- X\=H, apagatudo(X,T,Res).

ordenacres([],[]).
ordenacres([H|T],[M|Res]) :- menor([H|T],M), apagatudo(M,[H|T],L), ordenacres(L,Res).


%apagar(_,[],[]).
%apagar(X,[X|T],T).
%apagar(X,[H|T],[H|Res]) :- X\=H, apagar(X,T,Res).

%ordena([],[]).
%ordena([H|T], [R|RT]) :- menor([H|T],R), apagar(R,[H|T],Tail), ordena(Tail,RT).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xiv

ordenadecres([],[]).
ordenadecres([H|T],[M|Res]) :- maior([H|T],M), apagatudo(M,[H|T],L), ordenadecres(L,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xv

vazios([],0).
vazios([H|T],Res) :- H=[], vazios(T,R), Res is R+1.
vazios([H|T],Res) :- H\=[], vazios(T,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xvi

nao(Questao) :- Questao,!,fail.
nao(_).