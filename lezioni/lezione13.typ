// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 13 [09/04]

== Varianti di automi

Come possiamo *rappresentare* un automa a stati finiti? Questa macchina è molto semplice: abbiamo un *nastro* che contiene l'input, esaminato da una *testina in sola lettura* che, spostandosi *one-way* da sinistra verso destra, permette ad un *controllo a stati finiti* di capire se la stringa in input deve essere accettata o meno.

#figure(image("assets/13_dfa.svg", width: 50%))

La classe di linguaggi che riconosce un automa a stati finiti è la classe dei *linguaggi regolari*. Ma possiamo fare delle modifiche a questo modello? Se sì, che cosa possiamo cambiare?

=== One-way VS two-way

Se permettiamo all'automa di spostarsi da sinistra verso destra ma anche viceversa, andiamo ad ottenere gli *automi two-way*, che in base alla possibilità di leggere e basta o leggere e scrivere e in base alla lunghezza del nastro saranno in grado di riconoscere diverse classi di linguaggi.

#figure(image("assets/13_2dfa.svg", width: 50%))

=== Read-only VS read-write

Se manteniamo l'automa one-way, rendere il nastro anche in lettura non modifica per niente il comportamento dell'automa: infatti, anche se scriviamo, visto che siamo one-way non riusciremo mai a leggere quello che abbiamo scritto.

Consideriamo quindi un automa two-way che però mantiene la read-only del nastro: la classe che otteniamo è ancora una volta quella dei *linguaggi regolari*, e questo lo vedremo oggi.

Rendiamo ora la testina capace di poter scrivere sul nastro che abbiamo a disposizione. Ora, in base a come è fatto il nastro abbiamo due situazioni:
- se rendiamo il nastro illimitato oltre la porzione occupata dall'input, andiamo ad riconoscere i linguaggi di tipo $0$, ovvero otteniamo una *macchina di Turing*:

#figure(image("assets/13_mdt.svg", width: 50%))

- se invece lasciamo il nastro grande quando l'input andiamo a riconoscere i linguaggi di tipo $1$, ovvero otteniamo un *automa limitato linearmente*. Quest'ultima cosa vale perché nelle grammatiche di tipo $1$ le regole di produzione non decrescono mai, e un automa limitato linearmente per capire se deve accettare cerca di costruire una derivazione al contrario, accorciando mano a mano la stringa arrivando all'assioma $S$:

#figure(image("assets/13_all.svg", width: 50%))

=== Memoria esterna

L'ultima modifica che possiamo pensare per queste macchine è l'aggiunta di una *memoria esterna*.

Dato un automa one-way con nastro read-only, se aggiungiamo un secondo nastro in read-write che funga da memoria esterna, otteniamo le due situazioni che abbiamo visto per gli automi two-way con possibilità di scrivere sul nastro di input.

#figure(image("assets/13_memoria_esterna.svg", width: 50%))

Un caso particolare è se la memoria esterna è codificata come una *pila* illimitata, ovvero riesco a leggere solo quello che c'è in cima, allora andiamo a riconoscere i linguaggi di tipo $2$, ottenendo quindi un *automa a pila*. Se passiamo infine ad un two-way con una pila diventiamo più potenti ma non sappiamo di quanto.

#figure(image("assets/13_pila.svg", width: 50%))

== Automi two-way

Tra tutte queste varianti, fissiamoci sugli *automi two-way*, ovvero quelli che hanno il nastro in sola lettura e hanno la possibilità di andare avanti e indietro nell'input. Vediamo prima di tutto qualche linguaggio per il quale possiamo usare un automa two-way.

=== Esempi vari

#example()[
  Riprendiamo l'operazione $alpha$. Dato $L$ regolare, $alpha$ era tale che $ alpha(L) = {x in Sigma^* bar.v x x in L} . $

  Abbiamo $A$ un DFA che accetta $L$, come posso costruire un two-way per $alpha(L)$? Potremmo leggere $x$ la prima volta, ricordarci in che stato siamo arrivati, tornare indietro e poi ripartire a leggere $x$ dallo stato nel quale eravamo arrivati e vedere se finiamo in uno stato finale.

  Per fare ciò, ci serve sapere dove finisce il nastro: vedremo come fare tra poco.

  Il numero di stati nel two-way è $3n$:
  - $n$ stati di $A$ che usiamo per leggere $x$;
  - $n$ stati che tengono traccia dello stato nel quale siamo arrivati con $x$ e che ci permettono di ritornare all'inizio della stringa;
  - $n$ stati che fanno ripartire la computazione dallo stato nel quale siamo arrivati con $x$ e controllano se finiamo in uno stato finale.
]

