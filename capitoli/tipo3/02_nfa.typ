// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Capitolo

= Automi a stati finiti non deterministici
<capitolo02-tipo3>

L'automa proposto nell'esempio @esempio-terzultimo-a del capitolo precedente ci ha richiesto $2^n$ stati. Abbiamo poi detto che con la nozione di *distinguibilità* dimostreremo che non ci sono DFA con meno stati di quello che abbiamo costruito. Ma se invece utilizzassimo degli *automi non deterministici*?

#example()[
  Vediamo un automa non deterministico per il linguaggio appena discusso.

  #figure(image("assets/02/terzultimo_a.svg"))

  Abbiamo usato un numero di stati uguale a $n+1$ (escluso quello trappola), dove $n$ è la posizione da destra del carattere richiesto.
]<esempio-terzultimo-a-nd>

== Definizione

Un *automa non deterministico* è un oggetto molto particolare. Analizzando l'@esempio-terzultimo-a-nd, notiamo che dallo stato $q_0$, leggendo una $a$, noi abbiamo la possibilità di scegliere se restare in $q_0$ o andare in $q_1$, ovvero abbiamo più scelte di transizioni in uno stesso stato. Che significato diamo a questo? Noi non sappiamo a che punto siamo della stringa, quindi usiamo il non determinismo come una *scommessa*: scommetto che, quando sono in $q_0$, io sia nel terzultimo carattere, e che quindi riuscirò a finire nello stato $q_3$. Ovviamente, con questa nuova nozione di "*parallelismo*" che si va a creare dobbiamo anche modificare alcune componenti dell'automa.

Gli *automi non deterministici*, o *NFA*, sono definiti ancora dalla *quintupla* $ A = (Q, Sigma, delta, q_0, F) $ che differisce da quella dei DFA solo nella *funzione di transizione*. Essa è la funzione $ delta : Q times Sigma arrow.long 2^Q $ che, dati lo stato corrente e il carattere letto dalla testina, mi manda in un insieme di stati possibili.

Prima di definire formalmente l'accettazione di una stringa da parte di un automa non deterministico, definiamo l'*estensione* di $delta$ come la funzione $ delta^* : Q times Sigma^* arrow.long 2^Q $ definita induttivamente come $ delta^*(q,epsilon) &= {q} \ delta^*(q, x a) &= union.big_(p in delta^*(q,x)) delta(p, a) bar.v x in Sigma^* and a in Sigma . $

Come prima, per non avere in giro troppo nomi, usiamo $delta^*$ con il nome $delta$ anche per le stringhe.

Quando *accettiamo* una stringa? Avendo teoricamente la possibilità di fare *infinite computazioni parallele*, visto che ad ogni passo posso sdoppiare la mia computazione, ci basta avere *almeno* un percorso che finisce in uno stato finale.

Il *linguaggio riconosciuta* dall'automa $A$ non deterministico è $ L(A) = {w in Sigma^* bar.v delta^*(q_0, w) inter F eq.not emptyset.rev} . $

#example()[
  Considerando l'automa dell'@esempio-terzultimo-a-nd, scriviamo l'albero di computazione che viene generato mentre cerca di riconoscere la stringa $x = a b a b a$.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [$q_0$],
          ([$q_0$], ([$q_0$], ([$q_0$], ([$q_0$], [$q_0$], [$q_1$])), ([$q_1$], ([$q_2$], [$q_3$])))),
          ([$q_1$], ([$q_2$], ([$q_3$], ([$q_T$], [$q_T$])))),
        ))
      })
    ],
    [
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [${q_0}$],
          ([${q_0, q_1}$], ([${q_0, q_2}$], ([${q_0, q_1, q_3}$], ([${q_0, q_2, q_T}$], [${q_0, q_1, q_3, q_T}$])))),
        ))
      })
    ],
  )

  Visto che raggiungiamo, all'ultimo livello dell'albero, almeno una volta lo stato finale $q_3$, la stringa $x$ viene accettata dall'automa.
]

== Confronto tra DFA e NFA

Banalmente, ogni automa deterministico è anche un automa non deterministico nel quale abbiamo, per ogni stato, al massimo un arco uscente etichettato con lo stesso carattere. In poche parole, abbiamo sempre una sola scelta. Ma allora la classe dei linguaggi riconosciuti da DFA è inclusa nella classe dei linguaggi riconosciuti da NFA.

Ma vale anche il viceversa: ogni automa non deterministico può essere trasformato in un automa deterministico con una costruzione particolare, detta *costruzione per sottoinsiemi*.

