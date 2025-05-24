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

/*********************************************/
/***** DA CANCELLARE PRIMA DI COMMITTARE *****/
/*********************************************/
#set heading(numbering: "1.")

#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline(indent: auto)
/*********************************************/
/***** DA CANCELLARE PRIMA DI COMMITTARE *****/
/*********************************************/

= Equivalenza tra CFL e grammatiche di tipo $2$

Facciamo un breve ripasso sulle grammatiche di tipo $2$ e poi andiamo a vedere l'equivalenza tra le grammatiche di tipo $2$ e gli automi a pila.

== Ripasso e introduzione

Una grammatica $G$ di tipo $2$ ha le *regole di produzione* nella forma $ X arrow.long X_1 dots X_k quad bar.v quad X in V and X_1, dots, X_k in (V union Sigma) and k gt.eq 0 . $

Abbiamo modificato leggermente la forma ma il succo è quello: ad ogni variabile associamo una sequenza (anche vuota) di terminali e non terminali.

Il processo di derivazione nelle grammatiche di tipo $2$ può essere espresso mediante *alberi di derivazione*: essi sono alberi che visualizzano l'applicazione delle regole di produzione.

In un albero generico, la *radice* e i *nodi interni* sono *variabili*, mentre le foglie sono combinazioni di *variabili e terminali*. In un albero che rappresenta una stringa del linguaggio nella radice ho l'*assioma* $S$ e nelle foglie ho *solo terminali*.

Un nodo, con i suoi figli diretti, va a rappresentare l'*applicazione* di una regola di produzione. Ad esempio, prendendo la regola di produzione generica di una grammatica di tipo $2$, abbiamo il seguente *albero di derivazione*:

#align(center)[
  #cetz.canvas({
    import cetz.tree

    tree.tree((
      [$X_space.sixth$],
      [$X_1$],
      [$X_2$],
      [$dots$],
      [$X_k$],
    ))
  })
]

Vediamo questi alberi applicati a qualche esempio.

#example()[
  Riprendiamo la grammatica per le parentesi tonde bilanciate, che avevamo fatto a inizio corso, con le seguenti regole di produzione: $ S arrow.long epsilon bar.v (S) bar.v S S . $

  Vediamo due alberi di derivazione che abbiamo in questo linguaggio.

  #align(center)[
    #cetz.canvas({
      import cetz.tree

      tree.tree((
        [$S$],
        [$($],
        ([$S$], ([$S$], [$($], ([$S$], [$epsilon$]), [$)$]), ([$S$], [$($], ([$S$], [$epsilon$]), [$)$])),
        [$)$],
      ))
    })
  ]

  Questo primo albero rappresenta la derivazione della stringa $w = (()())$.

  #align(center)[
    #cetz.canvas({
      import cetz.tree

      tree.tree((
        [$S$],
        ([$S$], ([$S$], [$($], ([$S$], [$epsilon$]), [$)$]), ([$S$], [$($], ([$S$], [$epsilon$]), [$)$])),
        ([$S$], [$($], ([$S$], [$epsilon$]), [$)$]),
      ))
    })
  ]

  Questo secondo albero genera invece la stringa $w = ()()()$.

  Per leggera la stringa che viene generata basta una *visita in profondità* dell'albero.
]

Gli alberi sono un *modo compatto* di descrivere un processo di derivazione.

