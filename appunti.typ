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

== Storia

Un *linguaggio* è _uno strumento di comunicazione usato da membri di una stessa comunità_, ed è composto da due elementi:
- *sintassi*: insieme di simboli (o _parole_) che devono essere combinati con una serie di regole
- *semantica*: associazione frase-significato

Per i linguaggi naturali è difficile dare delle regole sintattiche: vista questa difficoltà, nel 1956 *Noam Chomsky* introduce il concetto di *grammatiche formali*, che si servono di regole matematiche per la definizione della sintassi di un linguaggio

Il primo utilizzo dei linguaggi risale agli stessi anni con il *compilatore Fortran*, ovvero un traduttore da un linguaggio di alto livello ad uno di basso livello, ovvero il _linguaggio macchina_

== Ripasso

Un *alfabeto* è un insieme _non vuoto_ e _finito_ di simboli, di solito indicato con $Sigma$ o $Gamma$

Una *stringa* (o *parola*) è una sequenza _finita_ di simboli appartenenti a $Sigma$

Data una parola $w$, possiamo definire:
- $|w|$ _numero di caratteri_ di $w$
- $|w|_a$ _numero di occorrenze_ della lettera $a in Sigma$ in $w$

Una parola molto importante è la *parola vuota* $epsilon$, che, come dice il nome, ha simboli, ovvero $|epsilon| = 0$

L'insieme di tutte le possibili parole su $Sigma$ è detto $Sigma^*$

Un'importante operazione sulle parole è la *concatenazione* (o _prodotto_), ovvero se $x,y in Sigma^*$ allora la concatenazione $w$ è la parola $w = x y$

Questo operatore di concatenazione:
- _non è commutativo_, infatti $w_1 = x y eq.not y z = w_2$ in generale
- _è associativo_, infatti $(x y) z = x (y z)$

La struttura $(Sigma^*, dot, epsilon)$ è un *monoide* libero generato da $Sigma$

Vediamo ora alcune proprietà delle parole
- *prefisso*: $x$ si dice _prefisso_ di $w$ se esiste $y in Sigma^*$ tale che $x y = w$
  - *prefisso proprio* se $y eq.not epsilon$
  - *prefisso non banale* se $x eq.not epsilon$
  - il numero di prefissi è uguale a $|w|+1$
- *suffisso*: $y$ si dice _suffisso_ di $w$ se esiste $x in Sigma^*$ tale che $x y = w$
  - *suffisso proprio* se $x eq.not epsilon$
  - *suffisso non banale* se $y eq.not epsilon$
  - il numero di suffissi è uguale a $|w|+1$
- *fattore*: $y$ si dice _fattore_ di $w$ se esistono $x,z in Sigma^*$ tali che $x y z = w$
  - il numero di fattori è al massimo $frac(|w| dot |w+1|, 2) + 1$
- *sottosequenza*: $x$ si dice _sottosequenza_ di $w$ se $x$ è ottenuta eliminando $0$ o più caratteri da $w$
  - un _fattore_ è una sottosequenza ordinata

Un *linguaggio* $L$ definito su un alfabeto $Sigma$ è un qualunque sottoinsieme di $Sigma^*$

#pagebreak()

= Gerarchia di Chomsky

== Rappresentazione

Vogliamo rappresentare in maniera finita un oggetto infinito come un linguaggio

Abbiamo a nostra disposizione due modelli molto potenti
- *generativo*: date delle regole, si parte da _un certo punto_ e si generano tutte le parole di quel linguaggio con le regole date
- *riconoscitivo*: si usano dei _modelli di calcolo_ che prendono in input una parola e dicono se appartiene o meno al linguaggio

Considerando il linguaggio sull'alfabeto ${(,)}$ delle parole ben bilanciate, proviamo a dare due modelli
- _generativo_: a partire da una sorgente $S$ devo applicare delle regole per derivate tutte le parole appartenenti a questo linguaggio
  - la parola vuota $epsilon$ è ben bilanciata
  - se $x$ è ben bilanciata, allora anche $(x)$ è ben bilanciata
  - se $x,y$ sono ben bilanciate, allora anche $x y$ sono ben bilanciate
- _riconoscitivo_: abbiamo una _black-box_ che prende una parola e ci dice se appartiene o meno al linguaggio (in realtà potrebbe non terminare mai la sua esecuzione)
  - $|x|_\( = |x|_\)$
  - per ogni prefisso, $|x|_\( gt.eq |x|_\)$

/* FINE LEZIONE 01 */

== Gerarchia

Negli anni 50 Noam Chomsky studia la generazione dei linguaggi formali e crea una *gerarchia di grammatiche formali*
- *tipo 0*: grammatiche che generano tutti i linguaggi, sono senza restrizioni e come modello equivalente hanno le *macchine di Turing*
- *tipo 1*: grammatiche _context-sensitive_ (dipendenti dal contesto), come modello equivalente hanno le *Linear Bounded Automata*
- *tipo 2*: grammatiche _context-free_ (libere dal contesto), hanno come modello equivalente gli *automi a pila*
- *tipo 3*: grammatiche regolari, hanno come modello equivalente gli *automi a stati finiti*

#v(12pt)

#figure(
    image("assets/gerarchia.svg", width: 50%)
)

#v(12pt)

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
