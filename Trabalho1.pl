/* María Isabel Diaz Andrade 2092318
Pedro Tomás Gomes Temtem 2044118
Sara Melissa Azevedo Freitas 2048518
Jénifer Graça Gouveia Constantino 2045618
Elimar Adriana Gonçalves Medina 2045018
Luana Filipa Ribeiro Queiroz Mendonça 2047618 */



:-op(100, fy, 'neg').
:-op(200, xfy, 'e').
:-op(300, xfy, 'ou').
:-op(400, xfy, 'imp').

/*NOTAS
{p, p → q, q} é representado da seguinte forma: [p, p imp q, q].
SIMBOLO PROPOSICIONAL: p,q, ou seja, são simvolos simples
LITERAL: ~q, q, ou seja, é o simbolo proposicional ou a negação desse
         simbolo.
*/


/*Execicio1:
   F-formula de L¬,∧,∨,→
   X-simbolo proposicional
   S-lista de simbolos proposicionais
   L-lista de 0's e 1's
   V-valoração da fomula
*/

/* a função simb_prop/1 recebe um argumento P e verifica se é ou não símbolo proposicional*/

simb_prop(P):- not(P = neg  X),not(P = X  e  Y), not(P = X ou Y), not(P = X imp Y).

/* A função concatena/3 é tal que concatena(L1,L2,L3) recebe como argumentos três listas e tem valor verdadeiro se L3 é a lista que resulta de juntar L1 e L2*/

concatena([],L,L).
concatena([X|R],L,[X|S]):-concatena(R,L,S).

/* A função membro/2 é tal que membro(X,L) recebe como argumento uma fórmula X e tem valor verdadeiro se X pertence à lista L*/

membro(X, [X | _]).
membro(X, [_ | C]):-membro(X, C).

/* A função el_rep/2 é tal que el_rep(L1,L2) recebe como argumento uma lista L1 e tem valor verdadeiro se L2 é a lista que resulta de retirar de L1 todas as ocorrências, exceto a última, de um elemento*/

el_rep([],[]).
el_rep([X|R],[X|S]):-not(membro(X,R)),el_rep(R,S).
el_rep([X|R],S):-membro(X,R),el_rep(R,S).

/* A função lista_s1/2 é tal que lista_s1(X,E) recebe como argumento X,uma fórmula de L¬,∧,∨,→, e devolve uma lista E com os símbolos proposicionais de X, sem repetições*/

lista_s1([X1],[X1]):-simb_prop(X1).
lista_s1([neg X1],[X1]):-simb_prop(X1).
lista_s1([neg X1],E):-not(simb_prop(X1)),lista_s1([X1],L),el_rep(L,E).


lista_s1([X1 e X2],E):-simb_prop(X1),simb_prop(X2),el_rep([X1,X2],E).
lista_s1([X1 e X2],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena([X2],S,L),el_rep(L,E).
lista_s1([X1 e X2],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena([X1],S,L),el_rep(L,E).
lista_s1([X1 e X2],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L),el_rep(L,E).


lista_s1([X1 ou X2],E):-simb_prop(X1),simb_prop(X2),el_rep([X1,X2],E).
lista_s1([X1 ou X2],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L),el_rep(L,E).
lista_s1([X1 ou X2],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),lista_s1([X1],R),concatena(R,S,L),el_rep(L,E).
lista_s1([X1 ou X2],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L),el_rep(L,E).


lista_s1([X1 imp X2],E):-simb_prop(X1),simb_prop(X2),el_rep([X1,X2],E).
lista_s1([X1 imp X2],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L),el_rep(L,E).
lista_s1([X1 imp X2],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),lista_s1([X1],R),concatena(R,S,L),el_rep(L,E).
lista_s1([X1 imp X2],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L),el_rep(L,E).


lista_s1([X1|F],E):-simb_prop(X1),lista_s1(F,L2),concatena([X1],L2,L),el_rep(L,E).
lista_s1([neg X1|F],E):-simb_prop(X1),lista_s1(F,L2),concatena([X1],L2,L),el_rep(L,E).
lista_s1([neg X1|F],E):-not(simb_prop(X1)),lista_s1([X1],S),lista_s1(F,L2),concatena(S,L2,L),el_rep(L,E).

lista_s1([X1 e X2|F],E):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L),el_rep(L,E).
lista_s1([X1 e X2|F],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 e X2|F],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena(S,[X1],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 e X2|F],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).

