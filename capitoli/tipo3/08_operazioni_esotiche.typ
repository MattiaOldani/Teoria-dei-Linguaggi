// Setup

#import "../alias.typ": *

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


// Capitolo

= Operazioni esotiche e avanzate
<capitolo08-tipo3>

Riprendiamo il filo del @capitolo06-tipo3[Capitolo] e andiamo avanti con alcune *operazioni avanzate*.

== Reversal

Sia $L subset.eq Sigma^*$ un linguaggio. Chiamiamo $ L^R = {w^R bar.v w in L} $ il linguaggio delle stringhe ottenute *ribaltando* tutte le stringhe di $L$, ovvero $ w = a_1 dots a_n arrow.long.double w^R = a_n dots a_1 . $

Questa operazione sul linguaggio $L$ viene detta *reversal*.

#lemma()[
  L'operazione di reversal preserva la regolarità.
]

#lemma-proof()[
  Dimostriamo questo lemma usando le espressioni regolari. Per fare ciò partiamo con il dare delle espressioni regolari per le espressioni base.

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$(emptyset.rev)^R = emptyset.rev$], [$(epsilon)^R = epsilon$], [$(a)^R = a$],
  )

  Ora vediamo le espressioni regolari induttive.

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$(E_1 + E_2)^R = E_1^R + E_2^R$], [$(E_1 dot E_2)^R = E_2^R dot E_1^R$], [$(E^*)^R = (E^R)^*$],
  )

  Queste espressioni sono ancora regolari, quindi il reversal preserva la regolarità.
]

Possiamo dimostrare questo lemma anche usando gli *automi*. Supponiamo di avere un DFA $A = (Q, Sigma, delta, q_0, F)$ che riconosce $L$. Vogliamo trovare un automa $A'$ per $L^R$: questo è facile, basta mantenere la struttura dell'automa invertendo il senso delle transizioni, rendendo finale lo stato iniziale e rendendo iniziali tutti gli stati finali.

In poche parole, definiamo l'automa $ A' = (Q, Sigma, delta', F, {q_0}) $ definito dalla *funzione di transizione* $delta'$ tale che $ delta'(q,a) = {p bar.v delta(p, a) = q} . $ In poche parole, visto che abbiamo reversato le transizioni, dobbiamo vedere tutti gli stati $p$ che finivano in $q$ con $a$ per poter fare il *cammino inverso*.

=== DFA

Ci piace questa soluzione? *NO*: siamo partiti da un DFA e abbiamo ottenuto un NFA per via degli stati iniziali multipli $F$ e per il fatto che la funzione di transizione può mappare in più stati con la stessa lettera letta.

Se voglio ottenere un DFA devo fare il classicissimo salto esponenziale con la *costruzione per sottoinsiemi*. Con il reversal dell'automa non abbiamo cambiato il numero degli stati, quindi $ sc(L^R) lt.eq 2^(nsc(L^R)) . $

Possiamo fare di meglio o nel caso peggiore abbiamo questo salto esponenziale?

#example()[
  Prendiamo $ L = (a+b)^(n-1) a (a+b)^* $ il linguaggio che ha l'$n$-esimo simbolo da sinistra uguale ad una $a$, che riconosciamo con il seguente automa deterministico.

  #figure(image("assets/08/reversal.svg"))

  In questo caso, il numero di stati è $n+1$, visto che ne abbiamo $n$ all'inizio per eliminare gli $n-1$ caratteri iniziali e poi uno stato per verificare di avere una $a$.

  Il suo reversal è $L^R = L_n$, il linguaggio dell'$n$-esimo simbolo da destra uguale ad una $a$. Abbiamo visto che un NFA per $L_n$ ha $n+1$ stati mentre il DFA ha $2^n$ stati, visto che deve osservare finestre di $n$ caratteri consecutivi.
]

Il *gap esponenziale* non riusciamo purtroppo ad evitarlo.

#example()[
  Molto curiosa la situazione inversa: se partiamo da $L_n$ riconosciuto da un DFA di $2^n$ stati noi otteniamo un reversal $L_n^R = L$ che, minimizzato, ha $n+1$ stati (_escluso lo stato trappola_).
]

=== NFA

