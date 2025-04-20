// Setup


// Lezione

= Lezione 01 [26/02]

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
