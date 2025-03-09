// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 03 [05/03]

== Gerarchia

Come si modifica la gerarchia di Chomsky considerando il non determinismo? Abbiamo che:
- le tipo $3$ ha i modelli equivalenti, con un costo in termini della descrizione;
- le tipo $2$ ha un cambiamento nei modelli, con quello non deterministico strettamente più potente;
- le tipo $1$ sono complicate;
- le tipo $0$ ha i modelli equivalenti.

Il non determinismo è una nozione del *riconoscitore* che uso per riconoscere: nel determinismo il riconoscitore può fare una cosa alla volta, nel non determinismo può fare più cose contemporaneamente. Nelle grammatiche è difficile catturare questa nozione, perché esse lo hanno intrinsecamente, perché le derivazioni le applico tutte per ottenere le stringhe del linguaggio.

== Decidibilità

#theorem([Decidibilità dei linguaggi context-sensitive])[
  I linguaggi di tipo $1$ sono ricorsivi.
]

Con ricorsività non intendiamo le procedure ricorsive, ma si intende una procedura che è calcolabile automaticamente. Nei linguaggi, un qualcosa di ricorsivo intende una macchina che, data una stringa $x$ in input, riesce a rispondere a $x in L$ terminando sempre dicendo SI o NO. Si usano i termini *ricorsivo* e *decidibile* come sinonimi.

#theorem-proof()[
  In una grammatica di tipo $1$ l'unico vincolo è sulla lunghezza delle produzioni, ovvero non possono mai accorciarsi.

  In input ho una stringa $w in Sigma^*$ la cui lunghezza è $abs(w) = n$. Ho una grammatica $G$ di tipo $1$. Mi chiedo se $w in L(G)$. Per rispondere a questo, devo cercare $w$ nelle forme sentenziali, ma possiamo limitarci a quelle che non superano la lunghezza $n$.

  Definiamo quindi gli insiemi $ T_i = {gamma in (V union Sigma)^(lt.eq n) bar.v S arrow.stroked^(lt.eq i) gamma} quad forall i gt.eq 0 . $

  Calcoliamo induttivamente questi insiemi.

  Se $i = 0$ non eseguo nessuna derivazione, quindi $ T_0 = {S} . $

  Supponiamo di aver calcolato $T_(i-1)$. Vogliamo calcolare $ T_i = T_(i-1) union {gamma in (V union Sigma)^(lt.eq n) bar.v exists beta in T_(i-1) : beta arrow.stroked gamma} . $

  Noi partendo da $T_0$ calcoliamo tutti i vari insiemi ottenendo una serie di $T_i$.

  Per come abbiamo definito gli insiemi, sappiamo che $ T_0 subset.eq T_1 subset.eq T_2 subset.eq dots subset.eq (V union Sigma)^(lt.eq n) $ e l'ultima inclusione è vera perché ho fissato la lunghezza massima, non voglio considerare di più perché io voglio $w$ di lunghezza $n$.

  La grandezza dell'insieme $(V union Sigma)^(lt.eq n)$ è finita, quindi anche andando molto avanti con le computazioni prima o poi arrivo ad un certo punto dove non posso più aggiungere niente, ovvero vale che $ exists i in NN bar.v T_i = T_(i - 1) . $

  Ora è inutile andare avanti, questo $T_i$ è l'insieme di tutte le stringhe che riesco a generare nella grammatica. Ora mi chiedo se $w in T_i$, che posso fare molto facilmente.

  Ma allora $G$ è decidibile.
]

Ci rendiamo conto che questa soluzione è mega inefficiente: infatti, in tempo polinomiale non riusciamo a fare questo nelle tipo $1$, ma è una soluzione che ci garantisce la decidibilità.

#theorem([Semi-decidibilità dei linguaggi di tipo 0])[I linguaggi di tipo $0$ sono ricorsivamente enumerabili.]

