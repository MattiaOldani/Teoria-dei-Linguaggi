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

== Operazioni sui linguaggi

Supponiamo di avere in mano una serie di linguaggi. Vediamo una serie di operazioni che possiamo fare su essi per combinarli assieme e ottenere altri linguaggi.

=== Operazioni insiemistiche

I linguaggi sono insiemi di stringhe, quindi perché non iniziare dalle *operazioni insiemistiche*?

Fissiamo un alfabeto $Sigma$, siano $L', L'' subset.eq Sigma^*$ due linguaggi definiti sullo stesso alfabeto $Sigma$. Se i due alfabeti sono differenti allora si considera come alfabeto l'unione dei due alfabeti.

Partiamo con l'operazione di *unione*: $ L' union L'' = {x in Sigma^* bar.v x in L' or x in L''} . $

Continuiamo con l'operazione di *intersezione*: $ L' inter L'' = {x in Sigma^* bar.v x in L' and x in L''} . $

Terminiamo con l'operazione di *complemento*: $ L'^C = {x in Sigma^* bar.v x in.not L'} . $

=== Operazioni tipiche

Passiamo alle *operazioni tipiche* dei linguaggi, definite comunque molto semplicemente.

Partiamo con l'operazione di *prodotto* (_o concatenazione_): $ L' dot L'' = {w in Sigma^* bar.v exists x in L' and exists y in L'' bar.v w = x y} . $ In poche parole, concateniamo in tutti i modi possibili le stringhe del primo linguaggio con le stringhe del secondo linguaggio. Questa operazione, in generale, è *non commutativa*, e lo è se $Sigma$ è formato da una sola lettera.

#example()[
  Vediamo due casi particolari e importanti di prodotto $ L' dot emptyset.rev = emptyset.rev dot L' = emptyset.rev \ L' dot {epsilon} = {epsilon} dot L' = L' . $
]

Andiamo avanti con l'operazione di *potenza*: $ L^k = underbracket(L dot dots dot L, k "volte") . $ In poche parole, stiamo prendendo $k$ stringhe da $L'$ e le stiamo concatenando in ogni modo possibile. Possiamo dare anche una definizione induttiva di questa operazione, ovvero $ L^k = cases({epsilon} & "se" k = 0, L^(k-1) dot L quad & "se" k > 0) . $

Infine, terminiamo con l'operazione di *chiusura di Kleene*, detta anche *STAR*. Questa operazione è estremamente simile alla potenza, ma in questo caso il numero $k$ non è fissato e quindi questa operazione di potenza viene ripetuta all'infinito. Vengono quindi concatenate un numero arbitrario di stringhe di $L$, e teniamo tutte le computazioni intermedie, ovvero $ L^* = union.big_(k gt.eq 0) L^k . $

Ecco perché scriviamo $Sigma^*$: partendo dall'alfabeto $Sigma$ andiamo ad ottenere ogni stringa possibile.

Esiste anche la *chiusura positiva*, definita come $ L^+ = union.big_(k gt.eq 1) L^k . $

Che relazione abbiamo tra le due chiusure? Questo dipende da $epsilon$, ovvero:
- se $epsilon in L$ allora $L^* = L^+$ perché $L^1 subset.eq L^+$ e visto che $epsilon in L^1$ abbiamo gli stessi insiemi;
- se $epsilon in.not L$ allora $L^+ = L^* slash {epsilon}$ perché l'unico modo di ottenere $epsilon$ sarebbe con $L^0$.

#example()[
  Vediamo una cosa simpatica: $ emptyset.rev^* = {epsilon} . $

  Abbiamo appena generato qualcosa dal nulla, fuori di testa. La generazione si blocca con la chiusura positiva, ovvero $ emptyset.rev^+ = emptyset.rev . $

  Infine, vediamo una cosa abbastanza banale sull'insieme formato dalla sola $epsilon$, ovvero $ {epsilon}^* = {epsilon}^+ = {epsilon} . $
]

Con la chiusura di Kleene, partendo da un *linguaggio finito* $L$, otteniamo una chiusura $L^*$ di cardinalità infinita, perché ogni volta andiamo a creare delle nuove stringhe.

Partendo invece da un *linguaggio infinito* $L$, otteniamo ancora una chiusura $L^*$ di cardinalità infinita ma ci sono alcune situazioni particolari.

#example()[
  Vediamo tre linguaggi infiniti che hanno comportamenti diversi.

  Consideriamo il linguaggio $ L_1 = {a^n bar.v n gt.eq 0} . $

  Calcolando la chiusura $L_1^*$ otteniamo lo stesso linguaggio $L_1$ perché stiamo concatenando stringhe che contengono solo $a$, che erano già presenti in $L_1$.

  Consideriamo ora il linguaggio $ L_2 = {a^(2k + 1) bar.v k gt.eq 0} . $

  Calcolando la chiusura $L_2^*$ otteniamo il linguaggio $L_1$ perché:
  - in $L_2^1$ ho tutte le stringhe formate da $a$ di lunghezza dispari;
  - in $L_2^2$ ho tutte le stringhe formate da $a$ di lunghezza pari (_dispari + dispari_).

  Già solo con $L_2^0 union L_2^1 union L_2^2$ generiamo tutto il linguaggio $L_1$

  Consideriamo infine $ L_3 = {a^n b bar.v n gt.eq 0} . $

  Proviamo a calcolare prima la potenza $L_3^k$ di questo linguaggio, ovvero $ L_3^k = {a^(n_1) b dots a^(n_k) b bar.v n_1, dots, n_k gt.eq 0} . $ La chiusura $L_3^*$ conterrà stringhe in questa forma con $k$ ogni volta variabili.
]

Abbiamo quindi visto diverse situazioni: nel primo linguaggio non abbiamo dovuto calcolare nessuna chiusura, nel secondo linguaggio abbiamo calcolato un paio di linguaggi, nel terzo linguaggio non ci siamo mai fermati.

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
