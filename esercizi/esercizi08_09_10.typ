// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Esercizi

= Esercizi lezioni 08, 09 e 10 [28/03]

== Esercizio 01

#exercise()[]

#request()[
  Scrivete un'espressione regolare per il linguaggio formato da tutte le stringhe sull'alfabeto ${0,1}$ che, interpretate come numeri in notazione binaria, rappresentano potenze di $2$.
]

#solution()[
  $ L = 1 0^* . $
]

== Esercizio 02

#exercise()[]

#request()[
  Scrivete un'espressione regolare per il linguaggio formato da tutte le stringhe sull'alfabeto ${0,1}$ che, interpretate come numeri in notazione binaria, _non rappresentano_ potenze di $2$.
]

#solution()[
  $ L = 0 + 1 (0 + 1)^* 1 (0 + 1)^* . $
]

== Esercizio 03

#exercise()[]

#request()[
  Scrivete un'espressione regolare per il linguaggio formato da tutte le stringhe sull'alfabeto ${a,b}$ in cui le $a$ e le $b$ si alternano (come $a b a b$, $b a b$, $b$, ecc.). Disegnate poi un automa per lo stesso linguaggio.
]

#solution()[
  $ L = epsilon + (a b)^+ + (b a)^+ + a (b a)^* + b (a b)^* . $

  Diamo un DFA per questo linguaggio.

  #figure(image("assets/080910_esercizio_03_01.svg"))
]

== Esercizio 04

#exercise()[]

#request()[
  Scrivere un'espressione regolare per il linguaggio formato da tutte le stringhe sull'alfabeto ${a,b}$ nelle quali ogni $a$ è seguita immediatamente da una $b$.
]

#solution()[
  $ L = b^* (a b^+)^* . $
]

== Esercizio 05

#exercise()[]

#request()[
  Scrivete un'espressione regolare per il linguaggio formato da tutte le stringhe sull'alfabeto ${a,b}$ che contengono un numero di $a$ pari e un numero di $b$ pari.

  _Suggerimento_. Se avete difficoltà nell'ottenere direttamente l'espressione, potete costruire prima un automa a stati finiti e, successivamente, ricavare l'espressione regolare servendovi di una delle trasformazioni da automi a espressioni presentate a lezione.
]

#solution()[
  Visto che non mi viene subito l'espressione regolare, usiamo un DFA.

  #figure(image("assets/080910_esercizio_05_01.svg"))

  Scriviamo il sistema di equazioni associato e risolviamo. Buona fortuna.

  $
    cases(X_0 = a X_2 + b X_1 + epsilon, X_1 = a X_3 + b X_0, X_2 = a X_0 + b X_3, X_3 = a X_1 + b X_2) \ cases(X_0 = a X_2 + b X_1 + epsilon, X_1 = a (a X_1 + b X_2) + b X_0, X_2 = a X_0 + b (a X_1 + b X_2)) \ cases(X_0 = a X_2 + b X_1 + epsilon, X_1 = a a X_1 + a b X_2 + b X_0, X_2 = b b X_2 + a X_0 + b a X_1) \ cases(X_0 = a X_2 + b X_1 + epsilon, X_1 = a a X_1 + a b X_2 + b X_0, X_2 = (b b)^* (a X_0 + b a X_1)) \ cases(X_0 = a (b b)^* (a X_0 + b a X_1) + b X_1 + epsilon, X_1 = a a X_1 + a b (b b)^* (a X_0 + b a X_1) + b X_0) \ cases(X_0 = a (b b)^* a X_0 + a (b b)^* b a X_1 + b X_1 + epsilon, X_1 = a a X_1 + a b (b b)^* a X_0 + a b (b b)^* b a X_1 + b X_0) \ cases(X_0 = a (b b)^* a X_0 + (a (b b)^* b a + b) X_1 + epsilon, X_1 = (a a + a b (b b)^* b a) X_1 + (a b (b b)^* a + b) X_0) \ cases(X_0 = a (b b)^* a X_0 + (a (b b)^* b a + b) X_1 + epsilon, X_1 = (a a + a b (b b)^* b a)^* (a b (b b)^* a + b) X_0) \ X_0 = a (b b)^* a X_0 + (a (b b)^* b a + b) (a a + a b (b b)^* b a)^* (a b (b b)^* a + b) X_0 + epsilon .
  $

  Possiamo ora sistemare quest'ultima espressione e trovare il risultato finale

  $
    X_0 = (a (b b)^* a + (a (b b)^* b a + b) (a a + a b (b b)^* b a)^* (a b (b b)^* a + b)) X_0 + epsilon \ L = (a (b b)^* a + (a (b b)^* b a + b) (a a + a b (b b)^* b a)^* (a b (b b)^* a + b))^* .
  $
]

