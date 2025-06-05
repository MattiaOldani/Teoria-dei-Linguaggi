// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Capitolo

= Macchine di Turing

Finiamo finalmente la gerarchia di Chomsky parlando finalmente di *macchine di Turing*.

== Introduzione

Come costruiamo una macchina di Turing?

Partiamo da un *automa a stati finiti*: questa macchina è one-way/two-way con un nastro che non può essere riscritto. Se aggiungiamo la possibilità di testina read-write allora otteniamo un *automa limitato linearmente*. Per ottenere finalmente una *macchina di Turing* dobbiamo rompere il vincolo di memoria pari alla lunghezza dell'input, togliendo i marcatori $lmarker rmarker$ e inserire due porzioni di nastro potenzialmente infinite. Queste celle che non contengono l'input contengono il simbolo $blank$.

#figure(image("assets/01/MdT.svg", width: 75%))

A differenza degli LBA abbiamo *memoria illimitata*, quindi se ci serve dello spazio ce l'abbiamo sempre a disposizione per fare conti o per ricordarci qualcosa.

Questa memoria infinita ci permette di riconoscere i linguaggi di tipo $0$. Infatti, le MdT sono *equivalenti* alle grammatiche di tipo $0$. Vediamo perché.

#theorem()[
  Le macchine di Turing sono equivalenti alle grammatiche di tipo $0$.
]

#theorem-proof()[
  Vediamo le due trasformazioni.

  [*Grammatica $arrow$ macchina di Turing*]

  Nelle grammatiche di tipo $1$ la condizione sulle produzioni $alpha arrow.long beta$ tale che $ abs(alpha) lt.eq abs(beta) $ ci permetteva di ricreare le produzioni al contrario sul nastro con la certezza di restare dentro il nastro per via della lunghezza della stringa che inserivamo.

  Nelle grammatiche di tipo $0$ invece non abbiamo vincoli, quindi ricreare le derivazioni al contrario potrebbe sforare il nastro, ma ora che abbiamo spazio a disposizione lo possiamo sfruttare per fare tutte le derivazioni possibili.

  [*Macchina di Turing $arrow$ grammatica*]

  Si può fare, ci fidiamo.
]

Questa limitazione che non abbiamo più sulle grammatiche causa anche la *semi-decidibilità* dei linguaggi di tipo $0$, o se vogliamo, il *riconoscimento parziale* dei linguaggi di tipo $0$. Questo non succedeva nei linguaggi di tipo $1$ perché la condizione sulle produzioni faceva terminare ad un certo punto le stringhe possibili generabili.

Con *semi-decidibilità* di un linguaggio $L$ di tipo $0$ intendiamo che:
- se una stringa appartiene a $L$ allora la macchina si ferma e accetta;
- se una stringa non appartiene a $L$ allora la macchina:
  - può fermarsi e non accettare;
  - può entrare in *loop infinito*.

#figure(image("assets/01/riconoscitore_MdT.svg", width: 65%))

Le macchine di Turing sono un modello in grado di calcolare tutte le *funzioni calcolabili* da un computer. Queste funzioni sono dette *funzioni ricorsive*, ma con "ricorsive" non intendiamo le funzioni che chiamano sé stesse.

== Varianti di MdT

Quella che abbiamo visto ora è una *MdT a $1$ nastro*. Da questa nostra base possiamo tirare fuori molte *varianti* interessanti.

=== Nastro semi-infinito

Abbiamo visto che limitando la lunghezza del nastro della macchina collassiamo nei linguaggi context-sensitive, ma se limitiamo il nastro da una parte sola otteniamo una MdT con *nastro semi-infinito*, o *infinito a destra*.

#figure(image("assets/01/semi-infinito.svg", width: 75%))

#lemma()[
  Una MdT con nastro semi-infinito è equivalente ad una MdT a $1$ nastro.
]

#lemma-proof()[
  Data una MdT con nastro semi-infinito, è facilissimo simularla con una MdT a $1$ nastro perché basta fare tutte le mosse che già fa la macchina data.

  Dato invece una MdT a $1$ nastro, la possiamo simulare con una MdT con nastro semi-infinito "incollando" la parte sinistra dell'input sopra al nastro, creando una nuova *traccia*.

  #figure(image("assets/01/semi-infinito_soluzione.svg", width: 75%))
]

=== Nastri multipli

