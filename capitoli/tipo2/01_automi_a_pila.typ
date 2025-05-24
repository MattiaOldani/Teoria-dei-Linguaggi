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

#import "@preview/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp

#import "@preview/fletcher:0.5.5": diagram, node, edge


// Capitolo

= Automi a pila

Lasciamo finalmente stare gli automi a stati finiti per passare ad una nuova classe di riconoscitori: gli *automi a pila*. Questi praticamente sono degli automi a stati finiti con testina di lettura one-way ai quali viene aggiunta una *memoria infinita con restrizioni di accesso*, ovvero l'accesso avviene solo sulla cima della memoria, con politica LIFO.

#figure(image("assets/01_pda.svg", width: 50%))

Come vediamo, la parte degli automi a stati finiti ce l'abbiamo ancora, ma ora abbiamo una *memoria esterna*, che nell'immagine è sulla destra, che possiamo utilizzare con una politica di accesso LIFO. Per via di questa politica, questi automi sono anche detti *automi pushdown*, o *PDA*, perché quando inserisci qualcosa lo fai a spingere giù.

== Definizione

Vediamo subito la definizione formale *non deterministica* dei PDA.

Sia $M$ un PDA definito dalla tupla $ (Q, Sigma, Gamma, delta, q_0, Z_0, F) $ tale che:
- $Q$ è un *insieme finito non vuoto di stati*, che rappresenta il controllo a stati finiti;
- $Sigma$ è un *alfabeto finito non vuoto di input*;
- $Gamma$ è un *alfabeto finito non vuoto di simboli della pila*;
- $delta$ è la *funzione di transizione*;
- $q_0 in Q$ è lo *stato iniziale*;
- $Z_0 in Gamma$ è il *simbolo iniziale sulla pila*;
- $F subset.eq Q$ è un *insieme di stati finali*.

La *funzione di transizione* è definita come segue: $ delta : Q times (Sigma union {epsilon}) times Gamma arrow.long 2^(Q times Gamma^*) . $ In poche parole, consideriamo lo *stato corrente*, il *simbolo sulla testina* o una $epsilon$-mossa e il *simbolo sulla cima della pila* per capire in che stato dobbiamo muoverci e che stringa andare ad inserire sulla pila. La lettura del carattere in cima alla pila lo va a *distruggere*.

Questa versione però non ci piace molto perché $Gamma^*$ è potenzialmente un *insieme infinito*, e non ci piace avere un insieme infinito di possibilità, quindi sostituiamo la definizione della funzione di transizione con questa analoga, ma molto migliore per noi: $ delta : Q times (Sigma union {epsilon}) times Gamma arrow.long PF(Q times Gamma^*) . $ Con PF intendiamo l'*insieme delle parti finite*, ovvero un insieme finito di possibilità prese dall'insieme delle parti. Ora sì che la definizione ci piace.

Facciamo qualche esempio. Come convenzione useremo le *maiuscole* per i simboli della pila.

#example()[
  Facciamo che la funzione di transizione sia definita in questo modo: $ delta(q, a, A) = {(q_1, epsilon), (q_2, B C C)} . $

  #figure(image("assets/01_primo_esempio.svg", width: 50%))

  Con $alpha$ nel disegno si intende una stringa in $Gamma^*$ perché oltre ad $A$ potremmo avere altro.

  Cosa vuol dire quella regola della funzione di transizione? Ci sta dicendo che se ci troviamo nello stato $q$, leggiamo $a$ sul nastro leggiamo $A$ sulla cima della pila, possiamo:
  - andare in $q_1$ e non mettere altro sulla pila, praticamente consumando un simbolo in input;
  - andare in $q_2$ e mettere sulla pila la stringa $B C C$.

  Vediamo la rappresentazione dei due casi nei quali possiamo finire.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [#figure(image("assets/01_primo_esempio_r1.svg"))], [#figure(image("assets/01_primo_esempio_r2.svg"))],
  )

  Per convenzione, quando inseriamo una stringa sulla pila, l'inserimento avviene da destra verso sinistra. In poche parole, se inseriamo la stringa $X in Gamma^*$ nella pila, se la togliessimo noi leggeremmo, in ordine, esattamente $X$. In altre parole ancora, quando leggiamo una stringa da inserire è come se la stessimo leggendo dall'alto verso il basso.

  Abbiamo la possibilità anche di fare delle $epsilon$-mosse: supponiamo di aggiungere la regola $ delta(q, epsilon, A) = {(r, B A A)} . $

  Ora abbiamo tre scelte a disposizione. Le $epsilon$-mosse possiamo vederle come delle *mosse interne*, che avvengono senza leggere l'input, e che ci permettono di spostarci negli stati modificando eventualmente la pila.

  #figure(image("assets/01_primo_esempio_r3.svg", width: 50%))
]

