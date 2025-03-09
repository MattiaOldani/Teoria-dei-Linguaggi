// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 04 [07/03]

== Linguaggi regolari

=== Macchine a stati finiti deterministiche

Nel contesto delle grammatiche di tipo $3$ andiamo ad utilizzare le *macchine a stati finiti* per stabilire se, data una stringa $x$, essa appartiene ad un dato linguaggio. Le macchine a stati finiti da ora le chiameremo anche *FSM* (_Finite State Machine_) o *DFA* (_Deterministic Finite Automata_).

Un FSM è un dispositivo formato da un *nastro*, che contiene l'input $x$ da esaminare disposto carattere per carattere uno per cella del nastro da sinistra verso destra. Abbiamo anche una *testina* read-only che punta alle celle del nastro e un *controllo a stati finiti*. Il numero di stati, come si capisce, sono in numero finito, e soprattutto sono fissati, ovvero non dipendono dalla grandezza dell'input. Infine, il modello base che usiamo per ora è quello delle FSM *one-way*, ovvero quello che usa una testina che va sinistra verso destra senza poter tornare indietro.

All'accensione della macchina il controllo si trova nello *stato iniziale* $q_0$ con la testina sul primo carattere dell'input. Ad ogni passo della computazione, la testina legge un carattere e, in base a questo e allo stato corrente, calcola lo stato prossimo. Lo spostamento avviene grazie alla *funzione di transizione*, che vedremo dopo. Arrivati alla fine dell'input grazie alla funzione di transizione, la macchina deve rispondere *SI* o *NO*.

Formalmente, una FSM è una *quintupla* $ A = (Q, Sigma, delta, q_0, F) $ formata da:
- $Q$ insieme finito di *stati*;
- $Sigma$ *alfabeto* di input;
- $delta$ *funzione di transizione*;
- $q_0 in Q$ *stato iniziale*;
- $F subset.eq Q$ insiemi degli *stati finali*.

La funzione di transizione, che non abbiamo ancora definito formalmente, è il programma dell'automa, il motore che ci manda avanti. Essa è una funzione $ delta : Q times Sigma arrow.long Q $ che, dati il simbolo letto dalla testina e lo stato corrente, mi dice in che stato muovermi.

La funzione di transizione spesso è comodo scriverla in *forma tabellare*, con le righe indicizzate dagli stati, le colonne indicizzate dai simboli e nelle celle inseriamo gli stati prossimi.

Può essere comodo anche disegnare l'automa. Esso è un *grafo orientato*, con i *vertici* che rappresentano gli stati e gli *archi* che rappresentano le transizioni. Gli archi sono etichettati dai simboli di $Sigma$ che causano una certa transizione. Lo *stato iniziale* è indicato con una freccia che arriva dal nulla, mentre gli *stati finali* sono indicati con un doppio cerchio o con una freccia che va nel nulla, ma quest'ultima convenzione è francese e noi non lo siamo, viva le lumache.

#example()[
  Sia $A = (Q, Sigma, delta, q_0, F)$ tale che:
  - $Q = {s_0, s_1, s_2}$;
  - $Sigma = {a,b}$;
  - $q_0 = s_0$;
  - $F = s_2$.

  #set math.mat(delim: "[")

  Diamo una rappresentazione tabellare della funzione di transizione $delta.$ Essa è $ mat(,a,b; s_0,s_0,s_1; s_1,s_0,s_2; s_2,s_0,s_0; augment: #(vline: 1, hline: 1)) . $

  Disegniamo anche l'automa $A$ avendo a disposizione la rappresentazione di $delta$.

  // TODO sistemare
  #figure(image("assets/04_esempio.svg"))

  Il linguaggio che riconosce questo automa è $ L = {x in Sigma^* bar.v "il più lungo suffisso di" x "formato solo da" b "è lungo" 3k + 2 bar.v k gt.eq 0} . $
]