Se partiamo invece da un NFA, con la costruzione precedente manteniamo lo status di NFA, mantenendo inoltre il numero degli stati, quindi siamo contenti, ottenendo $ nsc(L^R) = nsc(L) . $

=== Reversal di una grammatica

Abbiamo già visto l'operazione di reversal applicato ad un linguaggio, ovvero dato $L$ regolare definiamo $ L^R = {w^R bar.v w in L} $ anch'esso regolare formato da tutte le stringhe di $L$ lette in senso opposto. In poche parole, se $w = a_1 dots a_n$ allora $w^R = a_n dots a_1$. Ovviamente, il reversal è *autoinverso*, ovvero $ (L^R)^R = L . $

Cosa succede se applichiamo il reversal ad una *grammatica*?

Data una grammatica $G$ di tipo $2$ per $L$, come otteniamo una grammatica per $L^R$? Abbiamo scelto una grammatica di tipo $2$ perché le regole sono _"standard"_ nella forma $A arrow.long alpha$ con $alpha in (V union Sigma)^+$. Questa costruzione è facile: invertiamo ogni parte destra delle regole di derivazione, ovvero $ forall (A arrow.long alpha) in P quad "definiamo" A arrow.long alpha^R . $

#example()[
  Data una grammatica per $L$ con regola di produzione $ A arrow.long a a A b B b , $ una grammatica per $L^R$ ha come regola di produzione $ A arrow.long b B b A a a . $
]

Prendiamo ora una grammatica di tipo $3$, che sappiamo essere capace di generare i linguaggi regolari, a meno della parola vuota. Le regole di produzione sono nella forma $ A arrow.long a B bar.v a . $

Avevamo visto due estensioni delle grammatiche regolari: una di queste è rappresentata dalle *grammatiche lineari a destra*, ovvero quelle grammatiche con regole di produzione $ A arrow.long w B bar.v w quad "tale che" w in Sigma^* . $ Avevamo anche dimostrato che queste grammatiche sono equivalenti alle grammatiche di tipo $3$ trasformando la stringa $w$ in una serie di derivazioni che rispettino le grammatiche regolari.

L'altra estensione sono le grammatiche *lineari a sinistra*, con regole di produzione $ A arrow.long B w bar.v w quad "tale che" w in Sigma^* . $

Cosa possiamo dire di queste?

#lemma()[
  Le grammatiche lineari a sinistra generano i linguaggi regolari.
]

#lemma-proof()[
  Partiamo da una $G$ lineare a sinistra e applichiamo il *reversal*: otteniamo una grammatica $G'$ lineare a destra, visto che applichiamo la trasformazione $ A arrow.long B w bar.v w quad arrow.long.double quad A arrow.long w B bar.v w . $

  Possiamo quindi dire che $ L(G') = (L(G))^R . $ Sappiamo che i linguaggi regolari sono chiusi rispetto all'operazione di reversal, quindi essendo $L(G')$ regolare allora anche $L(G)$ lo deve essere. Quindi anche le grammatiche lineari a sinistra generano i linguaggi regolari.
]

Se prendiamo un linguaggio che è sia lineare a destra e a sinistra otteniamo le *grammatiche lineari*, che però generano di più rispetto alle grammatiche regolari. Di queste grammatiche ne abbiamo già parlato nella parte finale del @capitolo04-tipo3[Capitolo].

=== Algoritmo per l'automa minimo

Dato $M = (Q, Sigma, delta, q_0, F)$ un DFA senza stati irraggiungibili, costruiamo l'automa per il reversal del linguaggio accettato da $M$. Definiamo quindi l'automa $M^R = (Q, Sigma, delta^R, F, {q_0})$ definito dalla *funzione di transizione* $ delta^R (p, a) = {q bar.v delta(q, a) = p} . $

Questo automa, ovviamente, è NFA per via del non determinismo sulle transizioni e del non determinismo sugli stati iniziali multipli. A noi non piace, vogliamo ancora un DFA, quindi applichiamo la *costruzione per sottoinsiemi*.

Definiamo allora l'automa $N = sub(M^R)$ DFA ottenuto dalla *subset construction*, definito dalla tupla $(Q'', Sigma, delta'', q''_0, F'')$ tale che:
- $Q'' lt.eq 2^Q$ *insieme degli stati raggiungibili*, ovvero andiamo a rimuovere dall'automa tutti gli stati che sono irraggiungibili. Con *stati*, ovviamente, ci stiamo riferendo ai vari sottoinsiemi;
- $delta''$ *funzione di transizione* tale che $ delta''(alpha, a) = union.big_(p in alpha) delta^R (p, a) ; $
- $q''_0 = F$ *stato iniziale* preso da $M^R$, che aveva già un insieme come stato iniziale;
- $F''$ *insieme degli stati finali* tale che $ F'' = {alpha in Q'' bar.v q_0 in alpha} $ perché per il reversal lo stato iniziale diventava finale.

Vediamo adesso un risultato abbastanza strano di questa costruzione.

#lemma()[
  $N$ è il DFA minimo per il reversal del linguaggio riconosciuto da $M$.
]

