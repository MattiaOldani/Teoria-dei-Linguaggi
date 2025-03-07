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


// Lezione

= Esercizi lezione 01 e 02 [28/02]

== Esercizio 01

#exercise()[
  Considerate l'alfabeto $Sigma = {a,b}$.
]

#request()[
  Fornite una grammatica CF per il linguaggio delle stringhe palindrome di lunghezza pari su $Sigma$, cioè per l'insieme $"PAL"_"pari" = {w w^R bar.v w in Sigma^*}$.
]

#solution()[
  Definisco $G$ tale che $V = {S}$ e $ P = {S arrow.long epsilon bar.v a S a bar.v b S b} . $
]

#request()[
  Modificate la grammatica precedente per generare l'insieme PAL di tutte le stringhe palindrome su $Sigma$.
]

#solution()[
  Definisco $G$ tale che $V = {S}$ e $ P = {S arrow.long epsilon bar.v a S a bar.v b S b bar.v a bar.v b} . $
]

#request()[
  Per ogni $k in {0, dots, 3}$, rispondete alla domanda _"Il linguaggio PAL è di tipo k?"_ giustificando la risposta.
]

#solution()[
  Non è di tipo $3$ per le produzioni $S arrow.long a S a | b S b$ ma è di tipo $2$ visto che rispetta le restrizioni sulle produzioni. Di conseguenza, è anche di tipo $1$ e di tipo $0$.
]

#request()[
  Se sostituiamo l'alfabeto con $Sigma = {a, b, c}$, le risposte al punto precedente cambiano? E se sostituiamo con $Sigma = {a}$?
]

#solution()[
  Se $Sigma = {a, b, c}$ vanno aggiunte due produzioni che però sono nella forma di quelle precedenti, quindi le risposte non cambiano.

  Se $Sigma = {a}$ le uniche produzioni che abbiamo sono $ S arrow.long epsilon bar.v a S bar.v a $ e quindi la grammatica è di tipo $3$. Di conseguenza, è anche di tipo $2$, tipo $1$ e tipo $0$.
]

== Esercizio 02

#exercise()[
  Considerate l'alfabeto $Sigma = {a,b}$.
]

#request()[
  Scrivete una grammatica per generare il complemento di PAL.
]

#solution()[
  Sia $G$ tale che $V = {S,D,B}$ e $P$ formato da $ S arrow.long a S a bar.v b S b bar.v D \ D arrow.long a D b bar.v b D a bar.v B \ B arrow.long epsilon bar.v a bar.v b bar.v S . $
]

== Esercizio 03

#exercise()[
  Sia $Sigma = {(,)}$ un alfabeto i cui simboli sono la parentesi aperta e la parentesi chiusa.
]

#request()[
  Scrivete una grammatica CF che generi il linguaggio formato da tutte le sequenze di parentesi correttamente bilanciate, come ad esempio $(()(()))()$.
]

#solution()[
  Sia $G$ una grammatica con $V = {S}$ e $P$ formato da $ S arrow.long epsilon bar.v (S) bar.v S S . $
]

#request()[
  Risolvete il punto precedente per un alfabeto con due tipi di parentesi, come $Sigma = {(,),[,]}$, nel caso non vi siano vincoli tra i tipi di parentesi (le tonde possono essere contenute tra quadre e viceversa). Esempio $[()([])[]]$ ma non $[[][(])()]$.
]

#solution()[
  Sia $G$ una grammatica con $V = {S}$ e $P$ formato da $ S arrow.long epsilon bar.v (S) bar.v [S] bar.v S S . $
]

#request()[
  Risolvete il punto precedente con $Sigma = {(,),[,]}$, con il vincolo che le parentesi quadre non possano apparire all'interno di parentesi tonde. Esempio $[()(())[][]](()())$, ma non $[()([])[]]$.
]

