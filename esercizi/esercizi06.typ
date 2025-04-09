// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Esercizi lezione 06 [14/03]

== Esercizio 01

#exercise()[
  Considerate il linguaggio $ "DOUBLE"_k = {w w bar.v w in {a,b}^k}, $ dove $k > 0$ è un intero fissato.
]

#request()[
  Trovare un fooling set di cardinalità $2^k$ per questo linguaggio. Riuscite a trovare un fooling set o un extended fooling set di cardinalità maggiore?
]

#solution()[
  Definiamo il fooling set $ P = {(x,x) bar.v x in {a,b}^k} . $

  Esso è un fooling set per $"DOUBLE"_k$:
  - la stringa $z = x x$ appartiene al linguaggio;
  - presi due elementi di lunghezza $k$ da due coppie diverse, essi saranno diversi in almeno una posizione e quindi la stringa risultate non appartiene al linguaggio.

  Non so se riusciamo a trovare un fooling set o un extended set di cardinalità maggiore, non ti bastava questo qua?
]

== Esercizio 02

#exercise()[
  Considerate il linguaggio $ "PAL"_k = {w in {a,b}^k bar.v w = w^R} , $ dove $k$ è un intero fissato.
]

#request()[
  Qual è l'extended fooling set per $"PAL"_k$ di cardinalità maggiore che riuscite a trovare?
]

#solution()[
  Definiamo l'insieme $ P = {(w, w^R) bar.v w in {a,b}^(k/2)} . $

  Esso è un fooling set per il linguaggio $"PAL"_k$:
  - la coppia $(w,w^R)$ appartiene al linguaggio;
  - ogni altra stringa formata da elementi di due coppie diverse non appartiene al linguaggio perché esiste almeno una coppia di caratteri con la stessa distanza dagli estremi che sono diversi.

  $P$ ha cardinalità $2^(k/2)$, quindi ogni NFA per $"PAL"_k$ ha almeno $2^(k/2)$ stati.
]

== Esercizio 03

#exercise()[
  Considerate il linguaggio $ K_k = {w bar.v w = x_1 x_2 dots.c x_m x bar.v m > 0, x_1, dots x_m in {a,b}^k, exists i in {1, dots, m} bar.v x_i = x}, $ dove $k$ è un intero fissato. Si può osservare che ogni stringa $w$ di questo linguaggio è la concatenazione di blocchi di lunghezza $k$, in cui l'ultimo blocco coincide con uno dei blocchi precedenti.
]

#request()[
  Riuscite a costruire un (extended) fooling set di cardinalità $2^k$ o maggiore per il linguaggio $K_k$?

  _Suggerimento_. Ispiratevi all'esercizio $1$.
]

#solution()[
  Definiamo il fooling set $ P = {(x,x) bar.v x in {a,b}^k} . $

  Esso è un fooling set per $K_k$:
  - la stringa $z = x x$ appartiene al linguaggio;
  - presi due elementi di lunghezza $k$ da due coppie diverse, essi rappresentano due blocchi diversi perché diversi in almeno una posizione, quindi la stringa risultate non appartiene al linguaggio.

  La cardinalità di $P$ è $2^k$, quindi ogni NFA per $K_k$ ha almeno $2^k$ stati.
]

#request()[
  Quale è l'informazione principale che un automa non deterministico può scegliere di ricordare nel proprio controllo a stati finiti durante la lettura di una stringa per riuscire a riconoscere $K_k$?

  _Suggerimento_. Che "scommessa" può fare l'automa mentre legge la stringa in ingresso e come può verificare tale scommessa leggendo l'ultimo blocco?
]

#solution()[
  Un automa non deterministico dovrebbe scommettere che ha appena finito di leggere il blocco che poi sarà ripetuto alla fine. Il controllo che fa l'automa alla fine è quello di uguaglianza con il blocco scommesso, che viene fatta in maniera deterministica ma richiede un grande numero di stati. Va creato quindi un albero che in maniera non deterministica mi manda indietro allo start prima dell'ultimo nodo.

  Ad esempio, se $k = 2$ l'automa non deterministico ha questa forma.

  #figure(image("assets/06_esercizio_03_02.svg"))
]

#request()[
  Supponete di costruire un automa deterministico per riconoscere $K_k$. Cosa ha necessità di ricordare l'automa nel proprio controllo a stati finiti mentre legge la stringa in input?
]

#solution()[
  Un automa deterministico si deve ricordare i blocchi di lunghezza $k$ che ha incontrato fino a quel momento. Questo però fa esplodere il numero di stati, perché dobbiamo calcolare praticamente ogni combinazione possibile.
]

