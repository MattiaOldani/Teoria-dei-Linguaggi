// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@local/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp


// Lezione

= Lezione 19 [14/05]

== Ambiguità

Per parlare di ambiguità ci servirà il *lemma di Ogden*, ma in una forma leggermente diversa.

#lemma([Lemma di Ogden])[
  Sia $G = (V, Sigma, P, S)$ una grammatica CF. Allora $exists N$ tale che $forall z in L$ in cui sono marcate almeno $N$, possiamo scrivere $z$ come $z = u v w x y$ con:
  + $v w x$ contiene al più $N$ posizioni marcate;
  + $v x$ contiene almeno una posizione marcata;
  + $exists A in V$ tale che
    - $S arrow.stroked^* u A y$,
    - $A arrow.stroked^* v A x$,
    - $A arrow.stroked^* w$,
    e dunque $forall i gt.eq 0 quad u v^i w x^i y in L(G)$.
]

Abbiamo una differenza sostanziale con il lemma dell'altra volta: in quest'ultimo ci veniva detto $L$ è CF, mentre ora stiamo dicendo che la grammatica lo è, e dalla grammatica noi siamo in grado di ricavare il linguaggio, quindi è una condizione più forte di quella di prima.

Questo inoltre vale per ogni grammatica CF e non solo per quelle in FN di Chomsky.

#lemma-proof()[
  La dimostrazione cambia leggermente dalla scorsa volta.

  Visto che possiamo avere nodi interni con più di due figli, sia $d$ il numero massimo di elementi sul lato destro di una produzione. Come costante prendiamo $ N = d^(k+1) $ e poi la dimostrazione va avanti allo stesso modo.
]

Riprendiamo l'esempio che abbiamo visto la lezione scorsa per il discorso sull'ambiguità.

#example()[
  Definiamo il linguaggio $ L = {a^p b^q c^r bar.v p = q or q = r} . $

  Un automa a pila per $L$ all'inizio scommette quale condizione verificare con il non determinismo usando una grammatica in due parti:
  - una genera stringhe con $hash_a = hash_b$ e con un numero di $c$ qualsiasi;
  - una fa lo stesso ma con $hash_b = hash_c$ e con un numero di $a$ qualsiasi.

  Avevamo visto poi le definizioni di *grado di ambiguità di una stringa* e di un *linguaggio*.
]<linguaggio-i-ambiguo>

Avere tanti alberi di derivazione è scomodo, nei compilatori soprattutto, perché ho più espressioni per lo stesso concetto, e questo dà molto fastidio.

Possiamo togliere l'ambiguità da un linguaggio? Ovvero, data $G$ una grammatica ambigua per $L$, riusciamo a trovarne un'altra che generi ancora $L$ ma non ambigua?

In generale la risposta è *NO*: esistono linguaggi che hanno solo grammatiche ambigue che li generano, e sono detti *linguaggi inerentemente ambigui*.

#theorem()[
  Il linguaggio $L$ dell'@linguaggio-i-ambiguo è inerentemente ambiguo.
]