#example()[
  Rimaniamo con il linguaggio dell'ultimo esempio, e prendiamo in considerazione l'ultima stringa $()()()$ che abbiamo derivato.

  Proviamo a scrivere la derivazione usando proprio le regole di produzione che abbiamo a disposizione. Ci accorgiamo subito che abbiamo diversi modi di arrivare a quella stringa: $ #text(fill: blue)[$S$] arrow.stroked #text(fill: blue)[$S$] S arrow.stroked #text(fill: blue)[$S$] S S arrow.stroked (#text(fill: blue)[$S$]) S S arrow.stroked () #text(fill: blue)[$S$] S arrow.stroked () (#text(fill: blue)[$S$]) S arrow.stroked ()() #text(fill: blue)[$S$] arrow.stroked ()()(#text(fill: blue)[$S$]) arrow.stroked& ()()() \ #text(fill: blue)[$S$] arrow.stroked #text(fill: blue)[$S$] S arrow.stroked S #text(fill: blue)[$S$] S arrow.stroked S (#text(fill: blue)[$S$]) S arrow.stroked S () #text(fill: blue)[$S$] arrow.stroked #text(fill: blue)[$S$] () (S) arrow.stroked (#text(fill: blue)[$S$]) () (S) arrow.stroked ()() (#text(fill: blue)[$S$]) arrow.stroked& ()()() \ #text(fill: blue)[$S$] arrow.stroked #text(fill: blue)[$S$] S arrow.stroked (#text(fill: blue)[$S$]) S arrow.stroked () #text(fill: blue)[$S$] arrow.stroked () #text(fill: blue)[$S$] S arrow.stroked () (#text(fill: blue)[$S$]) S arrow.stroked ()() #text(fill: blue)[$S$] arrow.stroked ()() (#text(fill: blue)[$S$]) arrow.stroked& ()()() . $

  In blu viene indicata la variabile $S$ che viene sostituita ad ogni passo.

  Queste derivazioni generano la stessa stringa ma hanno alberi di derivazione diversi (non lo disegno, ma vale quanto scritto).
]

Cerchiamo di dare una corrispondenza tra derivazioni e alberi di derivazione. Andiamo ad utilizzare le *derivazioni leftmost*: esse sono derivazioni in cui, ad ogni passo, la variabile che andiamo a sostituire è quella più a sinistra nella forma sentenziale.

#example()[
  Nelle tre derivazioni precedenti ci accorgiamo che la prima e la terza derivazione sono leftmost, mentre la seconda non lo è.
]

Abbiamo quindi creato una corrispondenza $1:1$ tra derivazioni leftmost e alberi di derivazione. Da questo momento, parleremo di derivazioni leftmost riferendoci ad alberi di derivazione e viceversa.

#definition([Grammatica ambigua])[
  Una grammatica $G$ è *ambigua* se $exists w in L(G)$ che ammette due alberi di derivazione differenti, oppure, in maniera equivalente, se $exists w in L(G)$ che ammette due derivazioni leftmost diverse.
]

#example()[
  La grammatica delle parentesi tonde bilanciate è *ambigua*, mentre la grammatica della parole palindrome di lunghezza pari è *non ambigua*.
]

La pila è la struttura che ci permette di implementare la *ricorsione*. I linguaggi CFL hanno in più, rispetto ai regolari, l'accesso alle strutture ricorsive, e questo lo vediamo negli esempi che abbiamo fatto: l'esempio delle parentesi tonde bilanciate ha come flow
- inizio qualcosa (trovo una tonda aperta);
- vedo se ho ancora qualcosa di bilanciato;
- finisco quel qualcosa (trovo una tonda chiusa).

Tra l'altro, molto figo che *tutti i CFL* si possono ricondurre al *linguaggio delle parentesi bilanciate*, molto molto bello.

== Da grammatica di tipo 2 ad automa a pila

Abbiamo a disposizione una grammatica $G$ di tipo $2$, detta anche *CFG*. Vogliamo costruire un automa a pila $M$ che simuli il processo di derivazione tramite derivazioni leftmost.

