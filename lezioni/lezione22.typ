// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 22 [23/05]

In questa lezione parleremo di troppe cose: toccheremo tutta la gerarchia di Chomsky, esclusi i linguaggi di tipo $0$, considerando alfabeti particolari e macchine riconoscitrici diverse dal solito. Andremo poi avanti anche con le grammatiche di tipo $2$.

== Automi a pila two-way

Modifichiamo un po' la macchina che stiamo usando da forse troppo tempo.

=== Definizione

Negli automi a stati finiti, il movimento *two-way* non aumentava la potenza computazionale del modello. Ma cosa succede negli *automi a pila two-way*?

Vediamo prima di tutto una rappresentazione del modello.

#figure(image("assets/22_2PDA.svg", width: 75%))

Come nei 2DFA, mettiamo degli *end marker* per marcare i bordi della stringa, perché ora la nostra testina di lettura può andare *avanti e indietro* sul nastro.

Con questo modello possiamo fare *molto di più* dei classici automi a pila.

=== Esempi

Vediamo una serie di linguaggi non CFL che riusciamo a riconoscere con questo modello.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n c^n bar.v n gt.eq 0} . $

  Questo linguaggio non è CFL perché una volta che controlliamo le $b$ con le $a$ perdiamo l'informazione su $n$. Con un *2DPDA* possiamo controllare le $a$ con le $b$, poi tornare all'inizio delle $b$ e controllare le $b$ con le $c$.
]

#example()[
  Definiamo il linguaggio $ L = {a^2^n bar.v n gt.eq 0} . $

  Con il *pumping lemma* avevamo mostrato che questo linguaggio non è CFL. Ora che abbiamo la definizione di sequenza algebrica, possiamo dire che questo linguaggio non è una *sequenza algebrica* perché le $a$ si allontanano sempre di più tra loro.

  Dobbiamo controllare se l'input è una potenza di $2$: per fare ciò continuiamo a dividere per $2$, verificando di avere sempre resto zero, salvo alla fine, dove abbiamo per forza resto $1$.

  Se $k$ è la lunghezza dell'input, possiamo eseguire i seguenti passi:
  + leggiamo l'input per intero, e ogni due $a$ carichiamo una lettera sulla pila, caricando in totale $k / 2$ caratteri. Con questa passata controlliamo se le $a$ sono pari o dispari;
  + svuotiamo la pila, spostandoci di una posizione a sinistra ogni volta che togliamo un carattere. Con questa mezza passata ci troviamo, appunto, a metà della stringa, sul carattere in posizione $k / 2$;
  + ricominciamo dal primo punto fino a quando non rimaniamo con un carattere solo, che mi dà per forza resto $1$.

  Anche questo, come quello di prima, è un *2DPDA*.
]

#example()[
  Definiamo il linguaggio $ L = {w w bar.v w in {a,b}^*} . $

  Anche questo linguaggio non è CFL, e lo avevamo mostrato con uno dei quattro criteri della scorsa lezione, non mi ricordo quale in questo momento.

  Come prima, carichiamo nella pila un carattere ogni due caratteri letti dell'input completo. Con questa prima passata controlliamo anche se il numero di caratteri è pari o dispari, e in quest'ultimo caso ci fermiamo e rifiutiamo. Spostiamoci poi in mezzo alla stringa scaricando la pila fino al carattere iniziale che avevamo anche prima.

  Chiamiamo $w$ la parte a sinistra della posizione nella quale ci troviamo ora. Carichiamo $w$ dal centro verso l'inizio: stiamo leggendo $w^R$, che caricata sulla pila diventa $w$.

  Spostiamoci di nuovo a metà della stringa, mettendo un separatore $hash$ tra $w$ e i caratteri che usiamo per spostarci. Ora che siamo a metà, togliamo $hash$ dal congelatore e, con $w$ sulla pila, possiamo controllare se la seconda parte è uguale a $w$.

  Anche questo è un fantastico *2DPDA*.
]