#lemma-proof()[
  Per prima cosa, dimostriamo che $N$ *riconosce* il reversal del linguaggio riconosciuto da $M$. Ma questo è banale: l'abbiamo fatto per costruzione, usando prima il reversal e poi la costruzione per sottoinsiemi.

  Dimostriamo quindi che $N$ è *minimo*. In un automa minimo, tutti gli stati sono distinguibili tra loro. Analogamente, al posto di dimostrare questo, possiamo fare vedere che $ forall A,B in Q'' quad A,B "non distinguibili" arrow.long.double A = B . $

  Assumiamo quindi che $A,B in Q''$ siano due stati non distinguibili e che allora vale $A = B$. Questi due stati sono sottoinsiemi derivanti dalla costruzione per sottoinsiemi, quindi per dimostrare l'uguaglianza di insiemi devo dimostrare che $ A subset.eq B and B subset.eq A . $

  Partiamo con $A subset.eq B$. Sia $p in A$, allora visto che tutti gli stati sono raggiungibili esiste una stringa $w in Sigma^*$ tale che, nell'automa $M$, vale $ delta(q_0, w) = p . $ Per come abbiamo definito l'NFA per il reversal, allora $ q_0 in delta^R (p, w^R) . $ Usando invece il DFA, abbiamo che $ q_0 in delta''(A, w^R) $ perché abbiamo assunto che $p in A$. Ma allora $w^R$ è accettata da $N$ partendo da $A$.

  Ora, visto che $A$ e $B$ non sono distinguibili per ipotesi, la stringa $w^R$ è accettata da $N$ partendo anche da $B$, cioè $ q_0 in delta''(B, w^R) $ quindi esiste un elemento $p' in B$ tale che $ q_0 in delta^R (p', w^R) $ e quindi che $ delta(q_0, w) = p' . $

  L'automa è deterministico, quindi $p = p'$, e quindi che $p in B$, e quindi $ A subset.eq B . $

  La dimostrazione è analoga per la seconda inclusione.
]

Questa costruzione è un po' strana e contro quello che abbiamo sempre fatto: la costruzione per sottoinsiemi di solito fa esplodere il numero degli stati, mentre stavolta ci dà l'automa minimo per il reversal. Cosa possiamo fare con questo risultato?

#align(center)[
  #pseudocode-list(title: [*Algoritmo di Brzozowski*])[
    - Sia $K$ un DFA per il linguaggio $L$ senza stati irraggiungibili
    + Costruiamo $K^R$ NFA per $L^R$
    + Costruiamo $M = sub(K^R)$ DFA per $L^R$
    + Costruiamo $M^R$ NFA per $(L^R)^R = L$
    + Costruiamo $N = sub(M^R)$ DFA per $L$
  ]
]

#theorem()[
  $N$ è l'automa minimo per $L$.
]

#theorem-proof()[
  La dimostrazione è una conseguenza del lemma precedente: la prima coppia reversal+subset costruisce l'automa minimo per $L^R$, mentre la seconda coppia reversal+subset costruisce l'automa minimo per $(L^R)^R = L$.
]

Grazie all'*algoritmo di Brzozowski* noi abbiamo a disposizione un *algoritmo di minimizzazione* un po' strano dal punto di vista pratico che però ottiene l'automa minimo, anche se non è il più efficiente, ce ne sono di migliori.

