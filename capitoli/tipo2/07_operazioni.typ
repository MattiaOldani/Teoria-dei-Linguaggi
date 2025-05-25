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

= Operazioni tra linguaggi

In questo capitolo discutiamo le *proprietà di chiusura* dei linguaggi CFL e DCFL.

Introduciamo subito due linguaggi che ci serviranno per fare dei controesempi.

#definition([Linguaggi comodi])[
  Definiamo il *linguaggio* $ L' = {a^i b^j c^k bar.v i = j} $ e il *linguaggio* $ L'' = {a^i b^j c^k bar.v j = k} $ entrambi DCFL, molto facile da dimostrare.
]<linguaggi>

== Operazioni insiemistiche

Partiamo con le *operazioni insiemistiche*.

=== Unione

==== CFL

Due linguaggi CFL possono essere "uniti" in uno solo con l'operazione di *unione* mantenendo la proprietà di essere CFL, e lo possiamo vedere fornendo una grammatica per questa operazione.

Siano $ G' = (V', Sigma, P', S') quad bar.v quad G'' = (V'', Sigma, P'', S'') $ due grammatiche CF. Creiamo la grammatica $ G = (V, Sigma, P, S) $ formata da:
- $V$ insieme delle *variabili* formato dall'unione dei due insiemi, ovvero $ V = V' union V'' ; $
- $S$ nuovo *assioma*, dal quale decideremo quale strada prendere nella derivazione delle stringhe di questo nuovo linguaggio;
- $P$ insieme delle regole di produzione, che manteniamo tutte ma alle quali ne aggiungiamo due per fare da ponte, ovvero $ P = P' union P'' union {S arrow.long S' bar.v S''} . $

==== DCFL

Nel caso deterministico è più complicato: nella grammatica che abbiamo definito poco fa abbiamo introdotto del non determinismo, che però in questo caso non possiamo avere. Come lo dimostriamo? Esistono invece due linguaggi che rompono la chiusura per l'*unione*?

#example()[
  Prendiamo i due linguaggi definiti nella @linguaggi.

  Abbiamo detto che sono entrambi DCFL, ma la sua unione $ L = L' union L'' = {a^i b^j c^k bar.v i = j or c = k} $ deve essere riconosciuta da un automa non deterministico.
]

Quindi *non* siamo chiusi rispetto all'unione, ma almeno siamo caduti ancora nei tipo $2$.

=== Intersezione

Per quanto riguarda l'*intersezione* va male per entrambi.

==== CFL

#example()[
  Prendiamo ancora i due linguaggi della @linguaggi.

  Definiamo il linguaggio $ L = L' inter L'' = {a^i b^j c^k bar.v i = j = k} $ che abbiamo visto non essere nemmeno CFL.
]

Nei linguaggi regolari utilizzavamo l'*automa prodotto*, ma in questo caso non possiamo: infatti, dovendo mandare avanti due automi allo stesso momento servirebbero due pile, e noi avendone solo una possiamo avere delle operazioni discordanti.

==== DCFL

Vale lo stesso discorso dei CFL.

=== Intersezione con un regolare

L'operazione di *intersezione con un regolare* non l'abbiamo vista nei linguaggi regolari perché ovviamente in quel campo già ci eravamo lol.

==== CFL

Nel caso CFL *abbiamo chiusura*: infatti, usando un automa prodotto che manda in parallelo un automa a pila e un automa a stati finiti ci serve una sola pila.

==== DCFL

Stesso discorso per i DCFL.

=== Complemento

Ora veniamo all'ostica operazione di *complemento*.

==== CFL

Con le *leggi di De Morgan* possiamo esprimere l'operazione di intersezione con unione e complemento, ovvero $ L_1 inter L_2 = (L_1^C union L_2^C)^C . $

Visto che i CFL sono chiusi rispetto all'unione, se lo fosse anche il complemento allora lo sarebbe anche l'intersezione, ma questo abbiamo fatto vedere che non è vero.

#example()[
  Definiamo il linguaggio $ K = {a^i b^j c^k bar.v i eq.not k or j eq.not k} union {x in.not a^* b^* c^*} . $

  Questo linguaggio è CFL, ma il suo complemento $ K^C = {a^n b^n c^n bar.v n gt.eq 0} = L' inter L'' $ invece non è CFL.
]