Dobbiamo modificare leggermente la FDT: a noi piacerebbe averla definita sulle stringhe e non sui caratteri. Definiamo quindi l'*estensione* di $delta$ come la funzione $ delta^* : Q times Sigma^* arrow.long Q $ definita induttivamente come $ delta^*(q, epsilon) &= q \ delta^*(q, x a) &= delta(delta^*(q,x), a) bar.v x in Sigma^* and a in Sigma . $

Per non avere in giro troppo nomi usiamo $delta^*$ con il nome $delta$ anche per le stringhe, è la stessa cosa.

Noi *accettiamo* se finiamo in uno stato finale. Il *linguaggio accettato* da $A$ è l'insieme $ L(A) = {w in Sigma^* bar.v delta(q_0, w) in F} . $

Nel primo esempio abbiamo visto quello che si definiamo un *problema di analisi*: abbiamo in mano l'automa, dobbiamo descrivere il linguaggio che riconosce. L'altro tipo di problema è il *problema di sintesi*: abbiamo in mano un linguaggio, dobbiamo scrivere un automa per esso.

#example()[
  Sia $Sigma = {a,b}$, vogliamo trovare un automa per il linguaggio $ L = {x in Sigma^* bar.v "tra ogni coppia di" b "successive vi è un numero di" a "pari"} . $

  Costruiamo un automa deterministico per $L$.

  // TODO sistemare
  #figure(image("assets/04_coppie_a.svg"))
]

Come vediamo dall'esempio precedente, abbiamo uno stato particolare $q_T$ che è detto *stato trappola*: esso viene utilizzato come _"punto di arrivo"_ per esaurire la lettura dell'input e non accettare la stringa data in input. Finiamo in questo stato se, in uno stato $q$, leggiamo un carattere che rende la stringa non generabile da $L$.

Lo stato trappola è opzionale: per semplicità, quando un automa *non è completo*, ovvero uno stato non ha un arco per un carattere, si assume che quell'arco vada a finire in uno stato trappola. Questa semplificazione permette di disegnare automi molto più compatti, ma io sono un precisino e devo avere tutti gli stati disegnati.

#example()[
  Sia $Sigma = {a,b}$, vogliamo trovare un automa per il linguaggio $ L = {x in Sigma^* bar.v "il terzo simbolo di" x "è una" a} . $

  Costruiamo un automa deterministico per $L$.

  // TODO sistemare
  #figure(image("assets/04_terzo_a.svg"))
]

#example()[
  Sia $Sigma = {a,b}$, vogliamo trovare un automa per il linguaggio $ L = {x in Sigma^* bar.v "il terzo simbolo di" x "da destra è una" a} . $

  Costruiamo un automa deterministico per $L$. Qua l'idea è ricordarsi una finestra di $3$ simboli e grazie a questa vediamo se il primo carattere che definisce lo stato è una $a$.

  // TODO sistemare
  #figure(image("assets/04_terzultimo_a.svg"))
]

Ci servono per forza $8$ stati o possiamo fare meglio? Abbiamo trovato la strada migliore?

=== Macchine a stati finiti non deterministiche

Vediamo un automa che utilizza meno stati per riconoscere il linguaggio precedente.

#v(12pt)

// TODO sistemare ma in realtà anche no
#figure(image("assets/04_terzultimo_a_nd.svg"))

#v(12pt)

Abbiamo usato un numero di stati uguale a $n+1$ (_escluso quello trappola_), dove $n$ è la posizione da destra del carattere richiesto, ma abbiamo generato un *automa non deterministico*. Infatti, dallo stato $q_0$ noi abbiamo la possibilità di scegliere se restare in $q_0$ o andare in $q_1$, ovvero abbiamo più scelte di transizioni in uno stesso stato. Che significato diamo a questo? Noi non sappiamo a che punto siamo della stringa, quindi usiamo il non determinismo come una *scommessa*: scommetto che, quando sono in $q_0$, io sia nel terzultimo carattere, e che quindi riuscirò a finire nello stato $q_3$.

