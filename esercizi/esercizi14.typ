// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Esercizi

= Esercizi lezione 14 [11/04]

== Esercizio 01

#exercise()[]

#request()[
  Descrivete e costruite un automa a pila che accetti l'insieme delle stringhe sull'alfabeto ${a,b}$ che contengono lo stesso numero di $a$ e $b$, come ad esempio $a a b b$, $a b b a$, $b a b a$.
]

#solution()[
  L'idea dietro un automa a pila per questo linguaggio è quella di mettere sulla pila i caratteri $A$ e $B$ per contare quante ne abbiamo, e poi vedere se i due numeri sono uguali. Per contare usiamo un semplice algoritmo:
  - se leggo una $a$ e sulla pila ho una $A$ allora ne metto un'altra, altrimenti se ho una $B$ la andiamo a cancellare perché vuol dire che ho letto una $B$ poco prima, quindi la $a$ di ora e la $b$ di prima sono in egual numero;
  - stesso discorso per la $b$;
  - ogni volta che leggo $Z_0$ sulla pila, con una $epsilon$-mossa mi sposto in uno stato finale scommettendo che l'input sia finito e che quindi tutte le $A$ e le $B$ si sono cancellate sulla pila, avendo quindi un numero di $a$ e di $b$ uguale.

  Andiamo ad accettare per pila vuota. Va bene anche l'accettazione per stato finale, rendendo $q_f$ finale, ma mi piaceva di più pila vuota.

  #figure(image("assets/14_esercizio_01.svg"))

  Con l'accorgimento della $epsilon$-mossa riusciamo a riconoscere anche la stringa vuota.
]

== Esercizio 02

#exercise()[]

#request()[
  Descrivete e costruite un automa a pila che accetti il linguaggio ${a^n b^m bar.v n eq.not m}$.
]

#solution()[
  Per questo automa andiamo a riempire tutta la pila con un numero $n$ di $A$, poi andiamo a togliere una $A$ per ogni $b$ che troviamo. Se:
  - $n > m$ allora alla fine arriviamo con delle $A$ sulla pila, e non deterministicamente andiamo in uno stato finale;
  - $n < m$ vuol dire che leggendo delle $b$ arriviamo a $Z_0$, ma in questo caso andiamo a mettere delle $B$ sulla pila e poi a fine stringa ci spostiamo nello stato finale.

  Andiamo ad accettare per stati finali.

  #figure(image("assets/14_esercizio_02.svg"))

  Manca da aggiungere la transizione $ b,Z_0 bar.v Z_0 $ ma non ho voglia di cambiare l'immagine ora.
]

== Esercizio 03

#exercise()[
  Sia $Sigma = {(,)}$ un alfabeto i cui simboli sono la parentesi aperta e la parentesi chiusa.
]

#request()[
  Descrivete e costruite un automa a pila che riconosca il linguaggio formato da tutte le sequenze di parentesi correttamente bilanciate, come ad esempio $(()(()))()$.
]

#solution()[
  Costruiamo un automa a pila che:
  - ogni volta che legge una parentesi aperta mettiamo una $A$ sulla pila;
  - ogni volta che legge una parentesi chiusa toglie una $A$ dalla pila, se può.

  Se non possiamo togliere una $A$ dalla pila l'automa si blocca. Poi, non deterministicamente, ogni volta che leggiamo $Z_0$ sulla pila andiamo in uno stato finale.

  Andiamo ad accettare per pila vuota. Va bene anche l'accettazione per stato finale, rendendo $q_f$ finale, ma mi piaceva di più pila vuota.

  #figure(image("assets/14_esercizio_03_01.svg"))
]

#request()[
  Risolvete il punto precedente per un alfabeto con due tipi di parentesi, come $Sigma = {(,),[,]}$, nel caso non vi siano vincoli tra i tipi di parentesi (le tonde possono essere contenute tra quadre e viceversa). Esempio $[()([])[]]$, ma non $[[][(])()]$.
]

#solution()[
  L'automa è uguale a quello di prima, solo con delle regole in più per le parentesi quadre, rappresentate dal carattere $B$ nella pila.

  Andiamo ad accettare per pila vuota. Va bene anche l'accettazione per stato finale, rendendo $q_f$ finale, ma mi piaceva di più pila vuota.

  #figure(image("assets/14_esercizio_03_02.svg"))
]

#request()[
  Risolvete il punto precedente con $Sigma = {(,),[,]}$, con il vincolo che le parentesi quadre non possano mai apparire all'interno delle parentesi tonde. Esempio $[()(())[][]](()())$ ma non $[()([])[]]$.
]

#solution()[
  Con lo stato $q_0$ andiamo a riconoscere tutte le parentesi quadre, mentre appena leggiamo una parentesi tonda ci spostiamo in $q_1$, nel quale non possiamo leggere una quadra aperta.

  #figure(image("assets/14_esercizio_03_03.svg"))
]

== Esercizio 04

#exercise()[]

#request()[
  Basandovi su uno degli automi a pila presentati a lezione per il linguaggio $L = {a^n b^n bar.v n gt.eq 1}$, costruite un automa a pila per la chiusura di Kleene di $L$, cioè il linguaggio ${a^(n_1) b^(n_1) a^(n_2) b^(n_2) dots.c a^(n_k) b^(n_k) bar.v k gt.eq 0 and n_1, n_2, dots, n_k > 0}$.
]

