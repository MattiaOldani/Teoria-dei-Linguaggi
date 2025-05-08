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

#import "@preview/cetz:0.3.4"

#import "@local/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp

#import "@preview/fletcher:0.5.5": diagram, node, edge


// Esercizi

= Esercizi lezione 17 [07/05]

== Esercizio 01

#exercise()[
  Per ognuno dei seguenti linguaggi stabilite se sia context-free (fornendo una grammatica che lo generi o un automa a pila che lo riconosca) oppure no (applicando opportunamente il pumping lemma).
]

#request()[
  $L = {a^h b^j a^k bar.v j = max(h, k)}$.
]

#solution()[
  Questo linguaggio non è CFL. Dimostrazione fatta a lezione.
]

#request()[
  $L = {a^i b^j c^k bar.v i = j or j = k}$.
]

#solution()[
  Questo linguaggio è CF. Mostriamo un PDA che accetta per pila vuota.

  #figure(image("assets/17_esercizio_01_02.svg"))
]

#request()[
  $L = {a^n b^k c^k d^n bar.v n,k gt.eq 0}$.
]<riferimento01>

#solution()[
  Questo linguaggio è CF. Un automa a pila non deterministico per questo linguaggio deve:
  - considerare la stringa vuota, quindi mettiamo una scommessa nello stato iniziale;
  - considerare stringhe nella forma $a^n d^n$, ma questo si può fare caricando le $a$ sulla pila per poi scaricarle quando leggiamo le $d$;
  - considerare stringhe nella forma $b^k c^k$, ma questo si può fare caricando le $b$ sulla pila per poi scaricarle quando leggiamo le $c$;
  - considerare stringhe nella forma completa, ma questo si può fare caricando le $a$ e le $b$ sulla pila per poi scaricarle quando leggiamo le $c$ e le $d$.

  Potremmo accettare per pila vuota, togliendo $Z_0$ in maniera non deterministica subito nello stato iniziale, oppure quando siamo nello stato di scaricamento delle $c$ o nello stato di scaricamento delle $d$.
]

#request()[
  $L = {a^n b^k c^n d^k bar.v n,k gt.eq 0}$.
]

#solution()[
  Questo linguaggio non è CF: è molto simile al linguaggio $ L = {alpha alpha bar.v alpha in Sigma^*} $ ma la dimostrazione è diversa. Non è CF perché posso caricare $n$ caratteri $A$ e $k$ caratteri $B$ sulla pila, ma poi per controllare le $c$ devo cancellare l'informazione sul numero $k$.

  Per assurdo sia $L$ un CF e sia $N$ la costante del pumping lemma. Definiamo la stringa $ z = a^N b^N c^N d^N bar.v abs(z) gt.eq N . $

  Allora decomponiamo la stringa $z$ come $z = u v w x y$ e, sapendo che $abs(v w x) lt.eq N$, possiamo dire che questo fattore ha poche forme possibili: $ a^+ bar.v a^+ b^+ bar.v b^+ bar.v b^+ c^+ bar.v c^+ bar.v c^+ d^+ bar.v d^+ . $

  Nei quattro casi in cui $v w x$ sono formati da una sola lettera, possiamo ripetere un numero di volte $i gt.eq 2$ per rendere quella lettera in numero maggiore della sua lettera associata, quindi questo genera un assurdo.

  Nei tre casi in cui $v w x$ sono formati da due lettere, dobbiamo vedere in che fattore avviene il cambio di lettera. Facciamo la dimostrazione con $a^+ b^+$:
  - se $v = a^+ b^+$ basta usare $i gt.eq 2$ per avere più $a$ delle $c$ e per perdere la struttura;
  - se $x = a^+ b^+$ stessa cosa;
  - se $w = a^+ b^+$ allora vuol dire che $v = a^l$ e $x = b^r$. Con una $i$ generica noi possiamo generare la stringa $ a^(N + (i-1)l) b^(N + (i-1)r) c^N d^N $ quindi basta scegliere $i = 0$ per rendere le $a$ e le $b$ diverse dalle $c$ e le $d$.

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#request()[
  $L = {a^n b^n c^k d^k bar.v n,k gt.eq 0}$.
]<riferimento02>

#solution()[
  Questo linguaggio è CFL. Un automa a pila per $L$ deve:
  - vedere se le $a$ e le $b$ sono uguali, ma questo è molto facile;
  - vedere se le $a$ e le $b$ sono uguali, ma anche questo è molto facile.

  Deve inoltre controllare la parola vuota, quindi otteniamo un automa non deterministico.
]