#example()[
  Ci viene dato il DFA $K$ della seguente figura.

  #figure(image("assets/08/K.svg"))

  Notiamo subito che lo stato $q_2$ è ridondante. Andiamo a costruire $K^R$.

  #figure(image("assets/08/KR.svg"))

  Rendiamo DFA questo automa, e chiamiamolo $M$.

  #figure(image("assets/08/M.svg", width: 75%))

  Facciamo il renaming, chiamando $A$ l'insieme iniziale e $B$ l'insieme finale. Rifacciamo ora la costruzione del reversal, ottenendo $M^R$.

  #figure(image("assets/08/MR.svg"))

  Infine, facciamo la costruzione per sottoinsiemi su $M^R$ ottenendo $N$.

  #figure(image("assets/08/N.svg"))
]

== Shuffle

L'operazione di *shuffle*, applicata a due stringhe, le prende e le mescola, mantenendo l'ordine dei caratteri mentre le mischiamo. In poche parole, possiamo pensare di avere due *mazzieri*, ognuno dei quali tiene una stringa come lista ordinata (non lessicograficamente, ma proprio come è stata scritta) dei suoi caratteri. Ad ogni iterazione scegliamo a quale mazziere chiedere un carattere, e lo aggiungiamo alla stringa finale.

Come vediamo, l'inserimento che facciamo *non è atomico*: posso chiedere al mazziere che voglio ad ogni iterazione, l'unica cosa che mi viene chiesta è di mantenere l'ordine.

