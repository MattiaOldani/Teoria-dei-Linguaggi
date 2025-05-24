// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Lezione

= Lezione 15 [23/04]

== Equivalenza tra grammatiche di tipo 2 e automi a pila

Facciamo un breve ripasso sulle grammatiche di tipo $2$ e poi andiamo a vedere l'equivalenza tra le grammatiche di tipo $2$ e gli automi a pila.

=== Ripasso e introduzione

Una grammatica $G$ di tipo $2$ ha le *regole di produzione* nella forma $ X arrow.long X_1 dots X_k quad bar.v quad X in V and X_1, dots, X_k in (V union Sigma) and k gt.eq 0 . $

Abbiamo modificato leggermente la forma ma il succo è quello: ad ogni variabile associamo una sequenza (anche vuota) di terminali e non terminali.

Il processo di derivazione nelle grammatiche di tipo $2$ può essere espresso mediante *alberi di derivazione*: essi sono alberi che visualizzano l'applicazione delle regole di produzione.

In un albero generico, la *radice* e i *nodi interni* sono *variabili*, mentre le foglie sono combinazioni di *variabili e terminali*. In un albero che rappresenta una stringa del linguaggio nella radice ho l'*assioma* $S$ e nelle foglie ho *solo terminali*.

Un nodo, con i suoi figli diretti, va a rappresentare l'*applicazione* di una regola di produzione. Ad esempio, prendendo la regola di produzione generica di una grammatica di tipo $2$, abbiamo il seguente *albero di derivazione*:

// SISTEMA
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

=== Da grammatica di tipo 2 ad automa a pila

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

=== Automa a pila a grammatica di tipo 2

Questo la prossima volta, sium.

== Forme normali per le grammatiche context-free

Abbiamo detto che le produzioni sono nella forma $ A arrow.long alpha quad bar.v quad A in V and alpha in (V union Sigma)^* $

Possiamo dare diverse forme alle regole di produzione che abbiamo nelle grammatiche di tipo $2$, ognuna delle quali ha alcuni punti di forza che possono essere comodi in altri contesti.

Queste forme sono dette *forme normali* e le più conosciute sono la *forma normale di Greibach* e la *forma normale di Chomsky*.

=== FN di Greibach

Nella *forma normale di Greibach*, spesso abbreviata con *FNG*, le produzioni sono nella forma $ A arrow.long sigma A_1 A_2 dots A_k quad bar.v quad sigma in Sigma and A_1, A_2, dots, A_k in V and k gt.eq 0 . $

Data una grammatica $G$ qualunque, si può sempre scrivere una grammatica in FN di Greibach per lo stesso linguaggio a meno della parola vuota: infatti, se in $G$ abbiamo la parola vuota, nella sua trasformata non ce l'abbiamo e la dobbiamo aggiungere a mano. In poche parole vale $ L(FNG) = L(G) slash {epsilon} . $

La trasformazione da Greibach ad automa a pila in alcuni casi *elimina il non determinismo*, però da fare è abbastanza pesante e non vedremo come fare.

Con la FN di Greibach possiamo costruire un PDA leggermente più semplice di prima.

Data la grammatica $G$ in FN di Greibach, vogliamo costruire un PDA $ M = (Q, Sigma, Gamma, delta, q_0, Z_0, emptyset.rev) $ che *accetta per pila vuota* definito da:
- *insieme degli stati* $Q$ formato da un solo stato, ovvero $ Q = {q} ; $
- lo *stato iniziale*, vista la presenza di un solo stato, è $ q_0 = q ; $
- l'*alfabeto di lavoro della pila* $Gamma$ contiene tutto solo le variabili della grammatica, questo perché faremo un accorgimento per cancellare i terminali senza metterli sulla pila, quindi $ Gamma = V ; $
- il *simbolo iniziale della pila* $Z_0$ è l'assioma della grammatica, ovvero $ Z_0 = S ; $ useremo la pila per metterci sopra quello che vogliamo espandere mano a mano;
- la *funzione di transizione* non usa più $epsilon$-mosse e, soprattutto, non mette più nella pila i simboli terminali, ovvero $ delta(q, sigma, A) = {(q, A_1 dots.c A_k) bar.v (A arrow.long sigma A_1 dots A_k) in P} , $ ovvero guardo tutte le regole che iniziano in $A$ e hanno $sigma$ come primo carattere e tutto il resto della sostituzione lo andiamo a mettere nella pila. In questo modo, stiamo già consumando $sigma$ senza metterlo direttamente sulla pila e lo stiamo già controllando quindi. Ci avanzeranno poi tutte le variabili che sono rimaste sulla pila.

Il simbolo in input mi *aiuta* nella scelta della produzione, e questo può *ridurre il non determinismo*, ma dipende strettamente dalla grammatica che si ha davanti.

#example()[
  Modifichiamo leggermente la grammatica dell'ultimo esempio usando le seguenti regole di produzione:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long T U$], [$T arrow.long a T b bar.v a b$], [$U arrow.long b U a bar.v b a$],
  )

  In questo caso non abbiamo più $epsilon$ quindi il linguaggio diventa $ L = {a^n b^(n + m) a^m bar.v n,m gt.eq 1} . $

  Rendiamola in forma normale di Greibach (grazie Pighizzini, io non sono capace). Per fare ciò le produzioni diventano nella forma:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long a T B U bar.v a B U$], [$T arrow.long a B bar.v a T B$], [$U arrow.long b A bar.v b U A$],
  )

  #v(-10pt)

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$A arrow.long a$], [$B arrow.long b$],
  )

  Come prima, vediamo l'evoluzione della stringa $ w = a b b b a a . $

  #table(
    columns: (10%, 15%, 20%, 55%),
    align: center + horizon,
    inset: 10pt,
    [*Pila*], [*Testina*], [*Derivazione*], [*Spiegazione della mossa*],
    [$S$], [$#text(fill: blue)[$a$] b b b a a$], [$S$], [Configurazione iniziale],
    [$B \ U$],
    [$a #text(fill: blue)[$b$] b b a a$],
    [$#text(fill: blue)[$a$] B U$],
    [Avendo a disposizione il non determinismo, sono fortunato e scelgo la derivazione corretta, aiutandomi anche con il carattere che c'era sulla testina],

    [$U$], [$a b #text(fill: blue)[$b$] b a a$], [$#text(fill: blue)[$a b$] U$], [Come prima],
    [$U \ A$], [$a b b #text(fill: blue)[$b$] a a$], [$#text(fill: blue)[$a b b$] U A$], [Come prima],
    [$A \ A$], [$a b b b #text(fill: blue)[$a$] a$], [$#text(fill: blue)[$a b b b$] A A$], [Come prima],
    [$A$], [$a b b b a #text(fill: blue)[$a$]$], [$#text(fill: blue)[$a b b b a$] A$], [Come prima],
    [$epsilon$], [$a b b b a a #text(fill: blue)[$epsilon$]$], [#text(fill: blue)[$a b b b a a$]], [Come prima],
  )

  Ho ancora del non determinismo, ma è molto *ridotto*. In alcuni casi riusciamo addirittura a *toglierlo completamente*, ma dipende molto dalla grammatica.

]

Abbiamo quindi trovato un PDA che accetta per pila vuota, utilizza un solo stato e non utilizza le $epsilon$-mosse. Tutto bello, ma rimane comunque non deterministico.

Questa FN di Greibach nella pratica è *poco usata*: fare il passaggio non è banale e questo potrebbe stravolgere la grammatica iniziale rendendola illeggibile.