lista_s1([X1 ou X2|F],E):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L),el_rep(L,E).
lista_s1([X1 ou X2|F],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 ou X2|F],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena(S,[X1],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 ou  X2|F],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).


lista_s1([X1 imp X2|F],E):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L),el_rep(L,E).
lista_s1([X1 imp X2|F],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 imp  X2|F],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena([X1],S,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 imp  X2|F],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).


/*A função enesimo/3 é tal que enesimo(N,L,X) tem o valor verdadeiro se N é um número natural e X é o elemento que está na posição N da lista L*/
enesimo(1,[X|L],X).
enesimo(N,[X|L],Y):-enesimo(N1,L,Y), N is N1+1.

/* A função valor_log/4 é tal que ao executar uma consulta do tipo valor_log(F,S,L,V), onde F é uma fórmula (qualquer) de L¬,∧,∨,→, S uma lista (sem elementos repetidos) constituída pelos símbolos proposicionais que ocorrem nessa fórmula e L uma lista de zeros e uns com o mesmo comprimento que a lista S, este deve devolver como output V = x, onde x é o valor lógico atribuído à fórmula F por qualquer valoração v que atribui a cada
símbolo proposicional ocorrendo na lista S o valor lógico que ocorre na posição correspondente na lista L */

valor_log(F,S,L,V):-enesimo(N,S,F),enesimo(N,L,V). /*Se F é o elemento que esta na posição N da lista S, então o valor lógico de F é o valor que esta na posição N da lista L*/
valor_log(neg X,S,L,0):-valor_log(X,S,L,1).
valor_log(neg X,S,L,1):-valor_log(X,S,L,0).
valor_log(X imp Y,S,L,0):-valor_log(X,S,L,1),valor_log(Y,S,L,0).
valor_log(X imp Y,S,L,1):-valor_log(X,S,L,0).
valor_log(X imp Y,S,L,1):-valor_log(Y,S,L,1).
valor_log(X e Y,S,L,1):-valor_log(X,S,L,1),valor_log(Y,S,L,1).
valor_log(X e Y,S,L,0):-valor_log(X,S,L,0).
valor_log(X e Y,S,L,0):-valor_log(Y,S,L,0).
valor_log(X ou Y,S,L,1):-valor_log(X,S,L,1).
valor_log(X ou Y,S,L,1):-valor_log(Y,S,L,1).
valor_log(X ou Y,S,L,0):-valor_log(X,S,L,0),valor_log(Y,S,L,0).

/*A função val_sat_list_form/3 é tal que val_sat_list_form(F,S,V) recebe como argumento F sendo este uma fórmula de L¬,∧,∨,→ , uma lista S com
os símbolos proposicionais de F e uma lista V de zeros e uns, com o mesmo comprimento de S, e verifica se V satisfaz F, isto é,
se F é verdadeiro para a valoração V*/

val_sat_list_form(F,S,V):- valor_log(F,S,V,1).

/*A função val_sat_list_form2/3 é tal que val_sat_list_form(F,S,V) recebe como argumento uma lista de fórmulas de L¬,∧,∨,→ (F), uma lista com
os símbolos proposicionais de F (S) e uma lista de zeros e uns com o mesmo comprimento de S (V) e verifica se V satisfaz F, isto é,
se a valoração V é verdadeiro para cada uma das fórmulas em F.
Esta função usa a função auxiliar val_sat_list_form/3*/

val_sat_list_form2([],S,V).
val_sat_list_form2([F|T],S,V):-val_sat_list_form(F,S,V),val_sat_list_form2(T,S,V).

/*A função acrescenta/3 é tal que acrescenta(X,L1,L2) tem o valor verdadeiro se L2 é a lista que resulta de colocar o elemento X na cabeça da lista L1 */
acrescenta([],[],[]).
acrescenta([],[X1|R],[X1|S]):-acrescenta([],R,S).
acrescenta([X1|R],L,[X1|S]):-acrescenta(R,L,S).

