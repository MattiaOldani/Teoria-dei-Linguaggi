// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@preview/syntree:0.2.1": syntree

#import "@preview/fletcher:0.5.5": diagram, node, edge


// Capitolo

= Pumping lemma

Prima di iniziare con il topic di questo capitolo facciamo qualche *esempio*.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n c^m bar.v n,m gt.eq 0} . $

  Riusciamo a dire che $L$ è un linguaggio CF? *SI*, riusciamo a costruire una grammatica di tipo $2$ o un automa a pila per questo linguaggio. Quest'ultimo è molto facile: carichiamole $a$, scarichiamo le $b$, scorriamo le $c$.
]

#example()[
  Definiamo ora il linguaggio $ L = {a^n b^n c^n bar.v n gt.eq 0} . $

  Riusciamo ancora a costruire un automa a pila? *NO*, con un automa a pila riusciamo a caricare le $a$, confrontare le $b$ ma facendo questo andiamo a distruggere l'informazione sul numero di $n$ quindi non abbiamo indicazioni sulle $c$.
]

Abbiamo un modo formale per dimostrare che l'ultimo linguaggio non è CF?

== Prerequisiti per il pumping lemma

Come nei linguaggi regolari, anche nei CFL abbiamo un *pumping lemma*. Questa è una *condizione necessaria* affinché un linguaggio sia CF, quindi questo lemma è usato come "arma" per dimostrare che un linguaggio non appartiene ai CFL.

#example()[
  Le regole di produzione $ S arrow.long [S] bar.v S S bar.v T \ T arrow.long (T) bar.v T T bar.v epsilon $ sono in grado di generare le stringhe di parentesi bilanciate dove le parentesi tonde stanno solo dentro le parentesi quadre. La variabile $S$ genera le quadre e dà un livello "esterno", mentre la variabile $T$ genera le tonde e dà un livello "interno".

  Vediamo un albero di derivazione per una stringa di questo linguaggio.

  #align(center)[
    #cetz.canvas({
      import cetz.tree

      tree.tree((
        [$S$],
        [$bracket$],
        (
          [$S$],
          ([$S$], ([#text(fill: red)[$T$]], [$($], ([$T$], [$epsilon$]), [$)$])),
          (
            [#text(fill: blue)[$S$]],
            [$bracket$],
            ([#text(fill: fuchsia)[$S$]], ([#text(fill: red)[$T$]], [$epsilon$])),
            [$bracket.r$],
          ),
        ),
        [$bracket.r$],
      ))
    })
  ]

  Questo è l'albero di derivazione della stringa $ S arrow.stroked^* [()[]] . $

  Facciamo un paio di *osservazioni*.

  Prendiamo i due alberi che hanno radice $T$ colorata in rosso. Dal primo albero generiamo la stringa $()$ mentre dal secondo albero generiamo $epsilon$. Visto che questi due alberi hanno come radice la stessa variabile, possiamo *invertirli*.

  #align(center)[
    #cetz.canvas({
      import cetz.tree

      tree.tree((
        [$S$],
        [$bracket$],
        (
          [$S$],
          ([$S$], ([#text(fill: red)[$T$]], [$epsilon$])),
          (
            [#text(fill: blue)[$S$]],
            [$bracket$],
            (
              [#text(fill: fuchsia)[$S$]],
              ([#text(fill: red)[$T$]], [$($], ([$T$], [$epsilon$]), [$)$]),
            ),
            [$bracket.r$],
          ),
        ),
        [$bracket.r$],
      ))
    })
  ]

  Con questa operazione otteniamo la stringa $ S arrow.stroked^* [[()]] . $

  Prendiamo ora l'albero con radice in $S$ colorata di blu. Questo albero ha radice in $S$ che genera, in una sola mossa, la stringa $[S]$, dove la $S$ tra quadre è rappresentata dalla $S$ fuchsia nel disegno. Notiamo che possiamo innestare questo albero in sé stesso un numero arbitrario di volte.

  #align(center)[
    #cetz.canvas({
      import cetz.tree

      tree.tree((
        [$S$],
        [$bracket$],
        ([$S$], [$bracket$], ([$dots.c$], [$bracket$], [$S$], [$bracket.r$]), [$bracket.r$]),
        [$bracket.r$],
      ))
    })
  ]

  Ogni volta che innesto questo albero in sé stesso, mettendo la radice nella foglia che contiene $S$, inseriamo una quadra a sinistra e una quadra a destra, generando stringhe nella forma $ S arrow.stroked^* bracket^i space S space bracket.r^i . $

  In generale, questi alberi sono formati da una variabile come radice e da una serie di terminali ai lati con in mezzo la stessa variabile presente nella radice.

  #align(center)[
    #syntree(
      child-spacing: 2em,
      layer-spacing: 2em,
      "[^$A$ $$ $dots$ $$ $A$ $$ $dots$ $$]",
    )
  ]
]

Questi alberi di derivazioni saranno importantissimi per dimostrare il pumping lemma.

#definition([Profondità di un albero])[
  La *profondità di un albero* di derivazione $T$ misura la massima distanza tra la radice e le foglie, ovvero è il numero di archi che ci sono dalla radice alla foglia di distanza massima.
]

