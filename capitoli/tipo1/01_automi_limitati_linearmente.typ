// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Automi limitati linearmente

Toccata e fuga nel campo dei *linguaggi context-sensitive*, visto che li vedremo in pochissimi capitoli di questa magica dispensa.

== Definizione

I linguaggi di tipo $1$ hanno come modello riconoscitivo gli *LBA*, o *Linear Bounded Automata*. In poche parole, sono degli automi a stati finiti two-way con la testina che però può scrivere sul nastro.

#figure(image("assets/01/LBA.svg", width: 75%))

Gli LBA vedono il nastro come se fosse una memoria, nella quale possono anche scrivere. Visto che possiamo scrivere solo sul nastro, lo spazio a nostra disposizione rimane *limitato dall'input*.

Questo modello accetta tutti e soli i *linguaggi context-sensitive* CS.

== Classi di complessità associate

Visto che trattiamo dello spazio, qua possiamo definire qualche *classe di complessità*.

Gli *LBA* usano spazio pari alla lunghezza dell'input, ovvero vale $ LBA = CS = NSPACE(n) . $ In poche parole, gli LBA corrispondono alle *macchine riconoscitrici non deterministiche in spazio lineare*, o qualcosa di simile.

Consideriamo ora i *DLBA*, ovvero i *CS deterministici*, che anche loro usano spazio pari alla lunghezza dell'input, ovvero vale $ DLBA = DSPACE(n) . $ In poche parole, i DLBA corrispondono alle *macchine riconoscitrici deterministiche in spazio lineare*, o qualcosa di simile.

Quello che non sappiamo è la questione $ DSPACE(n) =^? NSPACE(n) . $

Si sa che dal non determinismo si passa al determinismo pagando un fattore quadratico, ovvero $ NSPACE(n) subset.eq DSPACE(n^2) . $ Si è congetturato che questi insiemi sono diversi, ma non è ancora stato dimostrato.

== Esempi

Riprendiamo gli esempi che abbiamo visto nei 2DPDA e cerchiamo di rifarli.