Sia quindi $ G = (V, Sigma, P, S) $ una CFG. Costruiamo $ M = (Q, Sigma, Gamma, delta, q_0, Z_0, emptyset.rev) $ un PDA che accetterà *per pila vuota* tale che:
- l'*insieme degli stati* $Q$ contiene un solo stato, ovvero $ Q = {q} ; $
- lo *stato iniziale*, vista la presenza di un solo stato, è $ q_0 = q ; $
- l'*alfabeto di lavoro della pila* $Gamma$ contiene tutto l'alfabeto della grammatica, ovvero l'insieme di tutti i simboli di $G$, ovvero $ Gamma = V union Sigma; $
- il *simbolo iniziale della pila* $Z_0$ è l'assioma della grammatica, ovvero $ Z_0 = S ; $ useremo la pila per metterci sopra quello che vogliamo espandere mano a mano;
- infine, la *funzione di transizione* è *non deterministica* e ha due regole:
  - ogni volta che ho una variabile sulla cima della pila, con una epsilon mossa per sostituirla con il lato destro di una produzione, ovvero $ forall A in V quad delta(q, epsilon, A) = {(q, alpha) bar.v (A arrow.long alpha) in P} ; $
  - ogni volta che ho un simbolo terminale sulla cima della pila, andiamo a leggere dal nastro e verifichiamo che i due valori siano uguali, ovvero $ forall a in Sigma quad delta(q, a, a) = {(q, epsilon)} . $

#lemma()[
  Vale $ L(G) = N(M) . $
]

Dimostriamo questo con un esempio.