Diamo ancora una nozione preliminare e poi siamo pronti per vedere il pumping lemma.

Ragioniamo con delle grammatiche in *FN di Chomsky*. Le regole di produzione sono $ A arrow.long a bar.v B C , $ quindi quello che otteniamo è un *albero binario*, che non si allarga molto in ampiezza.

#lemma()[
  Sia $G = (V, Sigma, P, S)$ una grammatica in FN di Chomsky. Se $ T : A arrow.stroked^* w $ è un albero di derivazione di profondità $k$, allora $ abs(w) lt.eq 2^(k-1) , $ con $w in Sigma^*$ stringa di soli terminali.
]

#lemma-proof()[
  Dimostriamolo per induzione sulla profondità $k$.

  [*Passo base*: $k = 1$]

  Visto che devo derivare almeno un terminale nella stringa, devo partire la derivazione usando la regola di produzione $A arrow.long a$. Gli alberi con profondità $1$ sono nella forma

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$A$ $$ $$ $$ $a$ $$ $$ $$]",
      )
    ],
    [
      #diagram(
        node-stroke: .1em,
        spacing: 4em,

        edge((0, 0), (0, 0.625), label: 1, "<->"),
      )
    ],
    [
      #align(center)[
        #cetz.canvas({
          import cetz.tree

          tree.tree((
            [$A$],
            [$a$],
          ))
        })
      ]
    ],
  )

  Avendo questa profondità, e generando quindi solo un terminale, la lunghezza delle stringhe è $ abs(w) = abs(a) = 1 lt.eq 2^(k-1) =^(k=1) 2^0 = 1 . $

  [*Passo induttivo*: $k - 1 arrow.long k$]

  Supponiamo di avere alberi di profondità $k > 1$, ovvero alberi che nella radice hanno usato la seconda regola di produzione $A arrow.long B C$.

  #align(center)[
    #syntree(
      child-spacing: 2em,
      layer-spacing: 2em,
      "[$A$ [^$B$ $$ $$ $$ $w'$ $$ $$ $$] [^$C$ $$ $$ $$ $w''$ $$ $$ $$]]",
    )
  ]

  La stringa $w$ la possiamo vedere come la concatenazione delle due stringhe generate dai due sotto-alberi, quindi $ w = w' w'' . $

  La profondità di questo albero è $k$, quindi gli alberi in $B$ e $C$ sono di profondità al massimo $k - 1$. Questi alberi sono $ T' : B arrow.stroked^* w' quad bar.v quad T'' : C arrow.stroked^* w'' $ che per ipotesi di induzione generano stringhe al massimo lunghe $2^(k-1-1) = 2^(k-2)$. Visto che $w$ è la concatenazione delle due stringhe, possiamo dire che $ abs(w) = underbracket(abs(w'), lt.eq 2^(k-2)) + underbracket(abs(w''), lt.eq 2^(k-2)) lt.eq 2^(k-1) . qedhere $
]

== Pumping lemma per i CFL

Nel pumping lemma per i linguaggi regolari prendevamo delle stringhe lunghe almeno quanto il numero di stati e osservavamo che si ripeteva almeno uno stato nella computazione.

Nel *pumping lemma per i CFL* non ci muoviamo più in linea, ma ci muoviamo all'interno dell'albero di derivazione cercando una variabile che viene ripetuta.

Vediamo la definizione formale e la dimostrazione.

#lemma([Pumping lemma per i CFL])[
  Sia $L$ un linguaggio CF. Allora $exists N > 0$ tale che $forall z in L$ tale che $abs(z) gt.eq N$ essa può essere scritta come $z = u v w x y$ tale che:
  + $abs(v w x) lt.eq N$;
  + $v x eq.not epsilon$;
  + $forall i gt.eq 0 quad u v^i w x^i y in L$.
]