#example()[
  Date le stringhe $#text(fill: red)[$a a b b$]$ e $#text(fill: blue)[$b$]$, possiamo ottenere le stringhe

  #grid(
    columns: (20%, 20%, 20%, 20%, 20%),
    align: center + horizon,
    inset: 10pt,
    [#text(fill: blue)[$b$]#text(fill: red)[$a a b b$]],
    [#text(fill: red)[$a$]#text(fill: blue)[$b$]#text(fill: red)[$a b b$]],
    [#text(fill: red)[$a a$]#text(fill: blue)[$b$]#text(fill: red)[$b b$]],
    [#text(fill: red)[$a a b$]#text(fill: blue)[$b$]#text(fill: red)[$b$]],
    [#text(fill: red)[$a a b b$]#text(fill: blue)[$b$]],
  )

  Ovviamente, le ultime tre stringhe sono uguali e vanno considerate come stringa unica.
]

#example()[
  Date le stringhe $#text(fill: red)[$a a b b$]$ e $#text(fill: blue)[$a b$]$, possiamo ottenere molte stringhe con lo shuffle. Ne vediamo un paio per vedere la non atomicità dell'operazione.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [#text(fill: blue)[$a$]#text(fill: red)[$a$]#text(fill: blue)[$b$]#text(fill: red)[$a b b$]],
    [#text(fill: red)[$a a$]#text(fill: blue)[$a$]#text(fill: red)[$b$]#text(fill: blue)[$b$]#text(fill: red)[$b$]],
  )
]

L'operazione di shuffle, se la applichiamo ai *linguaggi* $L'$ e $L''$, è il linguaggio di tutte le stringhe ottenute tramite shuffle di una stringa di $L'$ con una stringa di $L''$. Ovviamente prendiamo tutte le possibili coppie di stringhe per ottenere il linguaggio completo.

=== Alfabeti disgiunti

Consideriamo due DFA $A'$ e $A''$ per i due linguaggi appena definiti. Il caso più semplice di automa per lo shuffle parte con gli alfabeti per i due linguaggi *disgiunti*, ovvero $L'$ definito sul'alfabeto $Sigma' = {a,b}$ e $L''$ definito sull'alfabeto $Sigma'' = {c,d}$.

Prendiamo spunto dall'*automa prodotto*: uniamo i due automi e ne mandiamo avanti uno alla volta in base al carattere che leggiamo. Definiamo quindi $ A = (Q, Sigma, delta, q_0, F) $ tale che:
- gli *stati* sono tutte le possibili coppie di stati dei due automi, ovvero $ Q = Q' times Q'' ; $
- lo *stato iniziale* è formato dai due stati iniziali base, ovvero $ q_0 = (q'_0, q''_0) ; $
- l'*alfabeto* è l'unione dei due alfabeti di base, ovvero $ Sigma = Sigma' union Sigma'' ; $
- la *funzione di transizione*, in base al carattere che legge, deve mandare avanti uno dei due automi e mantenere l'altro nello stesso stato, ovvero $ delta((q,p), x) = cases((delta'(q,x), p) & "se" x in Sigma', (q, delta''(p,x)) quad & "se" x in Sigma'') quad ; $
- gli *stati finali* sono tutte le coppie formate da stati finali, perché devo riconoscere sia la prima che la seconda stringa, ovvero $ F = {(q,p) bar.v q in F' and p in F''} . $

Il numero di stati di questo automa è il prodotto del numero di stati dei due automi, ovvero $ sc(shuffle(L', L'')) = sc(L') dot sc(L'') . $

Abbiamo considerato solo il caso in cui $A'$ e $A''$ sono DFA. Per il caso non deterministico, basta modificare leggermente la funzione di transizione ma il numero di stati rimane invariato.

=== Stesso alfabeto

Se invece i due linguaggi sono definiti sullo stesso alfabeto $Sigma$ come ci comportiamo? Dobbiamo fare affidamento sul *non determinismo*: dobbiamo scommettere se il carattere che abbiamo letto deve mandare avanti il primo automa o il secondo automa. Tra tutte le possibili computazioni ce ne deve essere una che termina in una coppia di stati entrambi finali. Se nessuna computazione termina in uno stato accettabile allora rifiutiamo la stringa data.

Se partiamo da due DFA otteniamo un NFA con un numero di stati uguale al prodotto degli stati dei due automi iniziali. Questa situazione non ci piace, quindi torniamo in un DFA facendo un salto esponenziale con la costruzione per sottoinsiemi, quindi $ sc(shuffle(L', L'')) lt.eq 2^(nsc(shuffle(L', L''))) . $

Invece, se partiamo da due NFA otteniamo ancora un NFA, quindi la situazione ci piace. Il numero di stati l'abbiamo già definito ed è uguale a $ nsc(shuffle(L', L'')) = nsc(L') dot nsc(L'') . $

=== Alfabeto unario

Infine, se i due linguaggi sono definiti sull'*alfabeto unario*, ovvero $ L',L'' subset.eq {a}^* $ l'operazione di shuffle collassa banalmente l'operazione di *prodotto*, perché alla fine stiamo facendo shuffle su stringhe che sono formate sempre da una e una sola lettera, quindi non conta come le mischiamo ma conta la lunghezza finale della stringa che ci esce.

== Raddoppio

Sia $L$ regolare, definiamo l'operazione $alpha$ tale che $ alpha(L) = {x in Sigma^* bar.v x x in L} . $

#example()[
  Dato il linguaggio $L = {a^n b^n bar.v n gt.eq 0}$ allora $ alpha(L) = {epsilon} . $

  Dato invece il linguaggio $L = a^*$ allora $ alpha(L) = a^* . $

  Infine, dato il linguaggio $L = {a^n bar.v n "pari"}$ allora $ alpha(L) = a^* . $
]

Se $L$ è regolare, riesco a dimostrare che anche $alpha(L)$ è regolare? Abbiamo a disposizione un automa $A$ per $L$, vogliamo sapere se il mio input, raddoppiato, viene accettato da $L$.

Come possiamo ragionare? Vogliamo cercare un cammino che fa da $q_0$ a $q_f in F$ leggendo la stringa $x x$. Nell'automa $A$, leggendo $x$, finiamo in uno stato $p$: dobbiamo cercare di indovinare questo $p$ per far partire la computazione una seconda volta e arrivare in $q_f in F$.

L'idea è quindi di scommettere lo stato che raggiungiamo con $A$ leggendo $x$, e poi mandare in parallelo due copie di $A$, uno dall'inizio e uno dallo stato indovinato.

Formalizziamo questo automa. Dato $A = (Q, Sigma, delta, q_0, F)$ DFA per $L$, costruiamo l'automa $ A' = (Q', Sigma, delta', I', F') $ tale che:
- l'*insieme degli stati* $Q = Q^3$ è formato da triple $ [p, q', q''] $ dove:
  - $p$ è lo stato che abbiamo scommesso di raggiungere con $x$ in $A$;
  - $q'$ è lo stato che portiamo avanti in $A$ a partire da $q_0$;
  - $q''$ è lo stato che portiamo avanti in $A$ a partire da $p$;
