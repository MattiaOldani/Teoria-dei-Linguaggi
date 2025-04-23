// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Automa minimo

Negli scorsi capitoli abbiamo visto dei metodi che limitavano il numero di stati di DFA e NFA per un certo linguaggio. In questo capitolo vediamo invece un criterio che lavora direttamente sugli automi e non sui linguaggi.

// Prima: ho linguaggio, limite
// Ora: ho automa, limite

== Introduzione matematica

#definition([Relazione binaria])[
  Sia $S$ un insieme. Una *relazione binaria* sull'insieme $S$ è definita come l'insieme $ R subset.eq S times S . $
]

Come notazione useremo $ rel(x,R,y) $ oppure $(x,y) in R$, molto di più la prima che la seconda.

Ci interessiamo ad un tipo molto particolare di relazioni.

#definition([Relazione di equivalenza])[
  La relazione $R$ è una *relazione di equivalenza* se e solo se $R$ è:
  - *riflessiva*, ovvero $forall x in S quad rel(x, R, x)$;
  - *simmetrica*, ovvero $forall x,y in S quad rel(x, R, y) arrow.long.double rel(y, R, x)$;
  - *transitiva* $forall x,y,z in S quad rel(x, R, y) and rel(y, R, z) arrow.long.double rel(x, R, z)$.
]

Una relazione di equivalenza *induce* sull'insieme $S$ una *partizione* formata da *classi di equivalenza*. Queste classi sono formate da elementi che sono equivalenti tra di loro. Le classi di equivalenza le indichiamo con $[x]_R$, dove $x in S$ è detto *rappresentante* (_credo_).

Se $R$ è una relazione di equivalenza, l'*indice* di $R$ è il numero di classi di equivalenza.

#example()[
  Sia $S = NN$. Definiamo la relazione $R subset.eq NN times NN$ tale che $ rel(x, R, y) sse x mod 3 = y mod 3 . $

  Questa è una relazione di equivalenza (_non lo dimostriamo_) che ha tre classi di equivalenza:
  - $[0]_R$ formata da tutti i multipli di $3$;
  - $[1]_R$ formata da tutti i multipli di $3$ sommati a $1$;
  - $[2]_R$ formata da tutti i multipli di $3$ sommati a $2$.

  L'indice di questa relazione è quindi $3$.
]

#definition([Relazione invariante a destra])[
  Sia $dot$ un'operazione sull'insieme $S$. La relazione $R$ è *invariante a destra* rispetto a $dot$ se presi due elementi nella relazione $R$, e applicando $dot$ con uno stesso elemento, otteniamo ancora due elementi in relazione, ovvero $ rel(x, R, y) arrow.long.double forall z in S quad rel((x dot z), R, (y dot z)) . $
]

#example()[
  Sia $R$ la relazione dell'esempio precedente. Definiamo $dot = +$ l'operazione di somma. La relazione $R$ è invariante a destra?

  Dobbiamo verificare se $ rel(x, R, y) arrow.long.double forall z in NN quad rel((x + z), R, (y + z)) , $ ovvero se $ x mod 3 = y mod 3 arrow.long.double forall z in NN quad (x + z) mod 3 = (y + z) mod 3 . $

  Questo è vero perché ce lo dice l'algebra modulare, quindi $R$ è invariante a destra.
]

Ora vediamo una definizione che va contro la semantica italiana.

#definition([Raffinamento])[
  Sia $S$ un insieme e siano $R_1, R_2 subset.eq S times S$ due relazioni di equivalenza su $S$.

  Diciamo che $R_1$ è un *raffinamento* di $R_2$ se e solo se:
  + ogni classe di equivalenza di $R_1$ è contenuta in una classe di equivalenza di $R_2$ *OPPURE*
  + ogni classe di $R_2$ è l'unione di alcune classi di $R_1$ *OPPURE*
  + vale $ forall x,y in S quad (x,y) in R_1 arrow.long.double (x,y) in R_2 . $
]

Il primo punto è la definizione, le altre sono solo conseguenze.

Perché non rispecchia molto la semantica italiana? Perché un raffinamento di solito è qualcosa di migliore, in questo caso invece è il contrario: se $R_1$ è un raffinamento di $R_2$ allora $R_1$ è peggiore di $R_2$ in termini di classi di equivalenza.

