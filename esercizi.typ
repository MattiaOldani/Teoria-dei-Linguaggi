// Setup

#import "template.typ": project

#show: project.with(title: "Esercizi di teoria dei linguaggi")

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

= Lezione 03

== Esercizio 01

#assignment([Dimostrate che per il linguaggio $L$ tutte le stringhe di lunghezza $3$ sono distinguibili tra loro.])

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

#pagebreak()

= Lezione 06

== Esercizio 01

#introduction([])

#assignment([Scrivete un’espressione regolare per il linguaggio formato da tutte le stringhe sull’alfabeto ${0, 1}$ che, interpretate come numeri in notazione binaria, rappresentano potenze di $2$.])

#v(12pt)

#figure(image("assets-esercizi/lezione06-01.svg", width: 40%))

#v(12pt)

Imposto il sistema di equazioni: $ &cases(X_0 = 0 X_0 + 1 X_1 + epsilon, X_1 = 0 X_1 + epsilon) \ &cases(X_0 = 0 X_0 + 1 0^* + epsilon, X_1 = 0^*) quad . $

L'espressione regolare corrispondente é: $ X_0 &= 0^* (1 0^* + epsilon) \ X_0 &= 0^* 1 0^*. $

== Esercizio 02

#introduction([])

#assignment([Scrivete un’espressione regolare per il linguaggio formato da tutte le stringhe sull’alfabeto ${0, 1}$ che, interpretate come numeri in notazione binaria, _non rappresentano_ potenze di $2$.])

#v(12pt)

#figure(image("assets-esercizi/lezione06-02.svg", width: 60%))

#v(12pt)

Imposto il sistema di equazioni: $ &cases(X_0 = 0 X_0 + 1 X_1, X_1 = 0 X_1 + 1 X_2, X_2 = 0 X_2 + 1 X_2 + epsilon) \ &cases(X_0 = 0 X_0 + 1 X_1, X_1 = 0 X_1 + 1 (0 + 1)^*, X_2 = (0 + 1)^*) \ &cases(X_0 = 0 X_0 + 1 0^* 1 (0 + 1)^*, X_1 = 0^* 1 (0 + 1)^*) quad . $

L'espressione regolare corrispondente é: $ X_0 = 0^* 1 0^* 1 (0 + 1)^*. $

== Esercizio 03

#introduction([])

#assignment([Scrivete un’espressione regolare per il linguaggio formato da tutte le stringhe sull’alfabeto ${a, b}$ in cui le $a$ e le $b$ si alternano (come $a b a b$, $b a b$, $b$, ecc). Disegnate poi un automa per lo stesso linguaggio.])

#v(12pt)

#figure(image("assets-esercizi/lezione06-03.svg", width: 50%))

#v(12pt)

Imposto il sistema di equazioni: $ &cases(X_0 = a X_1 + b X_2 + epsilon, X_1 = b X_2 + epsilon, X_2 = a X_1 + epsilon) \ &cases(X_0 = a X_1 + b (a X_1 + epsilon) + epsilon, X_1 = b (a X_1 + epsilon) + epsilon) \ &cases(X_0 = (a + b a) X_1 + b + epsilon, X_1 = b a X_1 + b + epsilon) \ &cases(X_0 = (a + b a) (b a)^* (b + epsilon) + b + epsilon, X_1 = (b a)^* (b + epsilon)) quad . $

L'espressione regolare corrispondente é: $ X_0 = (a + b a)(b a)^* b + (a + b a)(b a)^* + epsilon . $

== Esercizio 04

#introduction([])

#assignment([Scrivete un’espressione regolare per il linguaggio formato da tutte le stringhe sull’alfabeto ${a, b}$ nelle quali ogni $a$ é seguita immediatamente da una $b$.])

#v(12pt)

#figure(image("assets-esercizi/lezione06-04.svg", width: 40%))

#v(12pt)