#request()[
  $L = {a^n b^m c^i d^k bar.v n,k,i,j gt.eq 0 bar.v (n = m and i = k) or (n = k and m = i)}$.
]

#solution()[
  Questo linguaggio è CFL. Un automa a pila per $L$ si comporta come quello della @riferimento02 per la prima condizione, mentre si comporta come quello della @riferimento01 per quanto riguarda la seconda condizione.
]

#request()[
  $pal^C$, dove $pal$ è l'insieme delle stringhe palindrome sull'alfabeto ${a,b}$.
]

#solution()[
  Questo linguaggio è CFL. Una grammatica per questo linguaggio l'abbiamo vista nei primissimi esercizi, ma la devo sistemare perché è sbagliata.
]

#request()[
  $L = {w w bar.v w in {a,b}^*}^C$.
]

#solution()[
  Non so come farlo.
]

#request()[
  $L = {a^2^n bar.v n gt.eq 0}$.
]

#solution()[
  Questo linguaggio non è CFL.

  Per assurdo sia $L$ un CFL e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a^2^N bar.v abs(z) gt.eq N . $

  Decomponiamo la stringa $z$ come $z = u v w x y$. Sappiamo che possiamo ripetere arbitrariamente i fattori $v$ e $x$, ovvero che $ forall i gt.eq 0 quad u v^i w x^i y in L . $

  Visto che $z$ è formata da sole $a$, allora anche $v$ e $x$ sono formate da sole $a$, e sia $k > 0$ il numero di $a$ di questi due fattori. Allora possiamo dire che $ u v^i w x^i y = a^(2^N + (i-1)k) . $

  Andiamo a scegliere $i = 2$ e otteniamo $a^(2^N + k)$. Visto che $k$ è il numero di $a$ del fattore $v x$, e sapendo che $abs(v x) lt.eq N$ possiamo dire che $ 2^N + k lt.eq 2^N + N < 2^(N+1) . $

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#request()[
  $L = {a^n^2 bar.v n gt.eq 0}$.
]

#solution()[
  Questo linguaggio non è CFL.

  Per assurdo sia $L$ un CFL e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a^N^2 bar.v abs(z) gt.eq N . $

  Decomponiamo la stringa $z$ come $z = u v w x y$. Sappiamo che possiamo ripetere arbitrariamente i fattori $v$ e $x$, ovvero che $ forall i gt.eq 0 quad u v^i w x^i y in L . $

  Visto che $z$ è formata da sole $a$, allora anche $v$ e $x$ sono formate da sole $a$, e sia $k > 0$ il numero di $a$ di questi due fattori. Allora possiamo dire che $ u v^i w x^i y = a^(N^2 + (i-1)k) . $

  Andiamo a scegliere $i = 2$ e otteniamo $a^(N^2 + k)$. Visto che $k$ è il numero di $a$ del fattore $v x$, e sapendo che $abs(v x) lt.eq N$ possiamo dire che $ N^2 + k lt.eq N^2 + N < N^2 + 2N < N^2 + 2N + 1 = (N+1)^2 . $

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#request()[
  $L = {a^p bar.v p "primo"}$.
]

#solution()[
  Questo linguaggio non è CFL. La dimostrazione è stata fatta a lezione.
]

== Esercizio 02

#exercise()[
  Dimostrate che i due linguaggi seguenti sono context-free, dove $pal$ indica l'insieme delle stringhe palindrome sull'alfabeto ${a,b}$.

  Fornite le grammatiche per i due linguaggi e descrivete un automa a pila per $qpalstar$.
]

#request()[
  $palstar = {w_1 hash w_2 hash dots hash w_k bar.v k gt.eq 0 and w_i in pal}$.
]

#solution()[
  Diamo una grammatica $G = (V, Sigma, P, S')$ definita dalle variabili ${S, S', P}$ e regole di produzione $ S' &arrow.long S bar.v epsilon \ S &arrow.long P hash S bar.v P \ P &arrow.long a bar.v b bar.v a a bar.v b b bar.v a P a bar.v b P b . $
]

#request()[
  $ qpalstar = {w_1 hash w_2 hash dots hash w_k bar.v k gt.eq 0 and exists! i in {1, dots, k} bar.v w_i in.not pal} . $
]

