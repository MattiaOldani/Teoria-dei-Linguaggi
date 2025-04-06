// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 12 [04/04]

== Problemi di decisione per i linguaggi regolari

I *problemi di decisione* sono dei problemi che hanno come unica risposta *SI* oppure *NO*. Sui linguaggi regolari abbiamo una serie di problemi di decisione interessanti che possono essere risolti in maniera automatica. Questa lista di problemi diventerà ancora più briosa quando andremo nei linguaggi context-free.

=== Linguaggio vuoto e infinito

Dato un linguaggio $L$ possiamo chiederci se $L eq.not emptyset.rev$, ovvero se $L$ *non è vuoto*, o se $L$ è *infinito*.

#lemma()[
  Sia $L$ un linguaggio regolare e sia $N$ la costante del pumping lemma per $L$. Allora:
  + $L eq.not emptyset.rev sse L$ contiene almeno una stringa di lunghezza $< N$;
  + $L$ è infinito $sse L$ contiene almeno una stringa $z$ con $N lt.eq abs(z) < 2N$.
]

#lemma-proof()[
  Partiamo con la dimostrazione del punto $1$.

  [$arrow.long.double.l$] Se $L$ contiene una stringa di lunghezza $< N$ allora banalmente $L eq.not emptyset.rev$.

  [$arrow.long.double$] Se $L eq.not emptyset.rev$ sia $z in L$ la stringa di lunghezza minima in $L$. Per assurdo sia $abs(z) gt.eq N$, ma allora per il pumping lemma possiamo dividere $z$ come $z = u v w$. Sappiamo dal terzo punto che possiamo ripetere un numero arbitrario di volte la stringa $v$ e stare comunque in $L$. Ripetiamo $v$ un numero di volte pari a $0$: otteniamo la stringa $z' = u w$ che appartiene a $L$ per il pumping lemma. Avevamo detto che $z$ era la stringa più corta di $L$, ma abbiamo appena mostrato che $abs(z') < abs(z)$: questo è assurdo e quindi $abs(z) < N$.

  Dimostriamo ora il punto $2$.

  [$arrow.long.double.l$] Se $L$ contiene una stringa $z$ di lunghezza $N lt.eq abs(z) lt.eq 2N$, visto che $abs(z) gt.eq N$ applichiamo il pumping lemma per scomporre $z$ in $z = u v w$. Per il terzo punto possiamo ripetere un numero arbitrario di volte il fattore $v$ e rimanere comunque in $L$. Ma allora $L$ è infinito.

  [$arrow.long.double$] Se $L$ è infinito, sicuramente esiste una stringa $z$ che è lunga almeno $N$. Tra tutte queste stringhe, scegliamo la più corta di tutte. Per assurdo sia $abs(z) gt.eq 2N$, ma allora possiamo scomporre $z$ come $z = u v w$ con $abs(u v) lt.eq N$ e $v eq.not epsilon$. Adesso andiamo a ripetere un numero di volte pari a $0$ il fattore $v$, ottenendo $z' = u w in L$. Quale è la sua lunghezza? Possiamo dire che $abs(z') = abs(z) - abs(v)$ ma $abs(v)$ è al massimo $N$ per il primo punto analizzato, quindi $abs(z')$ è almeno $N$ e al massimo $2N$, ma questo è assurdo perché $z$ era la più corta tra tutte le stringhe e, per assurdo, l'avevamo posta di lunghezza $gt.eq 2N$.
]

Questo lemma ci dice che se vogliamo sapere se un linguaggio non è vuoto basta generare tutte le stringhe di lunghezza fino a $N$ escluso e vedere se ne abbiamo una nel linguaggio, mentre se vogliamo sapere se un linguaggio è infinito basta generare tutte le stringhe di lunghezza compresa tra $N$ incluso e $2N$ escluso e vedere se ne abbiamo una nel linguaggio.

Quale è il problema? Sicuramente è un approccio *inefficiente*, visto che dobbiamo generare un numero esponenziale di casi da analizzare. Possiamo fare di meglio? *SI*: per vedere se un linguaggio non è vuoto devo cercare un *cammino* dallo stato iniziale ad uno stato finale, mentre per vedere se un linguaggio è infinito potrei cercare i *cicli* sui cammini del punto precedente. Ci siamo quindi ricondotti a dei *problemi su grafi*, che sappiamo risolvere efficientemente.

