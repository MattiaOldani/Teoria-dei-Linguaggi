// Setup

#import "template.typ": project

#show: project.with(title: "Teoria dei linguaggi")

#import "@preview/lemmify:0.1.5": *

#let (
  theorem,
  lemma,
  corollary,
  remark,
  proposition,
  example,
  proof,
  rules: thm-rules,
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true,
)

#pagebreak()

// Appunti

/* INIZIO LEZIONE 05 */

== Numero di stati

La domanda sorge spontanea: _quale é il minimo numero di stati necessari affinché un DFA per un dato linguaggio L riconosca una parola?_

=== Distinguibilità

Dato un linguaggio $L subset.eq Sigma^*$, due parole $x,y in Sigma^*$ sono *distinguibili* rispetto ad $L$ se $exists z in Sigma^*$ tale che $(x z in L and y z in.not L) or (x z in.not L and y z in L)$.

#theorem()[
  Siano $L subset.eq Sigma^*$ un linguaggio e $X subset.eq Sigma^*$ tale che ogni coppia di parole in $X$ é distinguibile rispetto ad $L$, allora ogni DFA per $L$ deve avere almeno $|X|$ stati.
]<thm>

#proof[
  \ Supponiamo che l'insieme $X$ sia $X = {x_1, dots, x_k}$ di cardinalità $k$. Definiamo l'automa $A = (Q, Sigma, delta, q_0, F)$ tale che $delta(q_0, x_i) = p_i quad forall i in [1,k].$

  #figure(image("assets-teoria/dfa-inizio.svg", width: 40%))

  Per assurdo sia $|Q| < k$, ma allora $exists i,j in [1,k]$ tali che $i eq.not j$ e $delta(q_0, x_i) = p_i = p_j = delta(q_0, x_j)$. Questo vale perché avendo meno stati del numero di elementi da "mappare" almeno due elementi finiscono nello stesso stato.

  Ma $x_i$ e $x_j$ sono due parole distinguibili: allora $exists z in Sigma^*$ tale che $x_i z in L and x_j z in.not L$ (o viceversa).

  #figure(image("assets-teoria/dfa-assurdo.svg", width: 50%))

  Ma questo é assurdo: infatti, $x_i$ e $x_j$ sono due parole distinguibili che però finiscono in uno stato che deve essere sia finale che non finale.

  Allora $|Q| gt.eq k$.
]<proof>

La costruzione dell'insieme $X$ é molto utile per dimostrare che alcuni linguaggi non possono essere di tipo 3: infatti, se si riesce a costruire un insieme $X$ tale che $|X| = +infinity$ allora si dimostra che un dato linguaggio non é riconoscibile da un DFA.

Vediamo un esempio: sia $L_n = {x in {a,b}^* bar.v "il simbolo di" x "in posizione " n "da destra é una " a}$. Il più semplice DFA utilizza $2^n$ stati, ovvero tutte le possibili finestre di lunghezza $n$, mentre il più semplice NFA utilizza $n+1$ stati.

Come costruiamo un insieme $X$ la cui cardinalità ci faccia da lower-bound?

Sia $X = {a,b}^n = {w in {a,b}^+ bar.v |w| = n}$ e siano $x,y in X$ tali che $x eq.not y$, ma allora $exists i in [1,n]$ tale che $x_i eq.not y_i$, ovvero $ x = x_1 dots & x_i dots x_n \ & eq.not \ y = y_1 dots & y_i dots y_n. $

Per semplicità sia $x_i = a$ e $y_i = b$. Aggiungiamo ora $i-1$ caratteri in coda alle parole, che per semplicità saranno delle $a$. $ x = x_1 dots & a dots x_n a^(i-1) \ y = y_1 dots & b dots y_n a^(i-1). $

I caratteri dopo la posizione $i$ diventano $(n-i) + (i-1) = n-1$, spostando i caratteri $x_i$ e $y_i$ nella posizione $n$-esima da destra, ma per come li avevamo definiti essi sono diversi, quindi le due parole sono distinguibili.

=== Da DFA a NFA

L'*automa di Meyer e Fischer* é un NFA molto importante ideato nel 1971 per dare un lower-bound al numero di stati necessari per rappresentare un DFA a partire da un NFA di $n$ stati.

#v(12pt)

#figure(image("assets-teoria/meyer-fischer.svg", width: 60%))

#v(12pt)

L'automa viene chiamato $M_n$ ed é formato da:
- $Q = {0, dots, n-1}$;
- $Sigma = {a,b}$;
- $q_0 = 0$;
- $F = {0}$.