#solution()[
  Sia $G$ una grammatica con $V = {S, T}$ e $P$ formato da $ S arrow.long epsilon bar.v [S] bar.v S S bar.v T \ T arrow.long epsilon bar.v (T) bar.v T T . $
]

== Esercizio 04

#exercise()[
  Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, B, C}$, $Sigma = {a, b, c}$ e $P$ contenente le seguenti produzioni: $ S arrow.long a S B C bar.v a B C \ C B arrow.long B C \ a B arrow.long a b \ b B arrow.long b b \ b C arrow.long b c \ c C arrow.long c c . $
]

#request()[
  Dopo aver stabilito di che tipo è $G$, provate a derivare alcune stringhe. Riuscite a dire da quali stringhe è formato il linguaggio generato da $G$?
]

#solution()[
  La grammatica $G$ è di tipo $1$.

  Prima derivazione: $ S arrow.long a B C arrow.long a b C arrow.long a b c . $

  Seconda derivazione: $ S & arrow.long a S B C arrow.long a a B C B C arrow.long a a b C B C \ & arrow.long a a b B C C arrow.long a a b b C C arrow.long a a b b c C arrow.long a a b b c c . $

  Possiamo dire che $L(G) = {a^n b^n c^n bar.v n gt.eq 1}$.
]

== Esercizio 05

#exercise()[
  Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, B, C}$, $Sigma = {a, b, c}$ e $P$ contenente le seguenti produzioni: $ S arrow.long a B S c bar.v a b c \ B a arrow.long a B \ B b arrow.long b b . $
]

#request()[
  Dopo aver stabilito di che tipo è $G$, provate a derivare alcune stringhe. Riuscite a dire da quali stringhe è formato il linguaggio generato da $G$?
]

#solution()[
  La grammatica $G$ è di tipo $1$.

  Prima derivazione: $ S arrow.long a b c . $

  Seconda derivazione: $ S arrow.long a B S c arrow.long a B a b c c arrow.long a a B b c c arrow.long a a b b c c . $

  Come prima, possiamo dire che $L(G) = {a^n b^n c^n bar.v n gt.eq 1}$.
]

== Esercizio 06

#exercise()[
  Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, A, B, C, D, E}$, $Sigma = {a, b}$ e $P$ contenente le seguenti produzioni: $ S arrow.long A B C \ A B arrow.long a A D bar.v b A E bar.v epsilon \ D C arrow.long B a C \ E C arrow.long B b C \ D a arrow.long a D \ D b arrow.long b D \ E a arrow.long a E \ E b arrow.long b E \ C arrow.long epsilon \ a B arrow.long B a \ b B arrow.long B b . $
]

#request()[
  Dopo aver stabilito di che tipo è $G$, provate a derivare alcune stringhe. Riuscite a dire da quali stringhe è formato il linguaggio generato da $G$?

  _Suggerimento_. Per ogni $w in {a,b}^*$ è possibile costruire una derivazione $S arrow.stroked^* w A B w C$ (provate a procedere per induzione sulla lunghezza di $w$ cercando di capire il ruolo di ciascuna delle variabile nel processo di derivazione).
]

#solution()[
  La grammatica $G$ è di tipo $1$.

  Prima derivazione: $ S arrow.long A B C arrow.long C arrow.long epsilon . $

  Seconda derivazione: $ S arrow.long A B C arrow.long a A D C arrow.long a A B a C arrow.long a a C arrow.long a a . $

  Terza derivazione: $ S & arrow.long A B C arrow.long a A D C arrow.long a A B a C arrow.long a b A E a C arrow.long a b A a E C \ & arrow.long a b A a B b C arrow.long a b A B a b C arrow.long a b a b C arrow.long a b a b . $

  Possiamo dire che $L(G) = {w w bar.v w in Sigma^*}$.
]

== Esercizio 07