#example()[
  Definiamo $ L = {a^n b^n c^n bar.v n gt.eq 0} . $

  Come possiamo riconoscere $L$ con un LBA?

  Eseguiamo in ordine i seguenti passi:
  + troviamo una $a$, la marchiamo con una $X$ e cerchiamo una $b$;
  + troviamo una $b$, la marchiamo con una $X$ e cerchiamo una $c$;
  + troviamo una $c$, la marchiamo con una $X$ e ripartiamo dal punto $1$.

  Con un controllo a stati finiti molto veloce controlliamo prima di tutto di avere tutte $a$, poi tutte $b$ e infine tutte $c$. Dopo questo controllo partiamo con la logica appena descritta.

  Ad esempio, se dovessimo riconoscere la stringa $z = a a a b b b c c c$ il nastro si presenta nel seguente modo durante le iterazioni:

  #align(center)[
    #table(
      columns: (5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%),
      row-gutter: 5pt,
      align: center + horizon,
      [#text(red)[$a$]], [$a$], [$a$], [$b$], [$b$], [$b$], [$c$], [$c$], [$c$],
      [$X$], [$a$], [$a$], [#text(red)[$b$]], [$b$], [$b$], [$c$], [$c$], [$c$],
      [$X$], [$a$], [$a$], [$X$], [$b$], [$b$], [#text(red)[$c$]], [$c$], [$c$],
      [$X$], [#text(red)[$a$]], [$a$], [$X$], [$b$], [$b$], [$X$], [$c$], [$c$],
      [$X$], [$X$], [$a$], [$X$], [#text(red)[$b$]], [$b$], [$X$], [$c$], [$c$],
      [$X$], [$X$], [$a$], [$X$], [$X$], [$b$], [$X$], [#text(red)[$c$]], [$c$],
      [$X$], [$X$], [#text(red)[$a$]], [$X$], [$X$], [$b$], [$X$], [$X$], [$c$],
      [$X$], [$X$], [$X$], [$X$], [$X$], [#text(red)[$b$]], [$X$], [$X$], [$c$],
      [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [#text(red)[$c$]],
      [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$],
    )
  ]
]

#example()[
  Definiamo il linguaggio $ L = {a^2^n bar.v n gt.eq 0} . $

  Cerchiamo di fare ancora delle *divisioni* per $2$, ma ora lo facciamo lavorando sul nastro.

  Andiamo quindi a marcare con una $X$ un carattere $a$ ogni due letti, e facendo così controlliamo anche se le $a$ sono pari o dispari. Una volta arrivati alla fine torniamo all'inizio dal nastro e ripartiamo, ignorando completamente le $X$ che abbiamo messo. Come prima, alla fine del processo deve rimanere una sola $a$ sul nastro.

  Vediamo il riconoscimento della stringa $z = a^8$.

  #align(center)[
    #table(
      columns: (5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%),
      row-gutter: 5pt,
      align: center + horizon,
      [#text(red)[$a$]], [$a$], [$a$], [$a$], [$a$], [$a$], [$a$], [$a$],
      [$X$], [$a$], [#text(red)[$a$]], [$a$], [$a$], [$a$], [$a$], [$a$],
      [$X$], [$a$], [$X$], [$a$], [#text(red)[$a$]], [$a$], [$a$], [$a$],
      [$X$], [$a$], [$X$], [$a$], [$X$], [$a$], [#text(red)[$a$]], [$a$],
      [$X$], [#text(red)[$a$]], [$X$], [$a$], [$X$], [$a$], [$X$], [$a$],
      [$X$], [$X$], [$X$], [$a$], [$X$], [#text(red)[$a$]], [$X$], [$a$],
      [$X$], [$X$], [$X$], [#text(red)[$a$]], [$X$], [$X$], [$X$], [$a$],
      [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [#text(red)[$a$]],
      [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$], [$X$],
    )
  ]

  Tra la terzultima e la penultima riga l'automa scorre fino in fondo l'input, non cancella la seconda $a$ perché ne ha appena cancellata una, torna indietro e poi si sposta sull'ultima $a$ per cancellarla effettivamente.
]

#example()[
  Definiamo il linguaggio $ L = {w w bar.v w in {a,b}^*} . $

  Vediamo prima un *approccio non deterministico*. Cerchiamo di indovinare la metà della stringa, marcandola con una $X$ e ricordandoci del carattere marcato. Ci spostiamo poi all'inizio del nastro, controllando l'uguaglianza con il carattere marcato. Se i due caratteri corrispondono ricomincio ma partendo dall'inizio, quindi marco un carattere iniziale, mi sposto a metà, controllo e riparto. Se azzecchiamo la metà con una computazione allora abbiamo vinto e riusciamo a riconoscere la stringa in input.

  Vediamo ora un *approccio deterministico*. L'idea l'abbiamo praticamente già vista, ma la dobbiamo adattare a questo preciso linguaggio per come è definito.

  Prendiamo ad esempio la stringa $z = a b b a b a b b a b$. Facciamo finta di avere un *secondo nastro* sotto quello che già abbiamo e facciamo quello che abbiamo fatto prima, ovvero ogni due simboli ne andiamo a marcare uno.

  #align(center)[
    #table(
      columns: (5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%),
      row-gutter: 5pt,
      align: center + horizon,
      [$a$], [$b$], [$b$], [$a$], [$b$], [$a$], [$b$], [$b$], [$a$], [$b$],
      [$X$], [], [$X$], [], [$X$], [], [$X$], [], [$X$], [],
    )
  ]

  Con questa passata controlliamo come sempre se la stringa ha lunghezza pari o dispari.

  Aggiungiamo un *terzo nastro*, nel quale prendiamo tutte le $X$ del secondo nastro e le trasciniamo tutte in fondo a sinistra.

  #align(center)[
    #table(
      columns: (5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%, 5%),
      row-gutter: 5pt,
      align: center + horizon,
      [$a$], [$b$], [$b$], [$a$], [$b$], [$a$], [$b$], [$b$], [$a$], [$b$],
      [$X$], [], [$X$], [], [$X$], [], [$X$], [], [$X$], [],
      [$X$], [$X$], [$X$], [$X$], [$X$], [], [], [], [], [],
    )
  ]

  Ora che conosco la metà, grazie al terzo nastro, ci spostiamo sul carattere appena dopo l'ultima $X$ e ripeto l'algoritmo non deterministico appena visto.

  Tutto bello, ma come facciamo senza nastri? Possiamo usare una sorta di *alfabeto esteso*, ovvero un alfabeto che come simboli ha i simboli che si ottengono concatenando le colonne dei vari nastri impilati. Ad esempio, il primo carattere $a$ prima diventa $a X$ e poi $a X X$.
]

Come vediamo, tutto quello che prima abbiamo fatto con i *2DPDA* siamo riusciti a farlo anche ora usando gli *LBA*, tra l'altro tutti *deterministici*.
