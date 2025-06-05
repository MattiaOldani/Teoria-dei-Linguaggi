// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Automi two-way

In questo ultimo capitolo della parte dei linguaggi regolari discuteremo alcune *varianti di automi a stati finiti*, passando prima per variazioni molto leggere, poi per alcune che modificano profondamente il modello di calcolo e infine daremo un'occhiata agli *automi two-way*.

== Varianti di automi a stati finiti

Vediamo prima di tutto delle varianti molto light dei nostri bellissimi automi.

=== Automi pesati e probabilistici

La prima, e unica, variante che vediamo sono gli *automi pesati*. Essi associano ad ogni transizione un peso. Il *peso di una stringa* viene calcolato come la somma dei pesi delle transizioni che la stringa attraversa per essere accettata. Questo peso poi può essere usato in problemi di ottimizzazione, come trovare il cammino di peso minimo, ma questo ha senso solo su NFA.

Un tipo particolare di automi pesati sono gli *automi probabilistici*, che come pesi sulle transizioni hanno la probabilità di effettuare quella transizione. Visto che parliamo di *probabilità*, i pesi sono nel range $[0,1]$ e, dato uno stato, tutte le transizioni uscenti sommano a $1$. In realtà, potremmo sommare a meno di $1$ se nascondiamo lo stato trappola. Con questi automi possiamo chiederci con che probabilità accettiamo una stringa.

Questi automi li possiamo usare come *riconoscitori a soglia*: tutte le parole oltre una certa soglia le accettiamo, altrimenti le rifiutiamo.

Questi automi comunque non sono più potenti dei DFA: si può dimostrare che se la soglia $lambda$ è *isolata*, ovvero nel suo intorno non cade nessuna parola, allora possiamo trasformare questi automi probabilistici in DFA. Se la soglia non è isolata riusciamo a riconoscere una strana classe di linguaggi, che però ora non ci interessa.

== Varianti pesanti di automi a stati finiti

Passiamo ora ad alcune varianti un po' più di hardcore, con alcune che cambiano completamente il modello di calcolo che siamo abituati a vedere.

Parlando di *modelli di calcolo*, come possiamo *rappresentare* un automa a stati finiti? Questa macchina è molto semplice: abbiamo un *nastro* che contiene l'input, esaminato da una *testina in sola lettura* che, spostandosi *one-way* da sinistra verso destra, permette ad un *controllo a stati finiti* di capire se la stringa in input deve essere accettata o meno.

#figure(image("assets/11/dfa.svg", width: 50%))

La classe di linguaggi che riconosce un automa a stati finiti è la classe dei *linguaggi regolari*.

Modifichiamo ora questo modello, toccando un po' tutti gli aspetti possibili.

=== One-way VS two-way

Se permettiamo all'automa di spostarsi da sinistra verso destra ma anche viceversa, andiamo ad ottenere gli *automi two-way*, che in base alla possibilità di leggere e basta o leggere e scrivere e in base alla lunghezza del nastro saranno in grado di riconoscere diverse classi di linguaggi.

#figure(image("assets/11/2dfa.svg", width: 50%))

=== Read-only VS read-write

Se manteniamo l'automa one-way, rendere il nastro anche in lettura non modifica per niente il comportamento dell'automa: infatti, anche se scriviamo, visto che siamo one-way non riusciremo mai a leggere quello che abbiamo scritto.

Consideriamo quindi un automa two-way che però mantiene la read-only del nastro: la classe che otteniamo è ancora una volta quella dei *linguaggi regolari*, e questo lo vedremo dopo.

Rendiamo ora la testina capace di poter scrivere sul nastro che abbiamo a disposizione. Ora, in base a come è fatto il nastro abbiamo *due situazioni* possibili.

Se rendiamo il nastro illimitato oltre la porzione occupata dall'input, andiamo ad riconoscere i linguaggi di tipo $0$, ovvero otteniamo una *macchina di Turing*.

#figure(image("assets/11/mdt.svg", width: 50%))

Se invece lasciamo il nastro grande quando l'input andiamo a riconoscere i linguaggi di tipo $1$, ovvero otteniamo un *automa limitato linearmente*. Quest'ultima cosa vale perché nelle grammatiche di tipo $1$ le regole di produzione non decrescono mai, e un automa limitato linearmente per capire se deve accettare cerca di costruire una derivazione al contrario, accorciando mano a mano la stringa arrivando all'assioma $S$.

#figure(image("assets/11/all.svg", width: 70%))

=== Memoria esterna

L'ultima modifica che possiamo pensare per queste macchine è l'aggiunta di una *memoria esterna*.

Dato un automa one-way con nastro read-only, se aggiungiamo un secondo nastro in read-write che funga da memoria esterna, otteniamo le due situazioni che abbiamo visto per gli automi two-way con possibilità di scrivere sul nastro di input.