Dato $A = (Q, Sigma, delta, q_0, F)$ un NFA, e costruisco $ A' = (Q', Sigma, delta', q_'0, F') $ un DFA tale che:
- $Q' = 2^Q$, ovvero gli *stati* sono tutti i possibili sottoinsiemi;
- $delta' : Q' times Sigma arrow.long Q'$ è la nuova *funzione di transizione* che ci permette di navigare tra i possibili sottoinsiemi, ed è tale che $ delta'(alpha,a) = union.big_(q in alpha) delta(q, a) ; $
- $q'_0 = {q_0}$ nuovo *stato iniziale*;
- $F' = {alpha in Q' bar.v alpha inter F eq.not emptyset.rev}$ nuovo *insieme degli stati finali*.

Come vediamo, il non determinismo è estremamente comodo, perché ci permette di rendere molto *compatta* la rappresentazione degli automi, ma è irrealistico pensare di fare sempre la scelta giusta nelle scommesse.

== Forme di non determinismo

Il non determinismo sulle *transizioni*, ovvero avere più opzioni per la stessa lettera a partire da uno stato, non è l'unica forma di non determinismo che abbiamo.

Infatti, un'altra forma di non determinismo è quella di avere *stati iniziali multipli*, ovvero poter scegliere più punti di partenza. Come potenza siamo uguali agli automi deterministici: basta fare una *costruzione per sottoinsiemi* e abbiamo sistemato tutto.

L'ultima forma di non determinismo che abbiamo è quella delle $epsilon$-*produzioni*, o $epsilon$-*mosse*: esse sono transizioni di stato etichettate dalla $epsilon$ che permettono di spostarsi da uno stato all'altro senza leggere un carattere della stringa da riconoscere.

Che applicazioni può avere una forma del genere? Nei *compilatori* questo approccio è comodissimo per riconoscere dei numeri che possono essere indicati con o senza segno.

#example()[
  Se $Sigma = {0, dots, 9, +, -}$ definiamo un numero come una sequenza non vuota di cifre, con un segno iniziale opzionale.

  #figure(image("assets/02/segno.svg"))

  La epsilon mossa indica una opzionalità: potremmo leggere il prossimo carattere stando nello stato $q_0$ oppure nello stato $q_s$.
]

Questa soluzione aumenta la potenza dell'automa? *NO*: ogni sequenza nella forma $ p arrow.long.squiggly^epsilon p' arrow.long^a q' arrow.long.squiggly^epsilon q $ può essere tradotta nella transizione $ p arrow.long^a q . $

#example()[
  Andiamo a rimuovere la $epsilon$-transizione usando le sequenze appena descritte.

  #figure(image("assets/02/segno_no_epsilon.svg"))

  Una soluzione analoga rimuove le $epsilon$-transizioni inserendo degli stati iniziali multipli, ma questo mantiene ancora la forma di non determinismo dell'automa e non migliora la potenza, visto che basta trasformare l'NFA in un DFA con la costruzione per sottoinsiemi e come stato iniziale si avranno più di due elementi.

  #figure(image("assets/02/segno_no_epsilon_iniziali_multipli.svg"))
]

Vediamo altre applicazioni delle $epsilon$-produzioni.

#example()[
  Ci vengono dati tre automi, che riconoscono sequenze di $a$, $b$ e $c$ arbitrarie.

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [#figure(image("assets/02/sequenza_a.svg"))],
    [#figure(image("assets/02/sequenza_b.svg"))],
    [#figure(image("assets/02/sequenza_c.svg"))],
  )

  Vogliamo costruire un automa che utilizzi le $epsilon$-transizioni usando questi tre moduli per riconoscere il linguaggio $ L = {a^n b^m c^h bar.v m,n,h gt.eq 0} . $

  #figure(image("assets/02/sequenza_arbitraria.svg"))

  Come lo rendiamo deterministico? Sicuramente non andiamo ad utilizzare gli stati iniziali multipli, che qui ci starebbero molto bene, ma appunto vogliamo un comportamento deterministico.

  #figure(image("assets/02/sequenza_arbitraria_DFA.svg"))

  Abbiamo un automa deterministico, ma quello di prima è molto più leggibile di questo.
]

#example()[
  Riprendiamo il linguaggio $L_n$ delle stringhe con l'$n$-esimo carattere da destra uguale ad una $a$. Avevamo visto un NFA sulle transizioni nell'@esempio-terzultimo-a-nd, vediamone uno non deterministico sulle $epsilon$-transizioni fissando il valore a $n = 3$.

  #figure(image("assets/02/ln_epsilon.svg"))

  La scommessa qua l'abbiamo messa nel primo stato, che cerca di indovinare se sia arrivato o meno al terzultimo carattere. Il numero di stati, per $L_n$ generico, è $n+2$.
]