#theorem-proof()[
  In una grammatica di tipo $0$ non abbiamo vincoli da considerare.

  In input ho una stringa $w in Sigma^*$ la cui lunghezza è $abs(w) = n$. Ho una grammatica $G$ di tipo $0$. Mi chiedo se $w in L(G)$. Per rispondere a questo, devo cercare $w$ nelle forme sentenziali, ma a differenza di prima non possiamo limitarci a quelle che non superano la lunghezza $n$: infatti, visto che le forme sentenziali si possono accorciare posso anche superare $n$ e poi sperare di tornare indietro in qualche modo.

  Definiamo quindi gli insiemi $ U_i = {gamma in (V union Sigma)^* bar.v S arrow.stroked^(lt.eq i) gamma} quad forall i gt.eq 0 . $

  Calcoliamo induttivamente questi insiemi.

  Se $i = 0$ non eseguo nessuna derivazione, quindi $ U_0 = {S} . $

  Supponiamo di aver calcolato $U_(i-1)$. Vogliamo calcolare $ U_i = U_(i-1) union {gamma in (V union Sigma)^* bar.v exists beta in U_(i-1) : beta arrow.stroked gamma} . $

  Noi partendo da $U_0$ calcoliamo tutti i vari insiemi ottenendo una serie di $U_i$.

  Per come abbiamo definito gli insiemi, sappiamo che $ U_0 subset.eq U_1 subset.eq U_2 subset.eq dots subset.eq (V union Sigma)^* . $

  A differenza di prima, la grandezza dell'insieme $(V union Sigma)^*$ è infinita, quindi non ho più l'obbligo di stopparmi ad un certo punto per esaurimento delle stringhe generabili.

  Come facciamo a rispondere a $w in L(G)$? Iniziamo a costruire i vari insiemi $U_i$ e ogni volta che termino la costruzione mi chiedo se $w in U_i$:
  - se questo è vero allora rispondo SI;
  - in caso contrario vado avanti con la costruzione.

  Vista la cardinalità infinita dell'insieme che fa da container, potrei andare avanti all'infinito (_a meno di ottenere due insiemi consecutivi identici, in tale caso rispondo NO_).

  Ma allora $G$ è semi-decidibile.
]

Diciamo *ricorsivamente enumerabile* perché ogni volta che costruisco un insieme $U_i$ posso prendere le stringe $w in Sigma^*$ appena generate ed elencarle, quindi enumerarle una per una.

== Parola vuota

Vediamo il problema della *parola vuota*: nelle grammatiche di tipo $2$ abbiamo ho messo il $+$ per evitare la parola vuota nelle derivazioni, ma ogni tanto potrebbe servirmi la parola vuota nel linguaggio di quella grammatica. La mossa di mettere $star$ mi farebbe cadere tutta la gerarchia.

Come risolviamo questo problema?

Partiamo da una grammatica $G = (V, Sigma, P, S)$ di tipo $1$. Creiamo una nuova grammatica $G_1 = (V_1, Sigma, P_1, S_1)$ tale che $L(G) = L(G_1)$. Vediamo come sono fatte le componenti di $G_1$:
- $V_1 = V union {S_1}$;
- per $P_1$ abbiamo due opzioni:
  - $P_1 = P union {S_1 arrow alpha bar.v (S arrow alpha) in P} union {S_1 arrow epsilon}$;
  - $P_1 = P union {S_1 arrow.long S} union {S_1 arrow.long epsilon}$;
- $S_1$ nuovo assioma che non appare mai nel lato destro delle produzioni.

La gerarchia ora diventa:
- tipo $1$ abbiamo $abs(alpha) lt.eq abs(beta)$ ed è possibile $S arrow.long epsilon$ purché $S$ non appaia mai sul lato destro delle produzioni;
- tipo $2$ permettiamo direttamente $A arrow.long beta$ con $beta in (V union Sigma)^*$ senza costringere ad isolarle. Questo perché non creano problemi, comunque resta decidibile se una stringa appartiene al linguaggio, anche se posso cancellare e ridurre la lunghezza;
- tipo $3$ idem delle tipo $2$.

Queste produzioni particolari sono dette $bold(epsilon)$*-produzioni*.

== Linguaggi non esprimibili tramite grammatiche finite

Ora vediamo linguaggi che non possiamo esprimere tramite grammatiche. Utilizzeremo la *dimostrazione per diagonalizzazione*, famosissima e utilizzatissima in tante dimostrazioni.