Abbiamo sollevato poco fa il problema: come facciamo a capire dove finisce il nastro? Andiamo a inserire dei *marcatori*, uno a sinistra e uno a destra, che delimitano la stringa. Se per caso arriviamo su un marcatore non possiamo andare oltre: possiamo solo rientrare sul nastro. In realtà, vedremo che in un particolare caso usciremo dai bordi.

#figure(image("assets/13_marker.svg", width: 60%))

Vediamo ancora un po' di esempi.

#example()[
  Definiamo $ L_n = (a+b)^* a (a+b)^(n-1) $ il solito linguaggio dell'$n$-esimo simbolo da destra uguale ad una $a$.

  Avevamo visto che con un NFA avevamo $n+1$ stati, mentre con un DFA avevamo $2^n$ stati perché ci ricordavamo una finestra di $n$ simboli. Ora diventa tutto più facile: ci spostiamo, ignorando completamente la stringa, sul marcatore di destra, poi contiamo $n$ simboli e vediamo se accettare o rifiutare.

  Come numero di stati siamo circa sui livelli dell'NFA, visto che dobbiamo solo scorrere la stringa per intero e poi tornare indietro di $n$.
]

#example()[
  Definiamo infine $ K_n = (a+b)^* a (a+b)^(n-1) a (a+b)^* $ il linguaggio delle parole che hanno due $a$ distanti $n$. Come lo scriviamo un two-way per $K_n$?

  Potremmo partire dall'inizio e scandire la stringa $x$. Ogni volta che troviamo una $a$ andiamo a controllare $n$ simboli dopo e vediamo se troviamo una seconda $a$:
  - se sì, accettiamo;
  - se no, torniamo indietro di $n-1$ simboli per andare avanti con la ricerca.

  Il numero di stati è:
  - $1$ che ricerca le $a$;
  - $n$ stati per andare in avanti;
  - $1$ stato di accettazione;
  - $n-1$ stati per tornare indietro.

  Ma allora il numero di stati è $2n + 1$.
]

Abbiamo trovato una buonissima soluzione per l'esempio precedente, ma se volessimo una soluzione alternativa che utilizza un automa sweeping? Ma cosa sono ste cose?

Un *automa sweeping* è un automa che non cambia direzione mentre si trova nel nastro, ma è un automa che rimbalza avanti e indietro sugli end marker. La soluzione che abbiamo trovato non usa automi sweeping perché se il simbolo a distanza $n$ è una $b$ noi invertiamo la direzione e torniamo indietro.

#example()[
  Cerchiamo una soluzione che utilizzi un automa sweeping per $K_n$.

  Supponiamo di numerare le celle del nastro da $1$ a $k$. Partendo nello stato $1$, andiamo a guardare tutte le celle a distanza $n$: se troviamo una $a$ e poi subito dopo ancora una $a$ accettiamo, altrimenti andiamo avanti fino a quando rimbalziamo sul marker, tornando indietro e andando sulla cella $2$. Da qui facciamo ripartire la computazione, andando ogni volta avanti di una cella.

  In generale, dalla cella $p in {1, dots, n}$ noi visitiamo tutte le celle $t n + p$.

  Con questo approccio, il numero di stati è $O(n^2)$ perché dobbiamo muoverci di $n$ simboli un numero $n$ di passate. Possiamo farlo con un numero lineare di stati se facciamo la ricerca modulo $n$ anche al ritorno, ma è questo è negli esercizi.
]

=== Definizione formale

Abbiamo visto come è costruito un automa two-way, ora vediamo la definizione formale. Definiamo $ M = (Q, Sigma, delta, q_0, q_f) $ un $bold(2)$*NFA* tale che:
- $Q$ rappresenta l'*insieme degli stati*;
- $Sigma$ rappresenta l'*alfabeto* di input;
- $q_0$ rappresenta lo *stato iniziale*;
- $delta$ rappresenta la *funzione di transizione*, ed è tale che $ delta : Q times (Sigma union {lmarker, rmarker}) arrow.long 2^(Q times {+1, -1}) , $ ovvero prende uno stato e un simbolo dell'alfabeto compresi gli end marker e ci restituisce i nuovi stati e che movimento dobbiamo fare con la testina. Ho dei *divieti*: se sono sull'end marker sinistro non ho mosse che mi portano a sinistra, idem ma specchiato su quello di destra con una piccola eccezione, che vediamo tra poco;
- $q_f$ è lo *stato finale* e si raggiunge _"passando"_ oltre l'end marker destro, unico caso in cui si può superare un end marker.