#request()[
  Utilizzando il concetto di distinguibilità, dimostrate che ogni automa deterministico che riconosce $K_k$ deve avere almeno $2^(2^k)$ stati.
]

// Ricordati che quando vedi 2^qualcosa è sempre sottoinsiemi
#solution()[
  Sia $T = {a,b}^k$ insieme di tutte le stringhe di lunghezza $k$ costruite sull'alfabeto ${a,b}$. Definiamo l'insieme $ X = cal(P)(T) $ insieme di tutti i sottoinsiemi di $T$, ovvero l'insieme delle parti di $T$. Supponiamo che ogni sottoinsieme venga rappresentato come una stringa ottenuta dalla concatenazione dei suoi elementi.

  Questo insieme è formato da stringhe distinguibili tra loro: infatti, prese due stringhe di $X$, esse hanno almeno un blocco lungo $k$ che appartiene a una delle due ma non all'altra. Ma allora usando quell'elemento come stringa $z$ che distingue noi otteniamo l'appartenenza per la stringa che contiene quell'elemento e la non appartenenza per l'altra.

  La cardinalità di $X$ è $2^abs(T)$, ovvero $2^(2^k)$, quindi ogni DFA per $K_k$ ha almeno $2^(2^k)$ stati.
]

== Esercizio 04

#exercise()[
  Considerate il linguaggio $ J_k = {w bar.v w = x x_1 dots.c x_m bar.v m > 0, x_1, dots x_m, x in {a,b}^k, exists i in {1, dots, m} bar.v x_i = x} , $ dove $k$ è un intero fissato. Si può osservare che ogni stringa $w$ di questo linguaggio è la concatenazione di blocchi di lunghezza $k$, in cui il primo blocco coincide con uno dei blocchi successivi; ogni stringa di $J_k$ si ottiene "rovesciando" una stringa del linguaggio $K_k$ dell'esercizio $3$.
]

#request()[
  Supponete di costruire automi a stati finiti per $J_k$. Valgono ancora gli stessi limiti inferiori ottenuti per $K_k$ o si riescono a costruire automi più piccoli? Rispondete sia nel caso di automi deterministici sia in quello di automi non deterministici.
]

#solution()[
  Un DFA per $J_k$ usa molti meno stati di un DFA per $K_k$: infatti, un DFA per $J_k$ deve fare un albero per vedere quale stringa lunga $k$ viene letta all'inizio e poi deve eseguire un controllo con altri $2k - 1$ stati per ogni stato foglia. Il numero di stati è quindi $ 2^(k+1) - 1 + 2^k (2k - 1) = 2^(k+1) - 1 + k 2^(k+1) - 2^k = O(k 2^k) . $

  Vediamo un esempio con $k = 2$ per semplicità.

  #figure(image("assets/06_esercizio_04_01.svg"))

  Per il caso non deterministico, ogni NFA deve comunque generare l'albero iniziale per vedere le possibili combinazioni. Nei nodi delle combinazioni potremmo inserire la scommessa, ma questo ci farebbe accettare più stringhe di quelle che vorremmo accettare.

  Quindi non lo so RIP, ci penserò più avanti, magari c'è un fooling set da trovare.
]

== Esercizio 05

#exercise()[]

#request()[
  Ispirandovi all'esercizio $3$, fornite limiti inferiori per il numero di stati degli automi che riconoscono il seguente linguaggio: $ E_k = {w bar.v w = x_1 dots.c x_m bar.v m > 0, x_1, dots, x_m in {a,b}^k, exists i < j in {1, dots, m} bar.v x_i = x_j} , $ dove $k$ è un intero fissato. Considerate sia il caso deterministico che quello non deterministico.
]

#solution()[
  Definiamo l'insieme $ P = {(x,x) bar.v x in {a,b}^k} . $

  Questo è un fooling set per il linguaggio $E_k$:
  - la stringa $z = x x$ appartiene a al linguaggio;
  - la stringa $z = x y$ non appartiene al linguaggio.

  Allora ogni NFA per $E_k$ ha almeno $abs(P) = 2^k$ stati.

  Per i DFA, come per $K_k$, essi si devono ricordare i blocchi lunghi $k$ che hanno incontrato fino a quel momento, e questo fa esplodere il numero di stati. Infatti, definiamo l'insieme $ X = cal(P)({a,b}^k) . $

  Esso è un insieme di stringhe distinguibili per $E_k$: presi due sottoinsiemi $A$ e $B$, allora prendiamo un elemento $x in A slash B$ e usiamolo per distinguere le due stringhe (generate dalla concatenazione di tutte le stringhe contenute in un sottoinsieme).

  Ma allora ogni DFA per $E_k$ ha almeno $abs(X) = 2^(2^k)$ stati.
]
