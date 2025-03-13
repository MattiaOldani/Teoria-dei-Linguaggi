// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Esercizi lezioni 03, 04 e 05 [12/03]

== Esercizio 01

#exercise()[]

#request()[
  Costruite un automa a stati finiti che riconosca il linguaggio formato da tutte le stringhe sull'alfabeto ${a,b}$ nelle quali ogni $a$ è seguita immediatamente da una $b$.
]

#solution()[
  #figure(image("assets/030405_esercizio_01_01.svg"))
]

== Esercizio 02

#exercise()[]

#request()[
  Costruite un automa a stati finiti che riconosca il linguaggio formato da tutte le stringhe sull'alfabeto ${4,5}$ che, interpretate come numeri in base $10$, rappresentano interi che _non sono_ divisibili per $3$.

  _Suggerimento_. Un numero intero è divisibile per $3$ se e solo se la somma delle sue cifre in base $10$ è divisibile per $3$.
]

#solution()[
  Prima versione

  #figure(image("assets/030405_esercizio_02_01.svg"))
]

#solution()[
  Seconda versione

  #figure(image("assets/030405_esercizio_02_02.svg"))
]

== Esercizio 03

#exercise()[]

#request()[
  Costruite un automa a stati finiti deterministico che riconosca il linguaggio formato da tutte le stringhe sull'alfabeto ${0,1}$ che, interpretate come numeri in notazione binaria, denotano multipli di $4$.
]

#solution()[
  #figure(image("assets/030405_esercizio_03_01.svg"))
]

#request()[
  Utilizzando il non determinismo si riesce a costruire un automa con meno stati?
]

#solution()[
  Utilizzando il non determinismo riusciamo ad utilizzare $1$ stato in meno, se non inseriamo uno stato trappola per le transizioni dagli stati $q_1$ e $q_2$.

  #figure(image("assets/030405_esercizio_03_02.svg"))
]

#request()[
  Generalizzate l'esercizio a multipli di $2^k$, dove $k > 0$ è un intero fissato.
]

#solution()[
  Per i DFA che riconoscono i multipli di $2^k$ dobbiamo ricordarci una finestra di $k$ caratteri. Tutte le possibili combinazioni di queste finestre sono $2^k$, quindi anche il DFA che riconosce quel linguaggio ha $2^k$ stati.

  Per gli NFA che riconoscono i multipli di $2^k$ dobbiamo utilizzare $k+1$ stati, di cui $k$ leggono gli ultimi $k$ zeri e uno che fa da _"stato scommettitore"_.
]

== Esercizio 04

#exercise()[]

#request()[
  Costruite un automa a stati finiti che riconosca il linguaggio formato da tutte le stringhe sull'alfabeto ${0,1}$ che, interpretate come numeri in notazione binaria, rappresentano multipli di $5$.
]

#solution()[
  #figure(image("assets/030405_esercizio_04_01.svg"))
]

== Esercizio 05

#exercise()[
  Considerate il seguente linguaggio: $ L = {w in {a,b}^* bar.v "il penultimo e il terzultimo simbolo di" w "sono uguali"} . $
]

#request()[
  Costruite un automa a stati finiti deterministico che accetta $L$.
]

#solution()[
  Secondo me andrebbero usati più stati per le stringhe di $1$ e $2$ caratteri, oppure si dovrebbe imporre il riconoscimento di stringhe lunghe almeno $3$ caratteri.

  #figure(image("assets/030405_esercizio_05_01.svg"))
]

#request()[
  Costruite un automa a stati finiti non deterministico che accetta $L$.
]

#solution()[
  #figure(image("assets/030405_esercizio_05_02.svg"))
]

#request()[
  Dimostrare che per il linguaggio $L$:
  - tutte le stringhe di lunghezza $3$ sono distinguibili tra loro;
  - la parola vuota è distinguibile da tutte le stringhe di lunghezza $3$.
]

#solution()[
  Sia $X = {a,b}^3$. Date due stringhe $sigma,gamma in X$ esse possono avere un carattere diverso in $3$ posizioni:
  - se $sigma_1 eq.not gamma_1$:
    - se $sigma_2 = gamma_2$ usiamo $z = epsilon$;
    - se $sigma_2 eq.not gamma_2$ usiamo $z = a^2$ oppure $z = b^2$;
  - se $sigma_2 eq.not gamma_2$:
    - se $sigma_3 = gamma_3$ usiamo $z in {a,b}$;
    - se $sigma_3 eq.not gamma_3$ usiamo $z = a^2$ oppure $z = b^2$;
  - se $sigma_3 eq.not gamma_3$ usiamo $z = a^2$ oppure $z = b^2$.

  Non voglio dimostrare perché funziona, ma funziona, fidatevi di me.

  Inoltre, la stringa vuota è distinguibile da ogni stringa di lunghezza $3$ perché basta aggiungere una stringa $z$ formata dall'ultimo carattere della stringa $sigma$ che stiamo considerando ripetuto due volte.
]

#request()[
  Utilizzando i risultati precedenti, ricavate un limite inferiore per il numero di stati di ogni automa deterministico che accetta $L$.
]

#solution()[
  Grazie al teorema sulla distinguibilità, ogni DFA per il linguaggio $L$ deve usare almeno $8$ stati.
]

== Esercizio 06

#exercise()[
  Costruite un insieme di stringhe distinguibili tra loro per ognuno dei seguenti linguaggi.
]

#request()[
  ${w in {a,b}^* bar.v hash_a (w) = hash_b (w)}$.
]

#solution()[
  $X = {a^n bar.v n gt.eq 0}$.
]

#request()[
  ${a^n b^n bar.v n gt.eq 0}$.
]

#solution()[
  $X = {a^n bar.v n gt.eq 0}$.
]

#request()[
  ${w w^R bar.v w in {a,b}^*}$ dove, per ogni stringa $w$, $w^R$ indica la stringa $w$ scritta al contrario.
]

#solution()[
  $X = {(a b)^n bar.v n gt.eq 0}$.
]

#request()[
  Per alcuni di questi linguaggi riuscite ad ottenere insiemi di stringhe distinguibili di cardinalità infinita? Cosa significa ciò?
]

#solution()[
  Significa che non sono dei linguaggi di tipo $3$.
]

== Esercizio 07

#exercise()[
  Considerate l'automa di Meyer e Fischer $M_n$ presentato nella Lezione 5 (caso peggiore della costruzione per sottoinsiemi) e mostrato nella seguente figura: #figure(image("assets/05_meyer_fischer.svg"))
]

#request()[
  Descrivete a parole la proprietà che deve soddisfare una stringa per essere accettata da $M_n$. Riuscite a costruire un automa non deterministico, diverso da $M_n$, per lo stesso linguaggio, basandovi su tale proprietà? (Potete usare un numero di stati diverso da $n$, ma non esponenziale, e stati iniziali
  multipli.)
]

#solution()[
  No non ci riesco.
]
