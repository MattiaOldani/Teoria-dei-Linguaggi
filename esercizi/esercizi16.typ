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

#import "@preview/cetz:0.3.4"


// Esercizi

= Esercizi lezione 16 [30/04]

So fare solo l'esercizio $01$, ma solo perché l'ha fatto a lezione. Gli altri non so nemmeno da che parte sono girato, quindi per ora non li vado a postare.
