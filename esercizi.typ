// Setup

#import "template.typ": project

#show: project.with(
  title: "Esercizi di teoria dei linguaggi"
)

#let medium-blue = rgb("#4DA6FF")
#let light-blue = rgb("#9FFFFF")

#let introduction(body) = block(
  fill: medium-blue,
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  body,
)

#let assignment(body) = block(
  fill: light-blue,
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  body,
)

#pagebreak()

// Esercizi

= Lezione 01

#pagebreak()

= Lezione 02

== Esercizio 01

#introduction(
  [Considerate l'alfabeto $Sigma = {a,b}$.],
)

#assignment(
  [- Fornite una grammatica context-free per il linguaggio delle stringhe palindrome di lunghezza pari su $Sigma$, cioè per l'insieme $"PAL"_"pari" = {w w^R bar.v w in Sigma^*}$.],
)

Regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long a S a$;
- $S arrow.long b S b$.

#assignment(
  [- Modificate la grammatica precedente per generare l'insieme PAL di tutte le stringhe palindrome su $Sigma$.],
)

Regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long a S a$;
- $S arrow.long b S b$;
- $S arrow.long L$;
- $L arrow.long a$;
- $L arrow.long b$.

#assignment(
  [- Per ogni $k in [0,3]$ rispondete alla domanda "il linguaggio PAL é di tipo $k$?" giustificando la risposta.]
)

- Tipo 0: sì, ogni linguaggio é un linguaggio di tipo 0;
- Tipo 1: sì, per ogni regola di produzione $alpha arrow.long beta$ vale $|beta| gt.eq |alpha|$;
- Tipo 2: sì, ogni regola di produzione $alpha arrow.long beta$ vede $alpha in V$ e $beta in (V union Sigma^*)$;
- Tipo 3: no, la regola $S arrow.long a S a$ non é nella forma $A arrow.long a B$ oppure $A arrow.long a$.

#assignment(
  [Se sostituiamo l'alfabeto con $Sigma = {a,b,c}$, le risposte al punto precedente cambiano? E se lo sostituiamo con $Sigma = {a}$?]
)

Se $Sigma = {a,b,c}$ le risposte non cambiano visto che vanno aggiunte le regole:
- $S arrow.long c S c$;
- $L arrow.long c$.

Se $Sigma = {a}$ le regole di produzione diventano:
- $S arrow.long epsilon$;
- $S arrow.long a$;
- $S arrow.long a S a$;

ma questo non fa cambiare le risposte.

== Esercizio 02

Non ancora spiegato

== Esercizio 03

#introduction(
  [Sia $Sigma = {(,)}$ un alfabeto i cui simboli sono la parentesi aperta e la parentesi chiusa.]
)

#assignment(
  [Scrivete una grammatica context-free che generi il linguaggio formato da tutte le sequenze di parentesi correttamente bilanciate, come ad esempio `(()(()))()`.]
)

Regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long (S)$;
- $S arrow.long S S$.

#assignment(
  [Risolvete il punto precedente per un alfabeto con due tipi di parentesi, come $Sigma = {(, ), [, ]}$, nel caso non vi siano vincoli tra i tipi di parentesi (le tonde possono essere contenute tra quadre e viceversa). Esempio `[()([])[]]`, ma non `[[][(])()]`.]
)

Regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long (S)$;
- $S arrow.long [S]$;
- $S arrow.long S S$.

#assignment(
  [Risolvete il punto precedente con $Sigma = {(, ), [, ]}$, con il vincolo che le parentesi quadre non possano mai apparire all’interno di parentesi tonde. Esempio `[()(())[][]](()())`, ma non `[()([])[]]`.]
)

Regole di produzione:
- $S arrow.long epsilon$;
- $S arrow.long [S]$;
- $S arrow.long S S$;
- $S arrow.long I$;
- $I arrow.long epsilon$;
- $I arrow.long (I)$;
- $I arrow.long I I$.

== Esercizio 04

#introduction(
  [Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, B, C}$, $Sigma = {a, b , c}$ e $P$ contenente le seguenti produzioni: #list([$S arrow.long a S B C | a B C$;], [$C B arrow.long B C$;], [$a B arrow.long a b$;], [$b B arrow.long b b$;], [$b C arrow.long b c$;], [$c C arrow.long c c$.])]
)

