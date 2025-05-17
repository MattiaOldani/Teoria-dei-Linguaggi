// Setup

#import "alias.typ": *

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

#import "@preview/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp


// Lezione

= Lezione 16 [30/04]

== Fine dimostrazione

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

== Forma normale di Chomsky

L'altra volta abbiamo visto la FN di Greibach, oggi vediamo la *FN di Chomsky*, forma utile e maneggevole per alcune dimostrazioni che faremo.

=== Definizione

Le produzioni che abbiamo nella FN di Chomsky sono di due tipi: $ A arrow.long a bar.v B C quad "tale che" quad A,B,C in V and a in Sigma . $

Questa rappresentazione è molto comoda perché riesce a generare degli alberi di derivazione che sono *binari*, quindi abbiamo molte indicazioni su numero di foglie, altezza, e altro.

Come nella FN di Greibach, anche qui non possiamo generare la parola vuota.

Infatti, se $G$ è una grammatica di tipo $2$, allora $exists G'$ in FN di Chomsky quasi equivalente, ovvero $ L(G') = L(G) slash {epsilon} $ ma solo se prima ce l'avevamo, sennò sono *totalmente equivalenti*.

=== Costruzione

Vediamo una *costruzione* per costruire effettivamente una grammatica in FN di Chomsky. Prima abbiamo detto che esiste, qua stiamo facendo vedere che esiste veramente.

Vogliamo costruire la grammatica $G' = (V, Sigma, P', S)$ in FN di Chomsky a partire dalla grammatica $G$ di tipo $2$. Lo possiamo fare seguendo i seguenti i passi:

#align(center)[
  #pseudocode-list(title: [FN di Chomsky])[
    + Eliminazione delle $epsilon$-produzioni
    + Eliminazione delle produzioni unitarie
    + Eliminazione dei simboli inutili
    + Eliminazione dei terminali
    + Smontaggio delle produzioni
  ]
]

I passi che abbiamo indicato devono essere eseguiti *in ordine*. Partiamo.

==== Eliminazione delle $epsilon$-produzioni

L'*eliminazione delle* $epsilon$*-produzioni* richiede la ricerca delle *variabili cancellabili*.

#definition([Variabile cancellabile])[
  Una variabile $A$ è *cancellabile* se $ A arrow.stroked^* epsilon . $
]

L'albero di computazione di una variabile cancellabile $A$ lo possiamo vedere come:

#align(center)[
  #syntree(
    child-spacing: 2em,
    layer-spacing: 2em,
    "[^A $$ $$ $$ $epsilon$ $$ $$ $$]",
  )
]

Banalmente, una variabile è cancellabile se nella grammatica ho una regola nella forma $ A arrow.long epsilon . $

Se però non abbiamo questa produzione, ma abbiamo delle regole $ A arrow.long X_1 dots X_k quad "tale che" quad X_1, dots, X_k in V $ quello che possiamo fare è controllare queste variabili. Se sono tutte cancellabili, allora anche $A$ sarà sicuramente cancellabile. Se vogliamo vedere l'albero di computazione, è nella forma:

#align(center)[
  #syntree(
    child-spacing: 2em,
    layer-spacing: 2em,
    "[A [^$X_1$ $$ $$ $$ $epsilon$ $$ $$ $$] [^$dots$ $$ $$ $$ $epsilon$ $$ $$ $$] [^$X_k$ $$ $$ $$ $epsilon$ $$ $$ $$]]",
  )
]

Se invece non tutte sono cancellabili dobbiamo cercarle con un algoritmo simile a quello che abbiamo usato per dimostrare la decidibilità dei linguaggi di tipo $1$. Definiamo l'insieme $ cal(C)_0 = {A in V bar.v A arrow.long epsilon} $ insieme di tutte le variabili banalmente cancellabili. Definiamo per induzione l'insieme $ cal(C)_i = {A in V bar.v exists (A arrow.long X_1 dots X_k) in P bar.v X_1, dots, X_k in cal(C)_(i-1)} union cal(C)_(i-1) $ formato da tutte le variabili che potremmo cancellare usando variabili già cancellabili.

