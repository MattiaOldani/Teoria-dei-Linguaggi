// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Automi a stati finiti deterministici

Nel contesto delle grammatiche di tipo $3$ andiamo ad utilizzare le *macchine a stati finiti* per stabilire se, data una stringa $x$, essa appartiene o meno ad un dato linguaggio. Le macchine a stati finiti da ora le chiameremo anche *FSM* (Finite State Machine) o, nel caso delle macchine deterministiche, *DFA* (Deterministic Finite Automata).

== Definizione

Un DFA è un dispositivo formato da un *nastro*, che contiene l'input $x$ da esaminare disposto carattere per carattere uno per cella del nastro da sinistra verso destra. Abbiamo anche una *testina* read-only che punta alle celle del nastro e un *controllo a stati finiti*. Il numero di stati, come si capisce, sono in numero finito, e soprattutto sono *fissati*, ovvero non dipendono dalla grandezza dell'input. Infine, il modello base che usiamo per ora è quello delle FSM *one-way*, ovvero quello che usa una testina che va sinistra verso destra senza poter tornare indietro.

All'accensione della macchina il controllo si trova nello *stato iniziale* $q_0$ con la testina sul primo carattere dell'input. Ad ogni passo della computazione la testina legge un carattere e, in base a questo e allo stato corrente, calcola lo stato prossimo. Questo spostamento avviene grazie alla *funzione di transizione*, che vedremo dopo. Arrivati alla fine dell'input grazie alla funzione di transizione, la macchina deve rispondere *SI* o *NO*.

#definition([DFA])[
  Un DFA è una *quintupla* $ A = (Q, Sigma, delta, q_0, F) $ formata da:
  - $Q$ *insieme finito* di *stati*;
  - $Sigma$ *alfabeto* di input;
  - $delta$ *funzione di transizione*;
  - $q_0 in Q$ *stato iniziale*;
  - $F subset.eq Q$ insiemi degli *stati finali*.
]

La funzione di transizione, che non abbiamo ancora definito formalmente, è il *programma dell'automa*, il *motore* che ci manda avanti. Essa è una funzione $ delta : Q times Sigma arrow.long Q $ che, dati il simbolo letto dalla testina e lo stato corrente, mi dice in che stato muovermi.

La funzione di transizione spesso è comodo scriverla in *forma tabellare*, con le righe indicizzate dagli stati, le colonne indicizzate dai simboli e nelle celle inseriamo gli stati prossimi.

Può essere comodo anche *disegnare* l'automa. Esso è un *grafo orientato*, con i *vertici* che rappresentano gli stati e gli *archi* che rappresentano le transizioni. Gli archi sono *etichettati* dai simboli di $Sigma$ che causano una certa transizione. Lo *stato iniziale* è indicato con una freccia che arriva dal nulla, mentre gli *stati finali* sono indicati con un doppio cerchio o con una freccia che va nel nulla, ma quest'ultima convenzione è francese e noi non lo siamo, viva le lumache.

Dobbiamo modificare leggermente la funzione di transizione: a noi piacerebbe averla definita sulle stringhe e non sui caratteri. Definiamo quindi l'*estensione* di $delta$ come la funzione $ delta^* : Q times Sigma^* arrow.long Q $ definita induttivamente come $ delta^*(q, epsilon) &= q \ delta^*(q, x a) &= delta(delta^*(q,x), a) bar.v x in Sigma^* and a in Sigma . $

Per non avere in giro troppo nomi usiamo $delta^*$ con il nome $delta$ anche per le stringhe, è la stessa cosa.

Noi *accettiamo* se finiamo in uno stato finale. Il *linguaggio accettato* da $A$ è l'insieme $ L(A) = {w in Sigma^* bar.v delta(q_0, w) in F} . $

== Esempi

Vediamo un po' di esempi che ci permettono di introdurre anche una serie di situazioni particolari.

Diamo subito una distinzione dei problemi che abbiamo sugli automi:
- se abbiamo in mano un automa e dobbiamo descrivere il linguaggio che riconosce, siamo davanti ad un *problema di analisi*;
- se abbiamo in mano un linguaggio e dobbiamo scrivere un automa che lo riconosce, siamo davanti ad un *problema di sintesi*.

#example()[
  Sia $A = (Q, Sigma, delta, q_0, F)$ tale che:
  - $Q = {s_0, s_1, s_2}$;
  - $Sigma = {a,b}$;
  - $q_0 = s_0$;
  - $F = s_2$.

  #set math.mat(delim: "[")

  Diamo una *rappresentazione tabellare* della funzione di transizione $delta.$ Essa è $ mat(,a,b; s_0,s_0,s_1; s_1,s_0,s_2; s_2,s_0,s_0; augment: #(vline: 1, hline: 1)) . $

  Disegniamo anche l'automa $A$ avendo a disposizione la rappresentazione di $delta$.

  #figure(image("assets/01_esempio.svg"))

  Il linguaggio che riconosce questo automa è $ L = {x in Sigma^* bar.v "il più lungo suffisso di" x "formato solo da" b "è lungo" 3k + 2 bar.v k gt.eq 0} . $
]

#example()[
  Sia $Sigma = {a,b}$, vogliamo trovare un automa per il linguaggio $ L = {x in Sigma^* bar.v "tra ogni coppia di" b "successive vi è un numero di" a "pari"} . $

  Costruiamo un automa *deterministico* per $L$.

  #figure(image("assets/01_coppie_a.svg"))
]

Come vediamo dall'esempio precedente, abbiamo uno stato particolare $q_T$ che è detto *stato trappola*: esso viene utilizzato come _"punto di arrivo"_ per esaurire la lettura dell'input e non accettare la stringa data in input. Finiamo in questo stato se, in uno stato $q$, leggiamo un carattere che rende la stringa non presente in $L$.

Lo stato trappola è opzionale: per semplicità, quando un automa *non è completo*, ovvero uno stato non ha un arco per un carattere, si assume che quell'arco vada a finire in uno stato trappola. Questa semplificazione permette di disegnare automi molto più compatti, ma io sono un precisino e devo avere tutti gli stati disegnati.

#example()[
  Sia $Sigma = {a,b}$, vogliamo trovare un automa per il linguaggio $ L = {x in Sigma^* bar.v "il terzo simbolo di" x "è una" a} . $

  Costruiamo un automa deterministico per $L$.

  #figure(image("assets/01_terzo_a.svg"))
]

#example()[
  Sia $Sigma = {a,b}$, vogliamo ora trovare un automa per il linguaggio $ L = {x in Sigma^* bar.v "il terzo simbolo di" x "da destra è una" a} . $

  Costruiamo un automa deterministico per $L$. Qua l'idea è ricordarsi una finestra di $3$ simboli e grazie a questa vediamo se il primo carattere che definisce lo stato è una $a$.

  #figure(image("assets/01_terzultimo_a.svg"))
]

Ci servono per forza $8$ stati o possiamo fare meglio? Abbiamo trovato la strada migliore?

Quando introdurremo il concetto di *distinguibilità* vedremo che questo è l'automa migliore che possiamo costruire per questo linguaggio.
