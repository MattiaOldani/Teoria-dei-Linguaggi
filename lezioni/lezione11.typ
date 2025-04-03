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


// Lezione

= Lezione 11 [02/04]

== Reversal

Abbiamo già visto l'operazione di reversal applicato ad un linguaggio, ovvero dato $L$ regolare definiamo $ L^R = {w^R bar.v w in L} $ anch'esso regolare formato da tutte le stringhe di $L$ lette in senso opposto. In poche parole, se $w = a_1 dots a_n$ allora $w^R = a_n dots a_1$. Ovviamente, il reversal è *idempotente*, ovvero $ (L^R)^R = L . $

Cosa succede se applichiamo il reversal ad una *grammatica*?

Data una grammatica $G$ di tipo $2$ per $L$, come otteniamo una grammatica per $L^R$? Abbiamo scelto una grammatica di tipo $2$ perché le regole sono _"standard"_ nella forma $A arrow.long alpha$ con $alpha in (V union Sigma)^+$. Questa costruzione è facile: invertiamo ogni parte destra delle regole di derivazione, ovvero definiamo $ forall (A arrow.long alpha) quad "definiamo" A arrow.long alpha^R . $

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

Se prendiamo un linguaggio che è sia lineare a destra e a sinistra otteniamo le *grammatiche lineari*, che però generano di più rispetto alle grammatiche regolari.

== Algoritmo per automa minimo

Dato $M = (Q, Sigma, delta, q_0, F)$ un DFA senza stati irraggiungibili, costruiamo l'automa per il reversal del linguaggio accettato da $M$. Definiamo quindi l'automa $M^R = (Q, Sigma, delta^R, F, {q_0})$ definito dalla *funzione di transizione* $ delta^R (p, a) = {q bar.v delta(q,a) = p} . $

Questo automa, ovviamente, è NFA per via del non determinismo sulle transizioni e del non determinismo sugli stati iniziali multipli. A noi non piace, vogliamo ancora un DFA, quindi applichiamo la *costruzione per sottoinsiemi*.

Definiamo allora l'automa $N = sub(M^R)$ DFA ottenuto dalla *subset construction*, definito dalla tupla $(Q'', Sigma, delta'', q''_0, F'')$ tale che:
- $Q'' lt.eq 2^Q$ *insieme degli stati raggiungibili*, ovvero andiamo a rimuovere dall'automa tutti gli stati che sono irraggiungibili; con stati, ovviamente, ci stiamo riferendo ai vari sottoinsiemi;
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

  Partiamo con $A subset.eq B$. Sia $p in A$, allora, visto che tutti gli stati sono raggiungibili, esiste una stringa $w in Sigma^*$ tale che, nell'automa $M$, vale $ delta(q_0, w) = p . $ Per come abbiamo definito l'NFA per il reversal, allora $ q_0 in delta^R (p, w^R) . $ Usando invece il DFA, abbiamo che $ q_0 in delta''(A, w^R) $ perché abbiamo assunto che $p in A$. Ma allora $w^R$ è accettata da $N$ partendo da $A$.

  Ora, visto che $A$ e $B$ non sono distinguibili per ipotesi, la stringa $w^R$ è accettata da $N$ partendo anche da $B$, cioè $ q_0 in delta''(B, w^R) $ quindi esiste un elemento $p' in B$ tale che $ q_0 in delta^R (p', w^R) $ e quindi che $ delta(q_0, w) = p' . $

  L'automa è deterministico, quindi $p = p'$, e quindi che $p in B$, e quindi $ A subset.eq B . $

  La dimostrazione è analoga per la seconda inclusione.
]

Questa costruzione è un po' strana e contro quello che abbiamo sempre fatto: la costruzione per sottoinsiemi di solito fa esplodere il numero degli stati, mentre stavolta ci dà l'automa minimo per il reversal. Cosa possiamo fare con questo risultato?

#align(center)[
  #pseudocode-list(title: [Algoritmo di Brzozowski])[
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

Grazie all'*algoritmo di Brzozowski* noi abbiamo a disposizione un algoritmo di minimizzazione un po' strano dal punto di vista pratico che però ottiene l'automa minimo, anche se non è il più efficiente, ce ne sono di migliori.