Una *MdT con $k$ nastri*, di cui almeno uno infinito semi-infinito, è una variante un pelo più complicata. Infatti, oltre ad avere $k$ nastri diversi, ognuno di questi ha la propria testina, che può essere in punti diversi durante la computazione.

#figure(image("assets/01/k_nastri.svg", width: 75%))

#lemma()[
  Una MdT con $k$ nastri è equivalente ad una MdT a $1$ nastro.
]

#lemma-proof()[
  Data una MdT con $1$ nastro, è facilissimo simularla con una MdT a $k$ nastri perché basta fare tutte le mosse su un nastro solo dei $k$ a disposizione, ovviamente scegliendo uno di quelli infiniti o semi-infiniti.

  Dato invece una MdT a $k$ nastri, la possiamo simulare con una MdT a $1$ nastro rendendo i simboli delle $k$-tuple, come se avessimo appunto $k$ tracce a disposizione. Per indicare dove sono le testine in ogni momento, marchiamo i caratteri corrispondenti con un puntino.

  La simulazione con questo setup è poi possibile, parola di Roberto Carlino.
]

=== Nastri dedicati

Una versione di MdT a più nastri è quella che *dedica un nastro al solo input*, che quindi ha la testina in sola lettura. Ci sono poi $k$ nastri usati come *memoria*.

Una versione ancora migliorata ha un nastro per il solo *output*, in cui scriviamo e basta senza poter tornare indietro, perché ovviamente è un output.

#figure(image("assets/01/dedicati.svg", width: 65%))

=== Testine multiple

Rimaniamo sulle MdT a $1$ nastro ma inseriamo *testine multiple*.

#figure(image("assets/01/testine_multiple.svg", width: 75%))

#lemma()[
  Una MdT con $k$ testine è equivalente ad una MdT a $1$ nastro.
]

#lemma-proof()[
  Data una MdT con $1$ nastro, è facilissimo simularla con una MdT a $k$ testine perché basta fare tutte le mosse con una testina delle $k$ a disposizione.

  Dato invece una MdT a $k$ testine, la possiamo simulare con una MdT a $1$ nastro marcando i simboli come nella variante precedente.
]

Se nelle MdT questa variante non aumenta la potenza, nei *linguaggi regolari* lo fa.

#example()[
  Nei linguaggi regolari non riusciamo a riconoscere $ L = {a^n b^n bar.v n gt.eq 0} . $

  Usando due testine, posizionandole una all'inizio delle $a$ e una all'inizio delle $b$, riusciamo a riconoscere questo linguaggio contando di volta in volta una coppia di caratteri.

  Ma allora in questo caso la potenza computazionale aumenta.
]

=== Automi a pila doppia

Negli automi a pila avevamo visto che non potevamo ricreare l'automa prodotto per l'intersezione e l'unione perché avevamo a disposizione una sola pila. Supponiamo di avere ora un *PDA con due pile*.

#figure(image("assets/01/PDA_doppia_pila.svg", width: 75%))

Con questa configurazione possiamo simulare una macchina di Turing. Prendiamo una MdT che ha sul nastro di lavoro $alpha$ e $beta$ concatenati, con la testina sul primo carattere di $beta$. Creiamo un automa a pila doppia che abbia $alpha^R$ sulla prima pila e $beta$ sulla seconda. Con questa configurazione se leggiamo qualcosa da $beta$ lo facciamo dalla seconda pila, mentre se leggiamo $alpha$ lo dobbiamo fare rovesciato.

== Determinismo VS non determinismo

Vediamo adesso i modelli *deterministici* e *non deterministici*. Se consideriamo PDA e LBA, la classe di complessità di macchine deterministiche è diversa dalla classe di complessità di macchine non deterministiche. Questa distinzione non c'era invece nelle FSM perché con la *costruzione per sottoinsiemi* noi riuscivamo a simulare tutte le computazioni in parallelo usando degli insiemi di stati, pagando un costo in termini di stati.

Anche con le MdT non abbiamo questa distinzione.

Se consideriamo un *modello deterministico*, una computazione ha una sola strada da percorrere, mentre se consideriamo un *modello non deterministico*, una computazione può avere più strade possibili, Se anche solo una di queste strade dice *SI* allora accettiamo la stringa.

#theorem()[
  Le Mdt deterministiche sono equivalenti alle MdT non deterministiche.
]