Sono più i numeri pari o i numeri dispari? Sono più i numeri pari o i numeri interi? Sono più le coppie di numeri naturali o i naturali stessi?

Per rispondere a queste domande si usa la definizione di *cardinalità*, e tutti questi insiemi ce l'hanno uguale. Anzi, diciamo di più: tutti questi insiemi sono grandi quanto i naturali, perché esistono funzioni biettive tra questi insiemi e l'insieme $NN$.

Consideriamo ora i sottoinsiemi di $NN$. Sono più questi sottoinsiemi o i numeri interi? In questo caso, sono di più i sottoinsiemi, che hanno la *cardinalità del continuo*. Per dimostrare questo useremo una dimostrazione per diagonalizzazione.

#theorem()[
  Vale $ NN tilde.not 2^NN . $
]

#theorem-proof()[
  Per assurdo sia $NN tilde 2^NN$, ovvero ogni elemento di $2^NN$ è listabile.

  Creiamo una tabella booleana $M$ indicizzata sulle righe dai sottoinsiemi di naturali $S_i$ e indicizzata sulle colonne dai numeri naturali. Per ogni insieme $S_i$ abbiamo sulla riga la funzione caratteristica, ovvero $ M[i,j] = cases(1 & "se" j in S_i, 0 quad & "se" j in.not S_i) . $

  Creiamo l'insieme $ S = {x in NN bar.v x in.not S_x} , $ ovvero l'insieme che prende tutti gli elementi $0$ della diagonale di $M$. Questo insieme non è presente negli insiemi $S_i$ listati perché esso è diverso da ogni $S_i$ in almeno una posizione, ovvero la diagonale.

  Abbiamo ottenuto un assurdo, ma allora $NN tilde.not 2^NN$.
]

Prima dell'ultima parte chiediamoci ancora una cosa: sono più le stringhe o i numeri interi? Questo è facile, basta trasformare ogni stringa in un numero intero con una qualche codifica a nostra scelta.

#theorem()[
  Esistono linguaggi che non sono descrivibili da grammatiche finite.
]

#theorem-proof()[
  Prendiamo una grammatica $G = (V, Sigma, P, S)$.

  Per descriverla devo dire come sono formati i vari campi della tupla. Cosa uso per descriverla? Sto usando dei simboli come lettere, numeri, parentesi, eccetera, quindi la grammatica è una descrizione che possiamo fare sotto forma di stringa. Visto quello che abbiamo da poco dimostrato, ogni grammatica la possiamo descrivere come stringa, e quindi come un numero intero. Siano $G_i$ tutte queste grammatiche, che sono appunto listabili.

  Consideriamo ora, per ogni grammatica $G_i$, l'insieme $L(G_i)$ delle parole generate dalla grammatica $G_i$, ovvero il linguaggio generato da $G_i$. Mettiamo dentro $L$ tutti questi linguaggi.

  Per assurdo, siano tutti questi linguaggi listabili, ovvero $NN tilde 2^L$.

  Come prima, creiamo una tabella $M$ indicizzata sulle righe dai linguaggi $L(G_i)$ e indicizzata sulle colonne dalle stringhe $x_i$ che possiamo però considerare come naturali. La matrice $M$ ha sulla riga $i$-esima la funzione caratteristica di $L(G_i)$, ovvero $ M[i,j] = cases(1 & "se" x_j in L(G_i), 0 quad & "se" x_j in.not L(G_i)) . $ In poche parole, abbiamo $1$ nella cella $M[i,j]$ se e solo se la stringa $x_j$ viene generata da $G_i$.

  Costruiamo ora l'insieme $ "LG" = {x_i in NN bar.v x_i in.not L(G_i)} , $ ovvero l'insieme di tutte le stringhe $x_i$ che non sono generate dalla grammatica $G_i$ con lo stesso indice $i$. Come prima, questo insieme non è presente in $L$ perché differisce da ogni insieme presente in almeno una posizione, ovvero quello sulla diagonale.

  Siamo ad un assurdo, ma allora $NN tilde.not 2^L$.
]
