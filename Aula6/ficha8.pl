%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


:- op( 900,xfy,'::' ).
:- dynamic servico/2.
:- dynamic ato/4.


%-------------------------------------------------
% Aplicação do PMF

-servico(Servico, Nome) :- 
    nao(servico(Servico, Nome)), 
    nao(excecao(servico(Servico, Nome))).
	
-ato(Ato, Prestador, Utente, Dia) :- 
    nao(ato(Ato, Prestador, Utente, Dia)), 
    nao(excecao(ato(Ato, Prestador, Utente, Dia))).


%--------------------------------- - - - - - - - - - -  -
% a)

%servico(Servico,Enfermeira).

%ato(Ato,Enfermeira,Utente,Data).


%--------------------------------- - - - - - - - - - -  -
% b)

servico(ortopedia, amelia).

servico(obstetricia, ana).

servico(obstetricia,maria).

servico(obstetricia,mariana).

servico(geriatria,sofia).

servico(geriatria,susana).

servico(x007,teodora).
excecao(servico(S,E)) :- servico(x007,E).

nulo(np9).
servico(np9,zulmira).
excecao(servico(S,E)) :- servico(np9,E).
+servico(_,_) :: (solucoes(Serv,(servico(Serv,zulmira),nao(nulo(Serv))),S),
                    comprimento(S,N),
                    N==0).

ato(penso,ana,joana,sabado).

ato(gesso,amelia,jose,domingo).

ato(x017,mariana,joaquina,domingo).
excecao(ato(A,E,U,D)) :- ato(x017,E,U,D).

ato(domicilio,maria,x121,x251).
excecao(ato(A,E,U,D)) :- ato(A,E,x121,x251).

excecao(ato(domicilio,susana,joao,segunda)).
excecao(ato(domicilio,susana,jose,segunda)).

ato(sutura,x313,josue,segunda).
excecao(ato(A,E,U,D)) :- ato(A,x313,U,D).

excecao(ato(sutura,maria,josefa,terca)).
excecao(ato(sutura,mariana,josefa,terca)).
excecao(ato(sutura,maria,josefa,sexta)).
excecao(ato(sutura,mariana,josefa,sexta)).

excecao(ato(penso,ana,jacinta,Data)) :- pertence(Data,[segunda,terca,quarta,quinta,sexta]).


%--------------------------------- - - - - - - - - - -  -
% c)

+ato(_,_,_,D) :: (solucoes(D,ato(A,E,U,D),S),
                  nao(pertence(feriado,S))).


%--------------------------------- - - - - - - - - - -  -
% d)

-servico(_,E) :: (solucoes(A,ato(A,E,_,_),S),
                   comprimento(S,N),
                   N==0).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).



pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).


					

				 