Vale ovviamente la catena $ C_0 subset.eq C_1 subset.eq dots subset.eq V $ che è bloccata da un insieme finito, quindi prima o poi non posso più aggiungere degli elementi all'insieme e mi devo fermare, ovvero $ exists i bar.v C_(i-1) = C_i . $

Una volta che ho tutte le variabili cancellabili creiamo delle *scorciatoie*: cancelliamo prima di tutto tutte le $epsilon$-produzioni, e poi $ forall (A arrow.long Y_1 dots Y_k) in P bar.v k > 0 and Y_i in V union Sigma quad (A arrow.long Y_(j_1) dots Y_(j_s)) in P' . $

In poche parole, aggiungiamo delle regole a $P'$ che otteniamo eliminando alcune variabili cancellabili da una regola di produzione. L'eliminazione non deve toglierle per forza tutte: possiamo toglierne zero come toglierle tutte, ma dobbiamo ricordarci di non creare $epsilon$-produzioni e che vanno provate tutte le combinazioni possibili.

#example()[
  Data la regola di produzione $ A arrow.long B C a D $ con $C,D$ variabili cancellabili, vogliamo costruire le nuove regola di una grammatica in FN di Chomsky eliminando le $epsilon$ produzioni.

  In questo caso possiamo:
  - far sparire la $C$;
  - far sparire la $D$;
  - far sparire la $C$ e la $D$;
  - lasciare tutto.

  Le produzioni che otteniamo sono $ A arrow.long B C a D bar.v B a D bar.v B C a bar.v B a . $
]

Vediamo un esempio un po' tedioso.

#example()[
  Data la regola di produzione $ A arrow.long C D E $ con $C,D,E$ variabili cancellabili (quindi anche $A$), come ci comportiamo?

  In questo caso dobbiamo cancellare tutti i possibili sottoinsiemi di variabili cancellabili, escluso l'insieme completo, quindi otteniamo le produzioni $ A arrow.long C D E bar.v D E bar.v C E bar.v C D bar.v E bar.v D bar.v C . $
]

==== Eliminazione delle produzioni unitarie

L'*eliminazione delle produzioni unitarie* va a rimuovere le produzioni che ha destra hanno solo una variabile, ovvero sono nella forma $ A arrow.long B quad "tale che" quad A,B in V . $

Cerchiamo di cancellare le *sequenze di produzioni unitarie*: se consideriamo solo produzioni unitarie abbiamo una sequenza del tipo $ A arrow.stroked B arrow.stroked C arrow.stroked dots $ che si può fermare quando deriviamo un terminale oppure una stringa con più di $2$ stringhe. In poche parole abbiamo una sequenza $ A arrow.stroked dots arrow.stroked B arrow.stroked alpha bar.v alpha in Sigma or abs(alpha) > 1 . $

Quando trovo queste sequenze posso fare ancora una scorciatoia: al posto di fare tutta la sequenza di unitarie, che possiamo vedere solo come cambi di variabili, facciamo direttamente il salto da $A$ ad $alpha$, ovvero $ forall (A,B) bar.v A arrow.stroked^+ B quad forall (B arrow.long alpha) bar.v alpha in Sigma or abs(alpha) > 1 quad (A arrow.long alpha) in P' . $

==== Eliminazione dei simboli inutili

L'*eliminazione dei simboli inutili* rimuove tutti i simbolo che non ci servono a niente, che non sono utili a generare delle stringhe del linguaggio.

#definition([Simbolo utile])[
  Un simbolo $X in V union Sigma$ è *utile* se:
  - il simbolo è raggiungibile, quindi esiste una computazione che genera una forma sentenziale che contiene quel simbolo, ovvero $ exists S arrow.stroked^* alpha X beta ; $
  - dalla forma sentenziale centrale si riesce a generare una stringa del linguaggio, ovvero $ alpha X beta arrow.stroked^* w in Sigma^* . $

  Riassunto in una sola sentenza, possiamo dire che $ exists S arrow.stroked^* alpha X beta arrow.stroked^* w in Sigma . $
]

