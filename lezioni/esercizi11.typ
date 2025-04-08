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

#import "@preview/cetz:0.3.3"


// Esercizi

= Esercizi lezione 11 [02/04]

== Esercizio 01

#exercise()[
  Considerate l'insieme delle stringhe sull'alfabeto ${a,b}$ il cui simbolo centrale è una $a$, cioè il linguaggio $ L = {w in {a,b}^* bar.v "il simbolo in posizione" ceil(abs(x) / 2) "di" w "è una" a} . $
]

#request()[
  Utilizzate il pumping lemma per dimostrare che $L$ non è regolare.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = b^N a b^N $ di lunghezza $abs(z) = 2N + 1 gt.eq N$ e scomponiamola come $z = u v w$. Sappiamo che $abs(u v) lt.eq N$, quindi $u v$ è formata da solo $b$, ovvero $ u = b^i and v = b^j bar.v i + j lt.eq N and j gt.eq 1 . $

  Sappiamo anche che possiamo ripetere $v$ un numero arbitrario di volte: se scegliamo $k gt.eq 2$ otteniamo una stringa $z'$ che viene gonfiata di $b$ all'inizio, spostando il carattere centrale mano a mano verso sinistra. Visto che i caratteri a sinistra del centro sono solo $b$, il nuovo elemento centrale sarà una $b$, ma questo è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

#request()[
  Cosa si può dire nel caso l'alfabeto sia formato dal solo simbolo $a$?
]

#solution()[
  Nel caso l'alfabeto sia unario, il linguaggio che stiamo riconoscendo è $a^+$, quindi lo possiamo fare con un DFA e quindi il linguaggio è regolare.
]

== Esercizio 02

#exercise()[
  Utilizzando il pumping lemma, dimostrate che i seguenti linguaggi non sono regolari.
]

#request()[
  $pal = {w in {a,b}^* bar.v w = w^R}$.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = b^N a b^N $ di lunghezza $abs(z) = 2N + 1 gt.eq N$ e scomponiamola come $z = u v w$. Sappiamo che $abs(u v) lt.eq N$, quindi $u v$ è formata da solo $b$, ovvero $ u = b^i and v = b^j bar.v i + j lt.eq N and j gt.eq 1 . $

  Sappiamo anche che possiamo ripetere $v$ un numero arbitrario di volte: se scegliamo $k = 0$ otteniamo una stringa $z'$ che contiene un numero iniziale di $b$ minore di $N$ perché ne abbiamo cancellata almeno una, ma questo è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

#request()[
  ${a^m b^n a^n bar.v m gt.eq 1 and n gt.eq 0}$.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a b^N a^N $ di lunghezza $abs(z) = 2N + 1 gt.eq N$ e scomponiamola come $z = u v w$. Sappiamo che $abs(u v) lt.eq N$, quindi per $u v$ abbiamo $3$ scomposizioni possibili:
  - $u = epsilon and v = a$: basta scegliere $k = 0$ nella ripetizione arbitraria per far cadere $m gt.eq 1$;
  - $u = epsilon and v = a b^i bar.v i in {1, dots, N-1}$: basta scegliere $k = 0$ nella ripetizione arbitraria per far cadere $m gt.eq 0$ e l'uguaglianza finale delle $a$ e delle $b$;
  - $u = a b^i and v = b^j bar.v i + j lt.eq N - 1 and j gt.eq 1$: basta scegliere $k = 0$ nella ripetizione arbitraria per far cadere l'uguaglianza finale delle $a$ e delle $b$.

  Ma questo è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

#request()[
  ${a^n b^m a^n bar.v m gt.eq 1 and n gt.eq 0}$.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a^N b a^N $ di lunghezza $abs(z) = 2N + 1 gt.eq N$ e scomponiamola come $z = u v w$. Sappiamo che $abs(u v) lt.eq N$, quindi $u v$ è formata da solo $a$, ovvero $ u = a^i and v = a^j bar.v i + j lt.eq N and j gt.eq 1 . $

  Sappiamo anche che possiamo ripetere $v$ un numero arbitrario di volte: se scegliamo $k = 0$ otteniamo una stringa $z'$ che contiene un numero iniziale di $a$ minore di $N$ perché ne abbiamo cancellata almeno una, ma questo è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

#request()[
  ${a^p bar.v p "è un numero primo"}$.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a^(N + k) bar.v k gt.eq 0 $ di lunghezza $abs(z) = N + k gt.eq N$ tale che $N + k$ è primo. Scomponiamo $z$ come $z = u v w$. Ogni pezzo di $z$ è formato da solo $a$, ma siamo sicuri che $v$ ne abbia almeno una perché $v eq.not epsilon$.

  Sia quindi $v = a^i bar.v i gt.eq 1$. Abbiamo due casi per $N + k$:
  - se $N + k$ pari vuol dire che $N + k = 2$, unico primo pari, ma allora:
    - se $i = 1$ scegliamo $k = 3$ ottenendo $z' = a a a a$ che non appartiene a $L$;
    - se $i = 2$ scegliamo $k = 2$ ottenendo ancora $z' = a a a a$ che non appartiene a $L$;
  - se $N + k$ dispari allora:
    - se $i$ è dispari andiamo a scegliere $k = 0$ nella ripetizione arbitraria per rimuovere un numero dispari di $a$ da $N + k$, ottenendo quindi un numero pari, che non è primo;
    - se $i$ è pari andiamo a scegliere $k$ che mi renda il numero di $a$ non primo, e siamo sicuri che esista questo numero perché esistono infiniti numeri dispari che non sono primi.

  Ma ogni caso visto è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

