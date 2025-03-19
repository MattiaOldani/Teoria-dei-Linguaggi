// Setup

#import "template.typ": project

#show: project.with(title: "Teoria dei linguaggi")

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#pagebreak()

// Appunti

/* INIZIO LEZIONE 07 */

= Estensioni

== $epsilon$-mosse

Le *$epsilon$-mosse* sono una possibile estensione degli automi a stati finiti che permettono transizioni sulla parola vuota, ovvero permettono di spostarsi da uno stato all'altro senza leggere un carattere dal nastro.

Sono utili nei compilatori quando é possibile definire gli interi positivi senza il segno _più_.

#v(12pt)

#figure(image("assets-teoria/segno.svg", width: 50%))

#v(12pt)

Questa estensione non aumenta però la potenza espressiva dell'automa: infatti, ogni sequenza del tipo $ p arrow.long.squiggly^epsilon p' arrow.long^a q' arrow.long.squiggly^epsilon q $ può essere tradotta nella transizione $p arrow.long^a q$.

== Stati iniziali multipli

L'ultima estensione che vediamo é quella degli *stati iniziali multipli*: al posto di avere un singolo stato iniziale abbiamo un insieme di stati dai quali poter iniziare.

Anche questa estensione non aumenta la potenza espressiva dell'automa: infatti, la funzione di transizione partirà direttamente con un insieme di stati e non da un insieme con un solo stato.

= Equivalenza tra linguaggi di tipo 3 e automi a stati finiti

Dimostriamo che dato l'automa $A$ per $L$ possiamo costruire una costruire una grammatica $G$ di tipo $3$ tale che $L(A) = L(G)$.

#theorem()[
  Le grammatiche di tipo $3$ sono equivalenti agli automi a stati finiti.
]

#theorem-proof()[
  \ [$A arrow.long.double G$] Dato $A = (Q, Sigma, delta, q_0, F)$ DFA per $L$ costruisco la grammatica $G = (V, Sigma, P, S)$ tale che:
  - $V = Q$;
  - $Sigma$ rimane uguale;
  - $S = q_0$.
  Le regole di produzione in $P$ sono nella forma:
  - $A arrow.long a B$ se $delta(A,a) = B$, con $A,B in Q$ e $a in Sigma$;
  - $A arrow.long a$ se $A in F$, con $A in Q$ e $a in Sigma$.
  Si può dimostrare che $ q_0 arrow.stroked x A arrow.long.double.l.r delta(q_0, x) = A. $

  [$G arrow.long.double A$] Data $G = (V, Sigma, P, S)$ grammatica di tipo $3$ costruisco un DFA $A = (Q, Sigma, delta, q_0, F)$ tale che:
  - $Q = V union {q_f}$;
  - $Sigma$ rimane uguale;
  - $q_0 = S$;
  - $F = {q_f}$.
  La funzione di transizione $delta$ é definita nel seguente modo:
  - se $A arrow.long a B$ allora $B in delta(A, a)$;
  - se $A arrow.long a$ allora $q_f in delta(A, a)$.
]

== Espressioni regolari

=== Operazioni insiemistiche

Sia $L subset.eq Sigma^*$ un linguaggio. Essendo un insieme, possiamo utilizzare le classiche operazioni di:
- intersezione $inter.big$;
- unione $union.big$;
- complemento $()^C$.

Altre operazioni importanti sono:
- *prodotto/concatenazione* di linguaggi: dati $L_1,L_2 subset.eq Sigma^*$ costruisco l'insieme $ L_1 dot.op L_2 = {z bar.v exists x in L_1 and exists y in L_2 bar.v z = x y}. $ Questa operazione _non_ é commutativa ma é associativa.
- *potenza* di un linguaggio: dato $L subset.eq Sigma^*$ costruisco l'insieme $ L_k = underbracket(L dot.op dots dot.op L, k). $ Notiamo, usando l'induzione, come $ L^k = cases({epsilon} & "se" k = 0, L dot.op L^(k-1) quad & "altrimenti") quad . $

