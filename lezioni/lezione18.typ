// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@local/syntree:0.2.1": syntree

// Lezione

= Lezione 18 [09/05]

== Ancora pumping lemma

La scorsa lezione abbiamo visto il pumping lemma per i CFL. Rivediamo un secondo la dimostrazione del punto $v x eq.not epsilon$ perché non era molto chiara.

Quando risaliamo l'albero di derivazione supponiamo di incontrare la variabile che viene ripetuta dopo. Chiamiamo questa variabile $A$. Visto che siamo in un nodo interno, e siamo nella FN di Chomsky, questa variabile arriva una biforcazione di una variabile del livello superiore. Sia $P$ questa variabile, che genera anche la variabile $B$ allo stesso livello di $A$.

Qua abbiamo due casi:
- se $P = A$ allora abbiamo subito la ripetizione e potremmo avere $v$ o $x$ uguali ad $epsilon$ ma non tutti e due, perché da $B$ tiriamo fuori almeno un terminale, non avendo $epsilon$-produzioni;
- se $P eq.not A$ allora ancora meglio di prima perché tutti e due potrebbero non essere nulli, visto che ci biforchiamo ancora in su.

Vediamo un esempio per capire meglio.

#example()[
  Abbiamo una grammatica in FN di Chomsky con le regole di produzione $ A arrow.long a bar.v A B \ B arrow.long b . $

  Ci viene dato l'albero di derivazione della stringa $z = a b$ in questa grammatica.

  #align(center)[
    #syntree(
      child-spacing: 2em,
      layer-spacing: 2em,
      "[$A$ [$A$ $a$] [$B$ $b$]]",
    )
  ]

  La $A$ più in basso viene ripetuta al livello superiore, quindi essa genera il fattore $w$ della nostra scomposizione. Questo implica che la parte prima, definita dal fattore $u v$, è vuota.

  La $A$ più in alto invece genera il fattore $v w x$, ma visto che $w = a$ e che $v = epsilon$, allora sicuramente $x = b$, che come vediamo non è vuoto.

  Gli altri due fattori esterni sono invece vuoti, ma su loro non abbiamo condizioni.
]

== Fail del pumping lemma

Il pumping lemma viene usato classicamente per dimostrare che un linguaggio non è CFL. Purtroppo per noi, questo lemma però ogni tanto fallisce nelle dimostrazioni.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n c^k bar.v k eq.not n} . $

  Questo linguaggio non è CFL, perché possiamo controllare le $a$ con le $b$ ma non possiamo controllare poi $n$ con $k$ perché abbiamo perso informazioni.

  Per assurdo sia $L$ un CFL e sia quindi $N$ la costante del pumping lemma per $L$. Mostriamo che qualsiasi stringa lunga almeno $N$ non riesce a rompere almeno una delle tre condizioni del pumping lemma. Prendiamo quindi la stringa $ z = a^n b^n c^k bar.v k eq.not n and 2n + k = abs(z) gt.eq N . $

  Decomponiamo $z$ nella stringa $z = u v w x y$. A noi interessano le tre parti centrali, perché qua dentro possiamo pompare (o almeno, le due parti esterne, quella centrale no).

  Abbiamo diversi casi da controllare: $ v w x in a^+ quad &bar.v quad v w x in b^+ \ v w x in b^+ c^+ quad &bar.v quad v w x in a^+ b^n c^+ \ v w x in c^+ quad &bar.v quad v w x in a^+ b^+ . $

  I casi della prima riga sono molto facili: pompando con $i eq.not 1$ rompiamo l'uguaglianza tra $a$ e $b$.

  I casi della seconda riga sono facili: controllando dove cadono i vari limiti della stringa rompiamo l'uguaglianza tra $a$ e $b$ oppure la struttura.

  I casi dell'ultima riga sono invece *molto molto difficili*. Vediamoli entrambi.

  [$bold(v w x in c^+)$]

  Consideriamo La stringa $u v^i w x^i y$: in questa stringa, al variare della $i$, l'unico valore che cambia rispetto alla stringa $z$ è il numero di $c$. Per rompere questa condizione dobbiamo rendere il numero di $c$ uguale al numero di $a$ e $b$, ma questo non è sempre possibile.

  Infatti, questo dipende dalla $z$ che abbiamo a disposizione:
  - se $z = a^n b^n c$ basta scegliere $i = n - 1$ per rompere la condizione di non uguaglianza;
  - se $z = a^(n + n!) b^(n + n!) c^n$, sapendo che $v x = c^j$, possiamo dire che $ u v^i w x^i y = a^(n + n!) b^(n + n!) c^(n + (i-1)j) $ ma allora scegliendo $ (i-1)j = n! arrow.long.double i = frac(n!, j) + 1 $ noi possiamo rendere il fattore $(i-1)j$ un fattoriale in $n$, e rompere di fatto la condizione sulla non uguaglianza.

  Come vediamo, ci sono casi favorevoli, ovvero quando $k < n$, ma non tutti sono così.

  [$bold(v w x in a^+ b^+)$]

  In questo caso, se $v$ e $x$ hanno il limite tra le due lettere andiamo a perdere la struttura.

  Se invece il limite è in $w$, ovvero se $v = a^l$ e $x = b^r$, allora abbiamo due casi:
  - se $l eq.not r$ questo è facile, con $i = 0$ abbiamo ottenuto $hash_a eq.not hash_b$;
  - se $l = r$ con la ripetizione arbitraria noi aggiungiamo lo stesso numero di $a$ e di $b$, ovvero otteniamo la stringa $ u v^i w x^i y = a^(n + (i-1)l) b^(n + (i-1)r) c^k $ che, per essere resa non in $L$, deve avere lo stesso numero di $a$, $b$ e $c$. Per fare questo è comodo quanto le $c$ sono tante, che va contro il caso precedente, dove volevamo invece poche $c$, e non sempre è possibile aggiungere $a$ e $b$ per raggiungere lo stesso numero di $c$.

  Quindi anche in questo caso ci sono casi favorevoli ma non tutti lo sono.
]