#theorem-proof()[
  Ovviamente, una MdT non deterministica simula alla grande una MdT deterministica visto che ha una sola scelta disponibile.

  Se abbiamo invece una MdT non deterministica, svogliamo un caso alla volta.

  Supponiamo che per ora le computazioni siano *finite*, ovvero che terminano tutte. Eseguo ora la mia computazione in maniera deterministica:
  - se arrivo in una configurazione accettante mi fermo e *accetto*;
  - se arrivo in una configurazione non accettante posso usare la memoria infinita a mia disposizione per ricordarmi le scelte che ho fatto e fare quindi *backtracking*.

  In poche parole, faccio un attraversamento dell'albero di computazione, e ogni volta che trovo un *SI* mi fermo e accetto, altrimenti torno indietro.

  Supponiamo ora di avere anche computazioni che non terminano. La tecnica più semplice è usare un *clock*, ovvero dare un numero massimo di passi possibili. Se entro il clock non si trova un *SI* si raddoppia il clock e si rifà da capo la ricerca.

  Se esiste una configurazione accettante la devo trovare in un numero finito di passi, altrimenti vado avanti all'infinito.
]

Vediamo un esempio di come funziona il *backtracking*.

#example()[
  Ci viene dato il seguente albero di computazione.

  #align(center)[
    #cetz.canvas({
      import cetz.tree: tree

      tree((
        [$circle.small.filled$],
        (
          [$circle.small.filled$],
          (
            [$circle.small.filled$],
            ([$circle.small.filled$], [*no*]),
            ([$circle.small.filled$], [$circle.small.filled$], [$bot$]),
          ),
          [$circle.small.filled$],
          (
            [$circle.small.filled$],
            [$circle.small.filled$],
            ([$circle.small.filled$], [$circle.small.filled$], ([$circle.small.filled$], [*si*])),
          ),
        ),
        (
          [$circle.small.filled$],
          [$circle.small.filled$],
          ([$circle.small.filled$], [$circle.small.filled$], [$circle.small.filled$]),
        ),
        (
          [$circle.small.filled$],
          [$circle.small.filled$],
          (
            [$circle.small.filled$],
            ([$circle.small.filled$], [$circle.small.filled$], [$circle.small.filled$]),
            [$circle.small.filled$],
          ),
        ),
      ))
    })
  ]

  Eseguendo una ricerca nel caso senza $bot$, quando troviamo il $bot$ di sinistra facciamo backtracking e torniamo indietro per cercare vie alternative. Se invece siamo nel caso con $bot$, quando arriviamo a sforare il clock perché siamo finiti in $bot$ allora raddoppiamo il timer e speriamo di trovarlo in quel numero di iterazioni.
]

== Definizione formale

Vediamo finalmente la *definizione formale* di una MdT a $1$ nastro.

Una MdT è una tupla $ M = (Q, Sigma, Gamma, delta, q_0, F) $ definita da:
- $Q$ *insieme finito di stati*;
- $Sigma$ *alfabeto finito di input*;
- $Gamma$ *alfabeto finito di lavoro* che contiene sicuramente $Sigma$ visto che andiamo a scrivere sullo stesso nastro dove abbiamo l'input; contiene inoltre $blank$, che però non sta in $Sigma$, ovvero $ Sigma subset.eq Gamma and blank in Gamma backslash Sigma ; $
- $delta$ *funzione di transizione* che permette di processare le stringhe date in input. Essa è la funzione
  #align(center)[
    #table(
      columns: (42.5%, 42.5%),
      align: center + horizon,
      inset: 10pt,
      stroke: (dash: "dashed"),
      [*MdT deterministica*], [*MdT non deterministica*],
      [$delta : Q times Gamma arrow.long Q times Gamma times {-1, 0, 1}$],
      [$delta : Q times Gamma arrow.long 2^(Q times Gamma times {-1, 0, 1})$],
    )
  ]
  che, dati lo stato corrente e il simbolo sulla testina, calcola il nuovo stato, il nuovo simbolo da mettere sul nastro e la mossa da eseguire. La mossa con movimento $0$ (nullo) può essere sostituita con una mossa a destra e una mossa a sinistra consecutiva (o viceversa). Assumiamo inoltre di non scrivere mai $blank$ nella porzione dove c'è scritto l'input perché il simbolo $blank$ lo usiamo un po' come separatore;
