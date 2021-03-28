%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op(900,xfy,'::').
:- dynamic jogo/3.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado jogo: Jogo,Arbitro,Ajudas -> {V,F,D}

-jogo(Jogo,Arbitro,Ajudas) :- nao(jogo(Jogo,Arbitro,Ajudas)), nao(excecao(jogo(Jogo,Arbitro,Ajudas))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% i

jogo(1,aa,500).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii

jogo(2,bb,unknown1).
excecao(jogo(Jogo,Arbitro,Ajudas)) :- jogo(Jogo,Arbitro,unknown1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii

excecao(jogo(3,cc,500)).
excecao(jogo(3,cc,2500)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv

excecao(jogo(4,dd,Ajudas)) :- Ajudas >= 250, Ajudas =< 750.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v

jogo(5,ee,unknown3).
nulo(unknown3).
excecao(jogo(Jogo,Arbitro,Ajudas)) :- jogo(Joao,Arbitro,unknown3).
+jogo(_,_,_) :: (solucoes(Ajudas,(jogo(5,ee,Ajudas),nao(nulo(Ajudas))),S),
                    comprimento(S,N),
                    N==0).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vi

jogo(6,ff,250).
excecao(jogo(6,ff,Ajudas)) :- Ajudas >= 5000.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii

-jogo(7,gg,2500).
jogo(7,gg,unknown4).
excecao(jogo(Jogo,Arbitro,Ajudas)) :- jogo(Jogo,Arbitro,unknown4).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii

excecao(jogo(8,hh,Ajudas)) :- Ajudas =< 1.25*1000, Ajudas >= 0.75*1000.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix

excecao(jogo(9,ii,Ajudas)) :- Ajudas >= 0.9*3000, Ajudas =< 1.1*3000.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% x

+jogo(J,_,_) :: (solucoes(As,jogo(J,As,_),S),
                    comprimento(S,N),
                    N=<1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xi

+jogo(_,A,_) :: (solucoes(Js,jogo(Js,A,_),S),
                    comprimento(S,N),
                    N=<3).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xii

+jogo(_,A,_) :: (solucoes(Jogos,jogo(Jogos,A,_),S),
                    consecutivos(S,Res),
                    Res==0).

consecutivos([],0).
consecutivos([X],0).
consecutivos(L,Res) :- sort(L,[H,X|T]), H =:= (X-1), consecutivos([X|T],R), Res is R+1,!.
consecutivos(L,Res) :- sort(L,[H,X|T]), H =\= (X-1), consecutivos([X|T],Res).  


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao(Termo) :- solucoes(Invariante,+Termo::Invariante,Lista), insercao(Termo), teste(Lista).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo),!,fail.

teste([]).
teste([R|LR]) :- R, teste(LR).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao(Termo) :- solucoes(Invariante,-Termo::Invariante,Lista), remocao( Termo ), teste( Lista ).

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo),!,fail.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo(Questao,verdadeiro) :- Questao.
demo(Questao,falso) :- -Questao.
demo(Questao,desconhecido) :- nao(Questao), nao(-Questao).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao) :- Questao, !, fail.
nao(Questao).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes(X,Y,Z) :- findall(X,Y,Z).

comprimento(S,N) :- length(S,N).