/*A função junta_form/2 é tal que junta_form(L,S) recebe uma lista de fórmulas e une-as com e*/
junta_form([X|[]],X).
junta_form([R|L],S):-junta_form(L,P), S= R e P.

/* O predicado lista_n_0s_e_1s/2 é tal que lista_n_0s_e_1s(N,L) dado um inteiro não negativo N,
esta função tem um valor verdadeiro se e so se L for uma lista de comprimento N composta apenas por 0's e por 1's.*/
lista_n_0s_e_1s(0,[]).
lista_n_0s_e_1s(N,[0|R]):-N>0, N1 is N-1, lista_n_0s_e_1s(N1,R).
lista_n_0s_e_1s(N,[1|R]):-N>0, N1 is N-1, lista_n_0s_e_1s(N1,R).

/*O predicado todas_listas_n_0s_e_1s/2 permite obter, para um qualquer número inteiro não negativo N dado, uma lista formada por todas as
listas de comprimento N que são compostas apenas por zeros e uns.*/

todas_listas_n_0s_e_1s(N,T):-findall(L,lista_n_0s_e_1s(N,L),T).

/*O argumento comprimento/2, comprimento(L,N) dá o comprimento de uma lista L*/

comprimento([],0).
comprimento([_|X],N):-comprimento(X,N1),N is N1+1.

/*lista_val/2 devolve todas as valorações possíveis para uma determinada lista de símbolos proposicionais com comprimento N*/
lista_val([X|Y],T):-comprimento([X|Y],N),todas_listas_n_0s_e_1s(N,T).

/* A função aux_lista_val_12/4 é tal que aux_lista_val_12(X,F,S,Y), onde X é a lista de listas de todas as valorações possíveis para a fórmula presente em F, S é a lista de símbolos proposicionais na fórmula F e Y é a lista das valorações presentes em X que satisfazem a fórmula F*/
aux_lista_val_12([],F,S,[]).
aux_lista_val_12([X1|L],F,S,[X1|L2]):-valor_log(F,S,X1,1),aux_lista_val_12(L,F,S,L2).
aux_lista_val_12([X1|L],F,S,L2):-not(valor_log(F,S,X1,1)),aux_lista_val_12(L,F,S,L2).

/*A função lista_val_1/3 é tal que lista_val_1(F,S,V), onde F é uma fórmula da linguagem em uso, S é uma lista de símbolos proposicionais de F e V é a lista das valorações que satisfazem a fórmula em F*/
lista_val_1(F,S,V):-lista_val(S,T),aux_lista_val_12(T,F,S,V).

/*A função lista_val_12/3 é tal que lista_val_12(F,S,L), onde F é uma fórmula da linguagem em uso, S é uma lista de símbolos proposicionais de F e L é uma lista com as listas das valorações que satisfazem a fórmula em F */
lista_val_12(F,S,L):-findall(V,lista_val_1(F,S,V),N),el_rep(N,L).

/* O argumento final/1, final(L), é tal que recebe uma lista de fórmulas de L¬,∧,∨,→  e devolve uma lista com os símbolos
proposicionais de L, sem repetições, e uma lista de listas com todas as valorações que satisfazem L.
Por exemplo, o programa recebe [p imp q, p ou q, r] e deverá retornar [p,q,r] e [[0,1,1],[1,1,1]]*/

final([]).
final(L):-lista_s1(L,S),junta_form(L,F),lista_val_12(F,S,M),write(S),write(M).




/*EXERCICIO 2: Verifica se é ou não consequencia semnatica e manda um exemplo de valoração caso não o seja */

/*Recebe duas listas e retorna uma lista com os elementos em comum*/
intersect([],L,[]).
intersect([X|R],L,[X|Z]):-membro(X,L),intersect(R,L,Z).
intersect([X|R],L,Z):-not(membro(X,L)),intersect(R,L,Z).


