// Setup

#import "template.typ": project

#show: project.with(
  title: "Teoria dei linguaggi"
)

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#pagebreak()

// Appunti

/* INIZIO LEZIONE 01 */

= Introduzione

== Storia

Un *linguaggio* è _uno strumento di comunicazione usato da membri di una stessa comunità_, ed è composto da due elementi:
- *sintassi*: insieme di simboli (o _parole_) che devono essere combinati con una serie di regole;
- *semantica*: associazione frase-significato.

Per i linguaggi naturali è difficile dare delle regole sintattiche: vista questa difficoltà, nel 1956 *Noam Chomsky* introduce il concetto di *grammatiche formali*, che si servono di regole matematiche per la definizione della sintassi di un linguaggio.

Il primo utilizzo dei linguaggi risale agli stessi anni con il *compilatore Fortran*, ovvero un traduttore da un linguaggio di alto livello ad uno di basso livello, ovvero il _linguaggio macchina_.

== Ripasso

Un *alfabeto* è un insieme _non vuoto_ e _finito_ di simboli, di solito indicato con $Sigma$ o $Gamma$.

Una *stringa* (o *parola*) è una sequenza _finita_ di simboli appartenenti a $Sigma$.

Data una parola $w$, possiamo definire:
- $|w|$ _numero di caratteri_ di $w$;
- $|w|_a$ _numero di occorrenze_ della lettera $a in Sigma$ in $w$.

Una parola molto importante è la *parola vuota* $epsilon$, che, come dice il nome, ha simboli, ovvero $|epsilon| = 0$.

L'insieme di tutte le possibili parole su $Sigma$ è detto $Sigma^*$.

Un'importante operazione sulle parole è la *concatenazione* (o _prodotto_), ovvero se $x,y in Sigma^*$ allora la concatenazione $w$ è la parola $w = x y$.

Questo operatore di concatenazione:
- _non è commutativo_, infatti $w_1 = x y eq.not y z = w_2$ in generale;
- _è associativo_, infatti $(x y) z = x (y z)$.

La struttura $(Sigma^*, dot, epsilon)$ è un *monoide* libero generato da $Sigma$.

Vediamo ora alcune proprietà delle parole:
- *prefisso*: $x$ si dice _prefisso_ di $w$ se esiste $y in Sigma^*$ tale che $x y = w$;
  - *prefisso proprio* se $y eq.not epsilon$;
  - *prefisso non banale* se $x eq.not epsilon$;
  - il numero di prefissi è uguale a $|w|+1$.
- *suffisso*: $y$ si dice _suffisso_ di $w$ se esiste $x in Sigma^*$ tale che $x y = w$;
  - *suffisso proprio* se $x eq.not epsilon$;
  - *suffisso non banale* se $y eq.not epsilon$;
  - il numero di suffissi è uguale a $|w|+1$.
- *fattore*: $y$ si dice _fattore_ di $w$ se esistono $x,z in Sigma^*$ tali che $x y z = w$;
  - il numero di fattori è al massimo $frac(|w| dot |w+1|, 2) + 1$.
- *sottosequenza*: $x$ si dice _sottosequenza_ di $w$ se $x$ è ottenuta eliminando $0$ o più caratteri da $w$;
  - un _fattore_ è una sottosequenza ordinata.

Un *linguaggio* $L$ definito su un alfabeto $Sigma$ è un qualunque sottoinsieme di $Sigma^*$.

#pagebreak()

= Gerarchia di Chomsky

== Rappresentazione

Vogliamo rappresentare in maniera finita un oggetto infinito come un linguaggio.

Abbiamo a nostra disposizione due modelli molto potenti:
- *generativo*: date delle regole, si parte da _un certo punto_ e si generano tutte le parole di quel linguaggio con le regole date; parleremo di questi modelli tramite le _grammatiche_;
- *riconoscitivo*: si usano dei _modelli di calcolo_ che prendono in input una parola e dicono se appartiene o meno al linguaggio.

Considerando il linguaggio sull'alfabeto ${(,)}$ delle parole ben bilanciate, proviamo a dare due modelli:
- _generativo_: a partire da una sorgente $S$ devo applicare delle regole per derivate tutte le parole appartenenti a questo linguaggio;
  - la parola vuota $epsilon$ è ben bilanciata;
  - se $x$ è ben bilanciata, allora anche $(x)$ è ben bilanciata;
  - se $x,y$ sono ben bilanciate, allora anche $x y$ sono ben bilanciate.
- _riconoscitivo_: abbiamo una _black-box_ che prende una parola e ci dice se appartiene o meno al linguaggio (in realtà potrebbe non terminare mai la sua esecuzione);
  - $\#\( space = space \#\)$;
  - per ogni prefisso, $\#\( space gt.eq space \#\)$.

/* FINE LEZIONE 01 */

