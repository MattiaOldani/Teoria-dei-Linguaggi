// Setup

#import "../alias.typ": *

#import "@preview/lovelace:0.3.0": pseudocode-list

#let settings = (
  line-numbering: "1:",
  stroke: 1pt + blue,
  hooks: 0.2em,
  booktabs: true,
  booktabs-stroke: 2pt + blue,
)

#let pseudocode-list = pseudocode-list.with(..settings)

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@preview/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp

#import "@preview/fletcher:0.5.5": diagram, node, edge


// Capitolo

= CFL VS DCFL

Per i CFL avevamo due criteri molto potenti per dire la *NON* appartenenza di un linguaggio $L$ generico a questa classe. Abbiamo delle tecniche anche per i DCFL? *SI*, menomale.

== Pumping lemma

Come per i CFL, anche i DCFL hanno il *pumping lemma*, o meglio, *i pumping lemma*: ce ne sono tanti, e di solito vanno bene solo su alcuni esempi, quindi sono molto tecnici e specifici.

== Linguaggio inerentemente ambiguo

Una seconda tecnica è dimostrare che $L$ è *inerentemente ambiguo*, per far si che ogni automa per $L$ sia ambiguo e quindi che $L$ è non deterministico.

#example()[
  Avevamo visto, con questa tecnica, la dimostrazione di $ L = {a^p b^q c^r bar.v p = q or q = r} in CFL . $
]

== Proprietà di chiusura

Una terza tecnica è usare le *proprietà di chiusura* rispetto al complemento. Se facciamo vedere che $L^C in.not CFL$ allora $L$ non può essere DCFL perché questi ultimi sono chiusi rispetto al complemento, ed essendo $L^C in.not CFL$ allora vale anche $L^C in.not DCFL$.