#assignment(
  [Dopo avere stabilito di che tipo é $G$, provate a derivare alcune stringhe. Riuscite a dire da quali stringhe é formato il linguaggio generato da $G$?]
)

La grammatica $G$ é di tipo 1.

Deriviamo qualche stringa:
- $S arrow.long a B C arrow.long a b C arrow.long a b c$;
- $S arrow.long a S B C arrow.long a a B C B C arrow.long a a b C B C arrow.long a a b B C C arrow.long a a b b C C arrow.long a a b b c C arrow.long a a b b c c $.

Il linguaggio $L(G)$ è l'insieme ${a^n b^n c^n bar.v n gt.eq 1}$.

== Esercizio 05

#introduction(
  [Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, B, C}$, $Sigma = {a, b, c}$ e $P$ contenente le seguenti produzioni: #list([$S arrow.long a B S c | a b c$;], [$B a arrow.long a B$;], [$B b arrow.long b b$.])]
)

#assignment(
  [Dopo avere stabilito di che tipo é $G$, provate a derivare alcune stringhe. Riuscite a dire da quali stringhe é formato il linguaggio generato da $G$?]
)

La grammatica $G$ é di tipo 1.

Deriviamo qualche stringa:
- $S arrow.long a b c$;
- $S arrow.long a B S c arrow.long a B a b c c arrow.long a a B b c c arrow.long a a b b c c$.

Il linguaggio $L(G)$ è l'insieme ${a^n b^n c^n bar.v n gt.eq 1}$.

== Esercizio 06

#introduction(
  [Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, A, B, C, D, E}$, $Sigma = {a,b}$ e $P$ contenente le seguenti produzioni: #list([$S arrow.long A B C$;], [$A B arrow.long a A D | b A E | epsilon$;], [$D C arrow.long B a C$;], [$E C arrow.long B b C$;], [$D a arrow.long a D$;], [$D b arrow.long b D$;], [$E a arrow.long a E$;], [$E b arrow.long b E$;], [$C arrow.long epsilon$;], [$a B arrow.long B a$;], [$b B arrow.long b B$.])]
)

#assignment(
  [Dopo avere stabilito di che tipo é $G$, provate a derivare alcune stringhe. Riuscite a dire da quali stringhe é formato il linguaggio generato da $G$?]
)

La grammatica $G$ é di tipo 1.

Deriviamo qualche stringa:
- $S arrow.long A B C arrow.long^* epsilon$;
- $S arrow.long A B C arrow.long a A D C arrow.long a A B a C arrow.long^* a a$;
- $S arrow.long^* a A B a C arrow.long a a A D a C arrow.long a a A a D C arrow.long a a A a B a C arrow.long a a A B a a C arrow.long^* a a a a$;
- $S arrow.long^* a A B a C arrow.long a b A E a C arrow.long a b A a E C arrow.long a b A a B b C arrow.long a b A B a b C arrow.long^* a b a b$;
- $S arrow.long A B C arrow.long b A E C arrow.long b A B b C arrow.long^* b b$;
- $S arrow.long^* b A B b C arrow.long b b A E b C arrow.long b b A b E C arrow.long b b A b B b C arrow.long b b A B b b C arrow.long^* b b b b$;
- $S arrow.long^* b A B b C arrow.long b a A D b C arrow.long b a A b D C arrow.long b a A b B a C arrow.long b a A B b a C arrow.long^* b a b a$.

Il linguaggio $L(G)$ è l'insieme ${a^(2n) union b^(2n) union (a b)^(2n) union (b a)^(2n) bar.v n gt.eq 0}$.

== Esercizio 07

#introduction(
  [Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, A, B, C, X, Y, L, R}$, $Sigma = {a}$ e $P$ contenente le seguenti produzioni: #list([$S arrow.long L X R$;], [$L X arrow.long L Y Y A | a C$;], [$A X arrow.long Y Y A$;], [$A R arrow.long B R$;], [$Y B arrow.long B X$;], [$L B arrow.long L$;], [$C X arrow.long a C$;], [$C R arrow.long epsilon$.])]
)