#exercise()[
  Sia $G = (V, Sigma, P, S)$ la grammatica con $V = {S, A, B, C, X, Y, L, R}$, $Sigma = {a}$ e P contenente le seguenti produzioni: $ S arrow.long L X R \ L X arrow.long L Y Y A bar.v a C \ A X arrow.long Y Y A \ A R arrow.long B R \ Y B arrow.long B X \ L B arrow.long L \ C X arrow.long a C \ C R arrow.long epsilon . $
]

#request()[
  Riuscite a stabilire da quali stringhe è formato il linguaggio generato da $G$?

  _Suggerimento_. Si può osservare che $L X^i R arrow.stroked^* L Y^(2i) A R arrow.stroked L X^(2i) R$ per ogni $i > 0$. Inoltre dal simbolo iniziale si ottiene la forma $L X R$. Le ultime tre produzioni sono utili per sostituire variabili in una forma sentenziale con occorrenze di terminali.
]

#solution()[
  La grammatica $G$ è di tipo $0$.

  Prima derivazione: $ S arrow.long L X R arrow.long a C R arrow.long a . $

  Seconda derivazione: $ S & arrow.long L X R arrow.long L Y Y A R arrow.long L Y Y B R arrow.long L Y B X R \ & arrow.long L B X X R arrow.long L X X R arrow.long a C X R arrow.long a a C R arrow.long a a . $

  Terza derivazione: $ S & arrow.long L X R arrow.long L Y Y A R arrow.long L Y Y B R arrow.long L Y B X R arrow.long L B X X R arrow.long L X X R \ & arrow.long L Y Y A X R arrow.long L Y Y Y Y A R arrow.long L Y Y Y Y B R arrow.long L Y Y Y B X R \ & arrow.long L Y Y B X X R arrow.long L Y B X X X R arrow.long L B X X X X R arrow.long L X X X X R \ & arrow.long a C X X X R arrow.long a a C X X R arrow.long a a a C X R arrow.long a a a a C R arrow.long a a a a . $

  Possiamo dire che $L(G) = {a^(2^n) bar.v n gt.eq 0}$.
]

== Esercizio 08

#exercise()[]

#request()[
  Modificate la grammatica dell'esercizio $7$ in modo da ottenere una grammatica di tipo $1$ che generi lo stesso linguaggio.
]

#solution()[
  La produzione che dà problemi è $L B arrow.long L$. La facciamo diventare $ L B arrow.long C R L . $

  In questo modo rispettiamo tutti i vincoli delle grammatiche di tipo $1$ e non modifichiamo la grammatica, visto che $C R$ non genera problemi con la $L$ o con la $a$ quando facciamo le sostituzioni finali.
]

== Esercizio 09

#exercise()[]

#request()[
  Dimostrate che la grammatica $G = ({A,B,S}, {a,b}, P, S)$, con l'insieme delle produzioni $P$ elencate sotto, genera il linguaggio ${w in {a,b}^* bar.v forall x in {a,b}^* quad w eq.not x x}$.

  $
    S arrow.long A B bar.v B A arrow.long A bar.v B \ A arrow.long a A a bar.v a A b bar.v b A a bar.v b A b bar.v a \ B arrow.long a B a bar.v a B b bar.v b B a bar.v b B b bar.v b
  $
]

#solution()[
  Eseguendo come prima produzione $S arrow.long A bar.v B$ si ottengono delle stringhe di lunghezza dispari, che quindi non possono essere scritte come concatenazione di due stringhe uguali.

  Eseguendo invece come prima produzione $S arrow.long A B bar.v B A$ e facendo un numero di sostituzioni uguali per entrambe le parti, le due stringhe risultanti di ugual lunghezza avranno almeno una posizione differente, generate dall'ultimo cambio di $A$ e $B$.

  Eseguendo invece come prima produzione $S arrow.long A B bar.v B A$ e facendo un numero di sostituzioni diverso per le due parti, non lo so dimostrare, secondo Martino lo dobbiamo fare ma io non lo farò, baci.
]