Il pumping lemma *non funziona*, o meglio, in questo caso non funziona, anche se $L$ non è CFL. Per risolvere questo problema, dobbiamo dare condizioni più forti del pumping lemma.

== Lemma di Ogden

Partiamo con un paio di esempi utili per fissare alcuni concetti.

#example()[
  Ci viene dato un albero di derivazione di una grammatica generica.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [$circle.small$],
        (
          [$circle.small$],
          (
            [$circle.small$],
            (
              [$circle.small$],
              ([$circle.small$], ([$circle.small$], [$circle.small$]), [$circle.small$]),
              [$circle.small$],
            ),
            [$circle.small$],
          ),
          (
            [$circle.small$],
            ([$circle.small$], [$circle.small$], ([$circle.small$], [$circle.small$]), [$circle.small$]),
            ([$circle.small$], [$circle.small$], ([$circle.small$], [$circle.small$], [$circle.small$])),
          ),
        ),
        ([$circle.small$], [$circle.small$], ([$circle.small$], ([$circle.small$], [$circle.small$]))),
      ))
    })
  ]

  Andiamo a *marcare*, con un pallino nero grosso, alcune foglie dell'albero.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [$circle.small$],
        (
          [$circle.small$],
          (
            [$circle.small$],
            (
              [$circle.small$],
              ([$circle.small$], ([$circle.small$], [$circle.filled$]), [$circle.small$]),
              [$circle.filled$],
            ),
            [$circle.small$],
          ),
          (
            [$circle.small$],
            ([$circle.small$], [$circle.small$], ([$circle.small$], [$circle.filled$]), [$circle.small$]),
            ([$circle.small$], [$circle.small$], ([$circle.small$], [$circle.filled$], [$circle.small$])),
          ),
        ),
        ([$circle.small$], [$circle.small$], ([$circle.small$], ([$circle.small$], [$circle.filled$]))),
      ))
    })
  ]

  Una volta marcate alcune foglie dell'albero, individuiamo i *branch point*: essi sono nodi interni con almeno due figli, o loro discenti, che sono nodi marcati. Indichiamo questi nodi con un triangolo rosso pieno.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [#text(fill: red)[$triangle.filled$]],
        (
          [#text(fill: red)[$triangle.filled$]],
          (
            [$circle.small$],
            (
              [#text(fill: red)[$triangle.filled$]],
              ([$circle.small$], ([$circle.small$], [$circle.filled$]), [$circle.small$]),
              [$circle.filled$],
            ),
            [$circle.small$],
          ),
          (
            [#text(fill: red)[$triangle.filled$]],
            ([$circle.small$], [$circle.small$], ([$circle.small$], [$circle.filled$]), [$circle.small$]),
            ([$circle.small$], [$circle.small$], ([$circle.small$], [$circle.filled$], [$circle.small$])),
          ),
        ),
        ([$circle.small$], [$circle.small$], ([$circle.small$], ([$circle.small$], [$circle.filled$]))),
      ))
    })
  ]

  Identifichiamo infine con un quadrato blu pieno tutti i *padri* dei nodi marcati. Se un nodo è già stato segnato come branch point viene lasciato così.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [#text(fill: red)[$triangle.filled$]],
        (
          [#text(fill: red)[$triangle.filled$]],
          (
            [$circle.small$],
            (
              [#text(fill: red)[$triangle.filled$]],
              ([$circle.small$], ([#text(fill: blue)[$square.filled$]], [$circle.filled$]), [$circle.small$]),
              [$circle.filled$],
            ),
            [$circle.small$],
          ),
          (
            [#text(fill: red)[$triangle.filled$]],
            (
              [$circle.small$],
              [$circle.small$],
              ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
              [$circle.small$],
            ),
            (
              [$circle.small$],
              [$circle.small$],
              ([#text(fill: blue)[$square.filled$]], [$circle.filled$], [$circle.small$]),
            ),
          ),
        ),
        (
          [$circle.small$],
          [$circle.small$],
          ([$circle.small$], ([#text(fill: blue)[$square.filled$]], [$circle.filled$])),
        ),
      ))
    })
  ]

  Chiamiamo *nodi speciali* tutti i branch point e i padri dei nodi marcati. Costruiamo ora un albero, detto *albero semplificato*, in cui teniamo solo le foglie marcate e i nodi speciali.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [#text(fill: red)[$triangle.filled$]],
        (
          [#text(fill: red)[$triangle.filled$]],
          (
            [#text(fill: red)[$triangle.filled$]],
            ([#text(fill: blue)[$#text(fill: blue)[$square.filled$]$]], [$circle.filled$]),
            [$circle.filled$],
          ),
          (
            [#text(fill: red)[$triangle.filled$]],
            (
              [#text(fill: blue)[$#text(fill: blue)[$square.filled$]$]],
              [$circle.filled$],
            ),
            (
              [#text(fill: blue)[$#text(fill: blue)[$square.filled$]$]],
              [$circle.filled$],
            ),
          ),
        ),
        (
          [#text(fill: blue)[$#text(fill: blue)[$square.filled$]$]],
          [$circle.filled$],
        ),
      ))
    })
  ]
]

#example()[
  Vediamo ora un albero in FN di Chomsky, già con nodi marcati e speciali.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [#text(fill: red)[$triangle.filled$]],
        (
          [#text(fill: red)[$triangle.filled$]],
          (
            [$circle.small$],
            ([$circle.small$], [$circle.small$]),
            ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
          ),
          (
            [$circle.small$],
            (
              [$circle.small$],
              ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
              ([$circle.small$], [$circle.small$]),
            ),
            ([$circle.small$], [$circle.small$]),
          ),
        ),
        (
          [#text(fill: red)[$triangle.filled$]],
          (
            [$circle.small$],
            ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
            ([$circle.small$], [$circle.small$]),
          ),
          (
            [#text(fill: red)[$triangle.filled$]],
            ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
            (
              [$circle.small$],
              ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
              ([$circle.small$], [$circle.small$]),
            ),
          ),
        ),
      ))
    })
  ]

  Si può dimostrare che, in un albero binario, i branch point sono uno in meno dei nodi marcati.

  Ora vediamo l'albero semplificato.

  #align(center)[
    #cetz.canvas({
      import cetz: tree

      tree.tree((
        [#text(fill: red)[$triangle.filled$]],
        (
          [#text(fill: red)[$triangle.filled$]],
          ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
          ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
        ),
        (
          [#text(fill: red)[$triangle.filled$]],
          ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
          (
            [#text(fill: red)[$triangle.filled$]],
            ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
            ([#text(fill: blue)[$square.filled$]], [$circle.filled$]),
          ),
        ),
      ))
    })
  ]

  Come vediamo, l'albero semplificato *mantiene* una FN di Chomsky.
]

Vediamo ora un lemma molto simile ad uno che abbiamo già visto prima del pumping lemma.

#lemma()[
  Sia $G = (V, Sigma, P, S)$ una grammatica in FN di Chomsky. Sia $ T : A arrow.stroked^* w bar.v w in Sigma^* $ un albero di derivazione in $G$. Supponiamo di marcare $d$ posizioni in $w$. Se il numero massimo di nodi speciali in un cammino dalla radice alle foglie in $T$ è $k$ allora $w$ contiene al più $2^(k-1)$ posizioni marcate, ovvero $ d lt.eq 2^(k-1) . $
]

Questo lemma dà una nuova idea di *misura*: non misuriamo più tutta la stringa, ma solo le posizioni marcate, e consideriamo l'albero semplificato al posto di quello normale.

#lemma-proof()[
  Si dimostra per induzione, come il lemma della lezione scorsa.
]

Introduciamo finalmente il *lemma di Ogden*.

#lemma([Lemma di Ogden])[
  Sia $L subset.eq Sigma^*$ un linguaggio CFL. Allora $exists N > 0$ tale che $forall z in L$ in cui vengono marcate almeno $N$ posizioni può essere decomposta come $z = u v w x y$ tale che:
  + $v w x$ contiene al più $N$ posizioni marcate;
  + $v x$ contiene almeno una posizione marcata;
  + $forall i gt.eq 0 quad u v^i w x^i y in L$.
]

Notiamo che marcando tutte le posizioni troviamo esattamente il *pumping lemma*.

#lemma-proof()[
  La dimostrazione di questo teorema è analoga a quella del pumping lemma, ma ragiona sull'albero semplificato associato a quello di derivazione di $z$.
]

== Applicazioni del lemma di Ogden

Applichiamo quindi il lemma di Ogden per risolvere il problema che abbiamo avuto con il pumping lemma nel primo esempio della lezione.

#example()[
  Sia di nuovo $ L = {a^n b^n c^k bar.v k eq.not n} . $

  La difficoltà di questo linguaggio risiede nel fatto di rendere $=$ un $eq.not$.

  Per assurdo sia $L$ un CFL e sia $N$ la costante del lemma di Ogden. Sia $z$ una stringa molto lunga, molto molto lunga, ad esempio $ z = a^N b^N c^(N + N!) . $

  Marchiamo, dentro questa stringa, almeno $N$ posizioni: scegliamo di marcare tutte le $a$. Facendo così abbiamo la garanzia che nelle stringhe da pompare abbiamo almeno una $a$, e questo sarà comodo per rompere l'uguaglianza con le $b$ o la struttura.

  Decomponiamo quindi $z$ come $z = u v w x y$. Sappiamo che $v x$ ha almeno una posizione marcata, quindi in $v x$ abbiamo almeno una $a$. Questo restringe il campo di possibili configurazioni da $6$ a $3$: $ v w x in a^+ quad bar.v quad v w x in a^+ b^+ quad bar.v quad v w x in a^+ b^N c^+ . $

  Il primo caso è banale, lo risolvevamo anche prima con $i = 0$ per avere $hash_a eq.not hash_b$.

  Il secondo caso invece era quello ostico, ma ora non più. Dobbiamo capire dove si trova il confine tra le $a$ e le $b$, quindi:
  - se $v in a^+ b^+ or x in a^+ b^+$ scegliamo $i = 2$ per rompere la struttura;
  - se $v in a^l and x in b^r$ anche qui abbiamo due casi:
    - se $l eq.not r$ scegliamo $i = 0$ per avere $hash_a eq.not hash_b$;
    - se $l = r$ qua avevamo dei problemi, mentre ora possiamo farlo, perché se prendiamo la stringa pompata $ u v^i w x^i y = a^(N + (i-1)l) b^(N + (i-1)r) c^(N + N!) =^(l = r) a^(N + (i-1)l) b^(N + (i-1)l) c^(N + N!) $ sapendo che $1 lt.eq l lt.eq N$ dobbiamo imporre $ (i-1)l = N! arrow.long.double i = frac(N!, l) + 1 . $

  Il terzo e ultimo caso l'avevamo già visto prima, dove perdiamo la struttura se $v$ o $x$ hanno almeno due tipi di lettere, mentre rompiamo l'uguaglianza quando $v$ è formato da sole $a$.

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#example()[
  Definiamo ora $ L = {a^p b^q c^r bar.v p = q or q = r "ma non entrambi"} . $

  Possiamo vedere questo linguaggio come $ L = L_("prima") space slash space {a^n b^n c^n bar.v n gt.eq 0} . $

  Questo linguaggio non è CFL: la scommessa che facciamo all'inizio verifica che almeno una delle due scelte vada bene, ma non esattamente una delle due.

  Anche questo si dimostra con il lemma di Ogden, ma devo farlo io, e non ho voglia ora.
]

== Ambiguità

Vediamo un esempio che ci serve per introdurre il concetto di *ambiguità*.

#example()[
  Definiamo il linguaggio $ L = {a^p b^q c^r bar.v p = q or q = r} . $

  Questo linguaggio è un *CFL*: infatti, possiamo fare una scommessa iniziale per verificare almeno una delle due condizioni del linguaggio.
]

Nel linguaggio appena visto però potrebbero essere vincenti entrambi i rami: in questo caso, noi abbiamo due modi diversi di riconoscere la stringa che ci viene data.

#example()[
  Diamo una grammatica per il linguaggio precedente. Le produzioni sono $ S &arrow.long S_1 C bar.v A S_2 \ S_1 &arrow.long a S_1 b bar.v epsilon \ S_2 &arrow.long b S_2 c bar.v epsilon \ A &arrow.long a A bar.v epsilon \ C &arrow.long c C bar.v epsilon . $

  Le variabili $S_1$ e $S_2$ sono usate per generare rispettivamente delle stringhe di $a$ e $b$ in egual numero e delle stringhe di $b$ e $c$ in egual numero. Le variabili $A$ e $C$ invece generano rispettivamente sequenze di $a$ e sequenze di $c$ in numero casuale. Riassumendo: $ S_1 &arrow.stroked^* a^n b^n \ S_2 &arrow.stroked^* b^n c^n \ A &arrow.stroked a^k \ C &arrow.stroked^* c^k . $

  Per la stringa $z = a b c$ abbiamo due alberi di derivazione differenti:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [$S$],
          ([$S_1$], [$a$], ([$S_1$], [$epsilon$]), [$b$]),
          ([$C$], [$c$]),
        ))
      })
    ],
    [
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [$S$],
          ([$A$], [$a$]),
          ([$S_2$], [$b$], ([$S_2$], [$epsilon$]), [$c$]),
        ))
      })
    ],
  )
]

