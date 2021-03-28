%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Instrumento de avaliação em grupo


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op(900,xfy,'::').
:- dynamic utente/9.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_covid/5.

:- dynamic vacinada/3.
:- dynamic segunda_toma/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
%vacinacao_covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento (com exemplos arbitrários)

utente(1,211111111,ana,(1,1,2000),'ana@gmail.com','Braga','Médica',[],1).
utente(2, 221111111, maria,(5,11,2001), 'maria@gmail.com', 'Viana do Castelo', 'Professora', [asma], 1).

centro_saude(1,'USFVida+','Vila Verde',253123456,'usfvida+@gmail.com').

staff(1,1,marria,'maria@gmail.com').

vacinacao_covid(1,1,(1,1,2021),'Pfizer',1).
vacinacao_covid(1,1,(1,1,2021),'Pfizer',2).
vacinacao_covid(1,2,(1,1,2021),'Pfizer',1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas nao vacinadas

-vacinada(P) :- nao(vacinada(P)), nao(excecao(vacinada(P))).

% Identificar pessoas nao vacinadas numa certa toma
-vacinada(P,T) :- nao(vacinada(P,T)), nao(excecao(vacinada(P,T))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas

vacinada(P) :- utente(Id,_,P,_,_,_,_,_,_), vacinacao_covid(_,Id,_,_,_).

% Identificar pessoas vacinadas e qual a toma 
vacinada(P,T) :- utente(Id,_,P,_,_,_,_,_,_), vacinacao_covid(_,Id,_,_,T).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas a quem falta a segunda toma da vacina

segunda_toma(P) :- utente(Id,_,P,_,_,_,_,_,_), vacinada(P,1), nao(vacinada(P,2)).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% exemplos que criei só para testes

excecao(vacinada(maria)).

+utente(Id,NISS,Nome,D,E,M,P,DC,IdC) :: (solucoes(Id,utente(Id,NISS,Nome,D,E,M,P,DC,IdC),S),
                                      comprimento(S,N),
                                      N==1).

-utente(Id,NISS,Nome,D,E,M,P,DC,IdC) :: (solucoes(Id,(utente(Id,NISS,Nome,D,E,M,P,DC,IdC), vacinada(Nome,1)),S),
                                      comprimento(S,N),
                                      N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

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