- l'*insieme degli stati iniziali* (multipli) $ I' = {[p, q_0, p] bar.v p in Q} $ dove scommettiamo un qualunque stato $p$ come stato intermedio;
- l'*insieme degli stati finali* $ F' = {[p,p,q] bar.v q in F} $ formato da tutti gli stati dove l'automa $A$ finisce in $p$ nella computazione iniziale e finisce in uno stato finale nella computazione da $p$
- la *funzione di transizione* $delta'$ è tale che $ delta'([p,q',q''], a) = [p, delta(q', a), delta(q'', a)] $ che manda avanti i due automi in parallelo.

Purtroppo, quello che otteniamo è un *NFA* per via di tutti gli stati iniziali multipli.

== Metà

Un'altra operazione strana che vediamo prende un linguaggio regolare $L$ e calcola $ 1 / 2 L = {x in Sigma^* bar.v exists y bar.v abs(y) = abs(x) and x y in L} . $

In poche parole, prendo le stringhe di $L$ di lunghezza pari e prendo la prima metà di queste.

#example()[
  Dato il linguaggio $L = {a^n b^n bar.v n gt.eq 0}$ allora $ 1 / 2 L = a^* . $
]

Si può dimostrare che questa operazione *mantiene la regolarità*, ma come facciamo? Possiamo ricondurre questo problema a quello precedente, variando un po' la seconda computazione.

In questo caso facciamo molte più scommesse: al posto di mandare avanti in parallelo i due automi, con la scommessa sullo stato intermedio $p$, qua mandiamo avanti il primo automa normalmente e il secondo lo mandiamo avanti non deterministicamente prendendo ogni simbolo possibile di $Sigma$. Infatti, la stringa $y$ è randomica, la dobbiamo inventare noi.

Cambia quindi la *funzione di transizione* $delta'$, che prende ancora la tripla dello stato ma ora:
- mantiene invariato lo stato scommessa;
- manda avanti deterministicamente il primo automa;
- per ogni carattere di $Sigma$ fa partire una computazione con quel carattere.

Quello che otteniamo è un *turbo NFA*, se non volessimo utilizzarlo? Abbiamo rappresentazioni alternative che ci bypassano il non determinismo?

== Automi come matrici

Possiamo rappresentare gli automi come *matrici di adiacenza*: esse sono matrici indicizzate, su righe e colonne, dagli stati dell'automa, e ogni cella è un valore booleano che viene posto a $1$ se e solo se abbiamo una transizione dallo stato riga allo stato colonna.

Queste matrici sono dette *matrici di transizione*, e rappresentano le transizioni che possiamo fare all'interno dell'automa. Queste matrici possono essere anche *associate ad una lettera* di $Sigma$, e queste rappresentano le transizioni che possono essere fatte nell'automa con quella lettera. Se invece le matrici sono *associate ad una stringa* rappresentano le transizioni che possono essere fatte nell'automa leggendo quella stringa, ma queste le vedremo meglio dopo.

Il *numero di possibili matrici* che possiamo costruire è finito: esso è $2^(n times n)$, con $n = abs(Q)$. Questa informazione ci servirà dopo per costruire degli automi.

#example()[
  Costruiamo le matrici di transizione del seguente automa.

  #figure(image("assets/08/esempio_matrice.svg"))

  Andiamo a calcolare le due matrici di transizione delle lettere $a$ e $b$.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$ M_a = mat(0, 1, 0; 0, 0, 1; 1, 0, 0) $], [$ M_b = mat(1, 0, 0; 0, 0, 1; 0, 1, 0) $],
  )

  Ovviamente, se l'automa è un *DFA* abbiamo un solo $1$ per ogni riga.

  Se calcoliamo $M_a M_b$ otteniamo la matrice che ci dice in che stato finiamo leggendo $a b$ in base allo stato di partenza che scegliamo. Infatti: $ M_(a b) = M_a M_b = mat(0, 1, 0; 0, 0, 1; 1, 0, 0) mat(1, 0, 0; 0, 0, 1; 0, 1, 0) = mat(0, 0, 1; 0, 1, 0; 1, 0, 0) $ che indica esattamente gli stati che raggiungiamo leggendo la stringa $a b$.

  Possiamo banalmente estendere questa moltiplicazione ad una stringa generica $w = a_1 dots a_n$, calcolando la matrice $M_w$ come $ M_w = M_(a_1) dots.c M_(a_n) . $
]