#example()[
  Non lo facciamo vedere, ma il linguaggio $ L = {w w^R bar.v w in {a,b}^*} $ ha un *2DPDA* che lo riconosce in maniera molto simile a quelle precedenti.
]

Come vediamo, questo modello è *molto potente*, talmente potente che nessuno sa quanto sia potente: infatti, tutti gli esempi visti sono stati risolti con un *2DPDA*, quindi anche da un *2NPDA* che fa partire una sola computazione alla volta, ma non sappiamo se $ 2"NPDA" =^? 2"DPDA" . $

Inoltre, non si conosce la relazione che si ha con i linguaggi di tipo $1$, che vediamo tra poco, ovvero non sappiamo se $ 2"DPDA" =^? "CS" . $

== Problemi di decisione dei CFL

Per finire questa lezione infinita, torniamo indietro ai linguaggi CFL e vediamo qualche *problema di decisione*. Per ora vedremo i problemi a cui sappiamo rispondere con quello che sappiamo, questo perché dei problemi di decisione richiedono conoscenze delle *macchine di Turing*, che per ora non abbiamo.

=== Appartenenza

Dato $L$ un CFL e una stringa $x in Sigma^*$, ci chiediamo se $x in L$.

Questo è molto facile: sappiamo che i CFL sono *decidibili* perché lo avevamo mostrato per i linguaggi di tipo $1$. Come complessità come siamo messi?

Sia $n = abs(x)$. Esistono algoritmi semplici che permettono di decidere in tempo $ T(n) = O(n^3) . $

L'*algoritmo di Valiant*, quasi incomprensibile, riconduce il problema di riconoscimento a quello di prodotto tra matrici $n times n$, che con l'algoritmo di Strassen possiamo risolvere in tempo $ T(n) = O(n^(log_2(7))) = O(n^(2.81...)) . $

L'algoritmo di Strassen in realtà poi è stato superato da altri algoritmi ben più sofisticati, che impiegano tempo quasi quadratico, ovvero $ T(n) = O(n^(2.3...)) . $

Una domanda aperta si chiede se riusciamo ad abbassare questo bound al livello quadratico, e questo sarebbe molto comodo: infatti, negli algoritmi di parsing avere degli algoritmi quadratici è apprezzabile, e infatti spesso di considerano sottoclassi per avvicinarsi a complessità lineari.

=== Linguaggio vuoto e infinito

Sia $L$ un CFL, ci chiediamo se $L eq.not emptyset.rev$ oppure se $abs(L) = infinity$.

Vediamo un teorema praticamente identico a uno che avevamo già visto.

#theorem()[
  Sia $L subset.eq Sigma^*$ un CFL, e sia $N$ la costante del pumping lemma per $L$. Allora:
  + $L eq.not emptyset.rev sse exists z in L bar.v abs(z) < N$;
  + $abs(L) = infinity sse exists z in L bar.v N lt.eq abs(z) < 2N$.
]

Gli algoritmi per verificare la non vuotezza o l'infinità non sono molto efficienti: infatti, prima di tutto bisogna trovare $N$, e se ho una grammatica è facile (basta passare in tempo lineare per la FN di Chomsky), ma se non ce l'abbiamo è un po' una palla. Poi dobbiamo provare tutte le stringhe fino alla costante, che sono $2^N$, e con questo rispondiamo alla non vuotezza. Per l'infinità è ancora peggio.

Si possono implementare delle tecniche che lavorano sul *grafo delle produzioni*, ma sono molto avanzate e (penso) difficili da utilizzare.

=== Universalità

Dato $L$ un CFL, vogliamo sapere se $L = Sigma^*$, ovvero vogliamo sapere se siamo in grado di generare tutte le stringhe su un certo alfabeto.

Nei linguaggi regolari passavamo per il complemento per vedere se il linguaggio era vuoto, ma nei CFL *non abbiamo il complemento*, quindi non lo possiamo utilizzare.

Infatti, questo problema *non si può decidere*: non esistono algoritmi che stabiliscono se un PDA riesce a riconoscere tutte le stringhe, o se una grammatica riesce a generare tutte le stringhe.
