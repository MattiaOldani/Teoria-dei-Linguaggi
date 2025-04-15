// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Esercizi

= Esercizi lezione 13 [09/04]

== Esercizio 01

#exercise()[
  Fissato un intero $n > 0$, sia $K_n$ il linguaggio sull’alfabeto ${a,b}$ denotato dall’espressione $(a+b)^* a (a+b)^(n-1) a (a+b)^*$.
]

#request()[
  A lezione abbiamo discusso come riconoscere il linguaggio $K_n$ con un automa deterministico two-way con $O(n)$ stati. Scrivete formalmente la funzione di transizione di tale automa (rispetto al parametro $n$).
]

#solution()[
  Usiamo lo stato $r$ per ricercare le $a$: $ delta(r, a) = (q_0, +1) \ delta(r, b) = (r, +1) . $

  Con lo stato $r$ andiamo avanti a fare la ricerca delle $a$, mentre da $q_0$ devo leggere $n-1$ caratteri: $ delta(q_i, a slash b) = (q_(i+1), +1) quad forall i in {0, dots, n-2} . $

  Nello stato $q_(n-1)$ vediamo se abbiamo una $a$: $ delta(q_(n-1), a) = (q_f, +1) . $

  In caso contrario, torniamo indietro di $n-1$ caratteri e ripartiamo con la ricerca delle $a$ a partire dallo stato $r$. Se $n = 2$ torniamo direttamente nello stato $r$ andando indietro di $1$, invece negli altri casi facciamo $ delta(q_(n-1), b) = (p_1, -1) \ delta(p_i, a slash b) = (p_(i + 1), -1) quad forall i in {1, dots, n-3} \ delta(p_(n-2), a slash b) = (r, -1) . $

  Dallo stato $q_f$ vado avanti a leggere fino a quando non sforo l'end marker destro.

  Infine, vanno aggiunti un po' di regole per vedere se, mentre andiamo avanti di $n$ caratteri, andiamo a sforare l'end marker: in questo caso andiamo in uno stato trappola e ciao a tutti.
]

#request()[
  Abbiamo inoltre accennato a come riconoscere $K_n$ con un automa _sweeping_ con $O(n^2)$ stati, cioè un automa two-way che può cambiare la direzione della testina di input solo sugli end-marker. (Nell’$i$-esima "passata" del nastro di input, l’automa ispeziona i simboli nelle posizioni $k$ tali che $k mod n = i$.) Scrivete la funzione di transizione di tale automa nel caso $n = 3$ e generalizzatela poi a ogni $n$ fissato.
]

#solution()[
  Non mi viene in mente ora.
]

== Esercizio 02

#exercise()[]

#request()[
  Modificate l'automa sweeping per $K_n$ ottenuto nell'esercizio $1$ in modo da ridurre il numero degli stati a $O(n)$.

  _Suggerimento_. In ciascuna passata si utilizza un contatore modulo $n$ per individuare i simboli da ispezionare. Il contatore può essere inizializzato in funzione del valore finale del contatore nella passata precedente, evitando di contare le passate.
]

#solution()[
  Non mi viene nemmeno questo.
]

== Esercizio 03

#exercise()[]

#request()[
  Svolgete l'esercizio $1$ per il linguaggio formato da tutte le stringhe in cui esistono due simboli a distanza $n$ tra loro che sono uguali.
]

#solution()[
  Vedi esercizio $1$ ma con gli stati di avanzamento doppi, in base alla lettera che viene letta dallo stato $r$.
]

== Esercizio 04

#exercise()[]

#request()[
  Svolgete l'esercizio $1$ per il linguaggio formato da tutte le stringhe in cui tutti i simboli a distanza $n$ tra loro sono uguali.
]

#solution()[
  Non ho voglia di formalizzarlo, quindi lo farò scritto:
  + partiamo da uno stato $r_0$, andiamo avanti di $n$ posti e vediamo se abbiamo lo stesso carattere;
  + in caso negativo andiamo in loop in qualche stato trappola;
  + in caso positivo torniamo indietro di $n-1$ caratteri e ripetiamo dal punto iniziale;
  + dopo aver fatto $n$ iterazioni andiamo a sforare l'end marker destro.
]

== Esercizio 05

#exercise()[]

#request()[
  Rivedete la simulazione di automi two-way deterministici mediante automi one-way deterministici presentata a lezione e studiate come possa essere modificata nel caso l'automa di partenza sia two-way non deterministico.
]

#solution()[
  Ho un dubbio amletico, fino a quando non lo risolvo non posso fare questo esercizio matto.
]

== Esercizio 06

