// Setup


// Lezione

= Lezione 02 [28/02]

== Grammatiche

Una *grammatica* è una tupla $(V, Sigma, P, S)$, con:
- $V$ _insieme finito e non vuoto_ delle *variabili*; queste ultime sono anche dette _simboli non terminali_ e sono usate durante il processo di generazione delle parole del linguaggio; sono anche detti meta-simboli;
- $Sigma$ _insieme finito e non vuoto_ dei *simboli terminali*; questi ultimi appaiono nelle parole generate, a differenza delle variabili che invece non possono essere presenti;
- $P$ _insieme finito_ e _non vuoto_ delle *regole di produzione*;
- $S in V$ *simbolo iniziale* o *assioma*, è il punto di partenza della generazione.

=== Regole di produzione

Soffermiamoci sulle regole di produzione: la forma di queste ultime è $alpha arrow.long beta$, con $alpha in (V union Sigma)^+$ e $beta in (V union Sigma)^*$. Non l'abbiamo detto la scorsa volta, ma la notazione con il $+$ è praticamente $Sigma^*$ senza la parola vuota.

Una regola di produzione viene letta come _"se ho $alpha$ allora posso sostituirlo con $beta$"_.

L'applicazione delle regole di produzione è alla base del *processo di derivazione*: esso è formato infatti da una serie di *passi di derivazione*, che permettono di generare una parola del linguaggio.

Diciamo che $x$ deriva $y$ in un passo, con $x,y in (V union Sigma)^*$, se e solo se $exists (alpha arrow.long beta) in P$ e $exists eta, delta in (V union Sigma)^*$ tali che $x = eta alpha delta$ e $y = eta beta delta$.

Il passo di derivazione lo indichiamo con $x arrow.stroked y$.

La versione estesa afferma che $x$ deriva $y$ in $k gt.eq 0$ passi, e lo indichiamo con $x arrow.stroked^k y$, se e solo se $exists x_0, dots, x_k in (V union Sigma)^*$ tali che $x = x_0$, $x_k = y$ e $x_(i-1) arrow.stroked x_i quad forall i in [1,k]$.

Teniamo anche il caso $k = 0$ per dire che da $x$ derivo $x$ stesso, ma è solo per comodità.

Se non ho indicazioni sul numero di passi $k$ posso scrivere:
- $x arrow.stroked^* y$ per indicare un numero generico di passi, e questo vale se e solo se $exists k gt.eq 0$ tale che $x arrow.stroked^k y$;
- $x arrow.stroked^+ y$ per indicare che serve almeno un passo, e questo vale se e solo se $exists k gt 0$ tale che $x arrow.stroked^k y$.

=== Linguaggio generato da una grammatica

Indichiamo con $L(G)$ il linguaggio generato dalla grammatica $G$, ed è l'insieme ${w in Sigma^* bar.v S arrow.stroked^* w}$. In poche parole, è l'insieme di tutte le stringhe di non terminali che si possono ottenere tramite *derivazioni* a partire dall'assioma $S$ della grammatica.

In questo insieme abbiamo solo stringhe di non terminali che otteniamo tramite derivazioni. Le stringhe intermedie che otteniamo nei vari passi di derivazioni sono dette *forme sintattiche*.

Due grammatiche $G_1, G_2$ sono *equivalenti* se e solo se $L(G_1) = L(G_2)$.

Se consideriamo l'esempio delle parentesi ben bilanciate, possiamo definire una grammatica per questo linguaggio con le seguenti regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long (S)$;
- $S arrow.long S S$.

/*
Vediamo un esempio più complesso. Siano:
- $Sigma = {a,b,c}$;
- $V = {S, B}$;
- $P = {S arrow.long a B S c bar.v a b c, B a arrow.long a B, B b arrow.long b b}$.

Questa grammatica genera il linguaggio $L(G) = {a^n b^n c^n bar.v n gt.eq 1}$: infatti, il "caso base" genera la stringa _abc_, mentre le iterazioni "maggiori" generano il numero di _a_ e _c_ corretti, con i primi che vengono ordinati prima di inserire anche il numero corretto di _b_.
*/

