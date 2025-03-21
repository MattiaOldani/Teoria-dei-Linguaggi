// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Esercizi lezione 07 [19/03]

== Esercizio 01

#exercise()[
  Per tutti i linguaggi di questo esercizio l'alfabeto è ${a,b}$.
]

#request()[
  Considerate l'insieme $L$ formato dalle stringhe in cui sia il numero di $a$ che il numero di $b$ sono pari.

  Richieste:
  - Determinate le classi di equivalenza della relazione $R$ di Myhill-Nerode associata a $L$.
  - Costruite l'automa deterministico minimo corrispondente.
  - Determinate un insieme $X$ di cardinalità massima che contenga stringhe tutte distinguibili tra loro.
  - La relazione cambia nel caso si chieda che le stringhe del linguaggio abbiano un numero di $a$ pari, un numero di $b$ pari ed entrambi siano positivi? E l'automa?
]

#solution()[
  Le classi di equivalenza di $R$ sono $4$:
  - $[p p]_R$ per $a$ e $b$ pari;
  - $[d d]_R$ per $a$ e $b$ dispari;
  - $[p d]_R$ per $a$ pari e $b$ dispari;
  - $[d p]_R$ per $a$ dispari e $b$ pari.

  L'automa minimo per $L$ è il seguente.

  #figure(image("assets/07_esercizio_01_01_01.svg"))

  L'insieme $X = {epsilon, a, b, a b}$ è un insieme di stringhe distinguibili, non voglio dimostrarlo.

  Richiedendo $a$ e $b$ pari in numero positivo la relazione sale a $9$ classi di equivalenza, e quindi anche l'automa passa ad avere $9$ stati.

  #figure(image("assets/07_esercizio_01_01_02.svg"))
]

#request()[
  Considerate ora il linguaggio $L'$ formato dalle stringhe in cui il numero di $a$ sia pari e il numero di $b$ sia dispari.

  Richieste:
  - Verificate che la relazione $R'$ di Myhill-Nerode associata a $L'$ coincide con la relazione $R$ associata a $L$.
  - Cosa hanno in comune e cosa hanno di diverso i rispettivi automi deterministici minimi.
]

#solution()[
  Le classi di equivalenza di $R'$ sono $4$:
  - $[p p]_R$ per $a$ e $b$ pari;
  - $[d d]_R$ per $a$ e $b$ dispari;
  - $[p d]_R$ per $a$ pari e $b$ dispari;
  - $[d p]_R$ per $a$ dispari e $b$ pari.

  Sono le stesse classi di equivalenza della relazione $R$ della richiesta precedente.

  L'automa minimo per $L'$ è lo stesso identico a quello per $L$ (_la prima versione_) tranne lo stato finale, che nei due automi è differente.

  #figure(image("assets/07_esercizio_01_02_01.svg"))
]

#request()[
  Considerate ora il linguaggio $L''$ formato dalle stringhe in cui il numero di $a$ sia pari e il numero di $b$ sia qualunque.

  Richieste:
  - Verificate che $L''$ è l'unione di alcune classi di equivalenza della relazione $R$ precedente.
  - Costruite un automa che accetti $L''$ i cui stati corrispondano alle classi di $R$.
  - Determinate le classi di equivalenza della relazione $R''$ di Myhill-Nerode associata a $L''$.
  - Costruite l'automa deterministico minimo corrispondente.
  - Che legame c'è tra $R$ e $R''$ e tra i due automi ottenuti?
]

#solution()[
  Possiamo definire $L''$ come l'unione delle classi di equivalenza $[p p]_R$ e $[p d]_R$, che vanno contenere tutte le stringhe che hanno un numero di $a$ pari.

  #figure(image("assets/07_esercizio_01_03_01.svg"))

  Le classi di equivalenza della relazione $R''$ sono $[p]_R''$ e $[d]_R''$, che contengono rispettivamente le stringhe con un numero di $a$ pari e le stringhe con un numero di $a$ dispari.

  #figure(image("assets/07_esercizio_01_03_02.svg"))

  Possiamo dire che $R$ è un raffinamento di $R''$, e quindi che l'automa di $R''$ è più compatto e conciso di quello di $R$, che infatti ha il doppio degli stati.
]

#request()[
  Considerate ora il linguaggio $L'''$ formato dalle stringhe in cui il numero di $a$ e il numero di $b$ siano entrambi pari o entrambi dispari. Rispondete alle domande del punto $c$ precedente, considerando $L'''$ e la rispettiva relazione $R'''$ di Myhill-Nerode al posto di $L''$ e $R''$.
]

#solution()[
  Possiamo definire $L'''$ come l'unione delle classi di equivalenza $[p p]_R$ e $[d d]_R$, che vanno contenere tutte le stringhe che hanno un numero di $a$ e $b$ entrambi pari o entrambi dispari.

  #figure(image("assets/07_esercizio_01_04_01.svg"))

  Le classi di equivalenza della relazione $R'''$ sono $[u]_R''$ e $[d]_R''$, che contengono rispettivamente le stringhe con un numero di $a$ e $b$ entrambi pari o entrambi dispari e le stringhe con un numero di $a$ dispari/pari e di $b$ pari/dispari.

  #figure(image("assets/07_esercizio_01_04_02.svg"))

  Possiamo dire che $R$ è un raffinamento di $R'''$, e quindi che l'automa di $R'''$ è più compatto e conciso di quello di $R$, che infatti ha il doppio degli stati.
]

== Esercizio 02

#exercise()[
  Calcolate le classi d'equivalenza della relazione di Myhill-Nerode associata a ciascuno dei seguenti linguaggi e, nel caso la relazione sia di indice finito, costruite l'automa deterministico minimo corrispondente.
]

#request()[
  $L = {w in {a,b}^* bar.v "la somma del numero di" a "e del numero di" b "è multiplo di" 3}$.
]

#solution()[
  Le classi di equivalenza della relazione $R_L$ sono $3$:
  - $[0]_R_L$ per $a + b$ multiplo di $3$;
  - $[1]_R_L$ per $a + b$ multiplo di $3 + 1$;
  - $[2]_R_L$ per $a + b$ multiplo di $3 + 2$.

  #figure(image("assets/07_esercizio_02_01.svg"))
]

#request()[
  $J = {a^n b^n bar.v n gt.eq 0}$.
]

#solution()[
  Il linguaggio $J$ non è regolare, quindi non siamo sicuri che l'indice della relazione $R_J$ sia finito. E infatti non lo è: le classi di equivalenza sono nella forma $ [a^n]_R_J bar.v n gt.eq 0 $ ma il numero di queste classi è infinito, quindi l'indice di $R_J$ è infinito.
]

#request()[
  $K = {a^i b^n a^j bar.v n > 0 and i + j "è pari"}$.
]

#solution()[
  Visto che sono furbo, prima ho costruito l'automa minimo e ora scrivo quali sono le classi di equivalenza, urlo del sium.

  #figure(image("assets/07_esercizio_sium.png", width: 50%))

  Le classi di equivalenza della relazione $R_L$ quindi sono $7$, che riprendono i nomi degli stati dell'automa successivo, molto facili.

  #figure(image("assets/07_esercizio_02_03.svg"))

  Sono sicuro che questo sia l'automa minimo, ho controllato con l'algoritmo di Hopcroft.
]
