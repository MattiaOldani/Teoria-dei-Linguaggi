// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Lezione

= Lezione 15 [23/04]

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