#theorem-proof()[
  Dobbiamo dimostrare che ogni grammatica $G$ che genera $L$ è ambigua, quindi esiste almeno una stringa in ogni $G$ che è generata in almeno due modi.

  Sia $G = (V, Sigma, P, S)$ una grammatica per $L$. Vogliamo dimostrare che $exists beta in L$ che ammette due alberi di derivazione differenti. Useremo il lemma di Ogden molte volte.

  Sia $N$ la costante del lemma di Ogden per $G$, e sia $m = max(3, N)$.

  Definiamo la stringa $ z = a^m b^m c^(m + m!) $ in cui andiamo a marcare tutte le $a$, così ho marcato almeno $N$ posizioni.

  Decomponiamo poi $z$ come $z = u v w x y$ e utilizziamo la terza proprietà, quindi scegliamo come moltiplicatore $i = 2$ generando la stringa $ alpha = u v^2 w x^2 y in L . $

  Di questa stringa sappiamo che $ hash_b (alpha) = hash_b (z) + hash_b (v x) lt.eq m + m = 2m <^(m gt.eq 3) m + m! < hash_c (alpha) . $

  Noi sappiamo che $alpha in L$, quindi se $b$ e $c$ sono diverse allora sono uguali le altri due lettere: $ hash_a (alpha) = hash_b (alpha) . $

  Partendo da una stringa con $a$ e $b$ uguali, visto che abbiamo ottenuto ancora una stringa con la stessa proprietà, allora abbiamo aggiunto lo stesso numero di $a$ e di $b$, quindi $ hash_a (v w) = hash_b (v w) . $

  Questa proprietà, che abbiamo appena dimostrato per $i = 2$, diventa una proprietà della decomposizione che abbiamo fatto prima.

  Sfruttiamo la seconda condizione: sapendo di avere almeno una posizione marcata, e che queste sono solo $a$, possiamo dire che $ hash_a (v x) gt.eq 1 arrow.long.double hash_b (v w) gt.eq 1 . $

  Vediamo in dettaglio come è fatta $v x$: se $v$ e $x$ contengono almeno due lettere diverse stiamo perdendo la struttura della stringa, perché $v^2$ o $x^2$ rompono il pattern.

  Mettiamoci quindi nel caso in cui $v = a^j$ è formata da sole $a$ e $x = b^j$ è formata da sole $b$, imponendo inoltre che $1 lt.eq j lt.eq m$.

  Riprendiamo la terza condizione, considerando stringhe generiche nella forma $ forall i gt.eq 0 quad u v^i w x^i y = a^(m + (i-1)j) b^(m + (i-1)j) c^(m + m!) in L . $

  Vogliamo una stringa con $hash_a = hash_b = hash_c$, e questo lo facciamo imponendo $ (i-1)j = m! arrow.long.double i = frac(m!, j) + 1 $ e questa divisione è intera per la condizione imposta sulla $j$.

  Con questa imposizione otteniamo la stringa $ beta = a^(m + m!) b^(m + m!) c^(m + m!) in L . $

  Sempre grazie alla terza condizione possiamo vedere gli alberi di derivazione di questa stringa:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$S$ $u$ $A$ $y$]",
      )
    ],
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$A$ $v$ $A$ $x$]",
      )
    ],
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$A$ $$ $$ $$ $w$ $$ $$ $$]",
      )
    ],
  )

  L'albero di derivazione di $beta$ è formato dal primo albero, poi ha ripetuto $i$ volte quello centrale, e infine ha usato l'ultimo albero come tappo per terminare.

  Mettiamo da parte questi risultati per adesso. Prendiamo ora $z' = a^(m + m!) b^m c^m$ in cui marchiamo tutte le $c$. Facciamo poi la decomposizione di $z'$ come $z' = u' v' w' x' y'$.

  Ripetiamo la dimostrazione appena fatta, ma ragionando sulla seconda parte della stringa.

  Quello che otteniamo è che:
  - i fattori $v'$ e $x'$ di $z'$ sono formati rispettivamente dalle sole $b$ e dalle sole $c$, ovvero sono le stringhe $ v' = b^k and x' = c^k bar.v 1 lt.eq k lt.eq m ; $
  - possiamo pompare la stringa $z'$ ottenendo una stringa con $hash_a = hash_b = hash_c$, ovvero $ i = frac(m!, k) + 1 arrow.long.double beta = a^(m + m!) b^(m + m!) c^(m + m!) in L . $

  Come prima, vediamo gli alberi di derivazione di questa stringa:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$S$ $u'$ $A'$ $y'$]",
      )
    ],
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$A'$ $v'$ $A'$ $x'$]",
      )
    ],
    [
      #syntree(
        child-spacing: 2em,
        layer-spacing: 2em,
        "[^$A'$ $$ $$ $$ $$ $w'$ $$ $$ $$ $$]",
      )
    ],
  )

  Se costruiamo l'albero totale di $beta$ ora uniamo la parte esterna, $i$ volte la parte interna e infine il tappo, ma questo albero è diverso da quello di prima perché qua stiamo pompando le $b$ e le $c$, mentre prima pompavamo le $a$ e le $b$.

  Ma allora abbiamo due alberi diversi per la stessa stringa, quindi $G$ è ambigua. Visto che abbiamo preso una grammatica $G$ generica, allora ogni $G$ per $L$ è ambigua, e quindi $L$ è inerentemente ambiguo.
]