#figure(image("assets/11/memoria_esterna.svg", width: 50%))

Un caso particolare è se la memoria esterna è codificata come una *pila* illimitata, ovvero riesco a leggere solo quello che c'è in cima, allora andiamo a riconoscere i linguaggi di tipo $2$, ottenendo quindi un *automa a pila*. Se passiamo infine ad un two-way con una pila diventiamo più potenti ma non sappiamo di quanto.

#figure(image("assets/11/pila.svg", width: 70%))

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

#figure(image("assets/11/marker.svg", width: 75%))

Vediamo ancora un po' di esempi.

#example()[
  Definiamo $ L_n = (a+b)^* a (a+b)^(n-1) $ il solito linguaggio dell'$n$-esimo simbolo da destra uguale ad una $a$.

  Avevamo visto che con un NFA avevamo $n+1$ stati, mentre con un DFA avevamo $2^n$ stati perché ci ricordavamo una finestra di $n$ simboli. Ora diventa tutto più facile: ci spostiamo, ignorando completamente la stringa, sul marcatore di destra, poi contiamo $n$ simboli e vediamo se accettare o rifiutare.

  Come numero di stati siamo circa sui livelli dell'NFA, visto che dobbiamo solo scorrere la stringa per intero e poi tornare indietro di $n$.
]

#example()[
  Definiamo infine $ K_n = (a+b)^* a (a+b)^(n-1) a (a+b)^* $ il linguaggio delle parole che hanno due $a$ a distanza $n$. Come possiamo scrivere un automa two-way per $K_n$?

  Potremmo partire dall'inizio e scandire la stringa $x$. Ogni volta che troviamo una $a$ andiamo a controllare $n$ simboli dopo e vediamo se troviamo una seconda $a$:
  - se sì, accettiamo;
  - se no, torniamo indietro di $n-1$ simboli per andare avanti con la ricerca.

  Il numero di stati è:
  - $1$ che ricerca le $a$;
  - $n$ stati per andare in avanti;
  - $1$ stato di accettazione;
  - $n-1$ stati per tornare indietro.

  Ma allora il numero di stati è $2n + 1$.
]<esempio-Kn>

Abbiamo trovato una buonissima soluzione per l'@esempio-Kn precedente, ma se volessimo una soluzione alternativa che utilizza un automa sweeping? Ma cosa sono ste cose?

Un *automa sweeping* è un automa che non cambia direzione mentre si trova nel nastro, ma è un automa che *rimbalza* avanti e indietro sugli end marker. La soluzione che abbiamo trovato non usa automi sweeping perché se il simbolo a distanza $n$ è una $b$ noi invertiamo la direzione e torniamo indietro.

#example()[
  Cerchiamo una soluzione che utilizzi un automa sweeping per $K_n$.

  Supponiamo di numerare le celle del nastro da $1$ a $k$. Partendo nello stato $1$, andiamo a guardare tutte le celle a distanza $n$: se troviamo una $a$ e poi subito dopo ancora una $a$ accettiamo, altrimenti andiamo avanti fino a quando rimbalziamo sul marker, tornando indietro e andando sulla cella $2$. Da qui facciamo ripartire la computazione, andando ogni volta avanti di una cella.

  In generale, dalla cella $p in {1, dots, n}$ noi visitiamo tutte le celle $t n + p$.

  Con questo approccio, il numero di stati è $O(n^2)$ perché dobbiamo muoverci di $n$ simboli un numero $n$ di passate. Possiamo farlo con un numero lineare di stati se facciamo la ricerca modulo $n$ anche al ritorno, ma è questo è negli esercizi.
]

=== Definizione formale

Abbiamo visto come è costruito un automa two-way, ora vediamo la definizione formale. Definiamo $ M = (Q, Sigma, delta, q_0, q_f) $ un *$2$NFA* tale che:
- $Q$ rappresenta l'*insieme degli stati*;
- $Sigma$ rappresenta l'*alfabeto* di input;
- $q_0$ rappresenta lo *stato iniziale*;
- $delta$ rappresenta la *funzione di transizione*, ed è tale che $ delta : Q times (Sigma union {lmarker, rmarker}) arrow.long 2^(Q times {+1, -1}) , $ ovvero prende uno stato e un simbolo dell'alfabeto compresi gli end marker e ci restituisce i nuovi stati e che movimento dobbiamo fare con la testina. Ho dei *divieti*: se sono sull'end marker sinistro non ho mosse che mi portano a sinistra, idem ma specchiato su quello di destra con una piccola eccezione, che vediamo tra poco;
- $q_f$ è lo *stato finale* e si raggiunge _"passando"_ oltre l'end marker destro, unico caso in cui si può superare un end marker.