=== Chiusura di Kleene

La *chiusura di Kleene*, o _star_, é definita come $ L^* = union.big_(k gt.eq 0) L^k. $

In poche parole, la chiusura di Kleene rappresenta l'insieme di tutte le stringhe ottenute concatenando le parole di $L$, compresa la parola vuota $epsilon$.

L'insieme $L^*$ é sempre infinito, tranne quando:
- $L = {epsilon}$, ottenendo $L^* = {epsilon}$;
- $L = emptyset.rev$, ottenendo $L^* = {epsilon}$ per definizione.

La *chiusura positiva* $L^+$ é definita come $ L^+ = union.big_(k gt.eq 1) L^k. $

Se $epsilon in L$ la differenza tra chiusura e chiusura positiva non esiste, mentre se $epsilon in.not L$ si ottene $L^+ = L^* - {epsilon}$.

Si può dimostrare che $ L^+ = L dot.op L^* = L dot.op union.big_(k gt.eq 0) L^k = union.big_(k gt.eq 0) L^(k+1) = union.big_(k gt.eq 1) L^k. $

=== Definizione di espressione regolare

Le *espressioni regolari* sono un _modello dichiarativo_ per le grammatiche di tipo $3$, ovvero permettono di dichiarare la forma delle stringhe del linguaggio tramite una serie di operazioni.

Introduciamo una serie di coppie, dove il primo elemento rappresenta un'espressione nel mondo delle espressioni regolari e il secondo elemento rappresenta il linguaggio generato da quell'espressione:
- $emptyset.rev arrow.long$ linguaggio vuoto;
- $epsilon arrow.long {epsilon}$;
- $a in Sigma arrow.long {a}$;
- $E_1 + E_2 arrow.long L(E_1) union L(E_2)$;
- $E_1 dot.op E_2 arrow.long L(E_1) dot.op L(E_2)$;
- $E_1^* arrow.long [L(E_1)]^*$.

=== Teorema di Kleene

Vediamo il *teorema fondamentale degli automi a stati finiti* (o _teorema di Kleene_), che afferma la coincidenza tra la classe degli automi a stati finiti con la classe delle espressioni regolari.

#theorem()[
  La classe di linguaggi accettati da automi a stati finiti é il più piccolo sottoinsieme di $Sigma^*$ che contiene i linguaggi finiti ed é chiusa rispetto alle operazioni di $union, dot.op$ e $*$.
]

#theorem-proof()[
  \ Dimostriamo che a partire da un automa a stati finiti per $L$ possiamo trovare un'espressione regolare per lo stesso linguaggio $L$.

  Sia $A = (Q, Sigma, delta, q_1, F)$, con $Q = {q_1, dots, q_n}$. Accetto una parola se e solo se esiste un cammino nel grafo di computazione che finisce in uno stato finale.

  Chiamo $R_(i j)^((k))$ le espressioni che iniziano nello stato $q_i$, finiscono nello stato $q_j$ e visitano stati con indice $lt.eq k$: $ q_i arrow.long.squiggly q_(h lt.eq k) arrow.long.squiggly q_j. $

  Definiamo $R_(i j)^((0))$ l'insieme di tutte le lettere che mi portano da $q_i$ a $q_j$, quindi $ R_(i j)^((0)) = {a in Sigma bar.v delta(q_i, a) = q_j}. $

  Se $i = j$ allora $ R_(i j)^((0)) = {epsilon} union {a in Sigma bar.v delta(q_i, a) = q_i}. $

  Definiamo ora $R_(i j)^((k))$ sapendo tutte le espressioni fino a $R_(i j)^((k-1))$

  Evidenzio tutti i punti del cammino che passano per lo stato $q_k$: $ q_i arrow.long.squiggly_(lt.eq k-1) q_k arrow.long.squiggly_(lt.eq k-1) dots arrow.long.squiggly_(lt.eq k-1) q_k arrow.long.squiggly_(lt.eq k-1) q_j. $

  Ma allora $ R_(i j)^((k)) = R_(i j)^((k-1)) union (R_(i k)^((k-1)) dot.op R_(k k)^((k-1)) dot.op R_(k j)^((k-1))). $

  Il linguaggio $L$ viene definito come $ L = union.big_(q_i in F) "cammini dallo stato" 1 "allo stato" q_i = union.big_(q_i in F) R_(1 i)^((n)). $
]