Nel caso del linguaggio @linguaggio-i-ambiguo, il *grado di ambiguità* è $2$. In alcuni casi, il grado di ambiguità cresce in base alla lunghezza della stringa che si sta riconoscendo, rendendo di fatto *infinito* il grado della grammatica e/o del linguaggio.

Il concetto di ambiguità è importante perché parlare di ambiguità nelle grammatiche è equivalente a parlare di ambiguità negli *automi a pila*.

Avevamo visto che potevamo trasformare una grammatica $G$ in un PDA simulando con quest'ultimo le derivazioni leftmost. Ecco, questa trasformazione riesce a mantenere il grado di ambiguità $k$ della grammatica $G$. Vale anche il viceversa: infatti, possiamo trasformare un PDA che riconosce una stringa in $k$ modi diversi in una grammatica con grado di ambiguità $k$ usando una costruzione leggermente diversa della nostra, che invece aumentava e non di poco il grado di ambiguità.

== Ambiguità e non determinismo

L'ambiguità è legata parzialmente anche al discorso del *non determinismo*.

Se una stringa può essere generata in due modi diversi allora l'automa è in grado di riconoscerla in due modi diversi, quindi l'automa è per forza non deterministico.

In poche parole, se abbiamo una grammatica $G$ *ambigua* per il linguaggio $L$, allora $L$ deve essere riconosciuto per forza da un automa non deterministico.

Riprendiamo velocemente la definizione di *automi a pila*. Essi sono delle tuple $ M = (Q, Sigma, Gamma, delta, q_0, Z_0, F) $ definiti da una funzione di transizione $ delta : Q times (Sigma union {epsilon}) times Gamma arrow.long PF(Q times Gamma^*) . $

Avevamo già visto la definizione di *PDA deterministico*, ma riprendiamola.

#definition([PDA deterministico])[
  Il PDA $M$ è *deterministico* se:
  + $forall q in Q quad forall A in Gamma quad delta(q, epsilon, A) eq.not emptyset.rev arrow.long.double forall a in Sigma quad delta(q, a, A) = emptyset.rev$;
  + $forall q in Q quad forall A in Gamma quad forall sigma in Sigma union {epsilon} quad abs(delta(q, sigma, A)) lt.eq 1$.
]

In poche parole, le due condizioni ci dicono che:
+ se nello stato definito dalla coppia stato-pila abbiamo delle $epsilon$-mosse allora non possiamo anche leggere un carattere dal nastro;
+ la dimensione dell'immagine della funzione di transizione è al massimo $1$.

Abbiamo visto due diverse *accettazioni* per gli automi a pila, e abbiamo dimostrato che nel caso non deterministico queste sono equivalenti. Nella trasformazione da stati finali a pila vuota, ogni volta che si finiva in uno stato finale si scommetteva di aver finito l'input svuotando la pila, ma lo facendo non deterministicamente. La trasformazione da pila vuota a stati finali invece ogni volta che svuotava la pila andava in uno stato finale, ma questo non introduceva non determinismo perché facevamo una pura simulazione e aggiungevamo regole che non interferivano tra loro.

Sappiamo inoltre che i CFL sono *equivalenti* ai PDA. Cosa possiamo dire dei CFL deterministici?

Definiamo la classe *DCFL* classe dei *linguaggi CF deterministici*, equivalente ai *DPDA* (PDA deterministici) che accettano per *stati finali*. Abbiamo specificato l'accettazione perché nel caso deterministico non abbiamo la stessa accettazione: con una pila vuota infatti andiamo ad accettare meno linguaggi. Addirittura ci sono dei *linguaggi regolari* che non riusciamo ad accettare.

#example()[
  Definiamo il linguaggio regolare $ L = a (a a)^* $ che possiamo riconoscere tranquillamente con un DFA a due stati.

  Abbiamo un DPDA che accetta per pila vuota. Prendiamo la stringa $z = a a a$. L'automa è programmato per riconoscere le stringhe di lunghezza pari, quindi appena legge la prima $a$ si deve fermare per accettare, ma questo non accade perché si pianta svuotando la pila ma con ancora dell'input da leggere.
]

