// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Esercizi

= Esercizi lezioni 19 e 20 [16/05]

== Esercizio 01

#exercise()[
  Non ho voglia di farlo, troppo lungo anche da scrivere.
]

#request()[

]

#solution()[

]

== Esercizio 02

#exercise()[
  Serve l'esercizio $1$, che peccato.
]

#request()[

]

#solution()[

]

== Esercizio 03

#exercise()[
  Tremendamente difficile anche questo.
]

#request()[

]

#solution()[

]

== Esercizio 04

#exercise()[
  Abbiamo visto che le classi dei linguaggi context-free e dei linguaggi context-free deterministici non sono chiuse rispetto all'intersezione.
]

#request()[
  Dimostrate che la classe dei linguaggi context-free è invece chiusa rispetto all'intersezione con linguaggi regolari, risolvendo questo esercizio.

  Sia $M$ un automa a pila che riconosce un linguaggio context-free $L$ e $A$ un automa a stati finiti che riconosce un linguaggio regolare $R$. Fornite la costruzione di un automa a pila $M'$ che riconosca $L inter R$.

  _Suggerimento_: $M'$ può simulare in parallelo $M$ e $A$ incorporando nel proprio controllo finito quelli di $M$ e di $A$. Prestate attenzione al fatto che $M$ potrebbe utilizzare $epsilon$-mosse.
]

#solution()[
  Automa prodotto, che non ho voglia di formalizzare.
]

#request()[
  Se $M$ è deterministico, come si può ottenere $M'$ deterministico?
]

#solution()[
  Ancora automa prodotto, ma si obbliga $A$ ad essere deterministico.
]

== Esercizio 05

#exercise()[]

#request()[
  Dato un linguaggio context-free $L$ e un intero $k$ dimostrate che l'insieme formato da tutte le stringhe di $L$ di lunghezza maggiore di $k$ è context-free.

  _Suggerimento_: potete servirvi della proprietà di chiusura presentata nell'esercizio $4$.
]

#solution()[
  Prendiamo il linguaggio regolare $ R = {w in Sigma^* bar.v abs(w) > k} $ che possiamo riconoscere con un automa a stati finiti che legge $k$ simboli con $k + 1$ stati, legge il $(k+1)$-esimo stato e finisce in uno stato che accetta tutto quello che legge da quel momento in poi.

  Le stringhe in $R$ sono tutte le possibili combinazioni di caratteri $w$ di lunghezza superiore a $k$, quindi calcolando l'intersezione con $L$ filtriamo da $L$ tutti quelli che hanno almeno quella lunghezza. Abbiamo visto che l'intersezione tra un CFL e un regolare è ancora CFL, quindi $ L inter R in CFL . $
]

#request()[
  Di che tipo è il linguaggio formato da tutte le stringhe di $L$ di lunghezza al più $k$?
]

#solution()[
  Ancora CFL, possiamo usare lo stesso automa di prima, solo che usa $k +2$ stati, divisi in $k+1$ per leggere $k$ caratteri e $1$ trappola nel quale finiamo se leggiamo almeno $k+1$ caratteri.

  Come prima, $ L inter R in CFL . $
]

== Esercizio 06

#exercise()[
  Non lo so.
]

#request()[

]

#solution()[

]

== Esercizio 07

#exercise()[
  Non lo so.
]

#request()[

]

#solution()[

]

== Esercizio 08

#exercise()[
  Fatto a lezione, non l'automa.
]

#request()[

]

#solution()[

]

== Esercizio 09

#exercise()[
  Non ho voglia.
]

#request()[

]

#solution()[

]

== Esercizio 10

#exercise()[
  Non lo so fare.
]

#request()[

]

#solution()[

]

== Esercizio 11

#exercise()[
  Serve l'esercizio $10$.
]

#request()[

]

#solution()[

]

== Esercizio 12

#exercise()[
  Fatto a lezione.
]

#request()[

]

#solution()[

]

== Esercizio 13

#exercise()[
  Non userò quel teorema, mi dispiace.
]

#request()[

]

#solution()[

]

== Esercizio 14

#exercise()[
  Mmmmmh.
]

#request()[

]

#solution()[

]

== Esercizio 15

#exercise()[
  Fatto a lezione.
]

#request()[

]

#solution()[

]

== Esercizio 16

#exercise()[
  L'ha fatto a lezione ma estremamente di fretta.
]

#request()[

]

#solution()[

]

== Esercizio 17

#exercise()[
  Troppi calcoli, non ho voglia.
]

#request()[

]

#solution()[

]