Una *configurazione* è una fotografia dell'automa in un dato istante di tempo, e ci dice quali sono le informazioni rilevanti per il futuro per definire al meglio la macchina, ovvero:
- lo *stato corrente*;
- il *contenuto del nastro* che ci manca da leggere;
- il *contenuto della pila*.

Una configurazione è quindi una *tripla* $ (q, a y, A alpha) $ che contiene lo stato corrente, il contenuto del nastro ancora da leggere indicato dal carattere corrente $a$ unito al resto della stringa $y$ e il contenuto della pila indicato dal carattere in testa $A$ e dal resto della pila $alpha$.

Una *mossa* è l'applicazione della funzione di transizione, ovvero un passaggio $ (q, a y, A alpha) arrow.long (p, y, gamma alpha) sse (p,gamma) in delta(q, a, A) . $ Analogamente, un passaggio che usa le $epsilon$-mosse è un passaggio $ (q, a y, A alpha) arrow.long (p, a y, gamma alpha) arrow.long (p,gamma) in delta(q, epsilon, A) . $

Una *computazione* è una serie di mosse che partono da una configurazione iniziale e mi portano in una configurazione finale. Di queste ultime parleremo tra poco. Torniamo sulle computazioni.

Come con i passi di derivazione, una computazione che usa una sola mossa si indica con $ C' tack.long C'' . $ Se invece una computazione impiega $k$ passi, si indica con $ C' tack.long^k C'' . $ Infine, per indicare una computazione con un numero generico di passi, maggiori o uguali a zero, si usa $ C' tack.long^* C'' . $

== Accettazione

Abbiamo parlato di arrivare in una configurazione accettante, ma quando *accettiamo*? Dobbiamo capire da dove partire e dove arrivare.

Quando partiamo abbiamo la stringa $w$ sul nastro, ci troviamo nello stato iniziale $q_0$ e abbiamo $Z_0$ sulla pila: questa è detta *configurazione iniziale* ed è la tripla $ (q_0, w, Z_0) . $

Le *configurazioni finali* dipendono dal tipo di nozione di accettazione che vogliamo utilizzare.

L'*accettazione per stati finali* ci obbliga a leggere tutto l'input e a finire in uno stato finale, con la pila che contiene quello che vuole, ovvero dobbiamo arrivare in una configurazione $ (q, epsilon, gamma) $ dove lo stato $q$ è finale. Il *linguaggio accettato per stati finali* è l'insieme $ L(M) = {w in Sigma^* bar.v (q_0, w, Z_0) tack.long^* (q, epsilon, gamma) bar.v q in F and gamma in Gamma^*} . $ Questa nozione è comoda perché vede i PDA come una *estensione* degli automi a stati finiti.

L'*accettazione per pila vuota* invece è una nozione più naturale: tutto ciò che metto nella pila lo devo anche buttare via. Possiamo arrivare in un qualsiasi stato, basta aver svuotato la pila. Il *linguaggio accettato per pila vuota* è l'insieme $ N(M) = {w in Sigma^* bar.v (q_0, w, Z_0) tack.long (q, epsilon, epsilon) bar.v q in Q} . $

Se svuotiamo la pila prima di finire l'input allora quella computazione si blocca perché noi dobbiamo sempre leggere qualcosa dalla pila.

