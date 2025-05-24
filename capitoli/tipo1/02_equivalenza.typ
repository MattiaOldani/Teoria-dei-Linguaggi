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

= Equivalenza tra LBA e grammatiche di tipo $1$

Vediamo, come abbiamo visto anche per gli altri due modelli, l'equivalenza tra *LBA* e grammatiche di tipo $1$, ovvero le *grammatiche context-sensitive*.

== Dimostrazione

Prima di tutto, ripassiamo velocemente come sono fatte queste grammatiche.

Una grammatica $G = (V, Sigma, P, S)$ di tipo $1$ ha *produzioni* nella forma $ alpha arrow.long beta quad "tali che" quad abs(alpha) lt.eq abs(beta) . $

In poche parole, le produzioni sono *non decrescenti*, e questo ci aiutava con la decidibilità delle grammatiche di tipo $1$, e quindi anche delle grammatiche di tipo $2$ e di tipo $3$.

#theorem()[
  Le grammatiche di tipo $1$ sono equivalenti agli automi limitati linearmente.
]

#theorem-proof()[
  Vediamo entrambe le trasformazioni.

  [*Grammatica $arrow.long$ LBA*]

  Data una grammatica, costruiamo un LBA che fa il contrario del processo di produzione: se ho in input una stringa $w$ devo costruire un LBA per capire se $S arrow.stroked^* w$.

  Questo lo facciamo imponendo la macchina a scrivere le forme sentenziali sul nastro, ovvero se sul nastro troviamo un certo $beta$ allora lo sostituiamo con un certo $alpha$ e qualche marcatore per fare da tappo. Ovviamente, il processo è non deterministico, e inoltre non ci fa strabordare perché sappiamo che $alpha$ non sorpassa $beta$ come lunghezza.

  [*LBA $arrow.long$ grammatica*]

  Si può costruire una grammatica data la descrizione di un LBA, fidiamoci.
]

== Determinismo e non determinismo

Sappiamo quindi che le due rappresentazioni sono equivalenti, ma non sappiamo la relazione che esiste tra *determinismo* e *non determinismo*.