=== Come costruire un'espressione regolare

Vediamo _come costruire un'espressione regolare a partire da un automa a stati finiti_ con un esempio.

#v(12pt)

#figure(image("assets-teoria/regex.svg", width: 50%))

#v(12pt)

Per scrivere un'espressione regolare dobbiamo scrivere un sistema di $n$ equazioni, dove $n = |Q|$. Ogni equazione $E_i$ descrive il linguaggio che l'automa riconoscerebbe se si partisse dallo stato $X_i$. Ogni equazione é una somma di fattori, ognuno formato da un simbolo di $Sigma$ e uno stato in $Q$. La presenza di un fattore del tipo $a X_j$ indica che dallo stato $X_i$ si finisce nello stato $X_j$ leggendo una $a$.

Scriviamo il sistema di equazioni per il DFA disegnato sopra, ricordandoci di aggiungere $epsilon$ in caso l'equazione $E_i$ descriva uno stato finale.

$ cases(X_0 = a X_1 + b X_0, X_1 = a X_2 + b X_0, X_2 = a X_2 + b X_1 + epsilon) quad . $

Risolviamo il sistema, introducendo una regola fondamentale: $ X = a X + B arrow.long X = a^* B. $ Questa ci permette di risolvere ogni sistema di equazioni che definisce un automa a stati finiti.

$ cases(X_0 = a (a X_2 + b X_0) + b X_0, X_2 = a X_2 + b (a X_2 + b X_0) + epsilon) quad . $

Raccogliamo $X_2$ nella seconda equazione e applichiamo la regola fondamentale precedente. $ & cases(X_0 = a a X_2 + (a b + b) X_0, X_2 = (a + b a) X_2 + b b X_0 + epsilon) \ & cases(X_0 = a a X_2 + (a b + b) X_0, X_2 = (a + b a)^* (b b X_0 + epsilon)) quad . $

Sostituiamo $X_2$ dentro $X_0$ e applichiamo ancora la regola fondamentale dopo aver raccolto ogni fattore che contiene $X_0$ nell'equazione. $ X_0 &= a a (a + b a)^* (b b X_0 + epsilon) + (a b + b) X_0 \ X_0 &= a a (a + b a)^* b b X_0 + a a (a + b a)^* + (a b + b) X_0 \ X_0 &= (a a (a + b a)^* b b + a b + b) X_0 + a a (a + b a)^* \ X_0 &= (a a (a + b a)^* b b + a b + b)^* (a a (a + b a)^*). $

= Studio della complessità

#let sc(linguaggio) = $op("sc")(linguaggio)$
#let nsc(linguaggio) = $op("nsc")(linguaggio)$

Sia $L subset.eq Sigma^*$, la *complessità di stati* di $L$ é il minimo numero di stati di un DFA che accetta $L$. La complessità di stati si indica con $sc(L)$.

In modo analogo, si definisce $nsc(L)$ la *complessità di stati non deterministica* come il minimo numero di stati di un NFA che accetta $L$.

Come sappiamo già, vale la relazione $ sc(L) lt.eq 2^nsc(L). $

In generale, ogni NFA ha almeno $n+1$ stati, dove $n$ é il numero di caratteri della stringa più corta del linguaggio.

/* FINE LEZIONE 07 */