Se nel *PL3* ripetevamo la parte centrale dicendo che questa non poteva essere vuota, ora invece:
+ la parte centrale della decomposizione è lunga al massimo $N$;
+ la seconda e la quarta parte non sono entrambe vuote allo stesso momento;
+ visto che almeno una parte tra la seconda e la quarta è non vuota, possiamo pompare quelle due parti lo stesso numero di volte generando nuove stringhe che mi fanno rimanere comunque dentro $L$.

#lemma-proof()[
  Abbiamo a disposizione un linguaggio CF, dal quale possiamo ricavare facilmente una grammatica CF e, per costruzione, una grammatica in FN di Chomsky. Sia quindi $G = (V, Sigma, P, S)$ una grammatica in FN di Chomsky per $L slash {epsilon}$.

  Fissato $k = abs(V)$, definiamo $ N = 2^k . $

  Prendiamo delle stringhe $z in L$ tali che $abs(z) gt.eq N$. Se $z in L$ allora esiste un albero di derivazione che, partendo da $S$, mi genera la stringa $z$: $ T : S arrow.stroked^* z . $

  Questo albero, molto piccolino, è nella forma:

  #align(center)[
    #syntree(
      child-spacing: 2em,
      layer-spacing: 2em,
      "[^$S$ $$ ^$$ $$ $z$ $$ $$ $$]",
    )
  ]

  Abbiamo definito la stringa $z$ in modo che $abs(z) gt.eq N = 2^k$. Grazie al lemma precedente sappiamo che la lunghezza di una stringa è limitata dalla profondità del suo albero di derivazione: se $h$ è la profondità dell'albero $T$, allora sappiamo che $ abs(z) lt.eq 2^(h - 1) . $ Unendo le due disuguaglianze otteniamo che $ 2^(h-1) gt.eq abs(z) gt.eq 2^k arrow.long.double h - 1 gt.eq k arrow.long.double h gt.eq k + 1 . $

  La profondità di un albero è il cammino massimo dalla radice alla foglia più lontana. Visto che questa profondità è almeno $k + 1$, stiamo attraversando $k + 1$ archi e quindi $k + 2$ nodi.

  Di questi $k + 2$ nodi, l'ultimo che visitiamo è il terminale presente nella stringa $z$, quindi stiamo visitando $k + 1$ variabili. Avendo a disposizione $k$ variabili, vuol dire che visitiamo una variabile almeno due volte. Sia $A$ questa variabile che viene ripetuta.

  #figure(image("assets/04/albero_ripetizione.svg", width: 85%))

  Nella figura precedente abbiamo indicato con due pallini la variabile $A$ che viene ripetuta durante il cammino dal fondo verso la radice. Ora iniziamo la divisione in fattori.

  Consideriamo solo l'albero che parto dalla $A$ più sotto: esso genera un fattore di $z$, che chiamiamo $w$, ovvero $A arrow.stroked^* w$.

  #figure(image("assets/04/albero_w.svg", width: 85%))

  Consideriamo ora l'albero che parte dalla $A$ più sopra: esso genera un altro fattore di $z$, che contiene quello precedente più due fattori esterni, che chiamiamo $v$ e $x$, ovvero $A arrow.stroked^* v w x$.

  #figure(image("assets/04/albero_vx.svg", width: 85%))

  Infine, prendiamo i due fattori esterni, che chiamiamo $u$ e $y$, trovando quindi la derivazione completa di $z$ come $ S arrow.stroked^* u v w x y . $

  #figure(image("assets/04/albero_uy.svg", width: 85%))

  Abbiamo quindi mostrato che esiste la decomposizione.

  [*TERZO PUNTO*]

  Cosa osserviamo dal disegno?

  Prendiamo la parte esterna dell'albero, ovvero la stringa generata dalla $S$ alla prima $A$. La produzione che sta avvenendo ora è $ S arrow.stroked^* u A y . $

  Prendiamo ora la parte intermedia dell'albero, ovvero la stringa generata tra le due $A$. La produzione che sta avvenendo è $ A arrow.stroked^* v A x . $

  Infine, prendiamo la parte interna dell'albero, ovvero la stringa generata dalla seconda $A$. La produzione che sta avvenendo è $ A arrow.stroked^* w . $

  Facciamo il gioco che abbiamo fatto prima con le parentesi: prendiamo l'albero intermedio, lo innestiamo tante volte in sé stesso e poi mettiamo l'albero interno come tappo, ovvero $ S arrow.stroked^* u A y arrow.stroked u v A x y arrow.stroked^* u v v A x x y arrow.stroked^* dots arrow.stroked^* u v^i A x^i y arrow.stroked^* u v^i w x^i y . $

  Questo possiamo farlo un numero arbitrario di volte, anche $0$: infatti, con $i = 0$ è come mettere subito il tappo al posto di $v A x$.

  [*SECONDO PUNTO*]

  Quando risaliamo l'albero di derivazione supponiamo di incontrare la variabile $A$ che poi viene ripetuta sopra. Visto che siamo in un nodo interno, e siamo nella FN di Chomsky, questa variabile arriva da una biforcazione di una variabile del livello superiore. Sia $P$ questa variabile, che genera anche la variabile $B$ allo stesso livello di $A$.

  Qua abbiamo due casi:
  - se $P = A$ allora abbiamo subito la ripetizione e potremmo avere $v$ o $x$ uguali ad $epsilon$ ma non tutti e due, perché da $B$ tiriamo fuori almeno un terminale, non avendo $epsilon$-produzioni;
  - se $P eq.not A$ allora ancora meglio di prima perché tutti e due potrebbero non essere nulli, visto che ci biforchiamo ancora in su.

  [*PRIMO PUNTO*]

  Consideriamo il cammino di $z$ che parte dalla foglia e arriva fino a $S$. Se saliamo di $k + 1$ archi abbiamo attraversato $k + 2$ nodi, ma uno di questi è il carattere terminale della foglia, quindi abbiamo attraversato $k + 1$ variabili. Avendo a disposizione $k$ variabili, una viene ripetuta.

  Questo albero ha altezza massima $k + 1$, perché al massimo in quel punto otteniamo la ripetizione della variabile. La variabile che troviamo ripetuta fa partire un albero che genera la stringa $v w x$, ma per il lemma precedente vale $ abs(v w x) lt.eq 2^(k + 1 - 1) = 2^k = N . qedhere $
]

