// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 04 [07/03]

== Linguaggi regolari

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
