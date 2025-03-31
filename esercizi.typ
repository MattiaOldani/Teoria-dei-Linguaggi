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

// Esercizi

= Lezione 03

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