#example()[
  Al contrario, dato il linguaggio $ L = {w w bar.v w in {a,b}^*} $ che non è CFL, se ne calcoliamo il complemento questo è CFL.
]

==== DCFL

Nel caso deterministico non possiamo usare De Morgan perché non siamo chiusi l'unione, quindi nessun ragionamento di quel tipo ha senso.

Incredibilmente, i DCFL *sono chiusi* rispetto all'operazione di complemento.

Nei linguaggi regolari ci bastava *completare* l'automa e poi invertire "banalmente" gli stati finali con i non finali e viceversa, ma qui non è così facile perché non siamo sempre sicuri che l'automa arrivi in fondo alla sua computazione. Inoltre, nei DCFL abbiamo a disposizione le $epsilon$-mosse, che non possiamo togliere perché perdiamo potenza, a differenza degli automi a stati finali dove si manteneva lo stesso potere riconoscitivo.

Ok teniamo le $epsilon$-mosse, perché sono fastidiose? Perché l'automa, con una sequenza di $epsilon$-mosse, potrebbe entrare in loop infinito e quindi non accettare la stringa. Potremmo fregarcene, ma invece ci interessa molto, perché questa situazione di non accettazione deve essere presa in considerazione ed essere accettata.

Che possibili casi abbiamo durante una sequenza di $epsilon$-mosse? Supponiamo di essere nello stato $q$ e di avere sulla pila il carattere $X$, senza mosse che possono leggere l'input.

#table(
  columns: (33%, 33%, 33%),
  align: center + horizon,
  inset: 10pt,
  [*Nessun loop*], [*Loop sullo stesso piano*], [*Loop crescente*],
  [
    #lq.diagram(
      width: 3.9cm,
      height: 2.6cm,

      xlim: (0, 4),
      ylim: (0, 1.5),

      grid: none,

      xaxis: none,
      yaxis: none,

      lq.rect(0.5, 0, width: 0.5, height: 0.5, fill: yellow, stroke: 0.5pt + black),

      lq.line(
        (1, 0.5),
        (1.75, 1.25),
      ),

      lq.line(
        (1.75, 1.25),
        (2, 1),
      ),

      lq.line(
        (2, 1),
        (2.25, 1.25),
      ),

      lq.line(
        (2.25, 1.25),
        (3.5, 0),
      ),

      lq.line(
        (1, 0),
        (3.75, 0),
        stroke: (paint: blue, dash: "dashed"),
      ),

      lq.place(0.25, 0.25)[$q$],
      lq.place(0.75, 0.25)[$X$],
    )
  ],
  [
    #lq.diagram(
      width: 3.9cm,
      height: 2.6cm,

      xlim: (0, 4),
      ylim: (0, 1.5),

      grid: none,

      xaxis: none,
      yaxis: none,

      lq.rect(0.5, 0, width: 0.5, height: 0.5, fill: yellow, stroke: 0.5pt + black),

      lq.line(
        (1, 0.5),
        (1.5, 1),
      ),

      lq.line(
        (1.5, 1),
        (1.75, 0.75),
      ),

      lq.line(
        (1.75, 0.75),
        (2, 1),
      ),

      lq.line(
        (2, 1),
        (2.25, 0.75),
      ),

      lq.line(
        (2.25, 0.75),
        (2.5, 1),
      ),

      lq.line(
        (2.5, 1),
        (2.75, 0.75),
      ),

      lq.line(
        (2.75, 0.75),
        (3, 1),
        stroke: (dash: "dashed"),
      ),

      lq.line(
        (1, 0),
        (3.5, 0),
        stroke: (paint: blue, dash: "dashed"),
      ),

      lq.plot((1.75, 2.25, 2.75), (0.75, 0.75, 0.75), stroke: none),

      lq.place(0.25, 0.25)[$q$],
      lq.place(0.75, 0.25)[$X$],
    )
  ],
  [
    #lq.diagram(
      width: 3.9cm,
      height: 2.6cm,

      xlim: (0, 4),
      ylim: (0, 1.5),

      grid: none,

      xaxis: none,
      yaxis: none,

      lq.rect(0.5, 0, width: 0.5, height: 0.5, fill: yellow, stroke: 0.5pt + black),

      lq.line(
        (1, 0.5),
        (1.5, 1),
      ),

      lq.line(
        (1.5, 1),
        (1.75, 0.75),
      ),

      lq.line(
        (1.75, 0.75),
        (2.25, 1.25),
      ),

      lq.line(
        (2.25, 1.25),
        (2.5, 1),
      ),

      lq.line(
        (2.5, 1),
        (3, 1.5),
        stroke: (dash: "dashed"),
      ),

      lq.line(
        (1, 0),
        (3.5, 0),
        stroke: (paint: blue, dash: "dashed"),
      ),

      lq.plot((1.75, 2.5), (0.75, 1), stroke: none),

      lq.place(0.25, 0.25)[$q$],
      lq.place(0.75, 0.25)[$X$],
    )
  ],
)

