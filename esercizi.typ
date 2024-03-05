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