La funzione di transizione é definita come $ delta(i,a) &= {i+1} \ delta(i,b) &= cases(emptyset.rev & "se" i eq.not 0, {i,0} quad & "se" 1 lt.eq i lt n) quad . $

Prima della dimostrazione effettiva vediamo un paio di proprietà molto importanti di questo automa.

Sia $S subset.eq {0, dots, n-1}$, definiamo la parola $ w_s = cases(b & "se" S = emptyset.rev, a^i & "se" S = {i}, a^(e_k - e_(k-1)) b a^(e_(k-1) - e_(k-2)) b dots b a^(e_2 - e_1) b a^(e_1) quad & "se" S = {e_k, dots, e_1} "insieme ordinato e" k gt.eq 2) quad . $

#proposition[
  $forall S subset.eq {0, dots, n-1} quad delta(0, w_s) = S$.
]

#proposition[
  Dati $S,T subset.eq {0, dots, n-1}$, se $S eq.not T$ allora $w_s$ e $w_t$ sono distinguibili.
]

#proof[
  \ Sia $x in S \\ T$ numero intero che appartiene a $S$ ma non a $T$. \ Sappiamo che $delta(0, w_s) = S$ per la proprietà precedente e che $x in S$, ma allora $ 0 arrow.long.squiggly^(w_s) x arrow.long.squiggly^(a^(n-x)) 0. $ Sappiamo inoltre che $delta(0, w_t) = T$ per la proprietà precedente e che $x in.not T$. Sia $y in T$, ma allora $ 0 arrow.long.squiggly^(w_t) y arrow.long.squiggly^(a^(n-x)) U. $ L'insieme $U$ non contiene $0$ perché l'unico modo per finire in $0$ é aggiungere un numero di $a$ uguale a $n-y$, ma sappiamo che $n-x eq.not n-y$ per come sono stati definiti $x$ e $y$.
  \ Ma allora la stringa $a^(n-x)$ distingue $w_s$ e $w_t$.
]<proof>

Ora possiamo dimostrare il seguente teorema.

#theorem()[
  Sia $A$ un NFA per $L$ di $n$ stati, allora $A'$ DFA per $L$ ha almeno $2^n$ stati.
]<thm>

#proof[
  \ Sia $S subset.eq {0, dots, n-1}$, l'insieme degli stati di $A$. Definisco l'insieme $ X = {w_s bar.v S subset.eq {0, dots, n-1}}. $ Questo insieme ha cardinalità $2^n$: infatti, é formato da tutte le stringhe $w_s$ generate da $S$ sottoinsieme di ${0, dots, n-1}$ di $n$ elementi, ma tutti i possibili sottoinsiemi di un insieme di $n$ elementi sono $2^n$. \ Per la seconda proprietà le stringhe $w_s in X$ sono tutte distinguibili, ma allora per il teorema precedente $A'$ deve avere almeno $2^n$ stati.
]<proof>

== Estensioni

=== $epsilon$-mosse

Le *$epsilon$-mosse* sono una possibile estensione degli automi a stati finiti che permettono transizioni sulla parola vuota, ovvero permettono di spostarsi da uno stato all'altro senza leggere un carattere dal nastro.

Sono utili nei compilatori quando é possibile definire gli interi positivi senza il segno _più_.

#v(12pt)

#figure(image("assets-teoria/segno.svg", width: 50%))

#v(12pt)

Questa estensione non aumenta però la potenza espressiva dell'automa: infatti, ogni sequenza del tipo $ p arrow.long.squiggly^epsilon p' arrow.long^a q' arrow.long.squiggly^epsilon q $ può essere tradotta nella transizione $p arrow.long^a q$.

=== Stati iniziali multipli

L'ultima estensione che vediamo é quella degli *stati iniziali multipli*: al posto di avere un singolo stato iniziale abbiamo un insieme di stati dai quali poter iniziare.

Anche questa estensione non aumenta la potenza espressiva dell'automa: infatti, la funzione di transizione partirà direttamente con un insieme di stati e non da un insieme con un solo stato.

== Equivalenza tra linguaggi di tipo 3 e automi a stati finiti

Dimostriamo che dato l'automa $A$ per $L$ possiamo costruire una costruire una grammatica $G$ di tipo $3$ tale che $L(A) = L(G)$.

#theorem()[
  Le grammatiche di tipo $3$ sono equivalenti agli automi a stati finiti.
]<thm>

#proof[
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
]<proof>

== Esempi

Vediamo qualche esempio notevole.

=== $L_n$

Sia $L_n = {x in {a,b}^+ bar.v x "contiene due simboli uguali a distanza" n}$.

Con $n = 3$, la stringa $a b a b b a$ appartiene a $L_n$. Costruiamo un NFA per questo linguaggio con $n = 3$.