/* INIZIO LEZIONE 02 */

== Grammatiche

Una *grammatica* è una tupla $(V, Sigma, P, S)$, con:
- $V$ _insieme finito e non vuoto_ delle *variabili*; queste ultime sono anche dette _simboli non terminali_ e sono usate durante il processo di generazione delle parole del linguaggio;
- $Sigma$ _insieme finito e non vuoto_ dei *simboli terminali*; questi ultimi appaiono nelle parole generate, a differenza delle variabili che invece non possono essere presenti;
- $P$ _insieme finito_ delle *regole di produzione*;
- $S in V$ *simbolo iniziale* o *assioma*, è il punto di partenza della generazione.

=== Regole di produzione

Soffermiamoci sulle regole di produzione: la forma di queste ultime è $alpha arrow.long beta$, con $alpha in (V union Sigma)^+$ e $beta in (V union Sigma)^*$.

Una regola di produzione viene letta come "$italic("se ho ") alpha italic("allora posso sostituirlo con ") beta$".

L'applicazione delle regole di produzione è alla base del *processo di derivazione*: esso è formato infatti da una serie di *passi di derivazione*, che permettono di generare una parola del linguaggio.

Diciamo che $x$ deriva $y$ in un passo, con $x,y in (V union Sigma)^*$, se e solo se $exists (alpha arrow.long beta) in P$ e $exists eta, delta in (V union Sigma)^*$ tali che $x = eta alpha delta$ e $y = eta beta delta$.

Il passo di derivazione lo indichiamo con $x arrow.stroked y$.

La versione estesa afferma che $x$ deriva $y$ in $k gt.eq 0$ passi, e lo indichiamo con $x arrow.stroked^k y$, se e solo se $exists x_0, dots, x_k in (V union Sigma)^*$ tali che $x = x_0$, $x_k = y$ e $x_(i-1) arrow.stroked x_i space.quarter forall i in [1,k]$.

Se non ho indicazioni sul numero di passi $k$ posso scrivere:
- $x arrow.stroked^* y$ per indicare un numero generico di passi, e questo vale se e solo se $exists k gt.eq 0$ tale che $x arrow.stroked^k y$;
- $x arrow.stroked^+ y$ per indicare che serve almeno un passo, e questo vale se e solo se $exists k gt 0$ tale che $x arrow.stroked^k y$.

=== Linguaggio generato da una grammatica

Indichiamo con $L(G)$ il linguaggio generato dalla grammatica $G$, ed è l'insieme ${w in Sigma^* bar.v S arrow.stroked^* w}$.

Due grammatiche $G_1, G_2$ sono *equivalenti* se e solo se $L(G_1) = L(G_2)$.

Se consideriamo l'esempio delle parentesi ben bilanciate, possiamo definire una grammatica per questo linguaggio con le seguenti regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long (S)$;
- $S arrow.long S S$.

Vediamo un esempio più complesso. Siano:
- $Sigma = {a,b,c}$;
- $V = {S, B}$;
- $P = {S arrow.long a B S c bar.v a b c, B a arrow.long a B, B b arrow.long b b}$.

Questa grammatica genera il linguaggio $L(G) = {a^n b^n c^n bar.v n gt.eq 1}$: infatti, il "caso base" genera la stringa _abc_, mentre le iterazioni "maggiori" generano il numero di _a_ e _c_ corretti, con i primi che vengono ordinati prima di inserire anche il numero corretto di _b_.

== Gerarchia

Negli anni 50 Noam Chomsky studia la generazione dei linguaggi formali e crea una *gerarchia di grammatiche formali*. La classificazione delle grammatiche viene fatta in base alle regole di produzione che definiscono la grammatica.

#align(center)[
  #table(
    columns: (31%, 37%, 32%),
    inset: 10pt,
    align: horizon,

    [*Grammatica*], [*Regole*], [*Modello riconoscitivo*],

    [_Tipo 0_.], [Nessuna restrizione, sono il tipo più generale.], [_Macchine di Turing_.],
    
    [_Tipo 1_, dette *context-sensitive* o _dipendenti dal contesto_.], [Se $(alpha arrow.long beta) in P$ allora $|beta| gt.eq |alpha|$, ovvero devo generare parole che non siano più corte di quella di partenza. \ \ Sono dette _dipendenti dal contesto_ perché ogni regola $(alpha arrow.long beta) in P$ può essere riscritta come $alpha_1 A alpha_2 arrow.long alpha_1 B alpha_2$, $space.thin$ dove $alpha_1$ e $alpha_2$ rappresentano il _contesto_.], [_Automi limitati linearmente_.],
    
    [_Tipo 2_, dette *context-free* o _libere dal contesto_.], [Le regole in $P$ sono del tipo $alpha arrow.long beta$, con $alpha in V$ e $beta in (V union Sigma)^+$.], [_Automi a pila_.],
    
    [_Tipo 3_, dette *grammatiche regolari*], [Le regole in $P$ sono del tipo $A arrow.long a B$ oppure $A arrow.long a$, con $A,B in V$ e $a in Sigma$. \ Vale anche il simmetrico.], [_Automi a stati finiti_.],
  )
]