Le due accettazioni sono *equivalenti*, o meglio, possiamo passare da una accettazione all'altra ma i linguaggi che accettano sono differenti. A parità di automa $M$, gli insiemi $L(M)$ e $N(M)$ in generale sono diversi, ma possiamo passare da un modello all'altro mantenendo il linguaggio accettato con facilità. Una ulteriore nozione di accettazione unisce stati finali e pila vuota, ma rimane comunque equivalente. Avere due nozioni è comodo: se una versione ci esce estremamente comoda allora la andiamo ad utilizzare, altrimenti andremo ad utilizzare l'altra.

Vediamo ora qualche esempio.

#example()[
  Prendiamo il nostro migliore amico, il linguaggio $ L = {a^n b^n bar.v n gt.eq 1} . $

  Lo possiamo riconoscere con un PDA, visto che abbiamo visto che non è regolare? Bhe sì: con i DFA non riuscivamo a ricordare il numero di $a$ e poi confrontare questo numero con le $b$, mentre ora riusciamo a farlo, le pile sanno contare.

  Possiamo pensare ad un automa che ogni volta che legge una $a$ butta una $A$ dentro la pila, e quando legge una $b$ toglie una $A$ dalla pila. Accettiamo se abbiamo messo $n$ caratteri $A$ dentro la pila e poi ne abbiamo tolti $n$, quindi qua viene comoda l'*accettazione per pila vuota*.

  Andiamo a definire la funzione di transizione.

  Iniziamo a togliere $Z_0$ dalla prima e inseriamo la prima $A$ in segno di aver letto la prima $a$ della stringa, che abbiamo per forza per definizione, quindi $ delta(q_0, a, Z_0) = {(q_0, A)} . $

  Utilizziamo lo stato $q_0$ per leggere tutte le $a$ della stringa, ovvero $ delta(q_0, a, A) = {(q_0, A A)} . $

  Appena troviamo una $b$ iniziamo a cancellare e cambiamo stato, visto che non ci aspettiamo più delle $a$ nella stringa, quindi $ delta(q_0, b, A) = {(q_1, epsilon)} . $ Inseriamo $epsilon$ sulla stringa perché la $A$ da cancellare per la lettura di $b$ è già stata cancellata dalla lettura.

  Andiamo a terminare la lettura delle $b$, quindi $ delta(q_1, b, A) = {(q_1, epsilon)} . $

  Abbiamo detto che accettiamo per pila vuota, quindi $L = N(M)$.
]

#example()[
  Se invece volessimo accettare il linguaggio precedente per *stati finali*?

  Non dobbiamo cancellare $Z_0$ dalla pila perché se una stringa viene accettata cancella tutta la pila, quindi ci serve un carattere fittizio dentro per poterlo leggere e spostarci in uno stato finale. Modifichiamo quindi la mossa iniziale con la mossa $ delta(q_0, a, Z_0) = delta(q_0, A Z_0) . $

  Se abbiamo una stringa del linguaggio alla fine delle $b$ dobbiamo spostarci in uno stato finale, quindi aggiungiamo la regola $ delta(q_1, epsilon, Z_0) = {(q_f, Z_0)} bar.v q_f in F . $

  Con queste modifiche abbiamo $L = L(M)$.
]

#example()[
  Se invece volessimo accettare anche $epsilon$? Il linguaggio diventa $ L = {a^n b^n bar.v n gt.eq 0} . $

  Con l'*accettazione per pila vuota*, nello stato iniziale possiamo aggiungere una regola che svuota subito la pila, ovvero aggiungiamo la regola $ delta(q_0, epsilon, Z_0) = {(q_0, epsilon)} . $

  Stiamo scommettendo che l'input è già finito, ovvero abbiamo solo $epsilon$ sul nastro, ma questo ha appena aggiunto il *non determinismo* al nostro automa a pila.

  Con l'*accettazione per stati finali* invece ci spostiamo direttamente nello stato $q_f$ a partire da $q_0$, ovvero aggiungiamo la regola $ delta(q_0, epsilon, Z_0) = {(q_f, epsilon)} . $

  Come prima, abbiamo aggiunto del *non determinismo* all'automa a pila, ma questo lo possiamo togliere: come facciamo a fare ciò?

  Introduciamo uno stato $q_I$ finale che diventa anche iniziale al posto di $q_0$, quindi ora $ F = {q_I, q_f} . $ Se inseriamo sul nastro la stringa vuota allora noi accettiamo, perché siamo in uo stato finale e non abbiamo altri simboli da leggere. Per passare poi al vecchio automa mettiamo una regola $ delta(q_I, a, Z_0) = {(q_0, A Z_0)} . $
]

