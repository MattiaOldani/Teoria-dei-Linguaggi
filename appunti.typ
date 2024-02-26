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

#v(12pt)

#figure(
    image("assets/gerarchia.svg", width: 50%)
)

#v(12pt)

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

#pagebreak()

= Grammatiche di tipo 3

== Automi a stati finiti

Gli *automi a stati finiti* sono un modello riconoscitivo usato per caratterizzare i _linguaggi regolari_

=== Definizione informale

Gli automi a stati finiti sono delle macchine molto semplici: hanno un *controllo a stati finiti* che legge l'input da un *nastro*, formato da una serie di celle, ognuna delle quali contiene un carattere dell'input

Per leggere l'input si utilizza una *testina di lettura*, posizionata inizialmente sulla cella più a sinistra (ovvero sul primo carattere di input), e poi spostata iterazione dopo iterazione da sinistra verso destra

Il controllo a stati finiti, prima della lettura dell'input, è allo *stato iniziale*

Ad ogni iterazione, a partire dallo stato corrente e dal carattere letto dal nastro, ci si muove con la testina a destra sul simbolo successivo e si cambia stato

Quando si arriva alla fine del nastro, in base allo stato corrente dell'automa, quest'ultimo risponde _"si"_, ovvero la parola in input appartiene al linguaggio, oppure _"no"_, ovvero la parola in input non appartiene al linguaggio

#v(12pt)

#figure(
    image("assets/automa_macchina.svg", width: 50%)
)

#v(12pt)

=== Definizione formale

Un automa è una tupla ${Q, Sigma, delta, q_I, F}$, con
- $Q$ insieme degli stati
- $Sigma$ alfabeto di input
- $delta: Q times Sigma arrow.long Q$ funzione di transizione
- $q_I in Q$ stato iniziale
- $F subset.eq Q$ insieme degli stati finali

La parte dinamica dell'automa è la *funzione di transizione* che, dati lo stato iniziale e un simbolo del linguaggio, calcola lo stato successivo

Possiamo estendere la funzione di transizione affinché utilizzi una parola del linguaggio, ovvero definiamo $overline(delta): Q times Sigma^* arrow.long Q$ tale che
- $overline(delta)(q, epsilon) = q quad forall q in Q$
- $overline(delta)(q, w a) = delta(overline(delta)(q,w), a) quad forall q in Q, w in Sigma^*, a in Sigma$

Per semplicità useremo $delta$ al posto di $overline(delta)$ nella notazione

=== Linguaggio

Chiamiamo $L(A) = {w in Sigma^* bar.v delta(q_I, w) in F}$ il *linguaggio riconosciuto dall'automa*, ovvero l'insieme delle parole che applicate alla funzione di transizione, a partire dallo stato iniziale, mi mandano in uno stato finale

=== Rappresentazione grafica

Possiamo vedere un automa come un grafo, dove
- gli *stati* sono nodi etichettati con il nome dello stato
- le *transizioni* sono archi orientati ed etichettati con la lettera dell'alfabeto che causa quella transizione

Lo *stato iniziale* è indicato con una freccia entrante nello stato, mentre gli *stati finali* sono nodi doppiamente cerchiati

#v(12pt)

#figure(
    image("assets/automa_grafo.svg", width: 50%)
)

#v(12pt)

== Automi a stati finiti non deterministici

Questi particolari automi sono utili nei linguaggi $R_n$ (fatti come esempio a lezione) perché necessitano di molto meno stati ($n-1$) rispetto ad un automa deterministico ($2^n$)

=== Definizione informale

Gli *automi a stati finiti non deterministici* (_NFA_) sono particolari automi che hanno _almeno_ uno stato dal quale escono $2$ o più archi con la stessa lettera

Negli automi *deterministici* (_DFA_) invece da _ogni_ stato esce al più un arco con la stessa lettera

La differenza principale sta nella complessità computazionale: se negli automi deterministici devo controllare se la parola ci porta in uno stato finale, negli automi non deterministici devo controllare se tra _tutti_ i possibili cammini dell'*albero di computazione* ne esiste uno che ci porta in uno stato finale 

Possiamo vedere il non determinismo come _una scommessa che va sempre a buon fine_

=== Definizione formale

Un automa non deterministico differisce da un automa deterministico solo per la funzione di transizione: infatti, quest'ultima diventa $delta: Q times Sigma arrow.long PP(Q)$, ovvero ritorna un elemento dell'*insieme delle parti* di $Q$, quindi un sottoinsieme di stati nei quali possiamo finire applicando un carattere di $Sigma$ allo stato corrente

Come prima, definiamo l'estensione della funzione di transizione come la funzione $overline(delta): Q times Sigma^* arrow.long PP(Q)$ tale che
- $overline(delta)(q, epsilon) = {q}$
- $overline(delta)(q, w a) = limits(union.big)_(r in overline(delta)(q,w)) delta(r,a)$

Cambia anche il linguaggio riconosciuto dall'automa: infatti, $L(A)$ diventa ${w in Sigma^* bar.v overline(delta)(q_I, w) sect.big F eq.not emptyset.rev}$








== Distinguibilità

Dato un linguaggio $L subset.eq Sigma^*$, due parole $x,y in Sigma^*$ sono *distinguibili* rispetto ad $L$ se $exists z in Sigma^*$ tale che $(x z in L and y z in.not L) or (x z in.not L and y z in L)$

#theorem()[
  Siano $L subset.eq Sigma^*$ un linguaggio, $X subset.eq Sigma^*$ un insieme di parole tutte distinguibili tra loro rispetto ad $L$ e $A$ un automa DFA per $L$, allora $A$ non può avere meno di $|X|$ stati
]<thm>

#proof[
  \ Per assurdo, sia $X = {x_1, dots, x_k}$ insieme di $k$ parole distinguibili tra loro rispetto ad $L$ e che $A$ abbia meno di $k$ stati \ Partendo dallo stato corrente $q_I$ ho due situazioni
  - leggendo il carattere $x_i$, con $1 lt.eq i lt.eq k-2$, l'automa finisce nello stato $q_i$
  - leggendo i caratteri $x_(k-1)$ e $x_k$ l'automa finisce nello stato stato $q_t$, visto che $A$ ha meno di $k$ stati
  
  Prendiamo ora una parola $z$ e la applichiamo allo stato $q_t$, che ci porta in uno stato $r$ qualsiasi, ma questo è assurdo: infatti, abbiamo due parole distinguibili ($x_(k-1)$ e $x_k$) che però sono entrambe accettate o entrambe rifiutate, in base allo stato $r$
]<proof>