=== Appartenenza

Dato $L$ un linguaggio regolare e $x in Sigma^*$ una stringa, il problema di *appartenenza* si chiede se $x in L$. Questo lo sappiamo fare tranquillamente in tempo lineare: basta eseguire il DFA (se ce l'abbiamo) e vedere se finiamo in uno stato finale.

=== Universalità

Dato $L$ un linguaggio regolare, il problema di *universalità* si chiede se $L = Sigma^*$, ovvero $L$ contiene tutte le stringhe della chiusura di Kleene dell'alfabeto $Sigma$. Questo sembra difficile, ma possiamo sfruttare le operazioni che rendono chiusi i linguaggi regolari: infatti, possiamo chiederci invece se $ L = Sigma^* sse L^C = emptyset.rev $ e questo lo sappiamo fare grazie al lemma precedente.

=== Inclusione e uguaglianza

Infine, l'ultimo problema che vediamo prende due linguaggi $L_1$ e $L_2$ regolari e si chiede se $L_1 subset.eq L_2$. Questo problema si chiama problema dell'*inclusione* e lo possiamo risolvere manipolando quello che ci viene chiesto: infatti, al posto dell'inclusione, possiamo chiederci se $ L_1 subset.eq L_2 sse L_1 inter L_2^C = emptyset.rev , $ che sappiamo fare tranquillamente grazie al lemma.

Se non volessimo utilizzare le proprietà di chiusura, possiamo costruire un *automa prodotto* che ha come stati finali tutte le coppie di stati dove il primo accetta $L_1$ e il secondo rifiuta $L_2$.

E se invece volessimo risolvere il problema di *uguaglianza*, ovvero quello che si chiede se $L_1 = L_2$? Basta dimostrare la doppia inclusione $L_1 subset.eq L_2 and L_2 subset.eq L_1$ e siamo a cavallo. Un algoritmo diverso utilizza le classi di equivalenza, ma non lo vedremo.

== Altre operazioni

Vediamo qualche *operazione* un pelo più complicata.

=== Raddoppio

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
- la *funzione di transizione* $delta'$ è tale che $ delta'([p,q',q''], a) = [p, delta(q',a), delta(q'',a)] $ che manda avanti i due automi in parallelo.

Purtroppo, quello che otteniamo è un *NFA* per via di tutti gli stati iniziali multipli.

=== Metà

Un'altra operazione strana che vediamo prende un linguaggio regolare $L$ e calcola $ 1/2 L = {x in Sigma^* bar.v exists y bar.v abs(y) = abs(x) and x y in L} . $

In poche parole, prendo le stringhe di $L$ di lunghezza pari e prendo la prima metà di queste.

#example()[
  Dato il linguaggio $L = {a^n b^n bar.v n gt.eq 0}$ allora $ 1/2 L = a^* . $
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

  #figure(image("assets/12_esempio_matrice.svg"))

  Andiamo a calcolare le due matrici di transizione delle lettere $a$ e $b$.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$ M_a = mat(0,1,0; 0,0,1; 1,0,0) $], [$ M_b = mat(1,0,0; 0,0,1; 0,1,0) $],
  )

  Ovviamente, se l'automa è un *DFA* abbiamo un solo $1$ per ogni riga.

  Se calcoliamo $M_a M_b$ otteniamo la matrice che ci dice in che stato finiamo leggendo $a b$ in base allo stato di partenza che scegliamo. Infatti: $ M_(a b) = M_a M_b = mat(0,1,0; 0,0,1; 1,0,0) mat(1,0,0; 0,0,1; 0,1,0) = mat(0,0,1; 0,1,0; 1,0,0) $ che indica esattamente gli stati che raggiungiamo leggendo la stringa $a b$.

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

Torniamo ora sull'operazione $1/2 L$: come possiamo fare questo con le matrici definite poco fa? Se prima le matrici per entrambi gli automi erano le stesse, qua la seconda parte, visto che viene inventata, si riduce ad un problema di *raggiungibilità del grafo*.

Quello che faremo è mandare avanti il primo automa deterministicamente e il secondo invece verrà rappresentato dalle potenze della *matrice dell'automa* per vedere la raggiungibilità. Qua con matrice dell'automa intendiamo la prima versione che abbiamo definito della matrice.