#request()[
  ${a^(2^n) bar.v n gt.eq 0}$.
]

#solution()[
  Vedi teoria.
]

#request()[
  ${a^(n!) bar.v n gt.eq 0}$.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a^(N!) $ di lunghezza $abs(z) = N! gt.eq N$ e scomponiamola come $z = u v w$. Ogni pezzo di $z$ è formato da solo $a$, ma siamo sicuri che $v$ ne abbia almeno una perché $v eq.not epsilon$. Sia quindi $v = a^i bar.v i gt.eq 1$.

  Potendo ripetere arbitrariamente $v$, scegliamo $k = 2$ e andiamo a scrivere $ abs(u v^2 w) = N! + abs(v) = N! + i . $

  Il fattoriale successivo a $N!$ è $(N+1)!$, ma per ottenere questo dovremmo avere $ N! + i < (N+1)! \ i < (N+1)N! - N! \ i < (N+1-1)N! \ i < N N! $

  TODO: *DA CHIEDERE A MARTINO*

  // Ma questo è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

== Esercizio 03

#exercise()[
  Dimostrate che il linguaggio delle parentesi bilanciate non è regolare in tre modi.
]

#request()[
  Utilizzando il pumping lemma.
]

#solution()[
  Per assurdo sia $L$ regolare, e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = \(^N )^N $ di lunghezza $abs(z) = 2N gt.eq N$ e scomponiamola come $z = u v w$. Sappiamo che $abs(u v) lt.eq N$, quindi $u v$ è formata da solo $($, ovvero $ u = \(^i and v = \(^j bar.v i + j lt.eq N and j gt.eq 1 . $

  Sappiamo anche che possiamo ripetere $v$ un numero arbitrario di volte: se scegliamo $k = 0$ otteniamo una stringa $z'$ che contiene un numero iniziale di $($ minore di $N$ perché ne abbiamo cancellata almeno una, ma questo è assurdo perché la ripetizione arbitraria dovrebbe mantenerci in $L$, quindi quest'ultimo non è regolare.
]

#request()[
  Utilizzando il concetto di distinguibilità.
]

#solution()[
  Definiamo l'insieme $ X = {\(^k bar.v k gt.eq 0} $ formato da stringhe distinguibili tra loro per $L$. Infatti, prese due stringhe $x_i$ e $x_j$, con $i eq.not j$, avremo $ hash_(\() (x_i) = i eq.not j = hash_(\() (x_j) $ che possono essere distinte con la stringa $z = )^i$.

  Ma allora ogni DFA per $L$ ha almeno $abs(X) = infinity$ stati, ma quindi $L$ non è regolare.
]

#request()[
  Sfruttando le proprietà di chiusura della classe dei linguaggi regolari per mostrare che la sua regolarità implicherebbe quella del linguaggio ${a^n b^n bar.v n gt.eq 0}$.
]

#solution()[
  Per assurdo sia $L$ regolare, allora esso è chiuso tramite l'operazione di intersezione. Andiamo a calcolare $ L inter \(^*)^* $ andiamo a ottenere il linguaggio $ {\(^n\)^n bar.v n gt.eq 0} $ perché tra tutte le stringhe di parentesi bilanciate vado a prendere quelle che hanno tutte le parentesi aperte all'inizio seguite da tutte quelle chiuse per, appunto, chiudere quelle aperte.

  Però il linguaggio ${\(^n\)^n bar.v n gt.eq 0}$ non è regolare, ed essendo $\(^*)^*$ regolare, deve essere per forza $L$ non regolare.
]

== Esercizio 04

#exercise()[
  Considerate il seguente linguaggio $L subset.eq {a,b,c}^*$: $ L = {a^m b^n c^n bar.v m gt.eq 1 and n gt.eq 0} union {b^m c^n bar.v m,n gt.eq 0} . $
]

#request()[
  Verificate che il linguaggio $L$ soddisfa la condizione del pumping lemma per i linguaggi regolari.
]

#solution()[
  Non ci riesco ora.
]

#request()[
  Dimostrate che $L$ non è regolare utilizzando il concetto di distinguibilità.
]

#solution()[
  Definiamo l'insieme $ X = {a b^k bar.v k gt.eq 0} $ formato da stringhe distinguibili tra loro per $L$. Infatti, prese due stringhe $x_i$ e $x_j$, con $i eq.not j$, avremo $ hash_(b) (x_i) = i eq.not j = hash_(b) (x_j) $ che possono essere distinte con la stringa $z = c^i$.

  Ma allora ogni DFA per $L$ ha almeno $abs(X) = infinity$ stati, ma quindi $L$ non è regolare.
]

#request()[
  Dimostrate che $L$ non è regolare sfruttando le proprietà di chiusura della classe dei linguaggi regolari.
]

#solution()[
  Per assurdo sia $L$ regolare, allora esso è chiuso tramite l'operazione di intersezione. Andiamo a calcolare $ L inter a b^* c^* $ andiamo a ottenere il linguaggio $ {a b^n c^n bar.v n gt.eq 0} $ perché andiamo a cancellare tutte le stringhe del secondo insieme e di tutte le prime teniamo quelle che hanno solo una $a$, seguita da tutte le $b$ e tutte le $c$, che però devono essere in numero uguale per la definizione del primo insieme.

  Però il linguaggio ${a b^n c^n bar.v n gt.eq 0}$ non è regolare, ed essendo $a b^* c^*$ regolare, deve essere per forza $L$ non regolare.
]