- $q_0$ *stato iniziale* della macchina;
- $F subset.eq Q$ *insieme finito di stati finali*.

Una *configurazione* è una foto della macchina in un dato istante di tempo. All'accensione della MdT la *configurazione iniziale* su input $w$ contiene tutto l'input $w$ sul nastro, la testina sul primo carattere di $w$ e la macchina nello stato $q_0$.

#figure(image("assets/01/configurazione_iniziale.svg", width: 65%))

Una *configurazione accettante* è una qualsiasi configurazione che si trova in uno stato finale, a prescindere da quello che troviamo sul nastro. Questo è abbastanza strano, ovvero *non siamo obligati a leggere tutto l'input*, questo perché magari devo riconoscere solo una parte iniziale dell'input. Si può forzare tutta la lettura obbligando la macchina a scorrere tutto l'input prima di poter andare in uno stato finale. Inoltre, assumiamo per semplicità che quando la macchina entra in uno stato finale allora essa *si ferma* e *accetta* l'input fornito.

Come possiamo scrivere queste configurazioni? Come descriviamo lo stato di una MdT?

Per descrivere a pieno lo stato di una MdT in un dato momento dobbiamo sapere:
- l'*input* presente sul nastro, e questo lo ricaviamo vedendo la porzione di nastro racchiusa tra $blank$;
- la posizione della *testina*;
- lo *stato* nel quale ci troviamo.

La posizione della testina è la più "difficile" da indicare perché non abbiamo una numerazione delle celle, quindi dobbiamo trovare una soluzione alternativa. Chiamiamo $x$ la parte di stringa che si trova *prima* della testina e $y$ la parte di stringa che contiene il *carattere indicato dalla testina* e il *resto* della stringa fino ai $blank$ di destra.

Con questo truccaccio riusciamo a fare una fotografia completa:
- l'*input* l'abbiamo spezzato in $x y$ ma ce l'abbiamo per intero;
- la posizione della *testina* l'abbiamo implicitamente segnata indicando la divisione della stringa di input;
- lo *stato* basta indicarlo e siamo a posto.

La configurazione di una MdT nello stato $q$ con input $w = x y$ è quindi una *tripla* $ x q y bar.v x,y in Gamma^* and q in Q . $ È molto comodo di solito *evidenziare* il primo simbolo $a$ di $y$ perché lo utilizza la funzione di transizione, quindi ogni tanto configurazioni diamo la forma $ x q a y bar.v x,y in Gamma^* and a in Gamma and q in Q . $

#figure(image("assets/01/configurazione.svg", width: 75%))

#example()[
  Se la configurazione è $ w q $ vuol dire che mi trovo nello stato $q$ avendo letto tutto l'input, ovvero mi trovo con la testina sul primo $blank$ di destra.
]

La *configurazione iniziale* su input $w$ è $ q_0 w . $

Una *configurazione accettante* è una qualsiasi configurazione che si trovi in uno stato finale, ovvero $ x q y bar.v x,y in Gamma^* and q in F . $

Come passiamo da una configurazione all'altra usando la funzione di transizione? Sia $ C = x q y bar.v x = x' c and y = a y' $ la *configurazione corrente*. La configurazione che segue $C$ si calcola con la *funzione di transizione* e dipende dalla mossa che questa funzione ci ritorna, ovvero:
- se $ delta(q, a) = (p, b, 0) $ vuol dire abbiamo cambiato la $a$ sulla testina con una $b$, abbiamo cambiato stato da $q$ a $p$ e non ci siamo spostati, ovvero $ x q a y' tack.long x p b y' ; $
- se $ delta(q, a) = (p, b, +1) $ vuol dire abbiamo cambiato la $a$ sulla testina con una $b$, abbiamo cambiato stato da $q$ a $p$ e ci siamo spostati avanti di una posizione, ovvero $ x q a y' tack.long x b p y' ; $
- se $ delta(q, a) = (p, b, -1) $ vuol dire abbiamo cambiato la $a$ sulla testina con una $b$, abbiamo cambiato stato da $q$ a $p$ e ci siamo spostati indietro di una posizione, ovvero $ x q a y' tack.long x' p c b y' . $

Il *linguaggio riconosciuto* dalla MdT $M$ è l'insieme $ L(M) = {w in Sigma^* bar.v exists q in F and exists x,y in Gamma^* bar.v q_0 w tack.long^* x q y} . $