== Esercizio 06

#exercise()[]

#request()[
  Scrivete un'espressione regolare per il linguaggio formato da tutte le stringhe sull'alfabeto ${4,5}$ che, interpretate come numeri in base $10$, rappresentano interi che non sono divisibili per $3$.

  _Suggerimento_. Riguardate gli esercizi delle lezioni $4$-$5$.
]

#solution()[
  Riprendiamo l'automa per questo linguaggio.

  #figure(image("assets/080910_esercizio_06_01.svg"))

  Scriviamo il sistema di equazioni associato e risolviamolo.

  $
    cases(X_0 = 4 X_2 + 5 X_1, X_1 = 4 X_0 + 5 X_2 + epsilon, X_2 = 4 X_1 + 5 X_0 + epsilon) \ cases(X_0 = 4 (4 X_1 + 5 X_0 + epsilon) + 5 X_1, X_1 = 4 X_0 + 5 (4 X_1 + 5 X_0 + epsilon) + epsilon) \ cases(X_0 = 44 X_1 + 45 X_0 + 4 + 5 X_1, X_1 = 54 X_1 + 4 X_0 + 55 X_0 + 5 + epsilon) \ cases(X_0 = 45 X_0 + (44 + 5) X_1 + 4, X_1 = (54)^* ((4 + 55) X_0 + 5 + epsilon)) \ X_0 = 45 X_0 + (44 + 5) (54)^* ((4 + 55) X_0 + 5 + epsilon) + 4 .
  $

  Come prima, risolviamo quest'ultima espressione per ottenere il risultato.

  $
    X_0 = 45 X_0 + (44 + 5) (54)^* (4 + 55) X_0 + (44 + 5) (54)^* 5 + (44 + 5) (54)^* + 4 \ X_0 = (45 + (44 + 5) (54)^* (4 + 55)) X_0 + (44 + 5) (54)^* 5 + (44 + 5) (54)^* + 4 \ L = (45 + (44 + 5) (54)^* (4 + 55))^* ((44+ 5) (54)^* 5 + (44 + 5) (54)^* + 4) .
  $
]

== Esercizio 07

#exercise()[
  Utilizzando le costruzioni presentate a lezione, disegnare un automa a stati finiti con $epsilon$-transizioni equivalente a ciascuna delle seguenti espressioni regolari. Ricavate poi degli automi a stati finiti deterministici equivalenti.
]

*Disclaimer: non so se le costruzioni che ho usato sono corrette, anche se mi sembra di sì.*

#request()[
  $(a + b)^* a b$
]

#solution()[
  Automa ottenuto con la costruzione:

  #figure(image("assets/080910_esercizio_07_01_01.svg"))

  Automa deterministico equivalente:

  #figure(image("assets/080910_esercizio_07_01_02.svg"))
]

#request()[
  $a (a + b + epsilon)^*$
]

#solution()[
  Automa ottenuto con la costruzione:

  #figure(image("assets/080910_esercizio_07_02_01.svg"))

  Automa deterministico equivalente:

  #figure(image("assets/080910_esercizio_07_02_02.svg"))
]