#example()[
  Definiamo la grammatica $G = (V, Sigma, P, S)$ tale che:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$V = {S, T, U}$], [$Sigma = {a,b}$],
  )

  #v(-10pt)

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long T U$], [$T arrow.long a T b bar.v epsilon$], [$U arrow.long b U a bar.v epsilon$],
  )

  Questa grammatica genera il linguaggio $ L = {a^n b^(n + m) a^m bar.v n,m gt.eq 0} . $

  Andiamo a scrivere un PDA $M$ per questa grammatica. Partiamo con le regole del primo tipo: $ delta(q, epsilon, S) &= {(q, T U)} \ delta(q, epsilon, T) &= {(q, a T b), (q, epsilon)} \ delta(q, epsilon, U) &= {(q, b U a), (q, epsilon)} . $ E terminiamo con le regole del secondo tipo: $ delta(q, a, a) &= {(q, epsilon)} \ delta(q, b, b) &= {(q, epsilon)} . $

  Simuliamo l'automa a pila che abbiamo costruito e il processo di derivazione con la stringa $ w = a b b b a a . $

  Ricordiamoci di usare una *derivazione leftmost*: questo è comodo perché i simboli che scriviamo più in alto sono quelli più a sinistra nella stringa aggiunta, e noi facciamo le sostituzioni proprio a partire da sinistra, quindi ottimo.

  Nella colonna della *testina*, in blu indichiamo il carattere che la testina può leggere, mentre nella colonna della *derivazione*, sempre in blu indichiamo i caratteri che sono già stati verificati. Di quest'ultimo fatto ne parleremo meglio dopo.

  #table(
    columns: (10%, 15%, 20%, 55%),
    align: center + horizon,
    inset: 10pt,
    [*Pila*], [*Testina*], [*Derivazione*], [*Spiegazione della mossa*],
    [$S$], [$#text(fill: blue)[$a$] b b b a a$], [$S$], [Configurazione iniziale],
    [$T \ U$],
    [$#text(fill: blue)[$a$] b b b a a$],
    [$T U$],
    [L'unica sostituzione che posso fare per $S$ la faccio. Inoltre, non sposto la testina],

    [$a \ T \ b \ U$],
    [$#text(fill: blue)[$a$] b b b a a$],
    [$a T b U$],
    [Avendo a disposizione il non determinismo, sono fortunato e scelgo la derivazione corretta e, come prima, non sposto la testina],

    [$T \ b \ U$],
    [$a #text(fill: blue)[$b$] b b a a$],
    [$#text(fill: blue)[$a$] T b U$],
    [Ora che ho un carattere sulla cima della pila, verifico che sono uguali (lo sono), sposto avanti la testina consumando il carattere della pila e quello del nastro],

    [$b \ U$],
    [$a #text(fill: blue)[$b$] b b a a$],
    [$#text(fill: blue)[$a$] b U$],
    [Avendo a disposizione il non determinismo, sono fortunato e scelgo la derivazione corretta e, come prima, non sposto la testina],

    [$U$],
    [$a b #text(fill: blue)[$b$] b a a$],
    [$#text(fill: blue)[$a b$] U$],
    [Ora che ho un carattere sulla cima della pila, verifico che sono uguali (lo sono), sposto avanti la testina consumando il carattere della pila e quello del nastro],

    [$b \ U \ a$],
    [$a b #text(fill: blue)[$b$] b a a$],
    [$#text(fill: blue)[$a b$] b U a$],
    [Avendo a disposizione il non determinismo, sono fortunato e scelgo la derivazione corretta e, come prima, non sposto la testina],

    [$U \ a$],
    [$a b b #text(fill: blue)[$b$] a a$],
    [$#text(fill: blue)[$a b b$] U a$],
    [Ora che ho un carattere sulla cima della pila, verifico che sono uguali (lo sono), sposto avanti la testina consumando il carattere della pila e quello del nastro],

    [$b \ U \ a \ a$],
    [$a b b #text(fill: blue)[$b$] a a$],
    [$#text(fill: blue)[$a b b$] b U a a$],
    [Avendo a disposizione il non determinismo, sono fortunato e scelgo la derivazione corretta e, come prima, non sposto la testina],

    [$U \ a \ a$],
    [$a b b b #text(fill: blue)[$a$] a$],
    [$#text(fill: blue)[$a b b b$] U a a$],
    [Ora che ho un carattere sulla cima della pila, verifico che sono uguali (lo sono), sposto avanti la testina consumando il carattere della pila e quello del nastro],

    [$a \ a$],
    [$a b b b #text(fill: blue)[$a$] a$],
    [$#text(fill: blue)[$a b b b$] a a$],
    [Avendo a disposizione il non determinismo, sono fortunato e scelgo la derivazione corretta e, come prima, non sposto la testina],

    [$a$],
    [$a b b b a #text(fill: blue)[$a$]$],
    [$#text(fill: blue)[$a b b b a$] a$],
    [Ora che ho un carattere sulla cima della pila, verifico che sono uguali (lo sono), sposto avanti la testina consumando il carattere della pila e quello del nastro],

    [$epsilon$],
    [$a b b b a a #text(fill: blue)[$epsilon$]$],
    [#text(fill: blue)[$a b b b a a$]],
    [Ora che ho un carattere sulla cima della pila, verifico che sono uguali (lo sono), sposto avanti la testina consumando il carattere della pila e quello del nastro],
  )

  Riprendiamo quello detto prima: possiamo notare che, guardando la derivazione, dalla variabile più a sinistra in poi c'è esattamente quello che troviamo sulla pila nello stesso momento, mentre prima della variabile troviamo la parte dell'input su nastro che abbiamo già controllato.
]

Le mosse che noi abbiamo etichettato come non deterministiche sono le mosse che avvengono nei *parser*:
- quando facciamo una predizione, ovvero quando cerchiamo di indovinare l'espansione, stiamo facendo una mossa di tipo *predictor*;
- quando controlliamo la predizione fatta, ovvero quando controlliamo le lettere sul nastro e sulla pila, stiamo facendo una mossa di tipo *scanner*.

Siamo partiti quindi da una CFG e abbiamo costruito un PDA *equivalente* che accetta per pila vuota e con un solo stato, tanta tanta roba.

== Da automa a pila a grammatica di tipo $2$

Per finire la dimostrazione che gli automi a pila sono equivalenti alle grammatiche di tipo $2$, ci manca da vedere il passo da automa a grammatica. Per fare ciò, dobbiamo introdurre una *nuova forma normale* per gli automi a pila, per rendere i conti più facili.

#example()[
  Definiamo l'alfabeto $Sigma = {(, )}$ e consideriamo l'alfabeto delle stringhe che rappresentano sequenze di parentesi tonde bilanciate. Come costruiamo un automa a pila per questo linguaggio?

  Facilmente, ogni volta che trovo una parentesi aperta metto un simbolo sulla pila, mentre ogni volta che trovo una parentesi chiusa tolgo un simbolo dalla pila, se possibile. Se a fine input arrivo in una configurazione $ (q, epsilon, Z_0) $ vado ad accettare, visto che tutto quello che ho messo sulla pila l'ho tolto. Andiamo quindi ad accettare "per stati finali", e non per pila vuota, come dice Pighizzini.

  Inoltre, la versione "per stati finali" è deterministica, mentre quella per pila vuota non lo è.

  Quello che stiamo facendo, in ogni caso, è buttare sulla pila delle robe da controllare dopo: ogni volta che apro devo fare altri lavori e poi andare a chiudere.
]

=== Forma normale per gli automi a pila

Vediamo una *forma normale* più semplice. Diamo delle regole:
+ all'inizio la pila contiene solo $Z_0$ e lo usiamo per marcare il fondo della pila. Questo carattere non è mai rimosso e mai aggiunto;
+ l'input è accettato se si raggiunge una configurazione in cui:
  - tutto l'input è stato letto;
  - la pila contiene solo $Z_0$;
  - lo stato è finale.
  In poche parole, tutto ciò che metto sulla pila sono attività che ho lasciato in sospeso, alla fine devo aver terminato tutto. È un po' un mix tra pila vuota (circa) e stati finali;
+ le mosse che facciamo sulla pila sono:
  - *push* di un simbolo (uno alla volta);
  - *pop* del simbolo in cima alla pila;
  - *pila invariata*.

#example()[
  Avendo delle regole nella forma $ delta(q, sigma, A) = {(p, alpha)} $ allora:
  - se $alpha = epsilon$ stiamo eseguendo una pop;
  - se $alpha = A$ stiamo facendo una pila invariata;
  - se $alpha = beta A$ stiamo facendo una pila invariata e $abs(beta)$ push;
  - se $alpha = beta A' bar.v A eq.not A'$ stiamo facendo una pop, una push e $abs(beta)$ push.
]

Ci rendiamo conto, visto l'esempio precedente, che *i due modelli sono equivalenti*.

#let filter_all = (value, distance) => false
#let filter_y = (value, distance) => value < 5 and value > 0

#example()[
  Definiamo l'alfabeto $Sigma = {(, ), [, ]}$. Vogliamo descrivere la computazione accettante della stringa $w = ([()]())$ data in input ad un automa a pila.

  #set math.mat(delim: none, row-gap: 0.5em)

  Simuliamo la computazione dell'automa su $w$ visualizzando la pila dell'automa: $ mat(, , , A, , , , , ; , , B, B, B, , A, , ; , A, A, A, A, A, A, A, ; Z_0, Z_0, Z_0, Z_0, Z_0, Z_0, Z_0, Z_0, Z_0; , \(, \[, \(, \), \], \(, \), \); augment: #(hline: 4)) . $

  Andiamo a graficare anche l'altezza della pila che abbiamo ottenuto durante la computazione.

  #align(center)[
    #lq.diagram(
      width: 12cm,
      height: 8cm,

      xlim: (-0.5, 11),
      ylim: (-0.5, 5),

      xaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),
      yaxis: (position: 0, tip: tp.stealth, filter: filter_y, tick-distance: 1, subticks: none),

      lq.line((1, 1), (2, 2)),
      lq.line((2, 2), (3, 3)),
      lq.line((3, 3), (4, 4)),
      lq.line((4, 4), (5, 3)),
      lq.line((5, 3), (6, 2)),
      lq.line((6, 2), (7, 3)),
      lq.line((7, 3), (8, 2)),
      lq.line((8, 2), (9, 1)),

      lq.place(2, -0.3)[$($],
      lq.place(3, -0.3)[$[$],
      lq.place(4, -0.3)[$($],
      lq.place(5, -0.3)[$)$],
      lq.place(6, -0.3)[$]$],
      lq.place(7, -0.3)[$($],
      lq.place(8, -0.3)[$)$],
      lq.place(9, -0.3)[$)$],
    )
  ]

  Sulle ascisse abbiamo rappresentato l'*input*, che possiamo vedere anche come *tempo* (a meno delle $epsilon$-mosse) nel quale l'automa si trova durante lo spostamento della testina da sinistra verso destra. Sulle ordinate invece abbiamo rappresentati l'*evoluzione* della pila.

  Come vediamo, tra la prima tonda l'ultima tonda non andiamo mai sotto, idem quando apriamo e chiudiamo la quadra. Infatti, quando apro qualcosa, in mezzo non vado mai sotto e prima di tornare a livello devo riconoscere altre sequenze bilanciate.

  In poche parole stiamo facendo una *chiamata ricorsiva*.
]

Studieremo le computazioni di questo tipo per scrivere la grammatica dall'automa a pila.

Aggiungiamo ancora una regola:
4. quando l'automa *legge* un simbolo di input e muove la testina la pila *non viene modificata*.

La nuova *funzione di transizione* di questi automi è nella forma $ delta : Q times (Sigma union {epsilon}) times Gamma arrow.long 2^(Q times {-, push(A) bar.v A in Gamma, pop}) , $ ovvero delle coppie formate da nuovo stato e operazione tra pila invariata, push e pop. Qua, a differenza di prima, non mi servono le parti finite perché ho già sottoinsiemi finiti.

Come sono fatte le regole della funzione di transizione? Dipende se stiamo leggendo o meno, per la nuova regola $4$, quindi possiamo avere:
- *mosse di lettura*, che facciamo lasciando inalterata la pila per la regola che abbiamo appena aggiunto, ovvero $ (p,-) in delta(q, a, A) bar.v p,q in Q and a in Sigma, and A in Gamma ; $
- *mosse pop*, che non leggono niente dal nastro ma liberano la prima posizione sulla pila, ovvero $ (p, pop) in delta(q, epsilon, A) ; $
- *mosse push*, che non leggono niente dal nastro ma aggiungono un elemento sulla pila, ovvero $ (p, push(B)) in delta(q, epsilon, A) bar.v B in Gamma ; $
- *mosse di cambio stato*, che non leggono niente e non modificano la pila, ovvero $ (p,-) in delta(q, epsilon, A) . $

=== Dimostrazione

Abbiamo detto che con questo nuovo automa noi vogliamo partire da $Z_0$ sulla pila e finire con lo stesso carattere alla fine della stringa. Abbiamo due casi possibili:
- durante la computazioni saliamo e scendiamo di livello ma raggiungiamo $Z_0$ alla fine;
- durante la computazione torniamo in $Z_0$ in almeno un punto.

In generale, possiamo sostituire a $Z_0$ un qualsiasi carattere che inseriamo sulla pila. Infatti, una volta inserito il carattere $A$ sulla pila nello stato $q$, noi saliamo e scendiamo e poi usciamo con ancora $A$ sulla pila nello stato $p$ o nello stato $r$ se siamo in uno intermedio.

#grid(
  columns: (50%, 50%),
  align: center + horizon,
  inset: 10pt,
  [
    #lq.diagram(
      width: 6.9cm,
      height: 4.6cm,

      xlim: (-0.5, 12),
      ylim: (-0.5, 5),

      xaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),
      yaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),

      lq.line((1, 1), (2, 2)),
      lq.line((2, 2), (3, 3)),
      lq.line((3, 3), (4, 2)),
      lq.line((4, 2), (5, 3)),
      lq.line((5, 3), (6, 4)),
      lq.line((6, 4), (7, 3)),
      lq.line((7, 3), (8, 4)),
      lq.line((8, 4), (9, 3)),
      lq.line((9, 3), (10, 2)),
      lq.line((10, 2), (11, 1)),

      lq.line((0, 1), (12, 1), stroke: (paint: blue, dash: "dashed")),
      lq.plot((1, 11), (1, 1), stroke: none, mark: "o"),

      lq.place(1, -0.3)[$q$],
      lq.place(11, -0.3)[$p$],
    )
  ],
  [
    #lq.diagram(
      width: 6.9cm,
      height: 4.6cm,

      xlim: (-0.5, 12),
      ylim: (-0.5, 5),

      xaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),
      yaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),

      lq.line((1, 1), (2, 2)),
      lq.line((2, 2), (3, 3)),
      lq.line((3, 3), (4, 2)),
      lq.line((4, 2), (5, 1)),
      lq.line((5, 1), (6, 2)),
      lq.line((6, 2), (7, 3)),
      lq.line((7, 3), (8, 2)),
      lq.line((8, 2), (9, 3)),
      lq.line((9, 3), (10, 2)),
      lq.line((10, 2), (11, 1)),

      lq.line((0, 1), (12, 1), stroke: (paint: blue, dash: "dashed")),
      lq.plot((1, 5, 11), (1, 1, 1), stroke: none, mark: "o"),

      lq.place(1, -0.3)[$q$],
      lq.place(5, -0.3)[$r$],
      lq.place(11, -0.3)[$p$],
    )
  ],
)

Definiamo la grammatica $G = (V, Sigma, P, S)$ formata dalle variabili $ V = S union {[q A p] bar.v q,p in Q and A in Gamma} . $ Le variabili, oltre a $S$, sono delle *triple* che mi indicano lo stato nel quale sono, il simbolo corrente sulla pila e lo stato nel quale arrivo dopo essere tornato nel simbolo che ho trovato sulla pila.

Vediamo le *mosse* che possiamo fare.

Se stiamo *leggendo un simbolo in input*, non modifichiamo la pila, quindi $ forall (p,-) in delta(q, a, A) quad [q A p] arrow.long a . $ In poche parole, ci stiamo spostando in linea retta, consumando il carattere $a$ sul nastro: $ q #box(stroke: black, inset: 2pt)[$A$] arrow.long^a #box(stroke: black, inset: 2pt)[$A$] p . $

Aggiungiamo anche la produzione $ [q A q] arrow.long epsilon $ che serve per chiudere delle ricorsioni banali come se fosse un caso base. In poche parole, andiamo a generare solo la *parola vuota*: $ q #box(stroke: black, inset: 2pt)[$A$] arrow.long^epsilon #box(stroke: black, inset: 2pt)[$A$] q . $

Se invece stiamo facendo la mossa che *cambia stato*, dobbiamo solo spostarci tra gli stati, ovvero $ forall (p,-) in delta(q, epsilon, A) quad [q A p] arrow.long epsilon . $ Come prima, possiamo vedere graficamente il movimento come una linea retta: $ q #box(stroke: black, inset: 2pt)[$A$] arrow.long^epsilon #box(stroke: black, inset: 2pt)[$A$] p . $

Ora facciamo le costruzioni *induttive*.

Supponiamo di essere nel caso in cui, dopo aver caricato $A$ sulla pila, torniamo con la lettera $A$ in cima alla pila alla fine della computazione. In questo caso, la pila è sempre più alta di $A$, che dopo essere stata caricata "induce" una chiamata ricorsiva nella quale carico, ad esempio, il carattere $B$ e poi lo devo scaricare prima o poi.

#align(center)[
  #lq.diagram(
    width: 12cm,
    height: 8cm,

    xlim: (-1, 12),
    ylim: (-2, 5),

    xaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),
    yaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),

    lq.line((1, 1), (2, 2)),
    lq.line((2, 2), (3, 3)),
    lq.line((3, 3), (4, 2)),
    lq.line((4, 2), (5, 3)),
    lq.line((5, 3), (6, 4)),
    lq.line((6, 4), (7, 3)),
    lq.line((7, 3), (8, 4)),
    lq.line((8, 4), (9, 3)),
    lq.line((9, 3), (10, 2)),
    lq.line((10, 2), (11, 1)),

    lq.plot((1, 11), (1, 1), stroke: none, mark: "o"),
    lq.plot((2, 10), (2, 2), stroke: none, mark: "o"),

    lq.line((1, -1.5), (11, -1.5), tip: tp.straight, toe: tp.straight),
    lq.place(6, -1)[$w$],

    lq.place(1, -0.3)[$q$],
    lq.place(11, -0.3)[$p$],
    lq.place(2, -0.3)[$q'$],
    lq.place(10, -0.3)[$p'$],
  )
]

Nel grafico, abbiamo $B$ che viene indicato dal pallino arancione, che è posizionato sopra il pallino blu, che indica invece la lettera $A$ che viene scaricata poi alla fine.

Se chiamiamo $w$ la parte di stringa che stiamo riconoscendo tra la prima $A$ e la seconda $A$, allora visto che non leggiamo altro durante la push di $B$ stiamo andando a consumare ancora $w$ ma partendo da $B$. Supponiamo che la mossa che carica la $B$ mi manda nello stato $q'$ e che la mossa che scarica la $B$ parte da $p'$. Possiamo definire allora $ forall (q', push(B)) in delta(q, epsilon, A) quad forall (p, pop) in delta(p', epsilon, B) quad [q A p] arrow.long [q' B p'] . $

In poche parole, se da $q$ ed $A$ faccio una push di $B$ in $q'$ e poi da $p'$ faccio una pop per andare in $p$ ho fatto una chiamata ricorsiva che ora parte da $B$ e usa gli stati accentati. Come detto prima, la stringa che stiamo consumando rimane sempre $w$ perché con le push e le pop non leggiamo caratteri dal nastro.

L'ultimo caso che ci manca è quando abbiamo almeno una configurazione intermedia nella quale mi trovo allo stesso livello. In questo caso finiamo in uno stato $r$ diverso, quindi abbiamo due percorsi:
- uno da $q$ a $r$;
- uno da $r$ a $p$.

#align(center)[
  #lq.diagram(
    width: 12cm,
    height: 8cm,

    xlim: (-1, 12),
    ylim: (-3, 4),

    xaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),
    yaxis: (position: 0, tip: tp.stealth, filter: filter_all, tick-distance: 1),

    lq.line((1, 1), (2, 2)),
    lq.line((2, 2), (3, 3)),
    lq.line((3, 3), (4, 2)),
    lq.line((4, 2), (5, 1)),
    lq.line((5, 1), (6, 2)),
    lq.line((6, 2), (7, 3)),
    lq.line((7, 3), (8, 2)),
    lq.line((8, 2), (9, 3)),
    lq.line((9, 3), (10, 2)),
    lq.line((10, 2), (11, 1)),

    lq.plot((1, 5, 11), (1, 1, 1), stroke: none, mark: "o"),

    lq.line((1, -1.5), (5, -1.5), tip: tp.straight, toe: tp.straight),
    lq.line((5, -1.5), (11, -1.5), tip: tp.straight, toe: tp.straight),
    lq.line((1, -2.5), (11, -2.5), tip: tp.straight, toe: tp.straight),

    lq.place(3, -1)[$w'$],
    lq.place(8, -1)[$w''$],
    lq.place(6, -2)[$w$],

    lq.place(1, -0.3)[$q$],
    lq.place(11, -0.3)[$p$],
    lq.place(5, -0.3)[$r$],
  )
]

Come regole aggiungiamo $ forall r in Q quad [q A p] arrow.long [q A r][r A p] . $ In poche parole, spezziamo la computazione in due parti, entrambe che partono e finiscono in $A$.

Tra tutte le computazioni noi vogliamo quelle *accettanti*, quindi vorremmo arrivare in una configurazione del tipo $ [q_0 Z_0 p] bar.v p in F . $ Per far sì che ciò accada, dobbiamo imporre le regole $ forall p in F quad S arrow.long [q_0 Z_0 p] . $

#lemma()[
  Vale $ forall q,p in Q quad forall w in Sigma^* quad [q A p] arrow.stroked^* w sse (q, w, A) tack.long^* (p, epsilon, A) . $
]

// corollario
#lemma()[
  Vale $ S arrow.stroked^* w sse (q_0, w, Z_0) tack.long^* (p, epsilon, Z_0) bar.v p in F . $
]

Hanno inoltre dimostrato che le triple per le variabili sono necessarie: non possiamo farne a meno.

Con questa *costruzione* abbiamo appena fatto vedere che i PDA sono *equivalenti* alle grammatiche di tipo $2$.
