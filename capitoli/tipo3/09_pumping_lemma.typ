// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Pumping Lemma

Come facciamo a dimostrare che un linguaggio non è regolare? Che tecniche abbiamo?

Prima di tutto abbiamo il *criterio di distinguibilità*: se troviamo un insieme $X$ di parole distinguibili tra loro per un linguaggio $L$, allora ogni DFA per $L$ ha almeno $abs(X)$ stati. Come lo utilizziamo? Se $abs(X) = infinity$ allora servono un numero infinito di stati, cosa che negli automi a *stati finiti* non è possibile.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n bar.v n gt.eq 0} . $

  Gli automi a stati finiti *non sanno contare*, quindi non posso contare quante $a$ ci sono nella stringa e poi verificare lo stesso numero di $b$.

  Definiamo l'insieme $ X = {a^n bar.v n gt.eq 0} . $ Esso è formato da stringhe distinguibili tra loro: infatti, date due stringhe $x = a^i$ e $y = a^j$, per distinguerle utilizziamo la stringa $z = b^i$.
]<esempio-an-bn>

Un altro modo per dimostrare la non regolarità è far vedere che il linguaggio dato fa saltare qualche *proprietà di chiusura*.

#example()[
  Definiamo il linguaggio $ L = {w in {a,b}^* bar.v hash_a (w) = hash_b (w)} $ che palesemente non è regolare perché non posso contare, ma come lo dimostriamo?

  Con la *distinguibilità* possiamo usare lo stesso insieme $X$ di prima, ma facciamo finta di non saperlo fare.

  Sappiamo che i linguaggi regolari sono chiusi rispetto all'operazione di intersezione. Prendiamo quindi un linguaggio regolare e facciamo l'intersezione con $L$, ad esempio facciamo $ L inter a^* b^* . $

  Visto che $a^* b^*$ è un linguaggio regolare e l'intersezione chiude i linguaggi regolari, anche il linguaggio risultante deve essere regolare, ma questa intersezione genera il linguaggio dell'@esempio-an-bn, perché date tutte le stringhe con $a$ e $b$ uguali filtriamo tenendo solo quelle che hanno tutte le $a$ all'inizio e poi tutte le $b$.

  Visto che il linguaggio risultante non è regolare, non lo è nemmeno $L$.
]

== Definizione

L'ultimo metodo che abbiamo a disposizione è il *pumping lemma per i linguaggi regolari*.

#lemma([Pumping lemma per i linguaggi regolari])[
  Sia $L$ un linguaggio regolare. Allora esiste una costante $N$ tale che $forall z in L$, con $abs(z) gt.eq N$, possiamo scrivere $z$ come $ z = u v w $ con:
  + $abs(u v) lt.eq N$;
  + $v eq.not epsilon$;
  + $forall k gt.eq 0 quad u v^k w in L$.
]

Un po' *strano*: il succo di questo lemma è che se prendiamo delle stringhe lunghe prima o poi qualcosa si deve ripetere. Infatti, i tre punti ci dicono questo:
+ il primo ci dice che la parte che contiene la ripetizione è all'inizio e non è troppo lontana;
+ il secondo ci dice che effettivamente viene ripetuto qualcosa;
+ il terzo ci dice che possiamo ripetere all'infinito la parte centrale senza uscire dal linguaggio, ovvero possiamo fare *pumping*, pompare la stringa.

In poche parole, la scomposizione di $z$ avviene nei punti di ripetizione: $u$ è la parte prima della ripetizione, $v$ è la parte che viene ripetuta e $w$ è la parte dopo la ripetizione.

Questa è una *condizione necessaria*: se faccio vedere se un linguaggio falsifica questo lemma allora non è regolare, ma potrebbe non bastare questo per far vedere che un linguaggio non è regolare.

#lemma-proof()[
  Sia $A = (Q, Sigma, delta, q_0, F)$ un DFA per $L$. Sia $N = abs(Q)$.

  Prendiamo una stringa $z = a_1 dots a_m in L$ con $abs(z) gt.eq N$. Un qualsiasi cammino accettante per $z$ è nella forma $ q_0 = p_0 arrow.long^(a_1) p_1 arrow.long^(a_2) dots arrow.long^(a_m) p_m in F $ che attraversa $N + 1$ stati, ma noi avendone $N$ vuol dire che almeno uno stato lo stiamo visitando $2$+ volte.

  Ma allora esistono $i,j bar.v i < j$ tali che $p_i = p_j$. Andiamo a scomporre la nostra stringa $z$ come $z = u v w$ tali che $ u &= a_1 dots a_i \ v &= a_(i+1) dots a_j \ w &= a_(j+1) dots a_m . $

  Visto che $i < j$ allora la parte centrale ha almeno un elemento, quindi $v eq.not epsilon$.

  Inoltre, visto che $p_i = p_j$ vuol dire che partendo da $p_i$, leggendo la parte di stringa $v$, finiamo in $p_j$. Ma visto che $p_i = p_j$ allora è possibile ripetere un numero questo cammino un numero arbitrario di volte.

  Infine, per assunzione la lunghezza della stringa è $abs(z) = m gt.eq N$. Quando arriviamo all'$N$-esimo carattere abbiamo visto $N+1$ stati, ovvero sono già passato in uno stato ripetuto, quindi $abs(u v) lt.eq N$ perché la ripetizione deve avvenire entro la lettura dell'$N$-esimo carattere, che causa necessariamente il primo loop.
]

== Applicazioni

Vediamo come utilizzare il pumping lemma per dimostrare la non regolarità. Generalmente, faremo delle *dimostrazioni per assurdo*: assumendo la regolarità faremo vedere che esiste una stringa tale che ogni sua scomposizione fa cadere almeno uno dei punti del pumping lemma.

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