/*Recebe a lista de todas as valorações, a formula, a lista de simbolos proposicionais e retorna a lista com as valorações que não satisfazem a formula*/
lista_val_nao_verifica([],F,S,[]).
lista_val_nao_verifica([X1|L],F,S,[X1|L2]):-valor_log(F,S,X1,0),lista_val_nao_verifica(L,F,S,L2).
lista_val_nao_verifica([X1|L],F,S,L2):-not(valor_log(F,S,X1,0)),lista_val_nao_verifica(L,F,S,L2).


/*Serve para que se possa gerar a lista com todas as valorações possíveis sendo que retorna as que não verificam*/
lista_val_0(F,S,V):-lista_val(S,T),lista_val_nao_verifica(T,F,S,V).
lista_val_02(F,S,L):-findall(V,lista_val_0(F,S,V),N),el_rep(N,L).

/*Recebe uma lista de listas que verificam uma dada formula e retorna essas valorações concatenadas numa so lista */
lista_concatenada([],[]):-!.
lista_concatenada([L|Ls],ListaJunta):-!,lista_concatenada(L,NewL),lista_concatenada(Ls,NewLs),concatena(NewL, NewLs, ListaJunta). /*Concatena uma lista de listas*/
lista_concatenada(L,[L]).

consequencia_semantica_aux(T,R1,M,M2,S,R2):- valor_log(T,S,R1,1), write('É consequencia semantica').
consequencia_semantica_aux(T,R1,M,M2,S,R2):-valor_log(T,S,R1,0), intersect(M,M2,L), write(' Não é consequencia semantica, valorações: '),write(L).

/*Funciona para algo do genero: consequencia_sematica([p imp (r imp q), r ou q], r imp q). Assim recebe como argumentos F que corresponde á primeira lista e T que corresponde á formula. S é o conjunto dos simbolos proposicionais de F que se obtem de lista_s1, H é a lista que se obtem da função junta_form (tem uma lista de formulas e une-as), M é a lista das valorações que satisfaz F, R1 é a lista das valorações concatenadas que satisfaz F, M2 é a lista das valorações concatenadas que não satisfazem T, R2 é uma lista que contem as valorações que satisfazem uma formula concatenada numa so lista. Assim, esta função chama a função consequencia_semantica_aux(T,R1,M,M2,S,R2) que vai verificar se são ou não efetivamente consequencias semantica*/
consequencia_semantica(F,T):-lista_s1(F,S), junta_form(F,H), lista_val_1(H,S,M),lista_concatenada(M,R1),lista_val_0(T,S,M2),lista_concatenada(M2,R2),consequencia_semantica_aux(T,R1,M,M2,S,R2).



/*Exercicio 3*/

elimina_listas2(H,S):-H=[P|T],S=[P|T].
elimina_listas([L|T],H):-L=[R|S],H=[R|S],elimina_listas2(H,P).

valor_log_a(F,S,[],V).
valor_log_a(F,S,[L|T],V):-valor_log(F,S,L,V),valor_log_a(F,S,T,V).

/*esta consequencia_sematica_adptada manda apenas true or false se for consequencia semantica */
consequencia_semantica_adap([],[]).
consequencia_semantica_adap(F,T):-lista_s1(F,S),junta_form(F,H), lista_val_12(H,S,M), elimina_listas(M,R), valor_log_a(T,S,R,1).


junta_elem_listaconj(E,[],[]).
junta_elem_listaconj(E,[X|R],[[E|X]|S]):-junta_elem_listaconj(E,R,S).

/*Com esta função temos as partes de um conjunto*/
partes([],[[]]).
partes([X|R],P):-partes(R,S),junta_elem_listaconj(X,S,T),concatena(S,T,P).

/*Recebe como argumentos a lista de formulas, conjunto(L), Uma formula F para verificar se é consequencia semantica e devolve uma lista apenas com aquelas formulas das partes de L que são consequencia semantica, C.*/
partes_cs_aux([],F,[]).
partes_cs_aux([P1|P],F,[P1|C]):-consequencia_semantica_adap(P1,F), partes_cs_aux(P,F,C).
partes_cs_aux([P1|P],F,C):-not(consequencia_semantica_adap(P1,F)), partes_cs_aux(P,F,C).
partes_cs(L,F,C):-partes(L,P),partes_cs_aux(P,F,C).


