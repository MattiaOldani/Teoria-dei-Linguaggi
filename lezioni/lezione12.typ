// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 12 [04/04]

== Varianti di automi

Per finire questa lezione infinita, vediamo qualche *variante* di automi.

=== Automi pesati

La prima variante che vediamo sono gi *automi pesati*. Essi associano ad ogni transizione un peso. Il *peso di una stringa* viene calcolato come la somma dei pesi delle transizioni che la stringa attraversa per essere accettata. Questo peso poi può essere usato in problemi di ottimizzazione, come trovare il cammino di peso minimo, ma questo ha senso solo su NFA.

=== Automi probabilistici

Un tipo particolare di automi pesati sono gli *automi probabilistici*, che come pesi sulle transizioni hanno la probabilità di effettuare quella transizione. Visto che parliamo di *probabilità*, i pesi sono nel range $[0,1]$ e, dato uno stato, tutte le transizioni uscenti sommano a $1$. In realtà, potremmo sommare a meno di $1$ se nascondiamo lo stato trappola. Con questi automi possiamo chiederci con che probabilità accettiamo una stringa.

Questi automi li possiamo usare come *riconoscitori a soglia*: tutte le parole oltre una certa soglia le accettiamo, altrimenti le rifiutiamo.

Questi automi comunque non sono più potenti dei DFA: si può dimostrare che se la soglia $lambda$ è *isolata*, ovvero nel suo intorno non cade nessuna parola, allora possiamo trasformare questi automi probabilistici in DFA. Se la soglia non è isolata riusciamo a riconoscere una strana classe di linguaggi, che però ora non ci interessa.