#request()[
  $a^* b a^* + (a a)^*$
]

#solution()[
  Automa ottenuto con la costruzione:

  #figure(image("assets/080910_esercizio_07_03_01.svg"))

  Automa deterministico equivalente:

  #figure(image("assets/080910_esercizio_07_03_02.svg"))
]

== Esercizio 08

#exercise()[]

#request()[
  Dimostrate che per ogni $n',n'' > 0$ esistono due linguaggi $L'$ e $L''$ con $sc(L') = n'$ e $sc(L'') = n''$ tali che $sc(L' union L'') = sc(L' inter L'') = n' n''$.

  _Suggerimento_. Per $n' = n'' = 2$ potete considerare $L' = {w in {a,b}^* bar.v "il numero di" a "in" w "è pari"}$ e $L'' = {w in {a,b}^* bar.v "il numero di" b "in" w "è pari"}$, due automi deterministici $A'$ e $A''$ con due stati che li riconoscono e dimostrare che ogni automa deterministico per l'unione o l'intersezione deve avere almeno $n' n'' = 4$ stati (conviene costruire l'automa prodotto di $A'$ e $A''$ e da esso ricavare $4$ stringhe tutte distinguibili tra loro). Potete poi generalizzare ad altri valori di $n'$ e $n''$.
]

#solution()[
  Consideriamo i due linguaggi $ L_n' = {w in {a,b}^* bar.v hash_a (w) mod n' = 0} \ L_n'' = {w in {a,b}^* bar.v hash_b (w) mod n'' = 0} $ riconosciuti da due DFA $A'$ e $A''$ rispettivamente di $n'$ e $n''$ stati. L'automa prodotto per $L' union L''$ o per $L' inter L''$ ha almeno (_si dimostra poi essere esattamente_) $n' n''$ stati.

  L'automa prodotto per $L' union L''$ accetta se una stringa sta in almeno uno dei due linguaggi, mentre la versione per $L' inter L''$ accetta se una stringa sta in entrambi i linguaggi.

  Definiamo l'insieme $ X = {a^p b^q bar.v p in {0, dots, n' - 1} and q in {0, dots, n'' - 1}} . $

  Questo insieme è formato da stringhe distinguibili tra loro per $L' union L''$:
  - date due stringhe $w'$ e $w''$ esse possono avere:
    - $p' eq.not p'' and q' eq.not q''$:
      - se nessuna stringa è accettata, aggiungiamo un numero di $a$ tale da rendere la prima stringa in $L'$;
      - se una sola delle due stringhe è accettata grazie ad uno dei linguaggi, scegliamo $z = epsilon$;
      - se entrambe le stringhe sono accettate, la prima per $L'$ e la seconda per $L''$, aggiungiamo un numero di $b$ tale da rendere la seconda fuori da $L''$;
    - $p' = p'' or q' = q''$:
      - se il valore nel quale sono uguali le due stringhe le fa accettare allora aggiungiamo:
        - una copia della lettera riferita a quel valore;
        - un numero $k$ dell'altra lettera tale che $k$ fa accettare una delle due stringhe;
      - se il valore nel quale sono uguali le due stringhe non le fa accettare allora aggiungiamo un numero di lettere riferite all'altro valore tale da rendere una delle due stringhe accettata.

  $X$ è un insieme di stringhe distinguibili e ogni automa per $L' union L''$ ha almeno $n' n''$ stati.

  Possiamo fare la stessa cosa per $L' inter L''$:
  - date due stringhe $w'$ e $w''$ esse possono avere:
    - $p' eq.not p'' and q' eq.not q''$:
      - se nessuna stringa è accettata, aggiungiamo un numero di $a$ e di $b$ tale da rendere la prima stringa in $L'$;
      - se una sola delle due stringhe è accettata, scegliamo $z = epsilon$;
    - $p' = p'' or q' = q''$: aggiungiamo un numero di lettere riferite all'elemento uguale per arrivare ad accettare il linguaggio di quella lettera e un numero di altre lettere per far accettare solo una delle due stringhe.

  $X$ è un insieme di stringhe distinguibili e ogni automa per $L' inter L''$ ha almeno $n' n''$ stati
]