#solution()[
  Diamo una grammatica $G = (V, Sigma, P, S')$ definita dalle variabili ${S, S', A, P, N}$ e regole di produzione $ S' &arrow.long S bar.v epsilon \ S &arrow.long P hash S bar.v N bar.v N hash A \ A &arrow.long P bar.v P hash A \ P &arrow.long a bar.v b bar.v a a bar.v b b bar.v a P a bar.v b P b \ N &arrow.long "non palindrome di prima, che va ancora sistemato" . $

  Un automa a pila deve prima di tutto considerare la parola vuota, quindi in maniera non deterministica va subito a svuotare la pila per verificare la vuotezza del nastro.

  Sempre all'inizio, ma anche dopo la lettura di un cancelletto, deve scommettere di essere nell'unica stringa non palindroma, andando a controllare questo e, se è vero, l'automa va in uno stato speciale che controlla solo le palindrome. Se è falso invece non succede niente perché in un'altra computazione stiamo già controllando la palindromicità di quella stringa.
]

== Esercizio 03

#exercise()[
  Non lo so fare.
]

#request()[]

#solution()[]

== Esercizio 04

#exercise()[
  Individuate, tra i seguenti linguaggi, quelli che non sono context-free. Per gli altri, facendo riferimento all'esercizio precedente, stabilite se sono lineari.
]

#request()[
  $L = {a^n b^m a^m b^n bar.v n,m gt.eq 0}$.
]

#solution()[
  Questo linguaggio è CFL ed è anche lineare.
]

#request()[
  $L = {a^n b^n a^m b^m bar.v n,m gt.eq 0}$.
]

#solution()[
  Questo linguaggio è CFL ma non è lineare.
]

#request()[
  $L = {a^n b^m a^n b^m bar.v n,m gt-eq 0}$.
]

#solution()[
  Questo linguaggio non è CFL.
]

#request()[
  $L = {a^n b^n bar.v n gt.eq 0}$.
]

#solution()[
  Questo linguaggio è CFL ed è anche lineare.
]

#request()[
  $L = {a^i b^j c^k bar.v i = j or j = k}$.
]

#solution()[
  Questo linguaggio è CFL ma non è lineare.
]

#request()[
  L'insieme delle parentesi bilanciate correttamente.
]

#solution()[
  Questo linguaggio è CFL ma non è lineare.
]

#request()[
  L'insieme delle stringhe non palindrome su un alfabeto di almeno due lettere.
]

#solution()[
  Questo linguaggio è CFL, non so se è lineare.
]

== Esercizio 05

#exercise()[
  Per ognuno dei seguenti linguaggi stabilite se sia context-free (fornendo una grammatica che lo generi o un automa a pila che lo riconosca) oppure no (applicando opportunamente il pumping lemma).
]

#request()[
  $L = {a^n b^n c^k bar.v k < n}$.
]

#solution()[
  Questo linguaggio non è CFL.

  Per assurdo sia $L$ un CFL e sia $N$ la costante del pumping lemma. Prendiamo la stringa $ z = a^N b^N c^(N-1) bar.v abs(z) gt.eq N . $

  Andiamo a scomporre la stringa $z$ come $z = u v w x y$ e, sapendo che $abs(v w x) lt.eq N$ possiamo dire che questo blocco possa essere presente nelle forme $ a^+ bar.v a^+ b^+ bar.v b^+ bar.v b^+ c^+ bar.v c^+ . $

  Se abbiamo $a^+$ e $b^+$ andiamo a scegliere $i = 0$ per rendere falsa la condizione $k < n$.

  Se abbiamo $c^+$ invece andiamo a scegliere $i gt.eq 2$ per rendere falsa ancora $k < n$.

  Se siamo nelle due configurazioni miste allora dobbiamo capire dove è la divisione delle lettere. Supponiamo di essere in $a^+ b^+$, allora:
  - se $v = a^+ b^+$ basta scegliere $i = 2$ per rompere la struttura;
  - se $x = a^+ b^+$ stessa cosa;
  - se $v = a^l and x = b^r$ allora:
    - se $l eq.not r$ basta scegliere $i eq.not 1$ per avere $hash_a eq.not hash_b$;
    - se $l = r$ basta scegliere $i = 0$ per avere meno $a$ o meno $b$ delle $c$ (o al massimo uguali).

  Se prendiamo invece $b^+ c^+$ i ragionamenti sono molto simili.

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#request()[
  $L = {a^n b^n c^k bar.v k > n}$.
]