#example()[
  Data la relazione $R$ di prima, definiamo ora la relazione $R'$ tale che $ rel(x, R', y) sse x mod 2 = y mod 2 . $

  Le classi di equivalenza di questa relazione sono $[0]_R'$ e $[1]_R'$.

  Come è messa $R$ rispetto a $R'$? E $R'$ rispetto a $R$?

  Nessuna delle due è un raffinamento dell'altra: ci sono elementi sparsi un po' qua e là quindi non riusciamo a unire le classi di una nelle classi dell'altra.

  Sia invece $R''$ la relazione tale che $ rel(x, R'', y) sse x mod 6 = y mod 6 . $

  La relazione $R''$ ha $6$ classi di equivalenza con le varie classi di resto da $0$ a $5$.

  Come è messa $R'$ rispetto a $R''$? E $R''$ rispetto a $R'$?

  Possiamo dire che $R''$ è un raffinamento di $R'$: infatti, la classe $[0]_R'$ la possiamo scrivere come $ union.big_(i "pari") [i]_R'' $ mentre la classe $[1]_R'$ la possiamo scrivere come $ union.big_(i "dispari") [i]_R'' . $

  Infine, come è messa $R$ rispetto a $R''$? E $R''$ rispetto a $R$?

  Anche in questo caso, possiamo dire che $R''$ è un raffinamento di $R$: infatti, la classe $[0]_R$ la possiamo scrivere come $ [0]_R'' union [3]_R'' , $ la classe $[1]_R$ la possiamo scrivere come $ [1]_R'' union [4]_R'' $ mentre la classe $[2]_R$ la possiamo scrivere come $ [2]_R'' union [5]_R'' . $
]

== Relazione $R_M$

Sia $M = (Q, Sigma, delta, q_0, F)$ un DFA. Definiamo la relazione $ R_M subset.eq Sigma^* times Sigma^* $ tale che $ rel(x, R_M, y) sse delta(q_0, x) = delta(q_0, y) . $ In poche parole, due stringhe sono in relazione se e solo se vanno a finire *nello stesso stato*.

#lemma()[
  La relazione $R_M$ è una relazione di equivalenza.
]

#lemma-proof()[
  Facciamo vedere che $R_M$ rispetta RST.

  La relazione $R_M$ è riflessiva: banale per la riflessività l'uguale.

  La relazione $R_M$ è simmetrica: banale per la simmetria dell'uguale.

  La relazione $R_M$ è transitiva: banale per la transitività dell'uguale.

  Ma allora $R_M$ è di equivalenza.
]

#lemma()[
  La relazione $R_M$ è invariante a destra rispetto all'operazione di concatenazione.
]

#lemma-proof()[
  Dobbiamo dimostrare che $ rel(x, R_M, y) arrow.long.double forall z in Sigma^* quad rel((x z), R_M, (y z)) . $

  Ma questo è vero: con $x$ e $y$ vado nello stesso stato per ipotesi, quindi applicando $z$ ad entrambe le stringhe finiamo nello stesso stato.
]

Quante classi di equivalenza abbiamo? Al massimo il numero di stati dell'automa. Come mai diciamo *AL MASSIMO* e non esattamente il numero di stati? Perché in un DFA potremmo avere degli stati che sono irraggiungibili e che quindi non vanno a creare nessuna classe di equivalenza.

In poche parole, $R_M$ è una relazione di equivalenza, invariante a destra e di indice finito limitato dal numero di stati dell'automa $M$.

Notiamo inoltre che se $(rel(x, R_M, y))$ allora $x$ e $y$ sono due stringhe non distinguibili per $L(M)$: infatti, esse vanno nello stato e, aggiungendo qualsiasi stringa $z in Sigma^*$ per l'invariante a destra, finisco sempre nello stesso stato. In particolare, se finiamo in uno stato finale accettiamo sia $x$ che $y$, altrimenti entrambe non sono accettate da $M$.

Abbiamo appena dimostrato che $L(M)$ è l'*unione* di alcune classi di equivalenza di $R_M$, ovvero tutte le classi di equivalenza che sono definite da stati finali.

#example()[
  Dato il seguente automa deterministico, determinare le classi di equivalenza della relazione $R_M$ appena studiata.

  #figure(image("assets/05_esempio_da_ridurre.svg"))

  Abbiamo $4$ classi di equivalenza, che sono tutte le varie combinazioni di $a$ e $b$ pari/dispari.

  Questo automa accetta:
  - stringhe con $a$ dispari e $b$ dispari;
  - stringhe con $a$ pari e $b$ dispari.

  Vedremo dopo come migliorare questo automa.
]