/*Um conjunto minimal é um conjunto que não contem nenhum subconjunto
 *Um conjunto deixa de ser minimal a partir do momento que contem algum
 conjunto
 Um conjunto para ser minimal não precisa de estar contido noutro */

/*Acrescenta apenas um elemento ao inicio da lista*/
acrescenta_adap4(X,L2,[X|L2]).


/*Manda true se os elementos que estao na lista [X1|L] nao estao contidos em A*/
nao_contido4([],P3).
nao_contido4([X1|L],A):-partes(A,P),not(membro(X1,P)),nao_contido4(L,A).


/*Manda a lista dos conjuntos minimais(M), recebendo como argumentos uma lista de listas em que cada uma dessas listas contem formulas. Enquanto isso vai guardando os elementos numa lista [Y1,L2] para que eles possam continuar a ser comparados*/
lista_minimais4([X1],[Y1,L2],[X1]):-nao_contido4([Y1|L2],X1),acrescenta_adap4(X1,[Y1|L2],L3). /*Base de indução: quando so tem um ultimo elemento na lista, L2 esta cheia e os elementos de L2 nao estão contidos em X1. Logo X1 é um minimal.*/
lista_minimais4([X1],[Y1|L2],[]):-not(nao_contido4([Y1|L2],X1)),acrescenta_adap4(X1,[Y1|L2],L3). /*Base de inducao: quando so tem um ultimo elemento na lista, L2 esta cheia e os elementos de L2 estão contidos em X1. Logo X1 não é um minimal*/
lista_minimais4([X1|L],[],[X1|M]):-nao_contido4(L,X1),acrescenta_adap4(X1,[],L3),lista_minimais4(L,L3,M). /*nenhum elem de L esta contido em X1 e a L2 é vazia*/
lista_minimais4([X1|L],[],M):-not(nao_contido4(L,X1)),acrescenta_adap4(X1,[],L3),lista_minimais4(L,L3,M). /*elem de L esta contido em X1 e a lista L2 esta vazia*/
lista_minimais4([X1|L],[Y1|L2],[X1|M]):-nao_contido4(L,X1),nao_contido4([Y1|L2],X1),acrescenta_adap4(X1,[Y1|L2],L3),lista_minimais4(L,L3,M). /*nenhum elem de L esta contido em X1 e a L2 nao vazia*/
lista_minimais4([X1|L],[Y1|L2],M):-not(nao_contido4(L,X1)),nao_contido4([Y1|L2],X1),acrescenta_adap4(X1,[Y1|L2],L3),lista_minimais4(L,L3,M). /*Elem da lista L esta contido em X1 mas nenhum elem de L2 esta contido em X1.X1 deixa de ser minimal porque tem elementos de outros conjuntos contidosnele logo nao vai para a lista M.*/
lista_minimais4([X1|L],[Y1|L2],M):-nao_contido4(L,X1),not(nao_contido4([Y1|L2],X1)),acrescenta_adap4(X1,[Y1|L2],L3),lista_minimais4(L,L3,M). /*Elemda lista L2 esta contido em X1 mas nenhum elem de L esta contido em X1. X1 deixa de ser minimal porque tem elementos de outros conjuntos contidos nele, logo nao vai para a lista M.*/
lista_minimais4([X1|L],[Y1|L2],M):-not(nao_contido4(L,X1)),not(nao_contido4([Y1|L2],X1)),acrescenta_adap4(X1,[Y1|L2],L3),lista_minimais4(L,L3,M). /*Elem da lista L e L2 estão contidos em X1. X1 deixa de ser um minimal porque tem elementos de outros conjuntos contidos nele, logo nao vai para a lista M.*/

/*Funciona para: exercicio3([p imp q, p ou q, p ,q],q). Recebe como argumentos uma lista de formulas,F, uma formula F1 (para selecionar os elementos de F que são consequencia semantica */
exercicio3(F,F1):-partes_cs(F,F1,C),lista_minimais4(C,[],M),write(M).
