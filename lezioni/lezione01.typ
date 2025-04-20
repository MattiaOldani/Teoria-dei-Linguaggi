// Setup


// Lezione

= Lezione 01 [26/02]

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