#example()[
  Ci viene dato il DFA $K$ della seguente figura.

  #figure(image("assets/11_K.svg"))

  Notiamo subito che lo stato $q_2$ è ridondante. Andiamo a costruire $K^R$.

  #figure(image("assets/11_KR.svg"))

  Rendiamo DFA questo automa, e chiamiamolo $M$.

  #figure(image("assets/11_M.svg"))

  Facciamo il renaming, chiamando $A$ l'insieme iniziale e $B$ l'insieme finale. Rifacciamo ora la costruzione del reversal, ottenendo $M^R$.

  #figure(image("assets/11_MR.svg"))

  Infine, facciamo la costruzione per sottoinsiemi su $M^R$ ottenendo $N$.

  #figure(image("assets/11_N.svg"))
]

== Pumping Lemma

Come facciamo a dimostrare che un linguaggio non è regolare? Che tecniche abbiamo?

Prima di tutto abbiamo il *criterio di distinguibilità*: se troviamo un insieme $X$ di parole distinguibili tra loro per un linguaggio $L$, allora ogni DFA per $L$ ha almeno $abs(X)$ stati. Come lo utilizziamo? Se $abs(X) = infinity$ allora servono un numero infinito di stati, cosa che negli automi a *stati finiti* non è possibile.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n bar.v n gt.eq 0} . $

  Gli automi a stati finiti *non sanno contare*, quindi non posso contare quante $a$ ci sono nella stringa e poi verificare lo stesso numero di $b$.

  Definiamo l'insieme $X = {a^n bar.v n gt.eq 0}$. Esso è formato da stringhe distinguibili tra loro: infatti, dati $a^i$ e $a^j$ per distinguere utilizzo $z = b^i$.
]

Un altro modo per dimostrare la non regolarità è far vedere che il linguaggio dato fa saltare qualche proprietà di chiusura.

#example()[
  Definiamo il linguaggio $ L = {w in {a,b}^* bar.v hash_a (w) = hash_b (w)} $ che palesemente non è regolare perché non posso contare, ma come lo dimostro?

  Con la *distinguibilità* posso usare lo stesso insieme $X$ di prima, ma facciamo finta di non saperlo fare.

  Sappiamo che i linguaggi regolari sono chiusi rispetto all'operazione di intersezione. Prendiamo quindi un linguaggio regolare e facciamo l'intersezione con $L$, ad esempio facciamo $ L inter a^* b^* . $

  Visto che $a^* b^*$ è un linguaggio regolare e l'intersezione chiude i linguaggi regolari, anche il linguaggio risultante deve essere regolare, ma questa intersezione genera il linguaggio dell'esempio precedente, perché date tutte le stringhe con $a$ e $b$ uguali filtriamo tenendo solo quelle che hanno tutte le $a$ all'inizio e poi tutte le $b$.

  Visto che il linguaggio risultante non è regolare, non lo è nemmeno $L$.
]

L'ultimo metodo che abbiamo a disposizione è il *pumping lemma per i linguaggi regolari*.

#lemma([Pumping lemma per i linguaggi regolari])[
  Sia $L$ un linguaggio regolare. Allora esiste una costante $N$ tale che $forall z in L$, con $abs(z) gt.eq N$, possiamo scrivere $z$ come $ z = u v w $ con:
  + $abs(u v) lt.eq N$;
  + $v eq.not epsilon$;
  + $forall k gt.eq 0 quad u v^k w in L$.
]

Un po' strano: il succo di questo lemma è che se prendiamo delle stringhe lunghe prima o poi qualcosa si deve ripetere. Infatti, i tre punti ci dicono questo:
+ il primo punto ci dice che la parte che contiene la parte ripetuta è all'inizio e non è troppo lontana;
+ il secondo punto ci dice che effettivamente viene ripetuto qualcosa;
+ il terzo punto ci dice che possiamo ripetere all'infinito la parte centrale senza uscire dal linguaggio, appunto pumping, pompare.

In poche parole, la scomposizione di $z$ avviene nei punti di ripetizione: $u$ è la parte prima della ripetizione, $v$ è la parte che viene ripetuta e $w$ è la parte dopo la ripetizione.

Questa è una *condizione necessaria*: se faccio vedere se un linguaggio viola questo lemma allora non è regolare, ma potrebbe non bastare questo per far vedere che un linguaggio non è regolare.