#solution()[
  Questo linguaggio non è CFL. La dimostrazione è molto simile a quella della richiesta precedente.
]

#request()[
  $L = {w w^R w bar.v w in {a,b}^*}$.
]

#solution()[
  Questo linguaggio non è CFL.

  Per assurdo sia $L$ un CFL e sia $N$ la costante del pumping lemma. Definiamo la stringa $ a^N b^N b^N a^N a^N b^N $ che possiamo decomporre come $z = u v w x y$.

  Sapendo che $abs(v w x) lt.eq N$ allora abbiamo alcune forme possibili per questo fattore: $ a^+ bar.v b^+ bar.v a^+ b^+ bar.v b^+ a^+ . $

  Se siamo nel caso di una sola lettera, ovunque sia questo fattore, se andiamo a rimuovere quelle lettere scegliendo $i = 0$ andiamo a rompere la palindromicità nel primo pezzo e la stessa stringa nel secondo pezzo.

  Se siamo invece nel caso di due lettere dobbiamo capire dove è il limite. Facciamo la dimostrazione con il fattore $a^+ b^+$:
  - se $v = a^+ b^+$ allora con $i = 2$ rompiamo la struttura e l'uguaglianza finale;
  - se $x = a^+ b^+$ stessa cosa;
  - se $v = a^l and x = b^r$ allora con $i = 2$ rompiamo in un caso la palindromicità, in un caso l'uguaglianza finale.

  Con il fattore $b^+ c^+$ la dimostrazione è molto simile.

  Ma questo è assurdo, quindi $L$ non è CFL.
]

#request()[
  $L = {w w^R w bar.v w in {a}^*}$.
]

#solution()[
  Questo linguaggio è CFL e addirittura regolare, perché è il linguaggio $ L ={a^(3k) bar.v k gt.eq 0} . $
]

#request()[
  $L = {a^n b^m a^k b^m a^n b^h bar.v n,m,h,k gt.eq 1}$.
]

#solution()[
  Questo linguaggio è CFL.

  Un automa a pila per questo linguaggio carica le $a$ e le $b$ sulla pila, poi scorre le $a$ intermedie, poi controlla le $b$ e le $a$ con quelle sulla pila, e infine scorre le $b$ finali.
]

#request()[
  $L = {a^n b^m a^k b^h a^k b^m bar.v n,m,h,k gt.eq 1}$.
]

#solution()[
  Questo linguaggio è CFL.

  Un automa a pila per questo linguaggio scorre le $a$ iniziali, poi carica le $b$ e le $a$ sulla pila, poi scorre le $b$ intermedie, e infine controlla le $a$ e le $b$ con quelle sulla pila.
]

#request()[
  $
    L = {a^(n_1) b^(m_1) a^(n_2) b^(m_2) dots a^(n_k) b^(m_k) bar.v & n_i,m_i gt.eq 1 \ & n_i = n_(k-i+1) bar.v i in {1, dots, k} \ & m_i = m_(k-i) bar.v i in {1, dots, k-1}} .
  $
]

#solution()[
  Questo linguaggio è CFL. È praticamente il linguaggio delle stringhe palindrome con una serie di $b$ finali, quindi facilmente riconoscibile da un NPDA.

  Le scommesse che facciamo sono per capire se siamo a metà del blocco di $a$ o di $b$ che definisce la metà della stringa palindroma. Quando poi arriviamo in $Z_0$ finendo di leggere delle $a$, andiamo a svuotare le ultime $b$ della stringa.
]

#request()[
  $
    L = {a^(n_1) b^(m_1) a^(n_2) b^(m_2) dots a^(n_k) b^(m_k) bar.v & n_i,m_i gt.eq 1 \ & n_i = n_(k-i+2) bar.v i in {2, dots, k} \ & m_i = m_(k-i+1) bar.v i in {1, dots, k}} .
  $
]

#solution()[
  Questo linguaggio è CFL ed è identico a quello precedente, solo che le stringhe hanno delle $a$ iniziali e poi sono formate da blocchi di $a$ e $b$ palindrome.
]

== Esercizio 06

#exercise()[
  Non lo so fare.
]

#request()[

]

#solution()[

]

#request()[

]

#solution()[

]

#request()[

]

#solution()[

]

#request()[

]

#solution()[

]