In generale, una struttura con stringhe prefisse di altre non riesce ad essere riconosciuta da DPDA per pila vuota. Come vediamo, è una classe particolare, con alcuni regolari e alcuni CF.

Nei parser il trucco è mettere un marcatore alla fine per indicare all'automa di svuotare la pila.

La questione dell'ambiguità si collega al non determinismo. Infatti, se $L$ è un CFL ed è anche *inerentemente ambiguo*, allora ogni PDA per $L$ deve essere non deterministico, quindi $ L in CFL slash DCFL . $

Questa affermazione mostra che i CFL sono diversi dai DCFL, e che questi sono meno potenti perché alcuni linguaggi non li possono proprio riconoscere.

Negli automi a stati finiti avevamo la *costruzione per sottoinsiemi* per rimuovere il non determinismo. Con gli automi a pila non possiamo utilizzare questa costruzione perché avendo una sola pila non riusciamo a tenere traccia di tutto quello che viene fatto su essa.

Breve *OT*: se abbiamo due pile il modello diventa potente quanto le macchine di Turing.

Ma vale anche il viceversa? Ovvero dato un automa non deterministico allora abbiamo per forza un linguaggio o una grammatica ambigua?

#example()[
  Sia $L$ il linguaggio delle palindrome pari, ovvero $ L = {w w^R bar.v w in {a,b}^*} . $

  Questo linguaggio non è deterministico, ma non l'abbiamo ancora dimostrato, vedremo.

  Anche se gli automi per questo linguaggio sono non deterministici, mi va bene una sola scommessa se la stringa è palindroma, quindi non abbiamo ambiguità.

  Vediamo una grammatica $G$ per $L$: $ S arrow.long a S a bar.v b S b bar.v epsilon . $

  Come vediamo, $G$ non è ambigua, e infatti nemmeno $L$ lo è.
]

#example()[
  Vediamo il complemento del linguaggio precedente, ovvero il linguaggio delle stringhe nelle quali esiste almeno una posizione alla stessa distanza dai bordi in cui i caratteri sono diversi.

  #figure(image("assets/19_lc.svg", width: 75%))

  Ovviamente questo è non deterministico: dobbiamo scommettere su un simbolo che non ci piace $sigma$, far passare un po' di stringa, trovare il suo compare $gamma$, controllare che sono diversi e vedere se la distanza dalla fine è uguale a quella tra il primo e l'inizio.

  Un automa a pila per questo linguaggio carica sulla pila delle $X$, arrivando ad altezza $i$ a $sigma$, poi scorre lasciando stare la pila, infine controlla $sigma$ con $gamma$ e inizia a scaricare. In poche parole, usiamo la pila come contatore.

  Questo automa è ovviamente ambiguo perché ci possono essere più coppie possibili che rendono vera l'accettazione della stringa.

  Possiamo evitare l'ambiguità in questo automa?

  Dobbiamo scegliere la *scommessa giusta*, ovvero dobbiamo verificare di avere una parte iniziale $i$ poi la stessa $i$ alla fine ma rovesciata. Per indovinare subito la prima posizione che non va bene sulla pila non salviamo più la distanza, ma quello che leggiamo. Dopo un po' scommettiamo, arriviamo alla fine, controlliamo e svuotiamo.

  Con questo magheggio riusciamo a renderlo non ambiguo, perché l'automa fa tante scommesse ma riesce a beccare solo la prima posizione sbagliata, perché le parti prima e dopo saranno invece uguali.
]

#example()[
  Per sfizio scriviamo $L^C$ in termini di grammatica.

  Abbiamo una posizione che è fallata, quindi prima inseriamo qualcosa di uguale ai bordi, poi inseriamo l'elemento sbagliato, e poi aggiungiamo quello che vogliamo.

  Le regole di produzione sono $ S &arrow.long a S a bar.v b S b bar.v T \ T &arrow.long a U b bar.v b U a \ U &arrow.long a U bar.v b U bar.v epsilon . $
]
