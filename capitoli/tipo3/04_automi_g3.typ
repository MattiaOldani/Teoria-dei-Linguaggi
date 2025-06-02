// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Equivalenza tra linguaggi di tipo 3 e automi a stati finiti

In questo capitolo mostreremo l'*equivalenza* tra le grammatiche di tipo $3$ e gli automi a stati finiti.

== Dall'automa alla grammatica

Dato un automa $A = (Q, Sigma, delta, q_0, F)$ per il linguaggio $L$, costruiamo una grammatica $G$ di tipo $3$ che riconosca lo stesso linguaggio $L$.

Per fare ciò dobbiamo definire le variabili, l'assioma e le produzioni. Definiamo quindi $G$ tale che:
- le *variabili* sono gli stati dell'automa, ovvero $V = Q$;
- l'*assioma* è lo stato iniziale dell'automa, ovvero $S = q_0$;
- le *produzioni* derivano dalle transizioni e sono nella forma:
  - $q arrow.long a p$ se la funzione di transizione è tale che $delta(q, a) = p$;
  - alla produzione precedente aggiungiamo la produzione $q arrow.long a$ se $p$ è uno stato finale, questo perché posso fermarmi in $p$.

#example()[
  Sia $Sigma = {4,5}$. Ci viene fornito un automa che, date le stringhe sull'alfabeto $Sigma$ interpretate come numeri decimali, una volta divise per $3$ ci danno $1$ come resto.

  #figure(image("assets/04/resto_uno.svg"))

  Costruiamo una grammatica $G$ di tipo $3$ analoga a questo automa. Sia quindi $G$ tale che:
  - variabili $V = {r_0, r_1, r_2}$;
  - assioma $S = r_0$;
  - produzioni $P$:
    - $r_0 arrow.long 4 r_1 bar.v 4 bar.v 5 r_2$;
    - $r_1 arrow.long 4 r_2 bar.v 5 r_0$;
    - $r_2 arrow.long 4 r_0 bar.v 5 r_1 bar.v 5$.

  Proviamo a derivare una stringa per vedere se effettivamente funziona: $ r_0 arrow.long 4 r_1 arrow.long 4 5 r_0 arrow.long 4 5 5 r_2 arrow.long 4 5 5 5 . $
]

== Dalla grammatica all'automa

In maniera analoga, data la grammatica $G$ di tipo $3$ creiamo un automa $A$ tale che:
- *stati* $Q = V union {q_F}$;
- *stato iniziale* $q_0 = S$;
- *stati finali* $F = {q_F}$;
- *transizioni* della funzione di transizione derivano dalle regole di produzione, ovvero:
  - per ogni produzione $(A arrow.long a B) in P$ essa ci dice che dallo stato $A$ leggendo una $a$ andiamo a finire in $B$, ovvero $delta(A, a) = B$;
  - per ogni produzione $(A arrow.long a) in P$ essa ci dice che possiamo finire la derivazione, cioè che andiamo da $A$ in uno stato finale tramite $a$, ovvero $delta(A, a) = q_F$.

  Per essere più precisi, definiamo i passi della funzione di transizione come $ delta(A, a) = {B bar.v (A arrow.long a B) in P} union {q_F "se" (A arrow.long a) in P} $

#example()[
  Data la grammatica $G = (V, Sigma, P, S)$ tale che:
  - $V = {r_0, r_1, r_2}$;
  - $S = r_0$;
  - produzioni $P$:
    - $r_0 arrow.long 4 r_1 bar.v 4 bar.v 5 r_2$;
    - $r_1 arrow.long 4 r_2 bar.v 5 r_0$;
    - $r_2 arrow.long 4 r_0 bar.v 5 r_1 bar.v 5$.

  Ricaviamo un automa dalla grammatica $G$. Per fare ciò definiamo:
  - $Q = {r_0, r_1, r_2, r_f}$;
  - $q_0 = r_0$;
  - $F = {r_f}$;
  - funzione di transizione $delta$ che ha il seguente comportamento:
    - $delta(r_0, 4) = {r_1, r_f}$;
    - $delta(r_0, 5) = {r_2}$;
    - $delta(r_1, 4) = {r_2}$;
    - $delta(r_1, 5) = {r_0}$;
    - $delta(r_2, 4) = {r_0}$;
    - $delta(r_2, 5) = {r_1, r_f}$.

  #figure(image("assets/04/resto_uno_peggiore.svg"))

  Notiamo come l'automa ottenuto sia non deterministico e, soprattutto, non è l'automa minimo che avevamo invece nell'esempio precedente.
]

// Non so se va qua
== Grammatiche lineari

Stiamo parlando di grammatiche, quindi vediamo un tipo particolare di grammatiche che però incontreremo molto più avanti: le *grammatiche lineari*.

=== Grammatiche lineari a destra

Potrebbero capitarci delle grammatiche che hanno una forma simile a quelle regolari, ma che in realtà non lo sono. Queste grammatiche hanno le produzioni nella forma $ A arrow.long x B bar.v x quad "tale che" quad x in Sigma^* . $ Non abbiamo più, come nelle grammatiche regolari, la stringa $x$ formata da un solo terminale, ma possiamo averne un numero arbitrario.

Queste grammatiche sono dette *grammatiche lineari a destra*, ma nonostante questa aggiunta di terminali non aumentiamo la potenza del linguaggio: per generare quella sequenza di terminali $x$ basta aggiungere una serie di regole che rispettano le grammatiche regolari che generino esattamente la stringa $x$.

#example()[
  Dato l'automa in figura, andare a scrivere l'automa regolare corrispondente.

  #figure(image("assets/04/lineare_destra.svg"))

  Nella grammatica avremmo una serie di regole che seguono la forma delle grammatiche regolari per generare la stringa $x$, ovvero:

  #figure(image("assets/04/lineare_destra_a_regolare.svg"))

  Abbiamo quindi sostituito la stringa $x = a_1 dots a_n$ con una serie di stati intermedi.
]

// Se $x = epsilon$ basta mettere una $epsilon$-mossa, tutto molto facile (_anche se non ho capito_).

=== Grammatiche lineari a sinistra

Esistono anche le *grammatiche lineari a sinistra*, che hanno le produzioni nella forma $ A arrow.long B x bar.v x quad "tale che" quad x in Sigma^* . $

Si dimostra che anche queste grammatiche non vanno oltre i linguaggi regolari, anche se è un accrocchio passare da queste grammatiche a quelle regolari.

=== Grammatiche lineari

E se facciamo un *mischione* delle due grammatiche precedenti?

Le produzione di queste grammatiche sono nella forma $ A arrow.long x B bar.v B x bar.v x quad "tale che" quad x in Sigma^* and A,B in V . $

Queste grammatiche, che generano i cosiddetti *linguaggi lineari*, sono a cavallo tra le grammatiche di tipo $3$ e le grammatiche di tipo $2$. Quindi siamo un pelo più forti delle grammatiche regolari, ma non quanto le grammatiche CF.

#example()[
  Definiamo una grammatica che utilizza le seguenti produzioni:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long a A bar.v epsilon$], [$A arrow.long S b$],
  )

  Con queste regole di una grammatica lineare stiamo generando il linguaggio $ L = {a^n b^n bar.v n gt.eq 0} , $ che non è un linguaggio di tipo $3$.
]

La cosa che stiamo aggiungendo è una sorta di *ricorsione*, che mi permette di saltare fuori dai linguaggi regolari e catturare di più di prima.