#solution()[
  All'automa a pila che abbiamo visto a lezione per $L$ aggiungiamo una transizione direttamente nello stato finale, visto che dobbiamo accettare anche $epsilon$. Inoltre, ogni volta che in $q_1$ torniamo sulla base della pila, se leggiamo una $a$ allora torniamo in $q_0$ per iniziare un nuovo riconoscimento.

  Andiamo ad accettare per pila vuota. Va bene anche l'accettazione per stato finale, rendendo $q_f$ finale, ma mi piaceva di più pila vuota.

  #figure(image("assets/14_esercizio_04.svg"))
]

== Esercizio 05

#exercise()[
  Considerate l'alfabeto $Sigma = {a,b}$.
]

#request()[
  Descrivete e costruite un automa a pila per il linguaggio $pal_hash = {w hash w^R bar.v w in Sigma^*}$, dove $hash$ è un nuovo simbolo, cioè $hash in.not Sigma$.
]

#solution()[
  Un automa a pila per $pal_hash$ legge la stringa, la mette nella pila, appena trova $hash$ controlla se tirandola fuori si ottiene la stessa stringa che si sta leggendo ora.

  #figure(image("assets/14_esercizio_05_01.svg"))
]

#request()[
  Modificate l'automa a pila ottenuto al punto precedente in modo che accetti il linguaggio delle stringhe palindrome di lunghezza pari su $Sigma$, cioè per l'insieme $pal_"pari" = {w w^R bar.v w in Sigma^*}$.
]

#solution()[
  Un automa a pila per $pal_"pari"$ in maniera non deterministica si sposta nello stato $q_1$ scommettendo di essere arrivato a metà stringa.

  #figure(image("assets/14_esercizio_05_02.svg"))
]

#request()[
  Riuscite a ottenere automi a pila deterministici per $pal_hash$ e per $pal_"pari"$?
]

#solution()[
  Per $pal_hash$ abbiamo un automa deterministico, mentre per $pal_"pari"$ no perché dobbiamo scommettere di essere arrivati a metà stringa.
]

== Esercizio 06

#exercise()[
  Considerate l'alfabeto $Sigma = {a,b}$ e gli automi a pila ottenuti nell'esercizio precedente.
]

#request()[
  Modificate gli automi a pila ottenuti nell'esercizio precedente in modo da riconoscere il linguaggio di tutte le stringhe palindrome su $Sigma$, cioè l'insieme $pal = {w in Sigma^* bar.v w = w^R}$.
]

#solution()[
  L'automa a pila deve iniziare a caricare la pila con alcuni caratteri, poi non deterministicamente deve spostarsi nello stato di check della stringa e vedere se ha scommesso bene. Inoltre, non deterministicamente si sposta nello stato di check rimuovendo un elemento dalla pila per indicare che l'elemento tolto è quello centrale di una stringa lunga dispari.

  #figure(image("assets/14_esercizio_06_01.svg"))
]

#request()[
  Come si possono modificare gli automi a pila per i linguaggi $pal_hash$, $pal_"pari"$ e $pal$ se $Sigma = {a,b,c}$? In quali casi si riescono ad ottenere dispositivi deterministici e in quali no?
]

#solution()[
  Basta aggiungere agli automi le stesse regole che già abbiamo per le $a$ e le $b$ ma usando i caratteri $c$ nell'alfabeto di input e $C$ nell'alfabeto della pila.

  Come prima, $pal_hash$ è l'unico automa che è deterministico, mentre gli altri due non lo sono perché dobbiamo scommettere di essere arrivati a metà stringa (_entrambi_) o di essere arrivato nel carattere centrale della stringa (_secondo_).
]

#request()[
  Come si possono modificare gli automi a pila per i linguaggi $pal_hash$, $pal_"pari"$ e $pal$ se $Sigma = {a,b,hash}$? In quali casi si riescono ad ottenere dispositivi deterministici e in quali no?
]

#solution()[

]

#request()[
  Considerate ora i linguaggi $pal_hash$, $pal_"pari"$ e $pal$ nel caso di alfabeto $Sigma = {a}$. Per ognuno di essi cercate di ottenere un dispositivo riconoscitore più semplice possibile e discutete se sia necessario l'uso del non determinismo.
]

#solution()[
  Il secondo e il terzo linguaggio mantengono i loro automi: abbiamo cambiato il carattere $c$ con il carattere $hash$, quindi rimaniamo non deterministici con il nostro bellissimo automa a pila.

  Nel primo caso dobbiamo aggiungere del non determinismo che indovina di essere arrivato nel carattere $hash$ che divide la stringa nelle due stringhe una il rovescio dell'altra.
]

== Esercizio 07

#exercise()[]

#request()[
  Definite un automa a pila che riconosca tutte le stringhe sull'alfabeto ${a,b}$ che _non sono_ palindrome.
]

#solution()[
  L'automa a pila inizia a caricare la pila con $A$ e $B$ e poi deve scommettere di essere arrivato a metà, spostandosi nello stato di check, cancellando eventualmente un carattere perché potremmo avere stringhe di lunghezza dispari.

  Nello stato di check, se troviamo una corrispondenza di caratteri diversi andiamo in uno stato finale e svuotiamo la pila. In questo caso accettiamo per stati finali.

  #figure(image("assets/14_esercizio_07_01.svg"))
]