#assignment(
  [Riuscite a stabilire da quali stringhe é formato il linguaggio generato da $G$?]
)

Deriviamo qualche stringa:
- $S arrow.long L X R arrow.long a C R arrow.long a$;
- $S arrow.long L X R arrow.long L Y Y A R arrow.long^* L X X R arrow.long a C X R arrow.long a a C R arrow.long a a$;
- $S arrow.long L X R arrow.long^* L X X R arrow.long L Y Y A X R arrow.long L Y Y Y Y A R arrow.long^* L X X X X R arrow.long^* a a a a$.
- $S arrow.long L X R arrow.long^* L X X X X R arrow.long^* L Y Y Y Y Y Y Y Y A R arrow.long^* L X X X X X X X X R arrow.long^* a a a a a a a a$.

Il linguaggio $L(G)$ è l'insieme ${a^(2^n) bar.v n gt.eq 0}$.

== Esercizio 08

#introduction([])

#assignment(
  [Modificate la grammatica dell’esercizio 07 in modo da ottenere una grammatica di tipo 1 che generi lo stesso linguaggio.]
)

Modificando la regola $L B arrow.long L$ in $L B arrow.long C R L$ la grammatica diventa di tipo 1.

== Esercizio 09

#introduction(
  []
)

#assignment(
  [Dimostrate che la grammatica $G = ({A, B, S}, {a, b}, P, S)$, con l’insieme delle produzioni $P$ elencate sotto, genera il linguaggio ${w in {a, b}^* bar.v forall x in {a, b}^* w eq.not x x}$: #list([$S arrow.long A B | B A | A | B$], [$A arrow.long a A a | a A b | b A a | b A b | a$], [$B arrow.long a B a | a B b | b B a | b B b | b$])]
)

Consideriamo in primo luogo i "casi base":
- $S arrow.long A arrow.long a$ va bene perché di lunghezza dispari;
- $S arrow.long B arrow.long b$ va bene perché di lunghezza dispari;
- $S arrow.long A B arrow.long^* a b$ va bene perché $a eq.not b$;
- $S arrow.long B A arrow.long^* b a$ va bene perché $b eq.not a$.

Consideriamo poi $S arrow.long A | B$:
$ S arrow.long A arrow.long & a A a arrow.long^* a^n A a^n arrow.long a^n a a^n; \ & a A a arrow.long^* a b^n A b^n a arrow.long a b^n a b^n a; \ & a A a arrow.long^* a {a,b}^n A {a, b}^n a arrow.long a {a,b}^n a {a, b}^n a; \ & a A b arrow.long^* dots space . $

$ S arrow.long B arrow.long & a B a arrow.long^* a^n B a^n arrow.long a^n b a^n; \ & a B a arrow.long^* a b^n B b^n a arrow.long a b^n b b^n a; \ & a B a arrow.long^* a {a,b}^n B {a, b}^n a arrow.long a {a,b}^n b {a, b}^n a; \ & a B b arrow.long^* dots space . $

Tutte le stringhe che vengono generate vanno bene perché sono di lunghezza dispari.

Consideriamo infine $S arrow.long A B | B A$ in due casi:
- se eseguiamo su $A$ e $B$ lo stesso numero di passi di derivazione abbiamo altri due casi:
  - usiamo regole con lo "stesso contesto", ma alla fine avremo un carattere diverso nella posizione dove sono presenti $A$ e $B$;
  - usiamo regole con "diverso contesto", ma la prima regola che rispecchia questa casistica ha almeno un carattere diverso (oltre ad avere il carattere in $A$ e $B$ diverso alla fine della derivazione);
- se eseguiamo su $A$ e $B$ un numero diverso di passi di derivazione, abbiamo due punti di partenza:
  - partiamo da $A B$ e indichiamo con $n$ la lunghezza della stringa derivata da $A$ e con $k$ la lunghezza della stringa derivata da $B$, con $k > n$. Per ottenere due stringhe della stessa lunghezza devo rimuovere da $k$ un numero $frac(n-k,2)$ di caratteri e appenderli a $n$, ottenendo due stringhe di lunghezza $t$. Prima dell'ultimo passo di derivazione di $A$ la variabile $A$ era in posizione $frac(n-1, 2)$, mentre ora si trova in posizione $frac(t-1, 2) - frac(n-k,4)$ perché prima mi devo prima posizionare nel "nuovo centro" e poi mi devo spostare di una posizione indietro ogni due caratteri che avevo aggiunto. Facciamo lo stesso ragionamento per trovare l'indice dell'ultima $B$ di $B$. Le due posizioni trovate sono le stesse, ma prima dell'ultima derivazione in $A$ si aveva una $A$ e in $B$ si aveva una $B$, che però generano rispettivamente $a$ e $b$, quindi otteniamo due stringhe che sono sempre diverse.
  - partiamo da $B A$ e facciamo lo stesso discorso, basta invertire l'ordine delle stringhe.

Abbiamo quindi dimostrato che $L(G) = {w in {a, b}^* bar.v forall x in {a, b}^* w eq.not x x}$.

#pagebreak()

= Lezione 03

== Esercizio 01

#introduction(
  []
)

#assignment(
  [Costruite un automa a stati finiti che riconosca il linguaggio formato da tutte le stringhe sull’alfabeto ${a, b}$ nelle quali ogni a é seguita immediatamente da una $b$.]
)

#v(12pt)

#figure(
  image("assets-esercizi/lezione03-01.svg", width: 50%)
)

#v(12pt)

== Esercizio 02

#introduction(
  []
)

#assignment(
  [Costruite un automa a stati finiti che riconosca il linguaggio formato da tutte le stringhe sull’alfabeto ${4, 5}$ che, interpretate come numeri in base $10$, rappresentano numeri interi che _non sono_ divisibili per $3$.]
)

#v(12pt)

#figure(
  image("assets-esercizi/lezione03-02.svg", width: 100%)
)

#v(12pt)

== Esercizio 03

#introduction(
  []
)

#assignment(
  [Costruite un automa a stati finiti deterministico che riconosca il linguaggio formato da tutte le stringhe sull’alfabeto ${0, 1}$ che, interpretate come numeri in notazione binaria, denotano multipli di $4$.]
)

#v(12pt)

#figure(
  image("assets-esercizi/lezione03-03-01.svg", width: 60%)
)

#v(12pt)

#assignment(
  [Utilizzando il non determinismo si riesce a costruire un automa con meno stati? Generalizzate l’esercizio a multipli di $2k$, dove $k > 0$ é un intero fissato.]
)

Utilizzando il non determinismo si usano ancora $4$ stati.

#v(12pt)

#figure(
  image("assets-esercizi/lezione03-03-02.svg", width: 70%)
)

#v(12pt)

Generalizzando a multipli di $2k$, con $k > 0$, abbiamo:
- per il DFA $2^k$ stati;
- per il NFA $k+2$ stati.

== Esercizio 04

#introduction(
  []
)

#assignment(
  [Costruite un automa a stati finiti che riconosca il linguaggio formato da tutte le stringhe sull’alfabeto ${0, 1}$ che, interpretate come numeri in notazione binaria, rappresentano multipli di $5$.]
)

#v(12pt)

#figure(
  image("assets-esercizi/lezione03-04.svg", width: 100%)
)

#v(12pt)

#pagebreak()

= Lezione 04

== Esercizio 01

#introduction(
  [Considerate il linguaggio$ L = {w in {a,b}^* bar.v "il penultimo e il terzultimo simbolo di" w "sono uguali"}. $ ]
)

#assignment(
  [Costruite un automa a stati finiti deterministico che accetta $L$.]
)

#v(12pt)

#figure(
  image("assets-esercizi/lezione04-01-01.svg", width: 100%)
)

#v(12pt)

#assignment(
  [Costruite un automa a stati finiti non deterministico che accetta $L$.]
)

#v(12pt)

#figure(
  image("assets-esercizi/lezione04-01-02.svg", width: 80%)
)

#v(12pt)

#assignment(
  [Dimostrate che per il linguaggio $L$ tutte le stringhe di lunghezza $3$ sono distinguibili tra loro.]
)

#v(12pt)