== Determinismo VS non determinismo

Con il termine *non determinismo* non intendiamo le $epsilon$-mosse da sole, quelle le possiamo avere, ma intendiamo un mix tra mosse che leggono e mosse che non leggono.

#definition([Determinismo])[
  Sia $M$ un PDA. Allora $M$ è *deterministico* se:
  + ogni volta che ho una $epsilon$-mossa da un certo stato e con un certo simbolo sulla pila, non ho mosse che leggono simboli dal nastro a partire dallo stesso stato e con lo stesso simbolo sulla pila, ovvero $ forall q in Q quad forall A in Gamma quad delta(q, epsilon, A) eq.not emptyset.rev arrow.long.double forall a in Sigma quad delta(q, a, A) = emptyset.rev ; $
  + come nel caso classico, considero un carattere, o anche $epsilon$, allora a parità di stato corrente e simbolo sulla pila, ho al massimo una transizione possibile, ovvero $ forall q in Q quad forall A in Gamma quad forall sigma in Sigma union {epsilon} quad abs(delta(q, sigma, A)) lt.eq 1 . $
]

A differenza del caso classico, il determinismo e il non determinismo non sono ugualmente potenti: un automa a pila non deterministico è *più potente* di un automa a pila deterministico, che riconosce una sottoclasse di linguaggi diversa dai linguaggi di tipo $2$, che sono riconosciuti dai PDA non deterministici.

== Trasformazioni

Avevamo parlato dell'*equivalenza* dell'accettazione per stati finali e per pila vuota: infatti, esistono due trasformazioni che permettono di passare da un automa all'altro, mantenendo il linguaggio di partenza riconosciuto inalterato. L'equivalenza infatti ci diceva che, partendo da un automa $M$ che riconosce per stati finali, abbiamo una trasformazione che ci dà $M'$ che riconosce per pila vuota che riconosce lo stesso linguaggio di $M$, e viceversa.