Con questo modello possiamo incappare in *loop infiniti*, che:
- nei *DFA* non ci fanno accettare;
- negli *NFA* magari indicano che abbiamo fatto una scelta sbagliata e c'era una via migliore.

Ci sono poi diverse modifiche che possiamo fare a questo modello, ad esempio:
- possiamo estendere le mosse con la *mossa stazionaria*, ovvero quella codificata con $0$ che ci mantiene nella posizione nella quale siamo, ma possono essere eliminate con una coppia di mosse sinistra+destra o viceversa;
- possiamo utilizzare un *insieme di stati finali*;
- possiamo *non* usare gli end marker, rendendo molto difficile la scrittura di automi perché non sappiamo dove finisce la stringa.

=== Potenza computazionale

Avere a disposizione un two-way sembra darci molta potenza, ma in realtà non è così: infatti, questi modelli sono equivalenti agli automi a stati finiti one-way, detti anche *$1$DFA*.

#theorem()[
  Vale $ L(2DFA) = L(1DFA) . $
]

#theorem-proof()[
  Abbiamo a disposizione un $2$DFA nel quale abbiamo inserito un input che viene accettato. Vogliamo cambiare la computazione del $2$DFA in una computazione di un $1$DFA. Vediamo che stati vengono visitati nel tempo.

  #figure(image("assets/11/computazione.svg", width: 75%))

  Prima di tutto, dobbiamo ricordarci che nei DFA non abbiamo end marker, quindi abbiamo solo l'input. Nell'automa two-way ci sono momenti dove entro nelle celle per la prima volta: nel grafico sopra sono segnati in verde. Chiamiamo questi stati $q_i bar.v i gt.eq 0$.

  Usiamo delle *scorciatoie*: visto che nel 1DFA non possiamo andare avanti a indietro, dobbiamo tagliare via le computazioni che tornano indietro e vedere solo in che stato esco.

  #figure(image("assets/11/computazione_DFA.svg", width: 75%))<sequenza-stati>

  Come vediamo, a noi interessa sapere in che stato dobbiamo spostarci a partire dalla posizione corrente, evitando il continuo ritorno all'indietro. Per tagliare queste parti usiamo delle *matrici*, molto simili a quelle del @capitolo08-tipo3[Capitolo]. Quelle matrici erano nella forma $M_w [p,q]$ che conteneva un $1$ se e solo se partendo da $q$ finivo in $p$ leggendo $w$.

  Le matrici che costruiamo ora sono nella forma $ tau_w : Q times Q arrow.long [0,1] $ che mi vanno a definire il primo stato che incontriamo quando leggiamo un nuovo carattere.

  Nella matrice abbiamo $tau_w [p,q] = 1$ se e solo se esiste una sequenze di mosse che:
  - inizia sul simbolo più a destra della porzione di nastro che contiene $(lmarker w)$ nello stato $p$;
  - termina quando la testina esce a destra dalla porzione di nastro considerata nello stato $q$.

  Ad esempio, considerando la @sequenza-stati, vale $ tau_(lmarker"inp") [q_2,q_3] = 1 . $

  Vediamo come ottenere induttivamente queste tabelle. Partiamo con $w = epsilon$: la porzione di nastro che stiamo considerando è formata solo da $lmarker$, ma non potendo andare a sinistra l'unica mossa che possiamo fare è andare a destra, quindi andare in un nuovo stato, ovvero $ tau_epsilon [p,q] = 1 sse delta(p, lmarker) = (q, +1) . $

  Supponiamo di aver calcolato la tabella di $w$, vediamo come costruire induttivamente la tabella di $w sigma$, con $w in Sigma^*$ e $sigma in Sigma$. Se vale $ delta(p, sigma) = (q, +1) $ la tabella è molto facile, perché sto subito uscendo dallo stato $p$, ovvero $ tau_(w sigma) [p,q] = 1 . $

  Se invece andiamo indietro dobbiamo capire cosa fare.

  #figure(image("assets/11/tau_induttiva.svg", width: 65%))

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

Come vediamo, la simulazione è *poli-esponenziale*. Abbiamo visto la trasformazione da $2$DFA a $1$DFA, ma la stessa trasformazione può essere fatta per il passaggio da $2$NFA a $1$NFA.

=== Problema di Sakoda & Sipser

Abbiamo visto questa trasformazione molto pesante, ma quanto costa?

Nel caso partissimo da un $2$DFA e volessimo arrivare in un $1$DFA, il costo il termini di stati, con un "ragionamento roseo", è $ lt.eq n 2^n^2 $ come detto prima, mentre con un "ragionamento raffinato", che tiene conto del determinismo delle tabelle $tau$ e del numero di funzioni (parziali), questo bound diventa $ lt.eq 2^(O(n log(n))) . $