#v(12pt)

#figure(image("assets-teoria/ln.svg", width: 60%))

#v(12pt)

Questo NFA ha $2n+2$ stati, un DFA quanti stati avrebbe? Cerchiamo di costruire un insieme $X$ di stringhe distinguibili per dare un lower bound al numero di stati.

Sia $X = {a,b}^n$ e siano $x,y in X$ tali che $x eq.not y$, ma allora $exists i in [1,n]$ tale che $x_i eq.not y_i$ rappresenta la prima cifra diversa delle due parole: $ x = x_1 dots & x_i dots x_n \ & eq.not \ y = y_1 dots & y_i dots y_n. $ Le prime $i-1$ cifre sono tutte uguali, allora se prendo la stringa $z = overline(x_1) dots overline(x_(i-1)) a$ ogni stringa in $X$ diventa distinguibile: infatti, prendendo il complemento di ogni cifra evitiamo che le prime $i-1$ cifre _"matchino"_ quelle inserite. Inserendo una $a$ in fondo a $z$ andiamo ad accettare solo $x$ o solo $y$, in base a quale parole ha la cifra $i$-esima uguale ad $a$.

La cardinalità di questo insieme é $2^n$, quindi ogni DFA per $L$ ha almeno $2^n$ stati.

=== $L_n '$

Sia $L_n ' = {x in {a,b}^+ bar.v "ogni coppia di simboli a distanza" n "contiene due simboli uguali"}$.

Notiamo subito come valga la relazione $L_n ' subset L_n$.

Con $n = 3$, la stringa $a b b a b b a$ appartiene a $L_n '$. In poche parole, $x in L$ se e solo se $exists w in {a,b}^n$, $exists y$ prefisso di $w$ e $exists k gt.eq 0$ tali che $x = w^k y$.

Costruiamo un DFA per questo linguaggio con $n = 2$, visto che con $n=3$ il numero di stati esplode, ma di questo ne parleremo dopo.

#v(12pt)

#figure(image("assets-teoria/ln-primo.svg", width: 60%))

#v(12pt)

Il numero di stati di questo DFA é $2^(n+1)-1 + 2^(n+1)$.

Riusciamo a fare meglio con un NFA? La risposta é no: gli NFA _"lavorano male"_ quando si parla di _"ogni"_, mentre _"lavorano bene"_ quando si parla di _"esiste"_.

Questo perché se si parla di _"esiste"_ dobbiamo fare una singola scommessa, mentre se si parla di _"ogni"_ dobbiamo fare molte più scommesse.

== Fooling set

Cerchiamo di fare, come per i DFA con l'insieme $X$ di stringhe distinguibili, un lower bound al numero di stati di un NFA.

=== Definizione

Diamo la definizione di *fooling set*, o _insieme di ingannatori/imbroglioni_.

Sia $L subset.eq Sigma^*$, l'insieme di coppie $P subset.eq Sigma^* times Sigma^* = {(x_i, y_i) bar.v x_i,y_i in Sigma^* and i in [1,n]}$ é un fooling set per $L$ se e solo se:
+ $x_i y_i in L quad forall i in [1,n]$;
+ $x_i y_j in.not L quad forall i.j in [1,n] and i eq.not j$.

Esiste una versione rilassata del fooling set, detta *extended fooling set*, che mantiene la proprietà $1$ ma sostituisce la proprietà $2$ con:
2. $x_i y_j in.not L or x_j y_i in.not L quad forall i.j in [1,n] and i eq.not j$.

In questo caso, prese due coppie, basta che _almeno un incrocio_ non appartenga a $L$, mentre nel primo caso _entrambi gli incroci_ non appartengono a $L$.

#theorem()[
  Siano $L subset.eq Sigma^*$ e $P$ extended fooling set per $L$, allora ogni NFA per $L$ ha almeno $|P|$ stati.
]<thm>

#proof[
  \ Sia $A = (Q, Sigma, delta, q_0, F)$ NFA per $L$, consideriamo le parole $x_i y_i$ formate dalla concatenazione dei valori contenuti nelle coppie di $P$ e consideriamo i cammini accettanti di queste parole.

  #v(12pt)

  #figure(image("assets-teoria/fooling-inizio.svg", width: 50%))

  #v(12pt)

  Per assurdo sia $|Q| < n$, ma allora $exists i,j in [1,n]$ tali che $p_i = p_j$.

  #v(12pt)

  #figure(image("assets-teoria/fooling-assurdo.svg", width: 50%))

  #v(12pt)

  Ma questo é assurdo: infatti, a partire dallo stesso stato $p_i = p_j$ finiamo in due stati entrambi finali, ma essendo $P$ un extended fooling set per la proprietà $2$ almeno una tra le parole $x_i y_j$ e $x_j y_i$ non deve essere accettata.

  Allora abbiamo dimostrato che $|Q| gt.eq n$.
]<proof>