== Esercizio 09

#exercise()[
  Richieste:
  - Ispirandovi alle costruzioni presentate a lezione, fornite delle costruzioni che, dati due automi deterministici $A'$ e $A''$ che accettano i linguaggi $L'$ e $L''$, producano automi deterministici per i seguenti linguaggi.
  - Se gi automi $A'$ e $A''$ hanno rispettivamente $n'$ e $n''$ stati, quanti sono gli stati degli automi risultanti? Ritenete che si possa fare di meglio (considerate l'esercizio $8$)?
  - Le costruzioni che avete fornito sono corrette anche nel caso uno o entrambi gli automi dati siano non deterministici? Se la risposta è negativa fornite delle costruzioni alternative e discutete cosa si ottiene rispetto al numero di stati.
]

#request()[
  $L = L' slash L''$.
]

#solution()[
  Possiamo costruire l'automa prodotto che abbiamo visto a lezione dove modifichiamo l'insieme degli stati finali: per avere la differenza, la stringa in input deve stare in $L'$ e non in $L''$, quindi $ F = {(q,p) bar.v q in F' and p in Q'' slash F''} . $

  Abbiamo detto che non si può fare meglio dell'automa prodotto in questi casi, quindi il numero di stati per questo automa è $n' n''$.

  Nel caso in cui uno dei due automi sia un NFA, possiamo eseguire una costruzione simile a quella della concatenazione: la prima componente dell'automa prodotto manda avanti il DFA, la seconda componente invece simula la costruzione per sottoinsiemi. Il numero di stati di questo automa è $lt.eq n' 2^(n'')$.

  Nel caso in cui entrambi gli automi sono NFA, dobbiamo eseguire una doppia costruzione per sottoinsiemi e costruire l'automa prodotto, ottenendo un numero di stati $lt.eq 2^(n') 2^(n'')$.
]

#request()[
  $L = L' Delta L''$ (differenza simmetrica di $L'$ e $L''$).
]

#solution()[
  Possiamo costruire l'automa prodotto che abbiamo visto a lezione dove modifichiamo l'insieme degli stati finali: per avere la differenza simmetrica, la stringa in input deve stare in $L'$ e non in $L''$ o viceversa, quindi $ F = {(q,p) bar.v q in F' and p in Q'' slash F''} union {(q,p) bar.v q in Q' slash F' and p in F''} . $

  Abbiamo detto che non si può fare meglio dell'automa prodotto in questi casi, quindi il numero di stati per questo automa è $n' n''$.

  Nel caso in cui uno dei due automi sia un NFA, possiamo eseguire una costruzione simile a quella della concatenazione: la prima componente dell'automa prodotto manda avanti il DFA, la seconda componente invece simula la costruzione per sottoinsiemi. Il numero di stati di questo automa è $lt.eq n' 2^(n'')$.

  Nel caso in cui entrambi gli automi sono NFA, dobbiamo eseguire una doppia costruzione per sottoinsiemi e costruire l'automa prodotto, ottenendo un numero di stati $lt.eq 2^(n') 2^(n'')$.
]

== Esercizio 10

#exercise()[]

#request()[
  Scrivete un'espressione regolare estesa (in cui cioè avete a disposizione anche operatori per intersezione e complemento) equivalente all'espressione $(a b a)^*$, nella quale non si utilizzi l'operatore $*$.

  _Suggerimento_. L'insieme $Sigma^*$ di tutte le stringhe su un alfabeto $Sigma$ che _non contengono_ un certo fattore $alpha$ può essere espresso come complemento di $overline(emptyset.rev) alpha overline(emptyset.rev)$. L'insieme delle stringhe che iniziano con il prefisso $alpha$ può essere espresso come $alpha overline(emptyset.rev)$. Quali fattori non possono comparire nelle stringhe del linguaggio che stiamo considerando? Quale prefisso e quale suffisso hanno in comune tutte le stringhe non vuote di questo linguaggio?
]

