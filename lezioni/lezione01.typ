// Setup


// Lezione

= Lezione 01 [26/02]

== Cosa faremo

In questo corso studieremo dei sistemi formali che possiamo quindi descrivere a livello matematico. Questi sistemi descrivono dei linguaggi. Ci chiediamo giustamente cosa sono in grado di fare questi sistemi, ovvero cosa sono in grado di descrivere in termini di linguaggi.

Ci occuperemo anche delle risorse utilizzate dal sistema o delle risorse necessarie per descrivere il linguaggio. Per le prime citate, ci occuperemo del tempo come numero di mosse eseguite da una macchina riconoscitrice oppure del numero di stati per descrivere, ad esempio, una macchina a stati finiti oppure dello spazio utilizzato da una macchina di Turing. Queste ultime due questioni rientrano più nella complessità descrizionale di una macchina.

== Storia

Un *linguaggio* è _uno strumento di comunicazione usato da membri di una stessa comunità_, ed è composto da due elementi:
- *sintassi*: insieme di simboli (o _parole_) che devono essere combinati/e con una serie di regole;
- *semantica*: associazione frase-significato.

Per i linguaggi naturali è difficile dare delle regole sintattiche: vista questa difficoltà, nel $1956$ *Noam Chomsky* introduce il concetto di *grammatiche formali*, che si servono di regole matematiche per la definizione della sintassi di un linguaggio.

Il primo utilizzo dei linguaggi risale agli stessi anni con il *compilatore Fortran*. Anche se ci hanno messo l'equivalente di 18 anni/uomo, questa è la prima applicazione dei linguaggi formali. Con l'avvento, negli anni successivi, dei linguaggi Algol, quindi linguaggi con strutture di controllo, la teoria dei linguaggi formali è diventata sempre più importante.

Oggi la teoria dei linguaggi formali sono usati nei compilatori di compilatori, dei tool usati per generare dei compilatori per un dato linguaggio fornendo la descrizione di quest'ultimo.

== Ripasso

Un *alfabeto* è un insieme _non vuoto_ e _finito_ di simboli, di solito indicato con $Sigma$ o $Gamma$.

Una *stringa* $x$ (o *parola*) è una sequenza _finita_ $x = a_1 dots a_n$ di simboli appartenenti a $Sigma$.

Data una parola $w$, possiamo definire:
- $|w|$ _numero di caratteri_ di $w$;
- $|w|_a$ _numero di occorrenze_ della lettera $a in Sigma$ in $w$.

Una parola molto importante è la *parola vuota* $epsilon$ o $lambda$, che, come dice il nome, ha simboli, ovvero $abs(epsilon) = abs(lambda) = 0$ (ogni tanto è $Lambda$).

L'insieme di tutte le possibili parole su $Sigma$ è detto $Sigma^*$, ed è un insieme infinito.

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
  - il numero di fattori è al massimo $frac(abs(w) abs(w+1), 2) + 1$, visti i doppioni.
- *sottosequenza*: $x$ si dice _sottosequenza_ di $w$ se $x$ è ottenuta eliminando $0$ o più caratteri da $w$; in poche parole, $x$ si ottiene da $w$ scegliendo dei simboli IN ORDINE; non devono essere caratteri contigui, basta che una volta scelti i caratteri essi siano mantenuti nell'ordine di apparizione della stringa iniziale;
  - un _fattore_ è una sottosequenza contigua.

Un *linguaggio* $L$ definito su un alfabeto $Sigma$ è un qualunque sottoinsieme di $Sigma^*$.

== Gerarchia di Chomsky

Vogliamo rappresentare in maniera finita un oggetto infinito come un linguaggio.

Abbiamo a nostra disposizione due modelli molto potenti:
- *generativo*: date delle regole, si parte da _un certo punto_ e si generano tutte le parole di quel linguaggio con le regole date; parleremo di questi modelli tramite le _grammatiche_;
- *riconoscitivo*: si usano dei _modelli di calcolo_ che prendono in input una parola e dicono se appartiene o meno al linguaggio.

Considerando il linguaggio sull'alfabeto ${(,)}$ delle parole ben bilanciate, proviamo a dare due modelli:
- _generativo_: a partire da una sorgente $S$ devo applicare delle regole per derivate tutte le parole appartenenti a questo linguaggio;
  - la parola vuota $epsilon$ è ben bilanciata;
  - se $x$ è ben bilanciata, allora anche $(x)$ è ben bilanciata;
  - se $x,y$ sono ben bilanciate, allora anche $x y$ è ben bilanciata.
- _riconoscitivo_: abbiamo una _black-box_ che prende una parola e ci dice se appartiene o meno al linguaggio (in realtà potrebbe non terminare mai la sua esecuzione);
  - $hash ( space = space hash )$;
  - per ogni prefisso, $hash ( space gt.eq space hash )$.
