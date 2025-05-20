// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

// Esercizi

= Esercizi lezione 18 [09/05]

== Esercizio 01

#exercise()[]

#request()[
  Dimostrate che il linguaggio $L = {a^i b^j c^k bar.v i = j or j = k "ma non" i = j = k}$ non è context-free.

  _Suggerimento_: procedete in modo analogo all'esempio ${a^n b^n c^k bar.v k eq.not n}$ presentato a lezione.
]

#solution()[
  Per assurdo sia $L$ un CFL e sia $N$ la costante del Lemma di Ogden. Sia $ z = a^N b^N c^(N + N!) in L $ e andiamo a marcare tutte le $a$ di $z$.

  Andiamo a decomporre $z$ come $z = u v w x y$ e, visto che $v x$ deve avere almeno una posizione marcata, possiamo concludere che $v w x$ può essere nelle seguenti configurazioni:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$a^+$], [$a^+ b^+$], [$a^+ b^N c^+$],
  )

  Per il primo caso basta scegliere $i = 0$ per rompere l'uguaglianza con le $b$.

  Per il secondo caso dobbiamo vedere dove cade la divisione delle lettere:
  - se $v in a^+ b^+ or x in a^+ b^+$ andiamo a rompere la struttura della stringa;
  - se $v in a^l and x in b^r$ abbiamo altri due casi:
    - se $l eq.not r$ basta scegliere $i = 0$ per rompere l'uguaglianza tra $a$ e $b$;
    - se $l = r$ allora dobbiamo scegliere un valore di $i$ che ci renda le $a$ e le $b$ uguali al numero di $c$, quindi deve succedere che $ u v^i w x^i y = a^(N + (i-1)l) b^(N + (i-1)l) c^(N + N!) arrow.long.double (i-1)l = N! arrow.long.double i = frac(N!, l) + 1 . $

  Per il terzo caso:
  - se $v$ o $x$ hanno almeno due tipi di lettere rompiamo la struttura della stringa;
  - se $v$ o $x$ hanno una sola lettera, quindi hanno solo $a$, rompiamo l'uguaglianza.

  Ma questo è assurdo, quindi $L$ non è CFL.
]

== Esercizio 02

#exercise()[]

#request()[
  Utilizzate il lemma di Ogden per dimostrare che $L = {a^i b^j c^k bar.v i eq.not j and j eq.not k and i eq.not k}$ non è context-free.

  _Suggerimento_: per questa prima parte considerate $z = a^N b^(N + N!) c^(N + 2N!)$ e marcate tutte le $a$.
]

#solution()[
  Per assurdo sia $L$ un CFL e sia $N$ la costante del lemma di Ogden. Sia $ z = a^N b^(N + N!) c^(N + 2N!) in L $ in cui andiamo a marcare tutte le $a$.

  Decomponiamo $z$ come $z = u v w x y$ e, sapendo che $v x$ deve avere una posizione marcata, le uniche configurazioni possibili per $v w x$ sono:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$a^+$], [$a^+ b^+$],
  )

  Per il primo caso andiamo a scegliere $ i = frac(N!, l) + 1 $ dove $l$ è il numero di $a$ in $v x$ per avere $hash_a = hash_b$.

  Per il secondo caso dobbiamo vedere dove cade la divisione delle lettere:
  - se $v = a^+ b^+ or x = a^+ b^+$ allora basta scegliere $i gt.eq 2$ per rompere la struttura della stringa;
  - se $v = a^l and x = b^r$ abbiamo altri due casi:
    - se $l = r$ allora come prima scegliamo un valore di $i$ che renda uguali le $a$ con le $c$ o le $b$ con le $c$, ovvero $ u v^i w x^i y = a^(N + (i-1)l) b^(N + N! + (i-1)l) c^(N + 2N!) &arrow.long.double (i-1)l = 2N! arrow.long.double i = frac(2N!, l) + 1 \ &arrow.long.double N! + (i-1)l = 2N! arrow.long.double i = frac(N!, l) + 1 . $

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#request()[
  Riuscite a dimostrare lo stesso risultato utilizzando direttamente il pumping lemma?
]

#solution()[
  Proviamo con il pumping lemma.

  Per assurdo sia $L$ un CFL e sia $N$ la costante del pumping lemma. Sia $ z = a^N b^(2N) c^(3N) in L . $

  Decomponiamo $z$ come $z = u v w x y$. Sapendo che $abs(v w x) lt.eq N$ allora abbiamo le seguenti configurazioni per questo fattore:

  #grid(
    columns: (20%, 20%, 20%, 20%, 20%),
    align: center + horizon,
    inset: 10pt,
    [$a^+$], [$b^+$], [$c^+$], [$a^+ b^+$], [$b^+ c^+$],
  )

  Secondo me non si riesce con il pumping lemma:
  - i primi tre casi richiedono casi discordanti, perché come avevamo visto a lezione questi casi richiedono che la parte da pompare sia minore delle altre due, e in questo caso possiamo ma non con tutti;
  - gli ultimi due casi invece riusciamo a rompere la struttura in alcuni divisioni, ma quando la divisione avviene in $w$ allora sarebbe meglio avere la situazione opposta di quella precedente.

  L'ho scritto malissimo, ma secondo me non si può fare.
]

== Esercizio 03

#exercise()[
  Il linguaggio $L = {a^i b^j c^k d^l bar.v i = 0 or j = k = l}$ non è context-free.
]

#request()[
  Provate a dimostrare questa affermazione utilizzando il pumping lemma: sia partendo da una stringa $z in L$ non contenente il simbolo $a$, cioè nella forma $b^j c^k d^l$, sia partendo da una stringa contenente $a$, cioè della forma $a^i b^j c^j d^j$, con $i > 0$, non si riesce ad arrivare a una contraddizione per qualunque decomposizione di $z$ in $u w v x y$.
]

#solution()[
  Simile a quello di prima come ragionamenti, non ho voglia di scriverlo ora.
]

#request()[
  Provate a utilizzare il Lemma di Ogden. A questo scopo, scegliere opportunamente una stringa $z in L$ da cui partire e le posizione da marcare in $z$.
]

#solution()[
  Basta scegliere $z = a^N b^N c^N$ e marcare tutte le $a$.
]