#solution()[
  Non mi viene in mente per ora.
]

== Esercizio 11

#exercise()[
  Dato l'alfabeto $Sigma = {a_0, a_1, a_2, dots, a_n}$, considerate la stringa $ w_n = (dots (((a_0^2 a_1)^2 a_2)^2 a_3)^2 dots a_n)^2 , $ dove, per una stringa $x$, $x^2$ è un'abbreviazione di $x x$.
]

#request()[
  Provate a scrivere alcune stringhe come $w_1$, $w_2$, $w_3$, $dots$ e a esprimere $w_i$ in funzione di $w_(i-1)$, per $i > 0$, scegliendo opportunamente $w_0$.
]

#solution()[
  Calcoliamo qualche stringa $w_i$: $ w_0 &= a_0^2 \ w_1 &= (a_0^2 a_1)^2 = (w_0 a_1)^2 \ w_2 &= ((a_0^2 a_1)^2 a_2)^2 = (w_1 a_2)^2 \ w_3 &= (((a_0^2 a_1)^2 a_2)^2 a_3)^2 = (w_2 a_3)^2 \ w_4 &= ((((a_0^2 a_1)^2 a_2)^2 a_3)^2 a_4)^2 = (w_3 a_4)^2 . $

  Notiamo una struttura ricorsiva: definiamo quindi $w_i$ induttivamente come $ w_i = cases(a_0^2 & "se" i = 0, (w_(i-1) a_i)^2 quad & "se" i > 0) . $
]

#request()[
  Quanto è lunga $w_n$? (Potete scrivere un'equazione di ricorrenza e risolverla.)
]

#solution()[
  La lunghezza di $w_n$ è definita dall'equazione di ricorrenza $ abs(w_n) = cases(2 abs(a_0) & "se" n = 0, 2 abs(w_(n-1)) + 2 abs(a_n) quad & "se" n > 0) . $

  Risolvendo questa equazione di ricorrenza si ottiene $ sum_(i=0)^n 2^(n + 1 - i) abs(a_i) . $
]

#request()[
  Osservate che ogni espressione regolare per il linguaggio $L_n = {w_n}$ (costituito da $w_n$ come unica stringa) deve essere lunga almeno quanto $w_n$.
]

/*
 Non potendo scrivere le potenze devo ogni volta scrivere tutti i singoli ai nell'espressione che esce.

 Ad esempio, w1 = (w0 a1)^2 = w0 a1 w0 1 = a0 a0 a1 a0 a0 a1.

 L'espressione che devo scrivere è esattamente wn.

 Ma non so se è giusto.
*/
#solution()[
  Soluzione nel commento, secondo me non è giusta.
]

#request()[
  Supponete di avere a disposizione anche l'operatore di intersezione. Riuscite a trovare un'espressione per $L_n$ di lunghezza $O(n^2)$?

  _Suggerimento_. Si potrebbe "imbottire" un'espressione come $(dots (((a_0^* a_1)^* a_2)^* a_3)^* dots a_n)^*$ con intersezioni con linguaggi opportuni, in modo che, per ogni occorrenza dell'operatore $*$, tutto ciò che viene ottenuto con un numero di ripetizioni diverso da $2$ venga eliminato.
]

#solution()[
  Sincero non so nemmeno da che parte sono girato.
]

== Esercizio 12

#exercise()[
  Dimostrate che se $L$ è un linguaggio regolare, allora lo sono anche i seguenti linguaggi. In ognuno dei casi, fornite una costruzione per ottenere un automa che accetta il linguaggio considerato a partire da un automa che accetta $L$. Discutete se le costruzioni fornite preservino il determinismo o no.
]

#request()[
  $pref(L) = {x in Sigma^* bar.v exists y in Sigma^* bar.v x y in L}$.
]