// TODO: definizione (????)
Una grammatica è *ambigua* quando riusciamo a trovare due diverse derivazioni per una stringa del linguaggio generato da quella grammatica.

#definition([Grado di ambiguità di una stringa])[
  Sia $G = (V, Sigma, P, S)$ una grammatica CF. Sia $w in Sigma^*$. Chiamiamo *grado di ambiguità* di $w$ rispetto a $G$ il numero di alberi di derivazione di $w$, oppure il numero di derivazioni leftmost di $w$.
]

Ovviamente, se una stringa non appartiene a $L(G)$ ha grado di ambiguità pari a zero.

#definition([Grado di ambiguità di una grammatica])[
  Il *grado di ambiguità* di una grammatica $G$ è il massimo grado di ambiguità delle stringhe $w in Sigma^*$.
]

// TODO: rivedi
Il concetto di *ambiguità* è legato al *non determinismo*: abbiamo visto nell'equivalenza tra grammatiche di tipo $2$ e automi a pila che questi ultimi potevano simulare le derivazioni leftmost della grammatica. Se ad un certo punto la grammatica ha più derivazioni leftmost che mi portano poi nella stessa stringa allora stiamo introducendo del non determinismo. Viceversa, quando guardavamo le computazioni possibili in un automa a pila e dovevamo generare le regole di produzione, quando eravamo di fronte ad una scelta dovevamo generare delle regole ambigue.

#definition([Grado di ambiguità di un automa a pila])[
  Il *grado di ambiguità* di un automa a pila è il numero di computazioni accettanti.
]

La relazione però non è biunivoca: infatti, nel linguaggio delle palindrome pari abbiamo del non determinismo ma non abbiamo ambiguità perché la metà della stringa è una sola. Viceversa, se abbiamo ambiguità sicuramente abbiamo non determinismo, perché c'è un punto di scelta dove noi possiamo sdoppiare il riconoscimento.

#definition([Grammatiche inerentemente ambigue])[
  Sia $L$ un CFL. Allora $L$ è *inerentemente ambigua* se ogni grammatica CF per $L$ è ambigua.
]

Andiamo avanti la prossima volta.