#example()[
  Definiamo il linguaggio $ L = {x in {a,b}^* bar.v exists.not w bar.v x = w w} $ formato dalle stringhe che non sono decomponibili come due stringhe uguali concatenate.

  Calcoliamo il suo complemento $ L^C = {w w bar.v w in {a,b}^*} . $

  Con il pumping abbiamo dimostrato che questo linguaggio non è CFL. Ma allora $L$ non è DCFL, quindi sapendo che è CFL cerchiamo un PDA per esso.

  Creiamo una sorta di automa prodotto che simula l'intersezione con un regolare:
  - una prima componente è un *automa a stati finiti* che controlla la lunghezza della stringa. Se questa è dispari allora accettiamo, altrimenti guardiamo l'altra componente;
  - la seconda componente è un'*automa a pila*, e ora vediamo come è fatto.

  Definita $m$ la quantità che indica la metà della lunghezza della stringa in input, l'automa a pila deve trovare due simboli a distanza $m$ che sono diversi.

  #align(center)[
    #lq.diagram(
      xlim: (-0.25, 4.25),
      ylim: (-0.25, 0.75),

      xaxis: none,
      yaxis: none,
      grid: none,

      lq.line((0, 0), (4, 0), stroke: 2pt + black),

      lq.line((0, 0.25), (0.75, 0.25), tip: tp.rays, toe: tp.rays),
      lq.line((0.75, 0.25), (2, 0.25), tip: tp.rays, toe: tp.rays),
      lq.line((2, 0.25), (2.75, 0.25), tip: tp.rays, toe: tp.rays),
      lq.line((2.75, 0.25), (4, 0.25), tip: tp.rays, toe: tp.rays),

      lq.line((2, 0), (2, 0.75), stroke: (paint: red, dash: "dashed")),

      lq.place(2, -0.15, $x$),
      lq.place(0.75, -0.15, $gamma$),
      lq.place(2.75, -0.15, $sigma$),

      lq.plot((0.75, 2.75), (0, 0), stroke: none, mark: "o"),

      lq.place(0.375, 0.4, $k$),
      lq.place(1.375, 0.4, $h$),
      lq.place(2.375, 0.4, $k$),
      lq.place(3.375, 0.4, $h$),
    )
  ]

  Abbiamo quindi un simbolo $gamma$ a distanza $k$ dall'inizio che deve essere diverso da un simbolo $sigma$ a distanza $h + k = m$ da $gamma$.

  La prima idea per risolvere questo problema è quella di azzeccare dove sta la metà, ma questo è molto difficile quindi è un campanello che ci deve dire che non ci potrebbe servire. E infatti.

  Facciamo una cosa più esotica: grazie alla bellissima *proprietà commutativa* della somma sappiamo che $h + k = k + h$. In particolare, proviamo a invertire la parte centrale della stringa, ovvero proviamo a pensare alla stringa $x$ come se fosse formata da due pezzi lunghi $k$ e da due pezzi lunghi $h$.

  Vediamo la soluzione divisa in fasi:
  + *prima fase*
    - leggiamo l'input e carichiamo un simbolo sulla pila come contatore;
    - ad un certo punto, non deterministicamente scegliamo il simbolo sospetto $gamma$ da controllare. A questo punto abbiamo caricato $k$ simboli sulla pila;
  + *seconda fase*
    - scarichiamo i $k$ simboli sulla pila leggendo altri $k$ simboli in input, arrivando fino al simbolo iniziale della pila. Con questa mossa abbiamo letto i primi due blocchi di $k$ simboli;
  + *terza fase*
    - ripetiamo la prima fase, quindi iniziamo a caricare sulla pila dei caratteri leggendo l'input;
    - ad un certo punto, sempre non deterministicamente, scegliamo il secondo simbolo sospetto $sigma$ tale che $gamma eq.not sigma$. Questo controllo lo possiamo fare con il controllo a stati finiti. A questo punto abbiamo caricato $h$ simboli sulla pila;
  + *quarta fase*
    - come nella seconda fase, andiamo a scaricare gli $h$ simboli che abbiamo sulla pila, sempre leggendo l'input.

  #align(center)[
    #lq.diagram(
      xlim: (-0.75, 4.75),
      ylim: (-0.25, 1.5),

      xaxis: none,
      yaxis: none,
      grid: none,

      lq.line((0, 0), (4, 0), stroke: 2pt + black),

      lq.line((0, 0.1), (0.75, 0.85)),
      lq.line((0.75, 0.85), (1.5, 0.1)),
      lq.line((1.5, 0.1), (2.75, 1.35)),
      lq.line((2.75, 1.35), (4, 0.1)),

      lq.line((2, 0), (2, 1.5), stroke: (paint: red, dash: "dashed")),

      lq.place(2, -0.15, $x$),
      lq.place(0.75, -0.15, $gamma$),
      lq.place(2.75, -0.15, $sigma$),

      lq.plot((0.75, 2.75), (0, 0), stroke: none, mark: "o"),

      lq.line((-0.5, 0.1), (-0.5, 0.85), stroke: (paint: blue, dash: "dashed"), tip: tp.diamond, toe: tp.diamond),
      lq.line((4.5, 0.1), (4.5, 1.35), stroke: (paint: blue, dash: "dashed"), tip: tp.diamond, toe: tp.diamond),

      lq.place(-0.75, 0.475, $k$),
      lq.place(4.75, 0.725, $h$),
    )
  ]

  Se abbiamo azzeccato bene il primo simbolo e bene il secondo simbolo arriviamo alla fine dell'input che abbiamo fatto una salita e una discesa di $k$ e una salita e una discesa di $h$.
]

#example()[
  Vediamo una grammatica per il linguaggio precedente.

  Le regole di produzione sono: $ S &arrow.long A B bar.v B A bar.v A bar.v B \ A &arrow.long a A a bar.v a A b bar.v b A a bar.v b A b bar.v a \ B &arrow.long a B a bar.v a B b bar.v b B a bar.v b B b bar.v b . $

  Se scegliamo solo una lettera generiamo stringhe dispari, che controlla l'automa a stati finiti. Se scegliamo invece una concatenazione di due lettere allora abbiamo che $ A arrow.stroked^* x A y arrow.stroked x a y quad &bar.v quad abs(x) = abs(y) \ B arrow.stroked^* z B v arrow.stroked z b v quad &bar.v quad abs(z) = abs(v) . $

  Ma allora stiamo generando della stringhe $ S arrow.stroked A B arrow.stroked^* underbracket(x a underbracket(y z) b v) quad bar.v quad abs(x) + abs(v) = abs(y) + abs(z) . $ Stesso discorso lo possiamo fare per $S arrow.stroked B A$.
]

#example()[
  Ora che abbiamo visto un automa a pila e anche una grammatica per $L$, possiamo usare il primo risultato per dire che $L$ non può essere deterministico perché con le proprietà di chiusura $L^C$ dovrebbe essere DCFL.
]