La matrice dell'automa la otteniamo come somma booleana di tutte le matrici $M_x$ associate al carattere $x in Sigma$. Facendo poi la potenza $k$-esima di questa matrice riusciamo a vedere la raggiungibilità dopo aver letto $k$ simboli.

Definiamo quindi l'automa $ A' = (Q', Sigma, delta', q'_0, F') $ tale che:
- l'*insieme degli stati* è formato da tutte le coppie $ Q' = Q times {0,1}^(abs(Q) times abs(Q)) $ dove la prima componente rappresenta lo stato dell'automa che viene mandato avanti deterministicamente e il secondo rappresenta tutte le potenze della matrice dell'automa;
- lo *stato iniziale* parte dallo stato iniziale e dalla matrice identità, ovvero $ q'_0 = (q_0, I_abs(Q)) ; $
- la *funzione di transizione* $delta'$ è tale che $ delta'([q,K], a) = (delta(q,a), K M) ; $
- l'*insieme degli stati finali* contiene tutte le coppie dove la matrice, osservata nella riga definita dalla prima componente, contiene un $1$ in una colonna di uno stato finale, ovvero $ F' = {[p,K] bar.v exists q in F bar.v K[p,q] = 1} . $

Il numero di stati è considerevole, considerando anche il prodotto cartesiano, ma abbiamo ottenuto un DFA, che invece prima non avevamo.

=== Matrici su NFA

Per ora abbiamo calcolato la matrice delle transizioni dei DFA, che succede se abbiamo un NFA? Ovviamente, in un NFA, avendo la possibilità di fare delle computazioni parallele, nella riga di una matrice associata ad una lettera possiamo avere più valori a $1$.

Calcolando però le potenze della matrice dell'automa cosa otteniamo?

#example()[
  Dato il seguente automa divertiamoci con qualche matrice.

  #figure(image("assets/12_matrice_NFA.svg"))

  Le matrici di transizione associate alle lettere $a$ e $b$ sono:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$ M_a = mat(1,1; 0,1) $], [$ M_b = mat(0,0; 1,1) $],
  )

  Proviamo a calcolare la matrice $M_(a a)$ calcolandola con la somma intera: $ M_(a a) = mat(1,1; 0,1) mat(1,1; 0,1) = mat(1,2; 0,1) . $

  Questa matrice non rappresenta più la raggiungibilità con una matrice booleana, ma *conta il numero di cammini* che abbiamo nell'automa per raggiungere quello stato. Usando la somma booleana invece avremmo ancora la matrice che definisce la raggiungibilità.

  I numeri che vediamo scritti nella tabella sono i *gradi di ambiguità* delle varie stringhe (_se ci limitiamo a quelle accettate_): questo rappresenta appunto il numero di modi in cui possiamo arrivare a quella stringa partendo dallo stato che indicizza la riga. Il *grado di ambiguità del grafo* è il massimo grado di ambiguità delle stringhe accettate.
]

== Varianti di automi

Per finire questa lezione infinita, vediamo qualche *variante* di automi.

=== Automi pesati

La prima variante che vediamo sono gi *automi pesati*. Essi associano ad ogni transizione un peso. Il *peso di una stringa* viene calcolato come la somma dei pesi delle transizioni che la stringa attraversa per essere accettata. Questo peso poi può essere usato in problemi di ottimizzazione, come trovare il cammino di peso minimo, ma questo ha senso solo su NFA.

=== Automi probabilistici

Un tipo particolare di automi pesati sono gli *automi probabilistici*, che come pesi sulle transizioni hanno la probabilità di effettuare quella transizione. Visto che parliamo di *probabilità*, i pesi sono nel range $[0,1]$ e, dato uno stato, tutte le transizioni uscenti sommano a $1$. In realtà, potremmo sommare a meno di $1$ se nascondiamo lo stato trappola. Con questi automi possiamo chiederci con che probabilità accettiamo una stringa.

Questi automi li possiamo usare come *riconoscitori a soglia*: tutte le parole oltre una certa soglia le accettiamo, altrimenti le rifiutiamo.

Questi automi comunque non sono più potenti dei DFA: si può dimostrare che se la soglia $lambda$ è *isolata*, ovvero nel suo intorno non cade nessuna parola, allora possiamo trasformare questi automi probabilistici in DFA. Se la soglia non è isolata riusciamo a riconoscere una strana classe di linguaggi, che però ora non ci interessa.