Vediamo un esempio per capire meglio la dimostrazione del secondo punto del pumping lemma.

#example()[
  Abbiamo una grammatica in FN di Chomsky con le regole di produzione $ A &arrow.long a bar.v A B \ B &arrow.long b . $

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

== Applicazioni del pumping lemma

Andiamo ad *applicare il pumping lemma* al linguaggio di prima.

#example()[
  Sia quindi $ L = {a^n b^n c^n bar.v n gt.eq 0} . $

  Come nel PL3, dobbiamo assumere per assurdo che $L$ sia CFL e vedere quale delle tre proprietà va a decadere per via di questa assunzione.

  Sia per assurdo $L$ un CFL, allora $exists N$ costante del PL per $L$. Cerchiamo una stringa che fa cadere una delle tre proprietà: non stiamo a risparmiare, abbondiamo, prendiamo la stringa $ z = a^N b^N c^N . $

  Sappiamo che la possiamo decomporre come $z = u v w x y$.

  Sfruttiamo la condizione $1$: la parte centrale è al massimo $N$, quindi se contiene una $a$ non contiene una $c$, viceversa se contiene una $c$ non contiene una $a$. Quindi abbiamo $ hash_a (v w x) = 0 space or space hash_c (v w x) = 0 . $

  Prendiamo il caso in cui $hash_a (v w x) = 0$, l'altro è totalmente simmetrico.

  Sappiamo che possiamo ripetere in modo arbitrario i due fattori pompabili, quindi se scegliamo $i = 0$ allora otteniamo $ z' = u w y in L . $

  Contiamo il numero di terminali che abbiamo:
  - $hash_a (z') = hash_a (z) = N$ perché non le avevo nella parte cancellata;
  - $hash_b (z') = hash_b (z) - hash_b (v x) = N - hash_b (v x)$ per la parte cancellata;
  - $hash_c (z') = hash_c (z) - hash_c (v x) = N - hash_c (v x)$ per la parte cancellata.

  Ora usiamo la seconda condizione, quindi sapendo che $v x eq.not epsilon$ questo implica che che $ hash_b (v x) + hash_c (v x) > 0 $ perché avendo almeno una lettera in $v x$, e non avendo $a$, ho cancellato almeno una $b$ o una $c$, quindi $ hash_b (z') < N or hash_c (z') < N . $

  Ma questo è assurdo: $z'$ dovrebbe essere in $L$ ma non lo è.
]

Vediamo un altro *linguaggio a blocchi*.

#example()[
  Definiamo ora $ L = {a^h b^j c^k bar.v j = max(h, k)} . $

  Questo linguaggio non è CFL: infatti, in maniera non deterministica possiamo scommettere all'inizio di avere $a$ e $b$ uguali o $b$ e $c$ uguali, ma non possiamo controllare che il numero di $b$ sia massimo. Infatti, potrei avere $a$ e $b$ uguali, e questo la pila lo sa fare, ma un numero di $c$ superiore. Se la richiesta fosse $ j = h or j = k $ potremmo scrivere un NPDA per il linguaggio, ma qua è diverso.

  Per assurdo sia $L$ un CFL, e sia quindi $N$ la costante del PL per $L$. Prendiamo una stringa $ z = a^N b^N c^N $ che ovviamente sta nel linguaggio ed è lunga almeno $N$. Decomponiamola quindi in $z = u v w x y$ e, sapendo che $abs(v w x) lt.eq N$, sappiamo che $ v w x in a^* b^* space or space v w x in b^* c^* . $ Sappiamo inoltre che $v w eq.not epsilon$, quindi qui abbiamo almeno un carattere.

  Andiamo per *casi*:
  - se $v w x in a^+$ allora pompiamo la stringa con $i = 2$ e otteniamo una stringa con un numero di $a$ più grande del numero di $b$ e di $c$, ma $b$ deve essere uguale al massimo, quindi questo è un assurdo;
  - se $v w x in c^+$ allora pompiamo nello stesso modo con $i = 2$;
  - se $v w x in b^+$ allora togliamo un po' di $b$ con $i = 0$ per renderle in numero minore del numero massimo, che è $N$, quindi questo è un assurdo:
  - se $v w x in a^+ b^+$ dobbiamo andare per *casi* per capire dove avviene la divisione tra $a$ e $b$:
    - se $v in a^+ b^+$ allora la divisione avviene nel primo fattore; se pompiamo con $i = 2$ otteniamo la stringa $u v v w x x y$ formata da una serie di $a$, da una serie di $b$, poi ancora una serie di $a$, ma questa operazione ci fa perdere la struttura del linguaggio, quindi questo è un assurdo;
    - se $x in a^+ b^+$ allora la divisione avviene nel terzo fattore; se pompiamo con $i = 2$ otteniamo la stessa perdita di struttura di prima;
    - se $v = a^l and x = b^r$ allora la divisione è nel fattore centrale; visto che questi due fattori assieme non sono vuoti, vuol dire che $l + r > 0$; se andiamo a prendere la stringa $u v^i w x^i y$ noi stiamo aggiungendo $i-1$ volte un numero $l$ di $a$ e un numero $r$ di $b$, ovvero $ u v^i w x^i y = a^(N + (i-1) l) b^(N + (i-1) r) c^N . $ Andiamo ancora per *casi*:
      - se $l eq.not r$ allora per $i = 2$ il numero di $a$ e $b$ sono diverse ma quelle di $b$ non sono uguali al massimo, che può essere il numero di $a$ o il numero di $b$;
      - se $l = r$ prendiamo $i = 0$ così che le $a$ e le $b$ siano uguali ma siano in numero minore di $N$, che però è il massimo.
  - se $v w x in b^+ c^+$ facciamo il simmetrico del caso precedente.

  In ogni caso possibile abbiamo ottenuto un assurdo, quindi $L$ non è CFL.
]

Questi esempi sono facili perché hanno la struttura a blocchi. Vediamo un esempio che è riconducibile ad una struttura a blocchi.

#example()[
  Definiamo ora $ L = {alpha alpha bar.v alpha in {a,b}^*} . $

  Non riusciamo a scrivere un automa a pila per $L$: possiamo mettere la stringa $alpha$ sulla pila, anche in maniera deterministica aggiungendo un separatore, ma per andare poi a confrontare il primo carattere sulla stringa dobbiamo distruggere tutta l'informazione.

  Sia per assurdo $L$ un CFL e sia $N$ la costante del PL. Prendiamo $z in L$ tale che $abs(z) gt.eq N$ nella forma $z = alpha alpha$. Come facciamo a costruire una roba del genere? Cerchiamo di ritornare in una *struttura a blocchi*, ovvero prendiamo la stringa $ z = underbracket(a^N b^N, alpha) underbracket(a^N b^N, alpha) . $

  Non lo facciamo vedere, ma la dimostrazione è molto simile a quella precedente.
]