Nella figura successiva vediamo una rappresentazione grafica della gerarchia di Chomsky: notiamo come sia una gerarchia propria, ovvero $ L_3 subset L_2 subset L_1 subset L_0, $ ma questa gerarchia non esaurisce comunque tutti i linguaggi possibili.

#v(12pt)

#figure(
  image("assets/gerarchia.svg", width: 50%)
)

#v(12pt)

Sia $L subset.eq Sigma^*$, allora $L$ è di tipo $i$, con $i in [0,3]$, se e solo se esiste una grammatica $G$ di tipo $i$ tale che $L = L(G)$, ovvero posso generare $L$ a partire dalla grammatica di tipo $i$.

== Potenza computazionale

Se una grammatica é di tipo 1 allora possiamo costruire una macchina che sia in grado di dire, in tempo finito, se una parola appartiene o meno al linguaggio generato da quella grammatica.

#theorem()[
  Una grammatica di tipo 1 è *decidibile*.
]<thm>

#proof[
  \ Siano $G$ una grammatica di tipo 1 e $w in Sigma^*$, ci chiediamo se $w in L(G)$. \ Sia $h = |w|$, ma allora essendo $G$ di tipo 1 ogni forma sentenziale che compare in $P$ non deve superare la lunghezza $h$, altrimenti potremmo ridurre il numero di caratteri presenti nella forma sentenziale e andare contro la definizione di grammatica di tipo 1. \ \ Sia $T_i = {gamma in (V union Sigma)^(lt.eq n) bar.v S arrow.stroked^(lt.eq i) gamma}$ l'insieme di tutte le parole generate dalla grammatica $G$ che hanno al massimo $n$ caratteri e sono generate in massimo $i$ passi di derivazione. \ Data questa definizione di $T_i$ possiamo affermare che:
  - $T_0 = {S}$;
  - $T_i = T_(i-1) union {gamma in (V union Sigma)^(lt.eq n) bar.v exists beta in T_(i-1) text(" tale che ") beta arrow.stroked gamma}.$

  Per come sono costruiti gli insiemi $T_i$ possiamo affermare che $ T_0 subset.eq T_1 subset.eq dots subset.eq (V union Sigma)^(lt.eq n), $ ma quest'ultimo insieme è un insieme _finito_. \ Prima o poi non si potranno più generare delle stringhe, ovvero $exists k$ tale che $T_(k-1) = T_k$. \ Una volta individuato questo valore $k$ basta controllare se $w in T_k$.
]<proof>

Questo non vale invece per le grammatiche di tipo 0: infatti, queste sono dette *semidecidibili*, in quanto un sistema riconoscitivo potrebbe non terminare mai l'algoritmo di riconoscimento e finire quindi in un loop infinito.

#theorem()[
  Una grammatica di tipo 0 è *semidecidibile*.
]

#proof[
  \ Siano $G$ una grammatica di tipo 0 e $w in Sigma^*$, ci chiediamo se $w in L(G)$. \ Non essendo $G$ di tipo 1 non abbiamo il vincolo $|beta| gt.eq |alpha|$ nelle regole di produzione. \ \ Sia $U_i = {gamma in (V union Sigma)^* bar.v S arrow.stroked^(lt.eq i) gamma}$ l'insieme di tutte le parole generate dalla grammatica $G$ in massimo $i$ passi di derivazione. \ Data questa definizione di $U_i$ possiamo affermare che:
  - $U_0 = {S}$;
  - $U_i = U_(i-1) union {gamma in (V union Sigma)^* bar.v exists beta in U_(i-1) text(" tale che ") beta arrow.stroked gamma}$.

  Per come sono costruiti gli insiemi $U_i$ possiamo affermare che $ U_0 subset.eq U_1 subset.eq dots subset.eq (V union Sigma)^*, $ ma quest'ultimo insieme è un insieme _infinito_. \ Vista questa caratteristica, nessuno garantisce l'esistenza di un $k$ tale che $U_(k-1) = U_k$ e quindi non si ha la certezza di terminare l'algoritmo di riconoscimento.
]<proof>

Le grammatiche di tipo 0 generano i *linguaggi ricorsivamente enumerabili*: per stabilire se $w in L(G)$ devo _elencare_ con un programma tutte le stringhe del linguaggio e controllare se $w$ compare in esse.

Questa operazione di elencazione in poche parole è la generazione degli insiemi $U_i$, che poi vengono ispezionati per vedere se la parole $w$ è presente o meno.

/* FINE LEZIONE 02 */
