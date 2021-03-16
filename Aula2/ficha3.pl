%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha 3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

nao(Questao) :- Questao,!,fail.
nao(_).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}
% i

pertence(X,[X|_]).
pertence(X,[Y|L]) :- X\=Y, pertence(X,L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}
% ii

comprimento([],0).
comprimento([_|L],N) :- comprimento(L,N1), N is N1+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado diferentes: Lista,Diferentes -> {V,F}
% iii

diferentes([],0).
diferentes([H|T],Dif) :- pertence(H,T), diferentes(T,Dif).
diferentes([H|T],Dif) :- nao(pertence(H,T)), diferentes(T,N), Dif is N+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}
% iv

apagar(_,[],[]).
apagar(X,[X|T],T).
apagar(X,[H|T],[H|Res]) :- X\=H, apagar(X,T,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}
% v

apagatudo(_,[],[]).
apagatudo(X,[X|T],Res) :- apagatudo(X,T,Res).
apagatudo(X,[H|T],[H|Res]) :- X\=H, apagatudo(X,T,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}
% vi

adicionar(X,[],[X]).
adicionar(X,L,[X|L]) :- nao(pertence(X,L)).
adicionar(X,L,L) :- pertence(X,L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}
% vii

concatenar([],L,L).
concatenar([H1|T1],L2,[H1|Res]) :- concatenar(T1,L2,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}
% viii

inverter([],[]).
inverter([H|T],Res) :- inverter(T,R), concatenar(R,[H],Res).

% -- ou --
%inverter([],[]).
%inverter(L,Res) :- accinverter(L,[],Res).

%accinverter([],L,L).
%accinverter([H|T],Acc,Res) :- accinverter(T,[H|Acc],Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}
%ix

prefixo(L1,R) :- concatenar(L1,_,R).
sufixo(L1,R) :- concatenar(_,L1,R).

sublista([],_).
sublista(SL,L) :- sufixo(Suf,L), prefixo(SL,Suf).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% x