Infine, vediamo un esempio di una struttura non a blocchi.

#example()[
  Definiamo infine $ L = {a^p bar.v p "è un numero primo"} . $

  Non riusciamo a scrivere un automa a pila perché per sapere se $p$ è primo l'automa dovrebbe saper fare delle divisioni, che infatti non sa fare.

  Per assurdo sia quindi $L$ un CFL. Sia $N$ la costante del PL per $L$ e definiamo un numero primo $m$ tale che $m gt.eq N$ che usiamo per definire $ z = a^m . $

  Decomponiamo la stringa come $z = u v w x y$. Sappiamo che $v x eq.not epsilon$ quindi $ abs(v x) = k > 0 . $

  La stringa $u v^i w x^i y$ è ottenuta da $z$ aggiungendo i fattori $v$ e $x$ per $i-1$ volte, ovvero $ forall i gt.eq 0 quad u v^i w x^i y = a^(m + (i - 1) k) in L . $

  Sappiamo inoltre che $ abs(v w x) lt.eq N arrow.long.double abs(v x) lt.eq N arrow.long.squiggly k lt.eq N lt.eq m . $

  Scegliamo $i = m + 1$: allora otteniamo la stringa $ a^(m + (m + 1 - 1)k) = a^(m + m k) = a^(m (k + 1)) $ che chiaramente non è lunga quanto un numero primo perché è fattorizzato.

  Ma questo è un assurdo, quindi $L$ non è CFL.
]

Una cosa molto interessante è che questo linguaggio lo potevamo dimostrare anche con il pumping lemma per i linguaggi regolari: infatti, nei linguaggi unari i CFL sono *uguali* ai linguaggi regolari.