Queste matrici ci danno informazioni molto interessanti: ogni riga ci dice in che stato possiamo arrivare partendo dallo stato della riga leggendo una certa sequenza di caratteri. Come possiamo utilizzare questa matrice a nostro vantaggio?

=== Prima applicazione: raddoppio

Riprendiamo l'operazione $alpha$: possiamo utilizzare le matrici per risolvere questo problema evitando il non determinismo. Se noi avessimo $M_x$ sarebbe molto facile rispondere a $x x in L$:
- prendiamo la riga dello stato iniziale $q_0$ e vediamo la colonna $p$ che contiene l'$1$ della riga;
- prendiamo la riga $p$ e vediamo la colonna $q_f$ che contiene l'$1$ della riga;
- verifichiamo se $q_f in F$.

Con queste tabelle è molto facile risolvere $alpha$: ce le teniamo nello stato e mano a mano costruiamo l'automa con le tabelle nuove, e poi alla fine verifichiamo quello scritto sopra.

Definiamo quindi l'automa $ A' = (Q', Sigma, delta', q'_0, F') $ tale che:
- l'*insieme degli stati* tiene tutte le possibili matrici booleane con indici in $Q$, ovvero $ Q' = {0,1}^(abs(Q) times abs(Q)) ; $
- lo *stato iniziale* è la matrice identità $I_(abs(Q))$ perché all'inizio non viene letto niente (viene letta $epsilon$) e quindi non ci spostiamo dallo stato nel quale siamo;
- la *funzione di transizione* $delta'$ è tale che $ delta'(M,a) = M M_a ; $
- l'*insieme degli stati finali* contiene tutti gli stati che hanno delle matrici con le proprietà descritte all'inizio della sezione, ovvero $ F' = {M bar.v exists p in Q bar.v M[q_0,p] = 1 and exists q in F bar.v M[p,q] = 1} . $

Sicuramente questo è un automa a stati finiti: il numero di matrici, anche se esponenziale, è comunque un numero finito. Inoltre, questo automa che otteniamo è DFA, a differenza del precedente.

=== Seconda applicazione: metà

Torniamo ora sull'operazione $1 / 2 L$: come possiamo fare questo con le matrici definite poco fa? Se prima le matrici per entrambi gli automi erano le stesse, qua la seconda parte, visto che viene inventata, si riduce ad un problema di *raggiungibilità del grafo*.

Quello che faremo è mandare avanti il primo automa deterministicamente e il secondo invece verrà rappresentato dalle potenze della *matrice dell'automa* per vedere la raggiungibilità. Qua con matrice dell'automa intendiamo la prima versione che abbiamo definito della matrice.

La matrice dell'automa la otteniamo come somma booleana di tutte le matrici $M_x$ associate al carattere $x in Sigma$. Facendo poi la potenza $k$-esima di questa matrice riusciamo a vedere la raggiungibilità dopo aver letto $k$ simboli.

Definiamo quindi l'automa $ A' = (Q', Sigma, delta', q'_0, F') $ tale che:
- l'*insieme degli stati* è formato da tutte le coppie $ Q' = Q times {0,1}^(abs(Q) times abs(Q)) $ dove la prima componente rappresenta lo stato dell'automa che viene mandato avanti deterministicamente e il secondo rappresenta tutte le potenze della matrice dell'automa;
- lo *stato iniziale* parte dallo stato iniziale e dalla matrice identità, ovvero $ q'_0 = (q_0, I_abs(Q)) ; $
- la *funzione di transizione* $delta'$ è tale che $ delta'([q,K], a) = (delta(q, a), K M) ; $
- l'*insieme degli stati finali* contiene tutte le coppie dove la matrice, osservata nella riga definita dalla prima componente, contiene un $1$ in una colonna di uno stato finale, ovvero $ F' = {[p,K] bar.v exists q in F bar.v K[p,q] = 1} . $

