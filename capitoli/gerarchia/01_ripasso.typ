// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Breve ripasso

Prima di addentrarci nello studio della gerarchia di Chomsky facciamo un breve *ripasso* delle basi che ci serviranno durante lo studio dei linguaggi formali.

Partiamo proprio dalle basi, quindi prima di tutto diamo la definizione di *alfabeto*.

#definition([Alfabeto])[
  Un *alfabeto* è un *insieme non vuoto* e *finito* di *simboli*, di solito indicato con le lettere greche maiuscole $ Sigma quad bar.v quad Gamma . $
]

Dato un alfabeto, sopra di esso ci possiamo costruire delle *stringhe* con varie proprietà.

#definition([Stringa])[
  Una *stringa*, o *parola*, è una *sequenza finita* di simboli appartenenti all'alfabeto $Sigma$. Viene indicata con la lettera $x$ e la possiamo scrivere come $ x = a_1 dots a_n bar.v a_i in Sigma . $
]

#definition([Lunghezza di una stringa])[
  Data una stringa $x$, indichiamo con $ abs(x) $ la sua *lunghezza*, ovvero il *numero di caratteri* contenuti in $x$.
]

#definition([Numero di occorrenze])[
  Data una stringa $x$ e un carattere $a$, indichiamo con $ abs(x)_a space "oppure" space hash_a (x) $ il *numero di occorrenze* del carattere $a$ in $x$.
]

Una stringa/parola molto importante è la *parola vuota*, che possiamo indicare in vari modi: $ epsilon quad bar.v quad lambda quad bar.v quad Lambda . $ Come dice il nome, questa parola non ha simboli, ovvero è l'unica parole tale che $ abs(epsilon) = 0 . $

Dato un alfabeto $Sigma$, l'insieme di tutte le possibili parole che possiamo formare si indica con $Sigma^*$. Questo insieme, ovviamente, è un *insieme infinito*, visto che possiamo concatenare infinite volte i caratteri presenti nell'alfabeto dato.

Con le parole possiamo definire una serie di *operazioni*, ma la più importante è la *concatenazione*, o *prodotto*. Date due stringhe $ x,y in Sigma^* bar.v x = x_1 dots x_n and y = y_1 dots y_m $ allora la concatenazione di $x$ e $y$ è la stringa $ w = x dot y = x_1 dots x_n y_1 dots y_m . $

L'operazione di concatenazione *non è commutativa* ma è *associativa*, quindi la struttura $ (Sigma^*, dot, epsilon) $ è un *monoide libero* generato da $Sigma$.

Vediamo, per (quasi) finire, alcune proprietà che possiamo dare alle stringhe/parole.

#definition([Prefisso])[
  La stringa $x in Sigma^*$ si dice *prefisso* di $w$ se $ exists y in Sigma^* bar.v w = x y . $

  In poche parole, $x$ è prefisso di $w$ se riusciamo a scomporre la stringa $w$ in due parti, dove $x$ è la prima di queste due. Abbiamo due tipi di prefisso:
  - *proprio* se $y eq.not epsilon$;
  - *non banale* se $x eq.not epsilon$.

  Il *numero* di prefissi di una stringa $w$ è $abs(w) + 1$.
]

#definition([Suffisso])[
  La stringa $y in Sigma^*$ si dice *suffisso* di $w$ se $ exists x in Sigma^* bar.v w = x y . $

  In poche parole, vale quanto scritto prima, ma in questo caso $y$ è la seconda delle due parti. Anche qui abbiamo tipi di suffisso:
  - *proprio* se $x eq.not epsilon$;
  - *non banale* se $y eq.not epsilon$.

  Anche il *numero* di suffissi di una stringa $w$ è $abs(w) + 1$.
]

#definition([Fattore])[
  La stringa $y in Sigma^*$ si dice *fattore* di $w$ se $ exists x,z in Sigma^* bar.v w = x y z . $

  In poche parole, vale quanto scritto prima, ma in questo caso dividiamo la stringa $w$ in tre parti e $y$ è la centrale di queste.

  Il *numero* di fattori di una stringa $w$ è $ lt.eq frac(abs(w) abs(w + 1), 2) + 1 $ per via dei possibili doppioni che possiamo trovare.
]

#definition([Sottosequenza])[
  La stringa $x in Sigma^*$ si dice *sottosequenza* di $w$ se $x$ è ottenuta eliminando $0$ o più caratteri da $w$. L'eliminazione può avvenire in maniera non contigua: posso eliminare qualsiasi carattere, ma la stringa risultante che leggiamo deve contenere i caratteri nello stesso ordine di partenza.

  Possiamo dire che un *fattore* è una *sottosequenza contigua*.
]

Per finire veramente, diamo forse la definizione più importante, quella di *linguaggio*.

#definition([Linguaggio])[
  Un *linguaggio* $L$, definito su un alfabeto $Sigma$, è un qualunque sottoinsieme di $Sigma^*$, ovvero $ L subset.eq Sigma^* . $
]

Ora che abbiamo fatto un ripasso siamo pronti per vedere la gerarchia di Chomsky nella sua interezza.