Con questi tre passi abbiamo rimosso tutte le $epsilon$-produzioni, tutti i cammini unitari e tutti i simboli inutili. Le produzioni che abbiamo ora sono nella forma $ A arrow.long alpha $ con $alpha$ terminale oppure $abs(alpha) > 1$.

==== Eliminazione dei terminali

L'*eliminazione dei terminali* si applica alle produzioni che derivano una forma sentenziale $alpha$ con $abs(alpha) > 1$. Per fare ciò dobbiamo usare delle *variabili ausiliarie* per rimuovere i simboli terminali nelle produzioni.

Come convenzione possiamo dire che i terminali $sigma in Sigma$ vengono sostituiti dalle variabili $X_sigma$.

#example()[
  Date le regole di produzione $ A arrow.long A a a b C bar.v b C bar.v b b $ cerchiamo di applicare l'eliminazione dei terminali.

  Usiamo due variabili ausiliarie $X_a$ e $X_b$, una per ogni terminale, ottenendo $ A arrow.long A X_a X_a X_b C bar.v X_b C bar.v X_b X_b \ X_a arrow.long a \ X_b arrow.long b . $

  Se avessi avuto anche la regola $ C arrow.long b $ non avrei applicato il cambio in $X_b$ perché avremmo ottenuto un cammino unitario, che però non possiamo avere in questo momento.
]

In questo penultimo passo ora abbiamo solo produzioni che derivano terminali oppure delle liste di variabili. L'ultimo passo sarà manipolare queste per raggiungere, finalmente, la FN di Chomsky.

==== Smontaggio delle produzioni

L'ultimo passo è lo *smontaggio delle produzioni* nella forma $ A arrow.long B_1 dots B_k quad "con" quad k > 2 . $

Infatti, le produzioni:
- con una sola variabile non ci sono;
- con due variabili vanno bene in questa FN;
- con tre o più variabili vanno ridotte.

Per fare ciò, usiamo ancora delle *variabili ausiliarie* per aggiungere delle regole formate da una variabile della produzione e da una variabile ausiliaria. Fa eccezione l'ultima regola, che sostituisce direttamente gli ultimi due caratteri della produzione da cambiare.

#example()[
  Data la produzione $ A arrow.long B_1 B_2 B_3 B_4 B_5 $ la andiamo a smontare creando le produzioni $ A arrow.long B_1 Z_1 \ Z_1 arrow.long B_2 Z_2 \ Z_2 arrow.long B_3 Z_3 \ Z_3 arrow.long B_4 B_5 . $
]

=== Esempio

Applichiamo questa costruzione ad un esempio.

#example()[
  Costruire la FN di Chomsky a partire da queste produzioni: $ S arrow.long a B bar.v b A \ A arrow.long a bar.v a S bar.v b A A \ B arrow.long b bar.v b S bar.v a B B . $

  Non abbiamo $epsilon$-produzioni e variabili cancellabili, come non abbiamo cammini unitari, come non abbiamo simboli inutili, quindi i primi tre passi non vengono eseguiti.

  Partiamo quindi con il cancellare tutti i terminali: $ S arrow.long X_a B bar.v X_b A \ A arrow.long a bar.v X_a S bar.v X_b A A \ B arrow.long b bar.v X_b S bar.v X_a B B \ X_a arrow.long a \ X_b arrow.long b . $

  Infine, smontiamo le catene di variabili che abbiamo ottenuto: $ S arrow.long X_a B bar.v X_b A \ A arrow.long a bar.v X_a S bar.v X_b Y_1 \ Y_1 arrow.long A A \ B arrow.long b bar.v X_b S bar.v X_a Y_2 \ Y_2 arrow.long B B \ X_a arrow.long a \ X_b arrow.long b . $
]
