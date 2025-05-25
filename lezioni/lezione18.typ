// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@preview/syntree:0.2.1": syntree

// Lezione

= Lezione 18 [09/05]

== Ambiguità

Vediamo un esempio che ci serve per introdurre il concetto di *ambiguità*.

#example()[
  Definiamo il linguaggio $ L = {a^p b^q c^r bar.v p = q or q = r} . $

  Questo linguaggio è un *CFL*: infatti, possiamo fare una scommessa iniziale per verificare almeno una delle due condizioni del linguaggio.
]

Nel linguaggio appena visto però potrebbero essere vincenti entrambi i rami: in questo caso, noi abbiamo due modi diversi di riconoscere la stringa che ci viene data.

#example()[
  Diamo una grammatica per il linguaggio precedente. Le produzioni sono $ S &arrow.long S_1 C bar.v A S_2 \ S_1 &arrow.long a S_1 b bar.v epsilon \ S_2 &arrow.long b S_2 c bar.v epsilon \ A &arrow.long a A bar.v epsilon \ C &arrow.long c C bar.v epsilon . $

  Le variabili $S_1$ e $S_2$ sono usate per generare rispettivamente delle stringhe di $a$ e $b$ in egual numero e delle stringhe di $b$ e $c$ in egual numero. Le variabili $A$ e $C$ invece generano rispettivamente sequenze di $a$ e sequenze di $c$ in numero casuale. Riassumendo: $ S_1 &arrow.stroked^* a^n b^n \ S_2 &arrow.stroked^* b^n c^n \ A &arrow.stroked a^k \ C &arrow.stroked^* c^k . $

  Per la stringa $z = a b c$ abbiamo due alberi di derivazione differenti:

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [$S$],
          ([$S_1$], [$a$], ([$S_1$], [$epsilon$]), [$b$]),
          ([$C$], [$c$]),
        ))
      })
    ],
    [
      #cetz.canvas({
        import cetz.tree

        tree.tree((
          [$S$],
          ([$A$], [$a$]),
          ([$S_2$], [$b$], ([$S_2$], [$epsilon$]), [$c$]),
        ))
      })
    ],
  )
]

// TODO: definizione (????)
Una grammatica è *ambigua* quando riusciamo a trovare due diverse derivazioni per una stringa del linguaggio generato da quella grammatica.

#definition([Grado di ambiguità di una stringa])[
  Sia $G = (V, Sigma, P, S)$ una grammatica CF. Sia $w in Sigma^*$. Chiamiamo *grado di ambiguità* di $w$ rispetto a $G$ il numero di alberi di derivazione di $w$, oppure il numero di derivazioni leftmost di $w$.
]

Ovviamente, se una stringa non appartiene a $L(G)$ ha grado di ambiguità pari a zero.

#definition([Grado di ambiguità di una grammatica])[
  Il *grado di ambiguità* di una grammatica $G$ è il massimo grado di ambiguità delle stringhe $w in Sigma^*$.
]

// TODO: rivedi
Il concetto di *ambiguità* è legato al *non determinismo*: abbiamo visto nell'equivalenza tra grammatiche di tipo $2$ e automi a pila che questi ultimi potevano simulare le derivazioni leftmost della grammatica. Se ad un certo punto la grammatica ha più derivazioni leftmost che mi portano poi nella stessa stringa allora stiamo introducendo del non determinismo. Viceversa, quando guardavamo le computazioni possibili in un automa a pila e dovevamo generare le regole di produzione, quando eravamo di fronte ad una scelta dovevamo generare delle regole ambigue.

#definition([Grado di ambiguità di un automa a pila])[
  Il *grado di ambiguità* di un automa a pila è il numero di computazioni accettanti.
]

La relazione però non è biunivoca: infatti, nel linguaggio delle palindrome pari abbiamo del non determinismo ma non abbiamo ambiguità perché la metà della stringa è una sola. Viceversa, se abbiamo ambiguità sicuramente abbiamo non determinismo, perché c'è un punto di scelta dove noi possiamo sdoppiare il riconoscimento.

#definition([Grammatiche inerentemente ambigue])[
  Sia $L$ un CFL. Allora $L$ è *inerentemente ambigua* se ogni grammatica CF per $L$ è ambigua.
]

Andiamo avanti la prossima volta.
