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


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
%centro_saúde: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
%vacinação_Covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }