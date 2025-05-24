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
