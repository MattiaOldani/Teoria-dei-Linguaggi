// Setup

#import "template.typ": project

#show: project.with(
  title: "Teoria dei linguaggi"
)

#pagebreak()

// Appunti

= Introduzione

== Richiamo sugli insiemi

Un *insieme* $S$ è una collezione di elementi di un certo dominio $U$

Fissato un insieme $S$, se è finito allora $|S|$ indica la sua *cardinalità*, ovvero il numero di elementi che contiene

Un insieme particolare è l'*insieme vuoto* $emptyset.rev$, l'unico insieme che ha cardinalità $0$

Sugli insiemi possiamo definire alcune operazioni:
- _intersezione_ $A sect B$ contiene gli elementi comuni di $A$ e $B$
- _unione_ $A union B$ contiene gli elementi di $A$ e $B$ assieme
- _differenza_ $A - B$ o $A \/ B$ contiene gli elementi di $A$ che non sono in $B$
- _complementare_ $A^c$ o $overline(A)$ contiene gli elementi di $U$ cje non sono in $A$
- _sottoinsieme_ $A subset B$ proprio oppure $A subset.eq B$ non proprio

== Richiamo sugli alfabeti e i linguaggi

Un *alfabeto* è un insieme di caratteri e simboli sul quale è possibile definire un *linguaggio*: quest'ultimo infatti è un insieme di parole costruite a partire dall'alfabeto dato

Ogni *parola* è una sequenza di caratteri (detti anche simboli o lettere) dell'alfabeto

Tra le parole di un linguaggio c'è anche la *parola vuota* $epsilon$

Un linguaggio può essere *finito* (linguaggio composto dalle parole italiane) oppure *infinito* (linguaggio sull'alfabeto ${(, )}$ delle parole ben bilanciate)

Per rappresentare i linguaggi possiamo usare diversi modelli
- *dichiarativo*: date delle regole, si verifica se una parola rispetta o meno queste regole, come nelle _espressioni regolari_
- *generativo*: date delle regole, si parte da _un certo punto_ e si generano tutte le parole di quel linguaggio con le regole date
- *riconoscitivo*: si usano dei _modelli di calcolo_ che prendono in input una parola e dicono se appartiene o meno al linguaggio

Considerando il linguaggio sull'alfabeto ${(,)}$ delle parole ben bilanciate, proviamo a dare due modelli
- _generativo_: a partire da una sorgente $S$ devo applicare delle regole per derivate tutte le parole di questo linguaggio \ Proviamo a definire alcune regole per questo linguaggio
  - la parola vuota $epsilon$ è ben bilanciata
  - se $x$ è ben bilanciata, allora anche $(x)$ è ben bilanciata
  - se $x,y$ sono ben bilanciate, allora anche $x y$ sono ben bilanciate

  I modelli generativi generano le *grammatiche*
- _riconoscitivo_: abbiamo una _black-box_ che prende una parola e ci dice se appartiene o meno al linguaggio (in realtà questa _black-box_ potrebbe non terminare mai la sua esecuzione) \ Proviamo a definire alcune regole per riconoscere tutte le parole di questo linguaggio:
  - il numero di $($ è uguale al numero di $)$
  - per ogni prefisso, il numero di $($ deve essere maggiore o uguale al numero di $)$

== Gerarchia di Chomsky

Negli anni 50 *Noam Chomsky* studia la generazione dei linguaggi formali e crea una *gerarchia di grammatiche formali*
- *tipo 0*: grammatiche che generano tutti i linguaggi, sono senza restrizioni e come modello equivalente hanno le *macchine di Turing*
- *tipo 1*: grammatiche _context-sensitive_ (dipendenti dal contesto), come modello equivalente hanno le *Linear Bounded Automata*
- *tipo 2*: grammatiche _context-free_ (libere dal contesto), hanno come modello equivalente gli *automi a pila*
- *tipo 3*: grammatiche regolari, hanno come modello equivalente gli *automi a stati finiti*

== Richiamo sulla notazione delle parole

Andremo ad indicare con le lettere maiuscole dell'alfabeto greco un *alfabeto*, come ad esempio $Sigma$ o $Gamma$

Sia $Sigma$ un alfabeto, indichiamo con $Sigma^*$ tutte le parole sull'alfabeto $Sigma$, compresa la parola vuota $epsilon$, e con $Sigma^+$ tutte le parole non vuote sull'alfabeto $Sigma$: in poche parole, $Sigma^+ = Sigma^* \/ {epsilon}$

Vediamo prima alcune operazioni sulle parole
- la _concatenazione_ è la composizione di due parole $x,y$ che formano la parola $w = x y$, e in generale $w_1 = x y eq.not y z = w_2$
- la _lunghezza_ di una parola $w$ si indica con $|w|$
- il _numero di occorrenze_ di una lettera $a in Sigma$ nella parola $w$ si indica con $|w|_a$

Vediamo ora alcune proprietà delle parole
- *fattore*: $y$ si dice _fattore_ di $w$ se esistono $x,z in Sigma^*$ tali che $x y z = w$
- *prefisso*: $x$ si dice _prefisso_ di $w$ se esiste $y in Sigma^*$ tale che $x y = w$
  - *prefisso proprio* se $y eq.not epsilon$
  - *prefisso non banale* se $x eq.not epsilon$
- *suffisso*: $y$ si dice _suffisso_ di $w$ se esiste $x in Sigma^*$ tale che $x y = w$
  - *suffisso proprio* se $x eq.not epsilon$
  - *suffisso non banale* se $y eq.not epsilon$
- *sottosequenza*: $x$ si dice _sottosequenza_ di $w$ se $x$ è ottenuta eliminando $0$ o più caratteri da $w$, anche non in ordine

Terminiamo definendo l'operazione *reversal*, ovvero se $w = a_1 a_2 dots a_n$, allora $w^R = a_n a_(n-1) ... a_1$

Una parola $w$ si dice *palindroma* se $w = w^R$