#exercise()[
  Supponete di disporre di un automa one-way deterministico $A$ che riconosca un linguaggio $L$. Fornite, partendo da $A$, la costruzione di automa two-way deterministico per i seguenti linguaggi (cercate di ottenere automi con un numero di stati lineare o polinomiale rispetto a quelli dell'automa $A$).
]

#request()[
  $beta(L) = {x bar.v x x^R in L}$.
]

#solution()[
  Dobbiamo costruire $A'$ un $2$DFA per $beta(L)$.

  Questo automa ha in input $x$, che legge per intero e simula l'esecuzione di $A$. Quando raggiunge l'end marker destro allora si rimette sull'ultimo carattere e continua la lettura dallo stesso stato nel quale eravamo alla fine di $x$.

  Ora leggiamo la $x$ al contrario fino all'end marker sinistro, dove controlliamo lo stato nel quale siamo: se esso è finale allora sfondiamo l'end marker destro.

  Come numero di stati abbiamo:
  - lo stesso numero di stati di $A$ per simularlo;
  - lo stesso numero di stati di $A$ per simularlo, ma al contrario, quindi servono regole che vanno indietro e non avanti;
  - uno stato finale e uno stato trappola.

  Quindi abbiamo lo stesso ordine di grandezza degli stati di $A$.
]

#request()[
  $alpha(L) = {x bar.v x x in L}$.
]

#solution()[
  Dobbiamo costruire $A'$ un $2$DFA per $alpha(L)$.

  Questo automa ha in input $x$, che legge per intero e simula l'esecuzione di $A$. Quando raggiunge l'end marker destro allora fa uno sweeping e si rimette sul primo carattere di $x$ e continua la lettura dallo stesso stato nel quale eravamo alla fine di $x$.

  Ora leggiamo la $x$ di nuovo fino all'end marker destro, dove controlliamo lo stato nel quale siamo: se esso è finale allora sfondiamo l'end marker destro.

  Come numero di stati abbiamo:
  - lo stesso numero di stati di $A$ per simularlo;
  - lo stesso numero di stati di $A$ per tornare indietro, perché dobbiamo tenere traccia dello stato nel quale eravamo;
  - lo stesso numero di stati di $A$ per simularlo di nuovo, quindi servono regole che poi si fermano all'end marker;
  - uno stato finale e uno stato trappola.

  Quindi abbiamo lo stesso ordine di grandezza degli stati di $A$.
]

== Esercizio 07

#exercise()[
  Supponete di disporre di un automa one-way deterministico $A$ che riconosca un linguaggio $L$.
]

#request()[
  Fornite, partendo da $A$, la costruzione di un automa two-way non deterministico per il seguente linguaggio: $ 1/2 L = {x in Sigma^* bar.v exists y in Sigma^* bar.v abs(x) = abs(y) and x y in L} . $

  Cercate di ottenere un automa two-way non deterministico con un numero di stati lineare o polinomiale rispetto a quelli dell'automa $A$.
]

#solution()[
  Dobbiamo costruire $A'$ un $2$NFA per $1/2 L$.

  Questo automa ha in input $x$, che legge per intero e simula l'esecuzione di $A$. Quando raggiunge l'end marker destro allora fa uno sweeping e si rimette sul primo carattere di $x$ con lo stesso stato che abbiamo raggiunto a fine $x$.

  Ora leggiamo la $x$ di nuovo fino all'end marker destro, ma *non deterministicamente* generiamo tutti i possibili cammini di lunghezza $abs(x)$. In poche parole, leggiamo i caratteri di $x$ ma solo per sapere quanto è lunga.

  Accettiamo se sull'end marker destro abbiamo almeno uno stato finale.

  Come numero di stati abbiamo:
  - lo stesso numero di stati di $A$ per simularlo;
  - lo stesso numero di stati di $A$ per tornare indietro, perché dobbiamo tenere traccia dello stato nel quale eravamo;
  - non oltre $2^abs(A)$ stati per via della costruzione per sottoinsiemi;
  - uno stato finale e uno stato trappola.
]

#request()[
  Cosa riuscite a dire rispetto al numero di stati di un automa two-way deterministico? (_Anche se non riuscite a calcolare il numero di stati necessario e sufficiente, provate a capire come si potrebbe ottenere facilmente un upper bound sul numero di stati di un automa two-way deterministico. Alla luce di quanto sarà discusso nella lezione $14$, cercate di capire quali implicazioni vi sarebbero se tale numero fosse anche necessario_.)
]

#solution()[
  Ho fatto la lezione $14$ prima di questi esercizi, RIP.
]