Con questo modello possiamo incappare in *loop infiniti*, che:
- nei DFA non ci fanno accettare;
- negli NFA magari indicano che abbiamo fatto una scelta sbagliata e c'era una via migliore.

Ci sono poi diverse modifiche che possiamo fare a questo modello, ad esempio:
- possiamo estendere le mosse con la *mossa stazionaria*, ovvero quella codificata con $0$ che ci mantiene nella posizione nella quale siamo, ma possono essere eliminate con una coppia di mosse sinistra+destra o viceversa;
- possiamo utilizzare un *insieme di stati finali*;
- possiamo *non* usare gli end marker, rendendo molto difficile la scrittura di automi perché non sappiamo dove finisce la stringa.

=== Potenza computazionale

Avere a disposizione un two-way sembra darci molta potenza, ma in realtà non è così: infatti, questi modelli sono equivalenti agli automi a stati finiti one-way, detti anche $bold(1)$*DFA*.

#theorem()[
  Vale $ L(2"DFA") = L(1"DFA") . $
]

#theorem-proof()[
  Abbiamo a disposizione un 2DFA nel quale abbiamo inserito un input che viene accettato. Vogliamo cambiare la computazione del 2DFA in una computazione di un 1DFA. Vediamo che stati vengono visitati nel tempo.

  #figure(image("assets/13_computazione.svg", width: 75%))

  Prima di tutto, dobbiamo ricordarci che nei DFA non abbiamo end marker, quindi abbiamo solo l'input. Nell'automa two-way ci sono momenti dove entro nelle celle per la prima volta: nel grafico sopra sono segnati in verde. Chiamiamo questi stati $q_(i gt.eq 0)$.

  Usiamo delle *scorciatoie*: visto che nel 1DFA non possiamo andare avanti a indietro, dobbiamo tagliare via le computazioni che tornano indietro e vedere solo in che stato esco.

  #figure(image("assets/13_computazione_DFA.svg", width: 75%))

  Come vediamo, a me interessa sapere in che stato devo spostarmi a partire dalla mia posizione, evitando quello che viene fatto tornando all'indietro. Per tagliare le parti che tornano indietro usiamo delle *matrici*, molto simili a quelle della lezione precedente. Quelle matrici erano nella forma $M_w [p,q]$ che conteneva un $1$ se e solo se partendo da $q$ finivo in $p$ leggendo $w$.

  Le matrici che costruiamo ora sono nella forma $ tau_w : Q times Q arrow.long [0,1] $ che mi vanno a definire il primo stato che incontriamo quando leggiamo un nuovo carattere della stringa.

  // #figure(image())

  Nella matrice abbiamo $tau_w [p,q] = 1$ se e solo se esiste una sequenze di mosse che:
  - inizia sul simbolo più a destra della porzione di nastro che contiene $(lmarker w)$ nello stato $p$;
  - termina quando la testina esce a destra dalla porzione di nastro considerata nello stato $q$.

  Ad esempio, considerando l'esempio sopra, vale $ tau_"inp" [q_2,q_3] = 1 . $

  Vediamo come ottenere induttivamente queste tabelle. Partiamo con $w = epsilon$: la porzione di nastro che stiamo considerando è formata solo da $lmarker$, ma non potendo andare a sinistra l'unica mossa che possiamo fare è andare a destra, quindi andare in un nuovo stato, ovvero $ tau_epsilon [p,q] = 1 sse delta(p,lmarker) = (q, +1) . $

  Supponiamo di aver calcolato la tabella di $w$, vediamo come costruire induttivamente la tabella di $w sigma$, con $w in Sigma^*$ e $sigma in Sigma$. Se vale $ delta(p, sigma) = (q, +1) $ la tabella è molto facile, perché sto subito uscendo dallo stato $p$, ovvero $ tau_(w sigma) [p,q] = 1 . $

  Se invece andiamo indietro dobbiamo capire cosa fare.

  #figure(image("assets/13_tau_induttiva.svg", width: 65%))

  Ogni volta che da $p_i$ torniamo indietro finiamo in uno stato $r_(i+1)$, che poi dopo un po' di giri finisce per forza in $p_(i+1)$. Andiamo avanti così, fino ad un certo $p_k$, dal quale usciamo e andiamo in $q$. In poche parole $ tau_(w sigma) [p,q] = 1 $ se e solo se esiste una sequenza di stati $ p_0, p_1, dots, p_k, r_1, dots, r_k bar.v k gt.eq 0 $ tale che:
  - $p_0 = p$, ovvero parto dallo stato $p$, per definizione;
  - $delta(p_(i-1), sigma) = (r_i, -1) quad forall i in {1, dots, k}$, ovvero in tutti i $p$ tranne l'ultimo io torno indietro;
  - $tau_w [r_i,p_i] = 1$, ovvero da $r_i$ giro in $w$ e poi torno in $p_i$;
  - $delta(p_k, sigma) = (q, +1)$, ovvero esco fuori dal $w sigma$.

  Notiamo che se prendiamo $k = 0$ abbiamo la situazione precedente in cui uscivo direttamente. Inoltre, $k$ è il numero massimo di stati del DFA perché se faccio ancora un giro in $w$ dopo $p_k$ vado in uno stato già visto ed entro in un loop infinito.

  Notiamo una cosa *importantissima*: se due stringhe hanno la stessa tabella, ovvero $tau_w = tau_(w')$, allora l'aggiunta di un qualsiasi carattere $sigma$ genera tabelle risultanti uguali, ovvero $tau_(w sigma) = tau_(w' sigma)$. Ma allora esiste una funzione $ f_sigma : [Q times Q arrow.long [0,1]] arrow.long [Q times Q arrow.long [0,1]] $ che genera una tabella a partire da una data, ed è tale che $ forall w in Sigma^* quad tau_(w sigma) = f_sigma (tau_w) . $

  In poche parole, la nuova tabella dipende solo da $sigma$ e non da $w$, e questa tabella è esattamente quella calcolata con i $4$ punti messi sopra. Le tabelle, inoltre, sono tantissime ma sono un numero finito.

  Siamo pronti per costruire il $1$DFA che tanto stiamo bramando. Noi avevamo $M = (Q, Sigma, delta, q_0, F)$ che è un $2$DFA, vogliamo costruire $ M' = (Q', Sigma, delta', q'_0, F') $ $1$DFA che sia equivalente a $M$. Esso è tale che:
  - $Q$ è l'*insieme degli stati* e lo usiamo tenere traccia dello stato nel quale siamo e della tabella che usiamo per calcolare lo stato successivo, ovvero $ Q' = Q times [Q times Q arrow.long [0,1]] ; $
  - $q'_0$ è lo *stato iniziale* ed è la coppia $ q'_0 = (q_0, tau_epsilon) ; $
  - $delta'$ è la *funzione di transizione* che manda avanti l'automa, ovvero $ delta'((p,T), sigma) = (q,T') $ con:
    - $T'$ che mi dà indicazioni sullo stato nel quale arrivo con $sigma$, che ho però appena letto, quindi $T' = f_sigma (T)$;
    - vale $T'[p,q] = 1$ perché io devo uscire in $q$ partendo da $p$;
  - $F'$ è l'*insieme degli stati finali*, ostico perché nel two-way abbiamo gli end marker, nel one-way non li abbiamo. Per accettare dovevo sforare l'end marker di destra e finire in $q_f$, ma questa informazione la ricavo dalla tabella del right marker, ovvero $ F' = {(q,T) bar.v (f_rmarker (T))[q,q_f] = 1} . $

  Ma allora stiamo simulando un $2$DFA con un $1$DFA, ma gli $1$DFA riconoscono la classe dei linguaggi regolari, quindi anche la classe degli automi a stati finiti two-way riconosce la classe dei linguaggi regolari.
]

Che considerazioni possiamo fare sul numero di stati? Sappiamo che:
- il numero di stati è $abs(Q) = n$;
- il numero di tabelle è $abs([Q times Q] arrow.long [0,1]) = 2^n^2$.

Ma allora il numero di stati è $ abs(Q') lt.eq n 2^n^2 . $

Come vediamo, la simulazione è *poli-esponenziale*.