In ordine abbiamo:
- una sequenza di $epsilon$-mosse che poi cancella il simbolo $X$ sulla pila;
- una sequenza di $epsilon$-mosse che ogni tanto ritorna in una configurazione con stato $p$ e $Y$ sulla pila alla stessa altezza della configurazione analoga precedente;
- una sequenza di $epsilon$-mosse che ogni tanto ritorna in una configurazione con stato $p$ e $Y$ sulla pila ad altezza maggiore della configurazione analoga precedente.

Ci interessa sapere queste informazioni, e data la funzione di transizione è possibile conoscere queste informazioni per ogni coppia di stato $q$ e carattere $X$.

Vediamo quindi come costruire questo automa per il complemento, anche se dobbiamo passare per molti passaggi intermedi. Buona fortuna.

Sia $M = (Q, Sigma, Gamma, delta, q_0, Z_0, F)$ un automa a pila deterministico che accetta il linguaggio $L$. Trasformiamo $M$ nell'automa $M'$, sempre per $L$, che ha la proprietà di *non finire mai in loop*, ovvero riesce sempre a leggere tutto l'input. Inoltre, $M'$ risulterà essere ancora deterministico.

Costruiamo quindi l'automa $ M' = (Q', Sigma, Gamma', delta', q'_0, X_0, F') $ definito da:
- $Q'$ *insieme degli stati* formato da quelli di $M$ e da tre nuovi stati, che ci permetteranno di fare il solito truccaccio di riempire la pila e di evitare i loop, ovvero $ Q' = Q union {q'_0, d, f} ; $
- $Gamma'$ *alfabeto di lavoro* che aggiunge solo il carattere del truccaccio, ovvero $ Gamma' = Gamma union {X_0} ; $
- $F'$ *insieme degli stati finali* che aggiunge il nuovo stato appena aggiunto, ovvero $ F' = F union {f} . $

La funzione di transizione viene arricchita di un sacco di mosse, che ora vediamo in ordine.

Prima di tutto facciamo il classico truccaccio, ovvero lasciamo qualcosa sotto la pila così che $M'$ non si blocchi se durante la simulazione di $M$ quest'ultimo dovesse svuotare la pila. Aggiungiamo quindi la regola $ delta'(q'_0, epsilon, Z_0) = (q_0, Z_0 X_0) $ che appunto mette il tappo in fondo e ci permette di iniziare la simulazione di $M$.

Se in una certa configurazione non abbiamo $epsilon$-mosse o mosse normali a disposizione allora finiamo in uno stato trappola, il *death state*, ovvero $ forall q in Q quad forall a in Sigma union {epsilon} quad forall X in Gamma quad delta(q, a, X) = emptyset.rev arrow.long.double delta'(q, a, X) = (d, X) . $

// chiedi se cambia qualcosa se questo succede alla fine
Se ad un certo punto troviamo $X_0$ sulla pila vuol dire che quest'ultima è stata svuotata da $M$, quindi l'automa si è bloccato e con $M'$ devo andare nel death state, ovvero $ forall a in Sigma quad delta'(q, a, X_0) = (d,X_0) . $

Nello stato trappola leggo l'input per intero senza toccare altro, quindi $ forall a in Sigma quad forall X in Gamma quad delta'(d, a, X) = (d, X) . $

Se in una certa configurazione ci sono $epsilon$-mosse potrei entrare in un loop, ma questa informazione l'abbiamo già calcolata, quindi con la presenza di $epsilon$-mosse e di un loop da $(q,X)$ abbiamo $ delta'(q, epsilon, X) = cases((d,X) & "se il loop non visita uno stato finale", (f,X) quad & "altrimenti") . $

Se sono finito nello stato finale è perché ho trovato un loop con stato finale, ma se l'ho trovato non alla fine della stringa devo andare nello stato trappola, quindi $ forall a in Sigma quad forall X in Gamma quad delta'(f, a, X) = (d, X) . $

In tutti gli altri casi teniamo le mosse che già c'erano, quindi $ forall q in Q quad forall a in Sigma union {epsilon} quad forall X in Gamma quad delta'(q, a, X) = delta(q, a, X) . $

*Perfetto*, ora che abbiamo un automa che non si blocca mai costruiamo un automa per il complemento. Facciamo un po' di renaming per semplicità.

Sia $M$ un DPDA per $L$ che scandisce sempre l'intero l'input. Vogliamo costruire $ M' = (Q', Sigma, Gamma, delta', q'_0, Z_0, F') $ per il complemento di $M$, ovvero quando $M$ risponde *SI* noi rispondiamo *NO* e viceversa.

Ora $M$ arriva sempre in fondo all'input, ma può fare comunque $epsilon$-mosse alla fine. Se durante queste ultime sequenze visitiamo almeno uno stato finale dobbiamo rifiutare, altrimenti accettiamo.

Definiamo quindi $M'$ formato da:
- $Q'$ *insieme degli stati* che memorizza, oltre allo stato nel quale si trova, anche se nella sequenza di $epsilon$-mosse che stiamo facendo abbiamo visto o meno uno stato finale. In realtà, ci dice di più questa flag, che il prof chiama un *bit e mezzo*, perché infatti $Q'$ è definito come $ Q' = Q times {y, n, A} $ con le flag che indicano rispettivamente se nella sequenza abbiamo visitato uno stato in $F$, se non l'abbiamo fatto o se non l'abbiamo fatto e non siamo più in grado di fare $epsilon$-mosse;
- $F'$ *insieme degli stati finali* formato dalle coppie che hanno come seconda componente la $A$, perché non sono passato da stati finali e mi sono fermato, quindi $ F' = Q times {A} ; $
- $q'_0$ *stato iniziale* che dipende dallo stato iniziale vecchio, ovvero $ q'_0 = cases([q_0, n] quad & "se" q_0 in.not F, [q_0, y] & "se" q_0 in F) space ; $
- $delta'$ *funzione di transizione* che dati $q in Q$ e $X in Gamma$:
  - se $delta(q, epsilon, X) = (p, gamma)$ allora posso eseguire delle $epsilon$-mosse, quindi in base alla seconda componente degli stati definisco $ delta'([q,y], epsilon, X) &= ([p,y], gamma) \ delta'([q,n], epsilon, X) &= cases(([p,y], gamma) & "se" p in F, ([p,n], gamma) quad & "altrimenti") \ delta'([q,A], epsilon, X) &= emptyset.rev ; $
  - se invece nella configurazione corrente ho finito le $epsilon$-mosse allora posso avere delle mosse che leggono simboli in input. Potendo fare questa operazione di lettura, dobbiamo dimenticarci dell'ultimo loop eseguito se contiene degli stati finali, quindi se $delta(q, a, X) = (p, gamma) bar.v a in Sigma$ allora $ delta'([q,y], a, X) = cases(([p,y], gamma) & "se" p in F, ([p,n], gamma) quad & "altrimenti") . $ Se invece nell'ultimo loop abbiamo terminato il giro senza passare da stati finali passiamo per $A$, ovvero $ delta'([q,n], epsilon, X) &= ([q,A], X) \ delta'([q, A], a, X) &= cases(([p,y], gamma) & "se" è in F, ([p,n], gamma) quad & "altrimenti") space . $

*Finita*, finalmente, questa costruzione senza senso.

=== Riassunto

#table(
  columns: (40%, 30%, 30%),
  align: center + horizon,
  inset: 10pt,
  [*Operazione*], [*CFL*], [*DCFL*],
  [*Unione*], [#emoji.checkmark.box], [#emoji.crossmark],
  [*Intersezione*], [#emoji.crossmark], [#emoji.crossmark],
  [*Intersezione con un regolare*], [#emoji.checkmark.box], [#emoji.checkmark.box],
  [*Complemento*], [#emoji.crossmark], [#emoji.checkmark.box],
)

== Operazioni regolari

Vediamo ora le *operazioni regolari*.

=== Prodotto

La prima operazione regolare, ovvero l'unione, l'abbiamo già analizzata. Vediamo ora il *prodotto*.

==== CFL

Per i CFL è facile creare una grammatica $G$ a partire da due grammatiche $G'$ e $G''$ CFG con un assioma $S$ e una regola di produzione $ S arrow.long S' S'' $ che permetta di produrre le due stringhe separatamente a partire dai loro assiomi.

==== DCFL

Purtroppo, i DCFL *non sono chiusi* rispetto al prodotto.

#example()[
  Prendiamo di nuovo i linguaggi della @linguaggi, che sono entrambi deterministici, e creiamo il linguaggio $ L_0 = L' union d L'' $ che è deterministico perché in base al primo carattere capisce subito che linguaggio riconoscere. Creiamo ora il linguaggio $ L_1 = {epsilon, d} L_0 . $

  In base al carattere che scegliamo di anteporre alle stringhe di $L_0$ noi possiamo avere un numero di $d$ iniziali differenti. Scriviamo quindi $L_1$ come l'insieme $ L_1 = {d^s a^i b^j c^k bar.v s in {0,1,2}} . $

  Analizziamo i vari casi:
  - se $s = 0$ allora stiamo scegliendo $epsilon$ e $L'$, quindi $i = j$;
  - se $s = 2$ allora stiamo scegliendo $d$ e $d L''$, quindi $j = k$;
  - se $s = 1$ allora:
    - stiamo scegliendo $d$ e $L'$, quindi $i = j$;
    - stiamo scegliendo $epsilon$ e $d L''$, quindi $j = k$.

  Filtriamo alcune stringhe di $L_1$ calcolando $ L_1 inter d a^* b^* c^* =^(s = 1) {d a^i b^j c^k bar.v i = j or j = k} $ che ovviamente non è DCFL. Ricordandoci che i DCFL sono chiusi rispetto all'intersezione con un regolare, se il linguaggio di destra non è DCFL allora non lo è nemmeno $L_1$, che era ottenuto però come concatenazione di due linguaggi DCFL.
]

Questa cosa è *tristissima*: non siamo chiusi nemmeno con un linguaggio finito, è drammatico.

Fatto stranissimo, se invece concateniamo con un linguaggio regolare a destra si ottiene un linguaggio DCFL, senza senso questa classe di linguaggi.

=== Star

Vediamo infine la *star* per finire le operazioni regolari.

==== CFL

Nei CFL basta creare una nuova grammatica $G$ a partire da $G'$ CFG con le regole di produzione $ S arrow.long S'S bar.v epsilon $ per iniziare a concatenare tante stringhe di $G'$ a nostro piacere.

Un automa invece ogni volta che arriva in uno stato finale fa ripartire la computazione dall'inizio.

==== DCFL

Sfigati come sono, i DCFL non sono chiusi nemmeno per la star di Kleene.

#example()[
  Non ho ben capito l'esempio che ha scritto.
]

=== Riassunto

#table(
  columns: (40%, 30%, 30%),
  align: center + horizon,
  inset: 10pt,
  [*Operazioni*], [*CFL*], [*DCFL*],
  [*Prodotto*], [#emoji.checkmark.box], [#emoji.crossmark],
  [*Star*], [#emoji.checkmark.box], [#emoji.crossmark],
)

== Considerazioni

Come vediamo, siamo messi molto male rispetto ai linguaggi regolari, dove praticamente tutte le operazioni permettevano la chiusura dei linguaggi regolari.

In questo caso, i CFL ancora ancora si salvano, però perdono il *complemento*, e questo sarà molto fastidioso in futuro. I DCFL non diciamo niente, visto che tolta l'intersezione con i regolari, che non è una vera e propria operazione interna, hanno solo una proprietà di chiusura.
