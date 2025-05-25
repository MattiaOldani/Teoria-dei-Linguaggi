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

= Automi a pila two-way

È arrivato il momento di modificare un po' la macchina che stiamo usando da forse troppo tempo, aggiungendo alcune funzionalità che faranno solo che bene.

== Definizione

Negli automi a stati finiti, il movimento *two-way* non aumentava la potenza computazionale del modello. Ma cosa succede negli *automi a pila two-way*?

Vediamo prima di tutto una rappresentazione del modello.

#figure(image("assets/11_2PDA.svg", width: 75%))

Come nei 2DFA, mettiamo degli *end marker* per marcare i bordi della stringa, perché ora la nostra testina di lettura può andare *avanti e indietro* sul nastro.

Con questo modello possiamo fare *molto di più* dei classici automi a pila.

== Esempi

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