Imposto il sistema di equazioni: $ &cases(X_0 = b X_0 + a X_1 + epsilon, X_1 = b X_0) \ &cases(X_0 = b X_0 + a b X_0 + epsilon, X_1 = b X_0) \ &cases(X_0 = (b + a b) X_0 + epsilon, X_1 = b X_0) \ &cases(X_0 = (b + a b)^* + epsilon, X_1 = b X_0) quad . $

L'espressione regolare corrispondente é: $ X_0 = (b + a b)^* + epsilon $

== Esercizio 05

#introduction([])

#assignment([Scrivete un’espressione regolare per il linguaggio formato da tutte le stringhe sull’alfabeto ${a, b}$ che contengono un numero di $a$ pari e un numero di $b$ pari.])

#v(12pt)

#figure(image("assets-esercizi/lezione06-05.svg", width: 70%))

#v(12pt)

Imposto il sistema di equazioni: $ &cases(X_0 = a X_1 + b X_2 + epsilon, X_1 = a X_0 + b X_3, X_2 = b X_0 + a X_3, X_3 = a X_1 + b X_2) \ &cases(X_0 = a X_1 + b X_2 + epsilon, X_1 = a X_0 + b (a X_1 + b X_2), X_2 = b X_0 + a (a X_1 + b X_2)) \ &cases(X_0 = a X_1 + b X_2 + epsilon, X_1 = b a X_1 + a X_0 + b b X_2, X_2 = a b X_2 + b X_0 + a a X_1) \ &cases(X_0 = a X_1 + b (a b)^* (b X_0 + a a X_1) + epsilon, X_1 = b a X_1 + a X_0 + b b (a b)^* (b X_0 + a a X_1), X_2 = (a b)^* (b X_0 + a a X_1)) \ &cases(X_0 = a X_1 + b (a b)^* b X_0 + b (a b)^* a a X_1 + epsilon, X_1 = (b a + b b (a b)^* a a) X_1 + a X_0 + b b (a b)^* b X_0) \ &cases(X_0 = b (a b)^* b X_0 + (a + b (a b)^* a a) X_1 + epsilon, X_1 = (b a + b b (a b)^* a a)^* (a + b b (a b)^* b) X_0) quad . $

$
  X_0 &= b (a b)^* b X_0 + (a + b (a b)^* a a) (b a + b b (a b)^* a a)^* (a + b b (a b)^* b) X_0 + epsilon \ X_0 &= (b (a b)^* b + (a + b (a b)^* a a) (b a + b b (a b)^* a a)^* (a + b b (a b)^* b)) X_0 + epsilon .
$

L'espressione regolare corrispondente é: $ X_0 &= (b (a b)^* b + (a + b (a b)^* a a) (b a + b b (a b)^* a a)^* (a + b b (a b)^* b))^* . $

== Esercizio 06

#introduction([])

#assignment([Scrivete un’espressione regolare per il linguaggio formato da tutte le stringhe sull’alfabeto ${4, 5}$ che, interpretate come numeri in base $10$, rappresentano interi che non sono divisibili per $3$.])

#v(12pt)

#figure(image("assets-esercizi/lezione06-06.svg", width: 60%))

#v(12pt)

Imposto il sistema di equazioni: $ &cases(X_0 = 0 X_0 + 1 X_1 + epsilon, X_1 = 0 X_2 + 1 X_0, X_2 = 0 X_1 + 1 X_2) \ &cases(X_0 = 0 X_0 + 1 X_1 + epsilon, X_1 = 0 1^* 0 X_1 + 1 X_0, X_2 = 1^* 0 X_1) \ &cases(X_0 = 0 X_0 + 1 X_1 + epsilon, X_1 = (0 1^* 0)^* 1 X_0) quad . $

$ X_0 &= 0 X_0 + 1 (0 1^* 0)^* 1 X_0 + epsilon \ X_0 &= (0 + 1(0 1^* 0)^* 1) X_0 + epsilon $

L'espressione regolare corrispondente é: $ X_0 = (0 + 1 (0 1^* 0)^* 1)^* . $