#lemma-proof()[
  Sia $A = (Q, Sigma, delta, q_0, F)$ un DFA per $L$. Sia $N = abs(Q)$.

  Prendiamo una stringa $z = a_1 dots a_m in L$ con $abs(z) gt.eq N$. Un qualsiasi cammino accettante per $z$ è nella forma $ q_0 = p_0 arrow.long^(a_1) p_1 arrow.long^(a_2) dots arrow.long^(a_m) p_m in F $ che attraversa $N + 1$ stati, ma noi avendone $N$ vuol dire che almeno uno stato lo stiamo visitando $2$+ volte.

  Ma allora esistono $i,j bar.v i < j$ tali che $p_i = p_j$. Andiamo a scomporre la nostra stringa $z$ come $z = u v w$ tali che $ u &= a_1 dots a_i \ v &= a_(i+1) dots a_j \ w &= a_(j+1) dots a_m . $

  Visto che $i < j$ allora la parte centrale ha almeno un elemento, quindi $v eq.not epsilon$.

  Inoltre, visto che $p_i = p_j$ vuol dire che partendo da $p_i$, leggendo la parte di stringa $v$, finiamo in $p_j$. Ma allora è possibile ripetere un numero questo cammino un numero arbitrario di volte.

  Infine, per assunzione la lunghezza della stringa è $abs(z) = m gt.eq N$. Quando arriviamo all'$N$-esimo carattere abbiamo visto $N+1$ stati, ovvero sono già passato in uno stato ripetuto, quindi $abs(u v) lt.eq N$ perché la ripetizione deve avvenire prima dell'inizio dell'ultima parte della stringa.
]

Vediamo come utilizzare il pumping lemma per dimostrare la non regolarità. Generalmente, faremo delle dimostrazioni per assurdo: assumendo la regolarità faremo vedere che esiste una stringa tale che ogni sua scomposizione possibile fa cadere almeno uno dei punti del pumping lemma.

#example()[
  Definiamo il linguaggio $L = {a^n b^n bar.v n gt.eq 0}$.

  Per assurdo sia $L$ un linguaggio regolare. Sia $N$ la costante del pumping lemma. Definiamo la stringa $z = a^N b^N$ che rispetta la minima lunghezza delle stringhe. Infatti, $abs(z) = 2N gt.eq N$.

  Scriviamo ora $z$ come $z = u v w$. Deve valere il punto $1$, ovvero $abs(u v) lt.eq N$, ma questo implica che $u$ e $v$ sono formate da solo $a$, quindi $ u = a^i and v = a^j and w = a^(N-i-j) b^N quad bar.v quad j eq.not 0 $ perché deve valere $v eq.not epsilon$.

  Sappiamo inoltre che la ripetizione arbitraria di $v$ mi mantiene nel linguaggio, ovvero che $forall k gt.eq 0$ allora $u v^k w in L$ ma questo non è vero: se scegliamo $k = 0$ la stringa $u w$ non è più accettata perché essa è nella forma $ u w = a^i a^(N - i - j) b^N = a^(N -j) b^N $ e ovviamente $N - j eq.not N$, quindi $L$ non è regolare.
]

Facciamo un ultimo esempio dell'applicazione del pumping lemma.

#example()[
  Definiamo il linguaggio $ L = {a^(2^n) bar.v n gt.eq 0} = {a^(2^0), a^(2^1), dots} = {a, a a, a a a a, dots} $ insieme delle potenze di due scritte in unario.

  Questo ovviamente non è regolare. Come lo dimostriamo con il pumping lemma?

  Sia $N$ la costante del PL per $L$. Prendiamo una stringa di $L$ lunga almeno $N$, ovvero la stringa $z = a^(2^N)$ la cui lunghezza è $abs(z) gt.eq N$. Scomponiamo ora $z$ come $z = u v w$, cosa possiamo dire?

  Sappiamo che $v eq.not epsilon$, quindi $abs(v) gt.eq 1$.

  Inoltre, sappiamo della ripetizione arbitraria di $v$, quindi le stringhe $u v^k w$ devono stare in $L$. Cosa possiamo dire della lunghezza di questa stringa? Sappiamo che $ abs(u v^k w) = 2^N + abs(v) (k-1) = 2^N + j(k-1) =^(k = 2) 2^N + j < 2^(N+1) . $

  Che valore assume $j$? La potenza successiva è $2^(N+1)$ ma $j$ essendo un pezzo di $z$ è al massimo $2^N$ quindi $j < 2^N$ e quindi $2^N + j < 2^(N+1)$.

  Ma allora $L$ non è regolare.
]