Se cambiamo il punto di partenza in un $2$NFA il salto diventa ancora peggiore: $ lt.eq 2^n 2^n^2 = 2^(n^2 + n) . $ Ma questo ce lo potevamo aspettare: abbiamo guà un salto esponenziale da NFA a DFA, se aggiungiamo anche il two-way esplodiamo con il numero di stati.

Ci sono due *simulazioni/trasformazioni* che sono però molto particolari e importanti.

La prima trasformazione che vediamo è quella *da $2$NFA a $2$DFA*: qua non possiamo usare la costruzione per sottoinsiemi perché ad un certo punto potrei avere il non determinismo su una mossa che però mi sposta la testina su due caratteri diversi della stringa, e questo non è possibile. Ci serve quindi una trasformazione alternativa, ma ci arriviamo dopo.

La seconda trasformazione è quella da *$1$NFA a $2$DFA*: questa trasformazione cerca di capire se, dando il two-way ad un automa deterministico, esso è capace di simulare il non determinismo.

Vediamo un paio di esempi.

#example()[
  Definiamo $ L_n = (a+b)^* a (a+b)^(n-1) $ il classicissimo linguaggio dell'$n$-esimo carattere da destra pari ad una $a$.

  Sappiamo che:
  - esiste un $1$NFA di $n + 1$ stati;
  - esiste un $1$DFA di $2^n$ stati.

  Abbiamo visto un automa two-way per questo linguaggio, che usa poco più di $n$ stati, quindi in questo caso riusciamo a togliere il non determinismo a basso costo.
]

#example()[
  Definiamo $ K_n = (a+b)^* a (a+b)^(n-1) a (a + b)^* $ il solito linguaggio con due $a$ a distanza $n$.

  Avevamo visto che un $1$NFA per questo linguaggio usava $n + 2$ stati, quindi una quantità lineare in $n$. Per un $2$DFA abbiamo visto che esiste anche qui una soluzione lineare in $n$, quindi anche qui eliminiamo il non determinismo a basso costo.
]

Abbiamo visto due esempi che sembrano dare buone notizie, ma riusciamo a dimostrare che si riesce sempre a fare un $2$DFA di $n$ stati partendo da un $1$NFA di $n$ stati? Purtroppo, nessuno ci è mai riuscito.

Questi problemi sono i *problemi di Sakoda & Sipser*, ideati nel $1978$ e che riguardano il costo della simulazioni di automi non deterministici one-way e two-way per mezzo di automi two-way deterministici, ovvero si chiedono se il *movimento two-way* aiuta nell'*eliminazione del non determinismo*.

Cosa sappiamo su questi problemi? Diamo qualche *upper* e *lower bound*.

Per il problema da $1$NFA a $2$DFA, si sfrutta la *costruzione per sottoinsiemi* per ottenere un $1$DFA, che è anche un $2$DFA che non torna mai indietro, ottenendo quindi un numero di stati $ lt.eq 2^n . $ Un lower bound per questo problema invece è $ gt.eq n^2 . $

Per il problema da $2$NFA a $2$DFA, si fa un passaggio intermedio all'$1$NFA e poi al $1$DFA, che come prima è anche $2$DFA, quindi gli stati nel caso peggiore sono $ lt.eq 2^(n^2 + n) . $

Il lower bound, invece, è lo stesso del primo problema.

Ci sono casi particolari che hanno delle dimostrazioni precise:
- se utilizziamo dei *$2$DFA sweeping* il costo per la trasformazione è *esponenziale*;
- se consideriamo un *alfabeto unario* $Sigma = {a}$:
  - se facciamo la trasformazione da $2$NFA a $2$DFA l'upper bound è $ e^(O(log^2(n))) , $ ovvero una funzione *super polinomiale* ma meno di una esponenziale. Inoltre, se si dimostra che esiste un lower bound super polinomiale, allora abbiamo dimostrato che $ "L" = NL , $ ch sono argomenti di *teoria della complessità*;
  - se facciamo la trasformazione da $1$NFA a $2$DFA l'upper bound diventa esattamente $n^2$, quindi la trasformazione fatta è ottimale.

Dei ricercatori hanno troviamo una classe di *automi completi* da studiare per risolvere questi problemi. Possiamo vedere questa classe come la *classe NPC*, ovvero una cerchia ristretta di problemi NP che potrebbero far cadere tutta la gerarchia delle classi di complessità se si riuscisse a risolvere anche solo uno di questi.

Per ora la *congettura* che circola tra la gente è che i costi siano *esponenziali nel caso peggiore*, ma niente è stato dimostrato.