#align(center)[
  #table(
    columns: (10%, 10%, 10%, 10%, 10%, 10%, 10%, 10%, 10%),
    inset: 10pt,
    align: horizon,

    [], [*$a a a$*], [*$a a b$*], [*$a b a$*], [*$a b b$*], [*$b a a$*], [*$b a b$*], [*$b b a$*], [*$b b b$*],

    [*$a a a$*], [-], [$a$], [$epsilon$], [$epsilon$], [$epsilon$], [$epsilon$], [$a$], [$a a$],
    [*$a a b$*], [-], [-], [$epsilon$], [$epsilon$], [$epsilon$], [$epsilon$], [$b b$], [$b$],
    [*$a b a$*], [-], [-], [-], [$b$], [$a$], [$a a$], [$epsilon$], [$epsilon$],
    [*$a b b$*], [-], [-], [-], [-], [$a a$], [$b$], [$epsilon$], [$epsilon$],
    [*$b a a$*], [-], [-], [-], [-], [-], [$a$], [$epsilon$], [$epsilon$],
    [*$b a b$*], [-], [-], [-], [-], [-], [-], [$epsilon$], [$epsilon$],
    [*$b b a$*], [-], [-], [-], [-], [-], [-], [-], [$a$],
    [*$b b b$*], [-], [-], [-], [-], [-], [-], [-], [-],
  )
]

#v(12pt)

#assignment(
  [Dimostrate che per il linguaggio $L$ la parola vuota é distinguibile da tutte le stringhe di lunghezza $3$.]
)

#v(12pt)

#align(center)[
  #table(
    columns: (10%, 10%, 10%, 10%, 10%, 10%, 10%, 10%, 10%),
    inset: 10pt,
    align: horizon,

    [], [*$a a a$*], [*$a a b$*], [*$a b a$*], [*$a b b$*], [*$b a a$*], [*$b a b$*], [*$b b a$*], [*$b b b$*],

    [*$epsilon$*], [$epsilon$], [$epsilon$], [$a b$], [$a$], [$a$], [$b a$], [$epsilon$], [$epsilon$],
  )
]

#v(12pt)

#assignment(
  [Utilizzando i risultati precedenti, ricavate un limite inferiore per il numero di stati di ogni automa deterministico che accetta L.]
)

L'insieme $X = {w in {a,b}^+ bar.v |w| = 3}$ é un insieme di parole tutte distinguibili tra loro rispetto al linguaggio  $L$, come dimostrato nei punti precedenti, quindi ogni DFA per $L$ deve avere almeno $|X|$ stati, ovvero almeno $8$ stati.

== Esercizio 02

#introduction(
  []
)

#assignment(
  [Costruite un insieme di stringhe distinguibili tra loro per ognuno dei seguenti linguaggi: #list([$L_1 = {w in {a,b}^* bar.v \#_a (w) = \#_b (w)}$,], [$L_2 = {a^n b^n bar.v n gt.eq 0}$,], [$L_3 = {w w^R bar.v w in {a,b}^*}$ dove, per ogni stringa $w$, $w^R$ indica la stringa $w$ scritta al contrario.])]
)

Costruiamo i seguenti insiemi:
- $X_1 = {a^i bar.v i gt.eq 1}$ di cardinalità infinita;
- $X_2 = {a^i bar.v i gt.eq 1}$ di cardinalità infinita;
- $X_3 = {(a b)^i bar.v i gt.eq 1}$ di cardinalità infinita.

#assignment(
  [Per alcuni di questi linguaggi riuscite ad ottenere insiemi di stringhe distinguibili di cardinalità infinita? Cosa significa ciò?]
)

I linguaggi che hanno insiemi di stringhe distinguibili di cardinalità infinita sono linguaggi non di tipo $3$.

== Esercizio 03

#introduction(
  [Considerate l’automa di Meyer e Fischer $M_n$ presentato nella Lezione $4$ (caso peggiore della costruzione per sottoinsiemi) e mostrato nella seguente figura:]
)

#v(12pt)

#figure(
  image("assets-teoria/meyer-fischer.svg", width: 50%)
)

#v(12pt)

#assignment(
  [Descrivete a parole la proprietà che deve soddisfare una stringa per essere accettata da $M_n$. Riuscite a costruire un automa non deterministico, diverso da $M_n$, per lo stesso linguaggio, basandovi su tale proprietà?]
)

Non lo so fare.