=== Applicazione a $L_n '$

Cerchiamo di definire un extended fooling set per l'insieme $L_n '$.

Definiamo l'insieme $P = {(x,x) bar.v x in {a,b}^n}$. Questo é un extended fooling set per $L_n '$ perché:
+ $x x in L_n '$;
+ $x y in.not L_n ' or y x in.not L_n '$.

La seconda proprietà vale perché essendo $x eq.not y$ esiste almeno una coppia di caratteri a distanza $n$ che non é uguale.

Ma allora ogni NFA per $L_n '$ ha almeno $|P| = 2^n$ stati.

=== Applicazione a $L_k$

L'ultimo esempio al quale applichiamo il concetto di extended fooling set é il linguaggio $ L_k = {0^i 1^i 2^i bar.v 0 lt.eq i lt.eq k}. $

Vediamo il caso $k = 3$ e creiamo un NFA per questo linguaggio.

#v(12pt)

#figure(image("assets-teoria/lk.svg", width: 100%))

#v(12pt)

Diamo un lower bound al numero di stati di un NFA generico. Definiamo l'insieme $ P = {(0^i 1^(j), 1^(i-j) 2^i) bar.v 0 lt.eq i lt.eq k and 0 lt.eq j lt.eq i}. $

Questo é un extended fooling set per $L_k$, quindi ogni NFA per $L_k$ ha almeno $|P| = (k+1)^2$ stati.

/* FINE LEZIONE 05 */

/* INIZIO LEZIONE 06 */

== Espressioni regolari

=== Operazioni insiemistiche

Sia $L subset.eq Sigma^*$ un linguaggio. Essendo un insieme, possiamo utilizzare le classiche operazioni di:
- intersezione $sect.big$;
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
]<thm>

#proof[
  \ Dimostriamo che a partire da un automa a stati finiti per $L$ possiamo trovare un'espressione regolare per lo stesso linguaggio $L$.

  Sia $A = (Q, Sigma, delta, q_1, F)$, con $Q = {q_1, dots, q_n}$. Accetto una parola se e solo se esiste un cammino nel grafo di computazione che finisce in uno stato finale.

  Chiamo $R_(i j)^((k))$ le espressioni che iniziano nello stato $q_i$, finiscono nello stato $q_j$ e visitano stati con indice $lt.eq k$: $ q_i arrow.long.squiggly q_(h lt.eq k) arrow.long.squiggly q_j. $

  Definiamo $R_(i j)^((0))$ l'insieme di tutte le lettere che mi portano da $q_i$ a $q_j$, quindi $ R_(i j)^((0)) = {a in Sigma bar.v delta(q_i, a) = q_j}. $

  Se $i = j$ allora $ R_(i j)^((0)) = {epsilon} union {a in Sigma bar.v delta(q_i, a) = q_i}. $

  Definiamo ora $R_(i j)^((k))$ sapendo tutte le espressioni fino a $R_(i j)^((k-1))$

  Evidenzio tutti i punti del cammino che passano per lo stato $q_k$: $ q_i arrow.long.squiggly_(lt.eq k-1) q_k arrow.long.squiggly_(lt.eq k-1) dots arrow.long.squiggly_(lt.eq k-1) q_k arrow.long.squiggly_(lt.eq k-1) q_j. $

  Ma allora $ R_(i j)^((k)) = R_(i j)^((k-1)) union (R_(i k)^((k-1)) dot.op R_(k k)^((k-1)) dot.op R_(k j)^((k-1))). $

  Il linguaggio $L$ viene definito come $ L = union.big_(q_i in F) "cammini dallo stato" 1 "allo stato" q_i = union.big_(q_i in F) R_(1 i)^((n)). $
]<proof>

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

== Studio della complessità

#let sc(linguaggio) = $op("sc")(linguaggio)$
#let nsc(linguaggio) = $op("nsc")(linguaggio)$

Sia $L subset.eq Sigma^*$, la *complessità di stati* di $L$ é il minimo numero di stati di un DFA che accetta $L$. La complessità di stati si indica con $sc(L)$.

In modo analogo, si definisce $nsc(L)$ la *complessità di stati non deterministica* come il minimo numero di stati di un NFA che accetta $L$.

Come sappiamo già, vale la relazione $ sc(L) lt.eq 2^nsc(L). $

In generale, ogni NFA ha almeno $n+1$ stati, dove $n$ é il numero di caratteri della stringa più corta del linguaggio.

/* FINE LEZIONE 06 */