/ Stati finali $arrow.long$ pila vuota:
  Dobbiamo trasformare un automa che accetta per stati finali in un automa che accetta per pila vuota. Con quest'ultimo simuliamo il primo, e ogni volta che vado in uno stato finale mi sposto in uno *stato di svuotamento*, che se raggiunto in mezzo blocca la pila, ma se raggiunto alla fine mi fa accettare. \ \ Abbiamo quindi $M = (Q, Sigma, Gamma, delta, q_0, Z_0, F)$ un PDA con $L = L(M)$. Definiamo ora $ M' = (Q union {q_e, q'_0}, Sigma, Gamma union {X}, delta', q'_0, X, emptyset.rev) $ un PDA tale che:
  - per metterci in una situazione piacevole per la fine usiamo un *truccaccio* definito dalla regola $ delta(q'_0, epsilon, X) = {(q_0, Z_0 X)} , $ ovvero prima di far partire la computazione dell'automa $M$ andiamo ad inserire un carattere $X$ in fondo alla pila, vedremo dopo perché;
  - l'automa deve eseguire *tutte le mosse* di $M$, ovvero $ forall q in Q quad forall sigma in Sigma union {epsilon} quad forall Z in Gamma quad delta(q, sigma, Z) subset.eq delta'(q, sigma, Z) , $ che scritto così significa che tutte le mosse che trovavamo nell'applicazione di delta ad una certa tripla le abbiamo anche nella nuova funzione di transizione, che però conterrà anche altro, che vedremo tra poco;
  - aggiungiamo uno *stato di svuotamento* per pulire la pila, definito dalle regole $ forall q in F quad forall Z in Gamma union {X} quad (q_e, epsilon) in delta'(q, epsilon, Z) \ forall Z in Gamma union {X} quad delta'(q_e, epsilon, Z) = {(q_e, epsilon)} , $ ovvero con la prima regola, ogni volta che mi trovo in uno stato finale *non deterministicamente* mi posso spostare nello stato di svuotamento, mentre con la seconda regola effettivamente svuoto.

  A cosa ci serve il *carattere* $X$? Facciamo finta di non mettere il carattere $X$. Se $M$ accetta una stringa $x$ arrivando con la pila vuota nessun problema, non ci spostiamo nello stato di svuotamento ma abbiamo la pila vuota quindi ottimo. Se invece $M$ non accetta una stringa $x$ ma arriva alla fine con la pila vuota, il simbolo $X$ messo all'inizio ci copre da una eventuale accettazione errata, perché non riusciremo ad andare nello stato di svuotamento per avere la pila vuota, anche se $M$ ci finisce in quel modo. Diciamo che abbiamo messo $X$ come se fosse una guardia, che ci copre questo preciso caso.

  Purtroppo, con questa costruzione abbiamo buttato dentro del *non determinismo* quando facciamo i passaggi in $q_e$ da uno stato finale.

/ Pila vuota $arrow.long$ stati finali:
  Il percorso opposto invece parte da un PDA $ M = (Q, Sigma, Gamma, delta, q_0, Z_0, F) $ tale che $L = N(M)$. Definiamo il PDA $ M' = (Q union {q'_0, q_f}, Sigma, Gamma union {X}, delta', q'_0, X, {q_f}) $ che come idea ha quella di simulare $M$ e, ogni volta che arriva con pila vuota, ci spostiamo nello stato finale. Vediamo i vari passi:
  - come prima, usiamo un *truccaccio* per infilare $X$ sotto la pila, quindi abbiamo la regola $ delta'(q'_0, epsilon, Z_0) = {(q_0, Z_0 X)} $ che usiamo per inserire $X$ come trigger per andare in uno stato finale;
  - simuliamo l'automa $M$ senza aggiungere niente, quindi $ forall q in Q quad forall sigma in Sigma union {epsilon} quad forall Z in Gamma quad delta'(q, sigma, Z) = delta(q, sigma, Z) ; $
  - ogni volta che leggiamo $X$ sulla cima della pila vuol dire che $M$ ha svuotato la pila, quindi devo andare nello stato finale, ovvero $ forall q in Q quad delta'(q, epsilon, X) = {(q_f, epsilon)} ; $ ovviamente, se andiamo in questo stato a metà stringa ci blocchiamo, altrimenti se ci andiamo alla fine è tutto ok.

  A differenza di prima, se partiamo da un automa *deterministico*, quello che otteniamo è ancora un automa *deterministico*.

== Esempi

Vediamo degli esempi di qualche linguaggio che possiamo riconoscere con degli automi a pila.

#example()[
  Definiamo il linguaggio $ L = {w hash w^R bar.v w in {a,b}^*} . $

  Un automa a pila per questo linguaggio memorizza $w$ sulla pila, legge $hash$ e poi verifica che la stringa $w^R$ sia presente sulla pila.

  Possiamo usare due stati:
  - $q_0$ lo usiamo per copiare $w$ sulla pila;
  - $q_1$ lo usiamo per confrontare il carattere sulla pila con quello sul nastro.

  In questo caso ci viene naturale accettare per pila vuota. Inoltre, otteniamo un automa deterministico, detto anche *DPDA*.
]

Un linguaggio riconosciuto da automi a pila deterministici DPDA fa parte dell'insieme dei *linguaggi context-free deterministici*, detti anche *DCFL*.

#example()[
  Definiamo ora il linguaggio $ L' = {w w^R bar.v w in {a,b}^*} $ insieme delle stringhe palindrome di lunghezza pari.

  In questo caso non riusciamo a farlo con un DPDA (difficile da dimostrare, lo faremo avanti) perché dobbiamo scommettere di essere arrivati a metà della stringa da riconoscere, quindi dobbiamo usare del *non determinismo*.
]

Analogamente, un linguaggio riconosciuto da automi a pila non deterministici, detti anche *NPDA* o solo *PDA*, da parte dell'insieme dei *linguaggi context-free*, detti anche *CFL*.