Vediamo un esempio più complesso. Siano:
- $Sigma = {a,b}$;
- $V = {S, A, B}$;
- $P = {S arrow.long a B bar.v b A, A arrow.long a bar.v a S bar.v b A A, B arrow.long b bar.v b S bar.v a B B}$.

Questa grammatica genera il linguaggio $L(G) = {w in Sigma^* bar.v hash_a (w) = hash_b (w)}$: infatti, ogni volta che inserisco una $a$ inserisco anche una $B$ per permettere poi di inserire una $b$. Il discorso vale lo stesso a lettere invertite.

Vediamo un esempio ancora più complesso. Siano:
- $Sigma = {a,b}$;
- $V = {S, A, B, C, D, E}$;
- $P = {S arrow.long A B C, A B arrow.long epsilon bar.v a A D bar.v b A E, D C arrow.long B a C, E C arrow.long B b C, D a arrow.long a D, D b arrow.long b D, E a arrow.long a E, E b arrow.long b E, C arrow.long epsilon, a B arrow.long B a, b B arrow.long B b}$.

Questa grammatica genera il linguaggio pappagallo $L(G) = {w w bar.v w in Sigma^*}$: infatti, eseguendo un paio di derivazioni si nota questo pattern.

== Gerarchia di Chomsky

Negli anni $'50$ Noam Chomsky studia la generazione dei linguaggi formali e crea una *gerarchia di grammatiche formali*. La classificazione delle grammatiche viene fatta in base alle regole di produzione che definiscono la grammatica.

#align(center)[
  #table(
    columns: (31%, 37%, 32%),
    inset: 10pt,
    align: horizon,
    [*Grammatica*], [*Regole*], [*Modello riconoscitivo*],
    [*Tipo 0*], [Nessuna restrizione, sono il tipo più generale], [*Macchine di Turing*],
    [*Tipo 1*, dette *context-sensitive* o _dipendenti dal contesto_.],
    [Se $(alpha arrow.long beta) in P$ allora $abs(beta) gt.eq abs(alpha)$, ovvero devo generare parole che non siano più corte di quella di partenza. \ \ Sono dette _dipendenti dal contesto_ perché ogni regola $(alpha arrow.long beta) in P$ può essere riscritta come $alpha_1 A alpha_2 arrow.long alpha_1 B alpha_2$, con $alpha_1, alpha_2 in (V union Sigma)^*$ che rappresentano il _contesto_, $A in V$ e $B in (V union Sigma)^+$],
    [*Automi limitati linearmente*],

    [*Tipo 2*, dette *context-free* o _libere dal contesto_],
    [Le regole in $P$ sono del tipo $alpha arrow.long beta$, con $alpha in V$ e $beta in (V union Sigma)^+$.],
    [*Automi a pila*],

    [*Tipo 3*, dette *grammatiche regolari*],
    [Le regole in $P$ sono del tipo $A arrow.long a B$ oppure $A arrow.long a$, con $A,B in V$ e $a in Sigma$. Vale anche il simmetrico.],
    [*Automi a stati finiti*],
  )
]

Nella figura successiva vediamo una rappresentazione grafica della gerarchia di Chomsky: notiamo come sia una gerarchia propria, ovvero $ L_3 subset L_2 subset L_1 subset L_0, $ ma questa gerarchia non esaurisce comunque tutti i linguaggi possibili. Esistono infatti linguaggi che non sono descrivibili in maniera finita con le grammatiche.

#v(12pt)

#figure(image("assets/02_gerarchia.svg", width: 70%))

#v(12pt)

Sia $L subset.eq Sigma^*$, allora $L$ è di tipo $i$, con $i in [0,3]$, se e solo se esiste una grammatica $G$ di tipo $i$ tale che $L = L(G)$, ovvero posso generare $L$ a partire dalla grammatica di tipo $i$.

Se una grammatica é di tipo $1$ allora possiamo costruire una macchina che sia in grado di dire, in tempo finito, se una parola appartiene o meno al linguaggio generato da quella grammatica. Questa macchina è detta *verificatore* e si dice che le grammatiche di tipo $1$ sono *decidibili*.