Il numero di stati è considerevole, considerando anche il prodotto cartesiano, ma abbiamo ottenuto un DFA, che invece prima non avevamo.

=== Matrici su NFA

Per ora abbiamo calcolato la matrice delle transizioni dei DFA, che succede se abbiamo un *NFA*? Ovviamente, in un NFA, avendo la possibilità di fare delle computazioni parallele, nella riga di una matrice associata ad una lettera possiamo avere più valori a $1$.

Calcolando però le potenze della matrice dell'automa cosa otteniamo?

#example()[
  Dato il seguente automa divertiamoci con qualche matrice.

  #figure(image("assets/08/matrice_NFA.svg"))

  Le matrici di transizione associate alle lettere $a$ e $b$ sono:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$ M_a = mat(1, 1; 0, 1) $], [$ M_b = mat(0, 0; 1, 1) $],
  )

  Proviamo a calcolare la matrice $M_(a a)$ calcolandola con la somma intera: $ M_(a a) = mat(1, 1; 0, 1) mat(1, 1; 0, 1) = mat(1, 2; 0, 1) . $

  Questa matrice non rappresenta più la raggiungibilità con una matrice booleana, ma *conta il numero di cammini* che abbiamo nell'automa per raggiungere quello stato. Usando la somma booleana invece avremmo ancora la matrice che definisce la raggiungibilità.

  I numeri che vediamo scritti nella tabella sono i *gradi di ambiguità* delle varie stringhe (_se ci limitiamo a quelle accettate_): questo rappresenta appunto il numero di modi in cui possiamo arrivare a quella stringa partendo dallo stato che indicizza la riga. Il *grado di ambiguità del grafo* è il massimo grado di ambiguità delle stringhe accettate.
]

== Quoziente
<paragrafo-quoziente>

Finiamo la carrellata di operazioni esotiche con il *quoziente tra linguaggi*.

Dati due linguaggi $L_1$ e $L_2$ definiamo l'operazione $ L_1 slash L_2 = {x in Sigma^* bar.v exists y in L_2 bar.v x y in L_1} . $ In poche parole, prendiamo tutte le stringhe nella forma $x y$ di $L_1$ e andiamo a togliere il suffisso $y$ che però dobbiamo trovare in $L_2$.

#example()[
  Ci vengono dati i seguenti linguaggi.

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$L_1 = a^+ b c^+$], [$L_2 = b c^+$], [$L_3 = c^+$],
  )

  Calcoliamo i possibili quozienti di questi linguaggi.

  #table(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$L_1 slash L_2$], [$L_1 slash L_3$], [$L_2 slash L_3$],
    [$a^+$], [$a^+ b c^*$], [$b c^*$],
  )
]

Dato un automa $M = (Q, Sigma, delta, q_0, F)$ che riconosce il linguaggio regolare $L_1$, possiamo costruire un automa $M' = (Q, Sigma, delta, q_0, F')$ tale che $ F' = {q in Q bar.v exists y in L_2 bar.v delta(q, y) in F} . $

In poche parole, rendiamo *finali* tutti gli stati dai quali, leggendo una stringa di $L_2$, riusciamo a finire in uno stato finale del primo automa.

#grid(
  columns: (50%, 50%),
  align: center + horizon,
  inset: 10pt,
  [#figure(image("assets/08/pre.svg"))], [#figure(image("assets/08/post.svg"))],
)

Questo automa $M'$ che abbiamo appena definito calcola il quoziente, ovvero $ L(M') = L_1 slash L_2 . $

#lemma()[
  Dati due linguaggi $L_1$ e $L_2$, con $L_1 in Reg$, allora $ L_1 slash L_2 $ è *regolare* per ogni possibile linguaggio $L_2$.
]

Non abbiamo studiato la *complessità* in stati di questa operazione, però possiamo intuire facilmente (credo) che DFA e NFA mantengono lo stesso numero di stati, quindi $ sc(L_1 slash L_2) = nsc(L_1 slash L_2) = sc(L_1) . $