Gli *automi non deterministici*, o *NFA*, sono definiti da una quintupla $A = (Q, Sigma, delta, q_0, F)$ definita allo stesso modo dei DFA tranne la funzione di transizione. Essa è la funzione $ delta : Q times Sigma arrow.long 2^Q $ che, dati lo stato corrente e il carattere letto dalla testina, mi manda in un insieme di stati possibili.

Quando accettiamo una stringa? Avendo teoricamente la possibilità di fare infinite computazioni parallele, visto che ad ogni passo posso sdoppiare la mia computazione, ci basta avere almeno un percorso che finisce in uno stato finale.

#example()[
  Considerando l'automa precedente, scrivere l'albero di computazione che viene generato dall'automa mentre cerca di riconoscere la stringa $x = a b a b a$.

  #table(
    columns: (50%, 50%),
    stroke: none,
    align: center + horizon,
    align(center)[
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [$q_0$],
          ([$q_0$], ([$q_0$], ([$q_0$], ([$q_0$], [$q_0$], [$q_1$])), ([$q_1$], ([$q_2$], [$q_3$])))),
          ([$q_1$], ([$q_2$], ([$q_3$], ([$q_T$], [$q_T$])))),
        ))
      })],
    align(center)[
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [${q_0}$],
          ([${q_0, q_1}$], ([${q_0, q_2}$], ([${q_0, q_1, q_3}$], ([${q_0, q_2, q_T}$], [${q_0, q_1, q_3, q_T}$])))),
        ))
      })],
  )

  Visto che raggiungiamo, all'ultimo livello dell'albero, almeno una volta lo stato finale $q_3$, la stringa $x$ viene accettata dall'automa.
]

Prima di definire formalmente l'accettazione di una stringa da parte di un automa non deterministico, definiamo l'*estensione* di $delta$ come la funzione $ delta^* : Q times Sigma^* arrow.long 2^Q $ definita induttivamente come $ delta^*(q,epsilon) &= {q} \ delta^*(q, x a) &= union.big_(p in delta^*(q,x)) delta(p,a) bar.v x in Sigma^* and a in Sigma . $

Come prima, per non avere in giro troppo nomi, usiamo $delta^*$ con il nome $delta$ anche per le stringhe.

Il *linguaggio riconosciuta* dall'automa $A$ non deterministico è $ L(A) = {w in Sigma^* bar.v delta^*(q_0, w) inter F eq.not emptyset.rev} . $

=== Confronto tra DFA e NFA

Banalmente, ogni automa deterministico è anche un automa non deterministico nel quale abbiamo, per ogni stato, al massimo un arco uscente etichettato con lo stesso carattere. In poche parole, abbiamo sempre una sola scelta. Ma allora la classe dei linguaggi riconosciuti da DFA è inclusa nella classe dei linguaggi riconosciuti da NFA.

Ma vale anche il viceversa: ogni automa non deterministico può essere trasformato in un automa deterministico con una costruzione particolare, detta *costruzione per sottoinsiemi*.

Dato $A = (Q, Sigma, delta, q_0, F)$ un NFA, e costruisco $A' = {Q', Sigma, delta', q_'0, F'}$ un DFA tale che:
- $Q' = 2^Q$, ovvero gli stati sono tutti i possibili sottoinsiemi;
- $delta' : Q' times Sigma arrow.long Q'$ è la nuova funzione di transizione che ci permette di navigare tra i possibili sottoinsiemi, ed è tale che $ delta'(alpha,a) = union.big_(q in alpha) delta(q,a) ; $
- $q'_0 = {q_0}$ nuovo stato iniziale;
- $F' = {alpha in Q' bar.v alpha inter F eq.not emptyset.rev}$ nuovo insieme degli stati finali.

Come vediamo, il non determinismo è estremamente comodo, perché ci permette di rendere molto compatta la rappresentazione degli automi, ma è irrealistico pensare di fare sempre la scelta giusta nelle scommesse.

=== Altre forme di non determinismo

Una ulteriore forma di non determinismo, oltre a quella sulle molteplici transizioni con lo stesso carattere in uno stato, è quella di avere *molteplici stati iniziali*.