#solution()[
  Non lo so, forse.

  // Partiamo dall'automa e togliamo tutti gli stati irraggiungibili, poi rendiamo finali tutti gli stati che non sono stati trappola.
]

#request()[
  $suff(L) = {x in Sigma^* bar.v exists y in Sigma^* bar.v y x in L}$.
]

#solution()[
  Non lo so, forse.

  // Partiamo dall'automa e togliamo tutti gli stati irraggiungibili, poi rendiamo finali tutti gli stati che non sono stati trappola.
]

#request()[
  $fact(L) = {x in Sigma^* bar.v exists y,z in Sigma^* bar.v y x z in L}$.
]

#solution()[
  Questo veramente non lo so.
]

#request()[
  $min(L) = {w in L bar.v forall x,y in Sigma^* quad x y = w and y eq.not epsilon arrow.long.double x in.not L}$.
]

#solution()[
  Non so nemmeno questo, forse.

  // Forse devo rendere finali tutti gli stati che non lo sono. Se invece x = epsilon allora devo garantire che lo stato iniziale non diventi finale, o qualcosa di simile.
]

#request()[
  $max(L) = {w in L bar.v forall x in Sigma^+ quad w x in.not L}$.
]

#solution()[
  Oggi terribile.

  // Forse devo rendere finali tutti gli stati che non lo sono.
]

== Esercizio 13

#exercise()[
  Date due stringhe $x,y in Sigma^*$, lo _shuffle_ di $x$ e $y$, indicato come $shuffle(x,y)$ è il linguaggio che si ottiene "fondendo" in tutti i modi possibili le due stringhe, i.e., $ shuffle(x,y) = {x_0 b_1 x_1 b_2 x_2 dots x_k b_k bar.v x_0, x_1, dots, x_k in Sigma^* and x_0 x_1 dots x_k = x and b_1, b_2, dots, b_k in Sigma^* and b_1 b_2 dots b_k = y} . $

  Lo shuffle di due linguaggi $L',L'' subset.eq Sigma^*$ è il linguaggio formato da tutte le stringhe ottenibili come shuffle di stringhe di $L'$ con stringhe di $L''$, cioè: $ shuffle(L',L'') = union.big_(x in L' and y in L'') shuffle(x,y) . $
]

#request()[
  Fornite una costruzione che dati due automi deterministici per $L'$ e $L''$ permetta di ottenere un automa per $shuffle(L',L'')$ (ispiratevi alla costruzione dell'automa prodotto utilizzata per unione e intersezione).
]

#solution()[
  Vedi teoria.
]

#request()[
  L'automa ottenuto è deterministico?
]

#solution()[
  No, l'automa ottenuto non è deterministico perché ad ogni iterazione deve scommettere qualche automa mandare avanti.
]

#request()[
  Cosa succede nel caso in cui $L'$ e $L''$ siano definiti su alfabeti disgiunti?
]

#solution()[
  Nel caso di linguaggi definiti su alfabeti disgiunti andiamo a finire in un automa deterministico.
]

== Esercizio 14

#exercise()[
  Lo _shuffle perfetto_ di due stringhe $x$ e $y$ della stessa lunghezza è la stringa che si ottiene alternando i simboli di $x$ con quelli di $y$, i.e., se $x = a_1 a_2 dots a_n$ e $y = b_1 b_2 dots b_n$, con $a_i b_i in Sigma$, $i = 1, dots, n$, allora $ perfectShuffle(x,y) = a_1 b_1 a_2 b_2 dots a_n b_n . $

  Dati due linguaggi $L'$ e $L''$ definiamo: $ perfectShuffle(L',L'') = {perfectShuffle(x,y) bar.v x in L' and y in L'' and abs(x) = abs(y)} . $
]

#request()[
  Svolgete l'esercizio $13$ per l'operazione di shuffle perfetto.
]

#solution()[
  Non mi viene in mente niente.
]