Vediamo ora un altro linguaggio con un esempio.

#example()[
  Definiamo quindi il linguaggio $ L = {w w^R bar.v w in {a,b}^*} $ che ovviamente è CFL, ed è infatti molto facile definire un automa a pila per $L$.

  Abbiamo visto che $L^C$ è anch'esso CFL, la scorsa lezione, usando una costruzione con la pila come contatore o con la pila come "ricercatore" della prima occorrenza sbagliata.

  Quindi in questo caso il criterio di chiusura dei DCFL non ci può aiutare. Inoltre, non ci può aiutare nemmeno il dimostrare $L$ inerentemente ambiguo, perché questo linguaggio non è ambiguo, visto che la metà è una sola (se uso il contatore) o che mi sto ricordando quello che sto guardando (se nella pila butto i caratteri).
]

Ok possiamo usare il pumping lemma o il lemma di Ogden, però vediamo un quarto criterio.

== Relazione di Myhill-Nerode

Per introdurre questo nuovo criterio dobbiamo riprendere la *relazione di Myhill-Nerode* che abbiamo definito nei linguaggi regolari. Dato un linguaggio $L subset.eq Sigma^*$, definiamo la relazione $ R subset.eq Sigma^* times Sigma^* bar.v rel(x, R, y) sse (forall z in Sigma^* quad (x z in L sse y z in L)) . $

Avevamo visto che $R$ era una *relazione di equivalenza* e le sue *classi di equivalenza* erano gli stati dell'*automa minimo*. Vediamo come useremo $R$ per i DCFL.

#theorem()[
  Se ogni classe di equivalenza di $R$ ha cardinalità finita allora $L$ non è DCFL.
]

La dimostrazione è combinatoria: preso il linguaggio $L$, si va ad assumere che esso sia DCFL e si dimostra che esiste almeno una classe di equivalenza con cardinalità infinita.

Applichiamolo subito all'ultimo esempio visto.

#example()[
  Definiamo di nuovo il linguaggio $ PAL = {x in {a,b}^* bar.v x = x^R} . $

  Facciamo vedere che $ x,y in {a,b}^* bar.v x eq.not y arrow.long.double (x,y) in.not R , $ ovvero che ogni classe di equivalenza è formata da un solo elemento.

  Prendiamo quindi due stringhe generiche $ x &= x_1 dots x_n \ y &= y_1 dots y_m $ e supponiamo di averle scritte in ordine di lunghezza, quindi $n lt.eq m$.

  Per dimostrare che queste due stringhe non sono in relazione devo far vedere che esiste una stringa $z$ che le distingue. Dividiamo in due casi l'analisi.

  Se esiste un indice che pesca da $x$ e da $y$ due caratteri diversi, ovvero se $ exists i in {1, dots, n} bar.v x_i eq.not y_i $ allora scegliamo la stringa $z = x^R$ tale che $ x z &= x x^R in PAL \ y z &= y x^R = y_1 dots y_m x_n dots x_1 in.not PAL $ perché
  - alla prima ho accodato proprio sé stessa ma rovesciata;
  - alla seconda ho accodato $X^R$ che però ha $x_i eq.not y_i$ alla stessa distanza dai bordi.

  Se invece tutti i caratteri di $x$ sono uguali ai primi $n$ caratteri di $y$, ovvero se $ forall i in {1, dots, n} quad x_i = y_i , $ sapendo che $x eq.not y$ possiamo dire che $m > n$. Possiamo scrivere $y$ come $ y = x_1 dots x_n y_(n+1) dots y_m . $

  Come stringa $z$ scegliamo $z = c x^R$ dove $ c = cases(a & "se" y_(n+1) = b, b quad & "altrimenti") . $

  Se applichiamo questa stringa alle due che abbiamo a disposizione otteniamo $ x z &= x c x^R in PAL \ y z &= x y_(n+1) dots y_m c x^R in.not PAL $ perché
  - alla prima ho accodato sé stessa ma rovesciata con in mezzo un carattere qualsiasi, che però essendo in mezzo non rompe;
  - alla seconda ho accordato $c x^R$, quindi il pezzo fino a $y_(n+1)$ è tutto uguale, e proprio in $y_(n+1)$ e $c$ abbiamo la diversità.

  Ma allora ogni classe di equivalenza ha un'unica stringa, ma allora per il teorema precedente il linguaggio PAL non è deterministico.
]