== Relazione $R_L$

Dato un linguaggio $L subset.eq Sigma^*$, ad esso ci associamo una relazione $ R_L subset.eq Sigma^* times Sigma^* $ tale che $ rel(x, R_L, y) sse forall z in Sigma^* quad (x z in L sse y z in L) $

In poche parole, se a due elementi in relazione attacco una stringa $z$ qualsiasi, allora esse vanno a finire entrambe in stati accettanti oppure no. È praticamente il contrario della distinguibilità.

#lemma()[
  La relazione $R_L$ è una relazione di equivalenza.
]

#lemma-proof()[
  Facciamo vedere che $R_L$ rispetta RST.

  La relazione $R_L$ è riflessiva: banale perché sto valutando la stessa stringa.

  La relazione $R_L$ è simmetrica: banale per la simmetria del se e solo se.

  La relazione $R_L$ è transitiva: banale per la transitività del se e solo se.

  Ma allora $R_L$ è di equivalenza.
]

#lemma()[
  La relazione $R_L$ è invariante a destra rispetto all'operazione di concatenazione.
]

// TODO: da togliere

#lemma-proof()[
  Dobbiamo dimostrare che $ rel(x, R_L, y) arrow.long.double forall w in Sigma^* quad rel((x w), R_L, (y w)) . $

  Se $(rel(x, R_L, y))$ allora $ forall w in Sigma^* quad (x w in L sse y w in L) . $

  Prendiamo ora una qualsiasi stringa $z in Sigma^*$ e aggiungiamola alle due stringhe, ottenendo $x w z$ e $y w z$. Se chiamiamo $z' = w z$, con un semplice renaming quello che otteniamo è comunque una stringa di $Sigma^*$ che mantiene la relazione $R_L$, ma effettivamente abbiamo aggiunto qualcosa, la stringa $z$, quindi abbiamo dimostrato che $R_L$ è invariante a destra.
]

Se prendiamo la stringa $z = epsilon$, le stringhe $x$ e $y$ che sono nella relazione $R_L$ sono o entrambe dentro o entrambe fuori da $L$. Ma allora $L$ è l'*unione* di alcune classi di equivalenza di $R_L$.

#example()[
  Definiamo il linguaggio $ L = {x in {a,b}^* bar.v hash_a (x) = "dispari"} . $

  Per questo linguaggio abbiamo due classi di equivalenza rispetto alla relazione $R_L$: una per le $a$ pari e una per le $a$ dispari.
]

Non abbiamo ancora parlato di *indice* per $R_L$. Ci sono linguaggi che hanno un numero di classi di equivalenza infinito: ad esempio il linguaggio $ L = {a^n b^n bar.v n gt.eq 0} $ ha un numero di classi di equivalenza infinito perché non è un linguaggio di tipo $3$.

Se confrontiamo gli ultimi due esempi fatti, notiamo che essi descrivono lo stesso linguaggio, ovvero quello delle stringhe con un numero di $a$ dispari, ma abbiamo due situazioni diverse:
- nel primo esempio la relazione $R_M$ ha $4$ classi di equivalenza e il DFA ha $4$ stati;
- nel secondo esempio la relazione $R_L$ ha $2$ classi di equivalenza e il DFA (_non disegnato_) ha $2$ stati.

// TODO: disegna il DFA (unisci q0-q2 e q1-q3 finale)

Ma allora $R_M$ è un *raffinamento* di $R_L$. Questa cosa vale solo per questo esempio? *NO*.

== Teorema di Myhill-Nerode

#theorem([Teorema di Myhill-Nerode])[
  Sia $L subset.eq Sigma^*$ un linguaggio.

  Le seguenti affermazioni sono equivalenti:
  + $L$ è accettato da un DFA, ovvero $L$ è regolare;
  + $L$ è l'unione di alcune classi di equivalenza di una relazione $E$ invariante a destra di indice finito;
  + la relazione $R_L$ associata a $L$ ha indice finito.
]

Queste relazioni che abbiamo visto fin'ora sono dette *relazioni di Nerode*.

