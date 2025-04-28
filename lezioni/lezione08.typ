// Setup

#import "alias.typ": *

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

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 08 [21/03]

=== Teorema di Kleene e espressioni regolari

Con le operazioni che abbiamo visto noi possiamo creare dei nuovi linguaggi. Tra queste operazioni, possiamo raggruppare *unione*, *prodotto* e *chiusura di Kleene* sotto il cappello delle *operazioni regolari*. Come mai questo nome? Perché esse sono usate per definire i *linguaggi regolari*-

Vediamo tre versioni del seguente teorema, ma ci interesseremo solo della prima e della terza.

#theorem([Teorema di Kleene])[
  La classe dei linguaggi accettati da automi a stati finiti coincide con la più piccola classe contenente i linguaggi $ emptyset.rev quad bar.v quad {epsilon} quad bar.v quad {a} $ e chiusa rispetto alle operazioni di unione, prodotto e chiusura di Kleene.
]

Questa prima versione ci dice che possiamo costruire la classe dei linguaggi regolari partendo da tre linguaggi base e applicando in tutti i modi possibili le tre operazioni regolari.

#theorem([Teorema di Kleene])[
  La classe dei linguaggi accettati da automi a stati finiti coincide con la più piccola classe che contiene i linguaggi finiti.
]

Seconda versione carina, ma che non commentiamo.

#theorem([Teorema di Kleene])[
  La classe dei linguaggi accettati da automi a stati finiti coincide con la classe dei linguaggi espressi con le espressioni regolari.
]

Tutto bello, ma cosa sono le *espressioni regolari*?

#table(
  columns: (50%, 50%),
  align: center + horizon,
  inset: 10pt,
  [*Simbolo/espressione*], [*Linguaggio associato*],
  [$emptyset.rev$], [$emptyset.rev$],
  [$epsilon$], [${epsilon}$],
  [$a$], [${a}$],
  [$E_1 + E_2$], [$L(E_1) union L(E_2)$],
  [$E_1 dot E_2$], [$L(E_1) dot L(E_2)$],
  [$E^*$], [$(L(E))^*$],
)

Le espressioni regolari sono una *forma dichiarativa*, ovvero grazie ad esse dichiariamo come sono fatte le stringhe di un certo linguaggio. Fin'ora avevamo usato gli automi (*forma riconoscitiva*) e le grammatiche (*forma generativa*).

#example()[
  Vediamo un po' di espressioni regolari per alcuni linguaggi.

  #table(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [*Linguaggio*], [*Espressione regolare*],
    [$L = {a^n bar.v n gt.eq 0}$], [$a^*$],
    [$L = {a^(2k + 1) bar.v k gt.eq 0}$], [$(a a)^* a$],
    [$L = {a^n b bar.v n gt.eq 0}$], [$a^* b$],
    [$L = {(a^n b)^k bar.v n gt.eq 0 and k > 0}$], [$(a^* b)^k$],
    [$L_3$ terzultimo simbolo da destra è una $a$], [$(a+b)^* a (a+b) (a+b)$],
  )

  Il penultimo linguaggio ha una espressione regolare che non abbiamo visto: si tratta di una piccola estensione algebrica che ci permette di unire assieme una serie di fattori identici.
]

Andiamo ora a dimostrare il teorema di Kleene.

#theorem-proof()[
  Dobbiamo mostrare una doppia implicazione.

  [Automa $arrow.long$ RegExp]

  Vedi esempio successivo su come fare questa operazione.

  [RegExp $arrow.long$ Automa]

  Non l'ha ancora spiegato.
]

Vediamo un esempio di come passare da un automa ad una espressione regolare.

#example()[
  Per ricavare una espressione regolare da un automa si usa un algoritmo di *programmazione dinamica* molto simile all'algoritmo Floyd-Warshall sui grafi, che cerca i cammini minimi imponendo una serie di vincoli.

  Un altro approccio invece cerca di risolvere un *sistema di equazioni* associato all'automa.

  Dato un automa, costruiamo un sistema di $n$ equazioni, dove $n$ è il numero di stati dell'automa. Supponendo di numerare gli stati da $1$ a $n$, la $i$-esima equazione descrive i cambiamenti di stato che possono avvenire partendo dallo stato $i$.

  Ogni *cambiamento di stato* è nella forma $a B$, dove $a$ è il carattere che causa una transizione e $B$ è lo stato di arrivo. Tutti i cambiamenti di stato a partire da $i$ vanno sommati tra loro. Inoltre, se lo stato $i$-esimo è uno stato finale si aggiunge anche $epsilon$ all'equazione.

  Questa somma di cambiamenti di stati va posta uguale allo stato $i$-esimo.

  #figure(image("assets/08_regex_esempio.svg"))

  Associamo all'automa precedente un sistema di $3$ equazioni, nel quale indichiamo gli stati con le variabili $X_i$ e i caratteri sono quelli dell'alfabeto ${a,b}$. Il sistema è il seguente: $ cases(X_0 = a X_1 + b X_0, X_1 = a X_2 + b X_0, X_2 = a X_2 + b X_1 + epsilon) . $

  Ora dobbiamo risolvere questo sistema di equazioni. Per fare ciò, dobbiamo introdurre una *regola fondamentale* che ci permetterà di risolvere tutti i sistemi che vedremo.

  #figure(image("assets/08_regex_regola.svg"))

  Il sistema di equazioni per questo automa è $ cases(X = A X + B Y, Y = epsilon) . $

  Sostituendo $Y = epsilon$ nella prima equazione otteniamo $ X = A X + B . $

  L'espressione regolare per questo automa è $ A^* B . $

  Visto che le due cose che abbiamo scritto devono essere identiche, ogni volta che abbiamo una equazione nella forma $ X = A X + B $ la possiamo sostituire con l'equazione $ X = A^* B . $

  Riprendiamo il sistema dell'automa dell'esempio e andiamo a risolvere le nostre equazioni: $ cases(X_0 = a (a X_2 + b X_0) + b X_0, X_2 = a X_2 + b (a X_2 + b X_0) + epsilon) \ cases(X_0 = a a X_2 + a b X_0 + b X_0, X_2 = a X_2 + b a X_2 + b b X_0 + epsilon) \ cases(X_0 = (a b + b) X_0 + a a X_2, X_2 = (a + b a) X_2 + b b X_0 + epsilon) \ cases(X_0 = (a b + b) X_0 + a a X_2, X_2 = (a + b a)^* (b b X_0 + epsilon)) \ X_0 = (a b + b) X_0 + a a ((a + b a)^* (b b X_0 + epsilon)) \ X_0 = (a b + b) X_0 + a a (a + b a)^* b b X_0 + a a (a + b a)^* \ X_0 = (a b + b + a a (a + b a)^* b b) X_0 + a a (a + b a)^* . $

  Applicando un'ultima volta la regola fondamentale otteniamo l'espressione regolare $ (a b + b + a a (a + b a)^* b b)^* a a (a + b a)^* . $

  E pensare che l'algoritmo basato su Floyd-Warshall è anche più difficile...
]