#theorem-proof()[
  Facciamo vedere $1 arrow.long.double 2 arrow.long.double 3 arrow.long.double 1$.

  [$1 arrow.long.double 2$]

  Sia $M$ un DFA per $L$. Consideriamo la relazione $R_M$: abbiamo osservato che essa è:
  - di equivalenza;
  - invariante a destra;
  - di indice finito.

  Inoltre, rende $L$ unione di alcune classi di equivalenza, quindi è esattamente quello che vogliamo dimostrare.

  [$2 arrow.long.double 3$]

  Supponiamo di avere una relazione $ E subset.eq Sigma^* times Sigma^* $ di equivalenza, invariante a destra, di indice finito e che $L$ è l'unione di alcune classi di $E$.

  Sia $(rel(x, E, y))$. Sappiamo che $E$ è invariante a destra, ovvero vale che $ forall z in Sigma^* quad rel((x z), E, (y z)) . $

  Inoltre, vale che $ forall z in Sigma^* quad (x z in L sse y z in L) $ perché L è unione di alcune classi di equivalenza di $E$.

  Ma allora $ rel(x, R_L, y) $ per tutta la catena che abbiamo costruito.

  Inoltre, $E$ è un raffinamento di $R_L$, quindi vuol dire che l'indice di $E$ è maggiore di $R_L$, ovvero $ indice(R_L) lt.eq indice(E) . $

  Visto che $E$ ha indice finito, anche $R_L$ ha indice finito.

  [$3 arrow.long.double 1$]

  Sia $R_L$ di indice finito, costruiamo l'automa $M'$ che deve essere un DFA per $L$.

  Definiamo quindi l'automa $M' = (Q', Sigma, delta', q'_0, F')$ tale che:
  - $Q'$ insieme degli stati formato delle classi di equivalenza di $R_L$, ovvero $ {[x] bar.v x in Sigma^*} ; $
  - $q'_0$ stato iniziale che poniamo uguale alla classe di equivalenza che contiene la parola vuota, ovvero $ q'_0 = [epsilon] ; $
  - $delta$ funzione di transizione tale che $ forall sigma in Sigma quad delta'([x], sigma) = [x sigma] ; $
  - $F$ insieme degli stati finali formato dalle classi di equivalenza che contengono stringhe del linguaggio, ovvero $ F' = {[x] bar.v x in L} . $

  Ma allora $L(M') = L(M)$ per costruzione.
]

Visto che abbiamo dimostrato questo teorema, possiamo porre $E$ uguale a $R_M$: otteniamo $ indice(R_L) lt.eq indice(R_M) $ se $L$ è una tipo $3$, altrimenti partiamo a $infinity$ con le classi di equivalenza di $R_L$.

== Automa minimo

Finiamo con le nozioni di automa minimo.

Con *automa minimo* intendiamo il DFA per $L$ con il minimo numero di stati.

#theorem([Teorema dell'automa minimo])[
  Dato un linguaggio $L$ accettato da automi, il DFA minimo per $L$ è unico. Con unicità intendiamo la non esistenza di una configurazione diversa del grafo.
]

L'automa minimo contiene anche l'eventuale stato trappola dove mandiamo i pattern non accettanti.

L'automa minimo $M'$ è ottenuto grazie alla relazione $R_L$.

Per calcolare l'automa minimo abbiamo algoritmi per farlo in modo efficiente, che cercano le stringhe non distinguibili per abbassare il numero di stati. Se troviamo delle stringhe distinguibili siamo arrivati all'automa minimo.

== Applicazioni agli NFA

Cosa succede se applichiamo tutte questi concetti sugli NFA?

#example()[
  Costruiamo un po' di automi non deterministici per stringhe che finiscono in $b$.

  #grid(
    align: center + horizon,
    columns: (50%, 50%),
    inset: 10pt,
    [#figure(image("assets/05_01.svg"))], [#figure(image("assets/05_02.svg"))],
    [#figure(image("assets/05_03.svg"))], [#figure(image("assets/05_04.svg"))],
  )
]

Ovviamente non possiamo andare sotto i $2$ stati perché almeno un carattere lo dobbiamo leggere, quindi tutti questi sono *automi minimi* ma *non sono unici*.

Inoltre, per i DFA abbiamo algoritmi polinomiali ben studiati negli anni $'60$, per gli NFA non abbiamo algoritmi efficienti perché esso è un problema difficile, estremamente difficile, che è ben oltre gli _NP_-completi, ovvero è un problema _PSPACE_-completo

Per fare un confronto, un problema NP-completo è CNF-SAT, un problema PSPACE-completo è CNF-SAT con una serie arbitraria di $forall$ e $exists$ posti davanti alla formula CNF.
