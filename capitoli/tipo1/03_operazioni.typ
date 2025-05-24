// Setup

#import "../alias.typ": *

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

#import "@preview/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp

#import "@preview/fletcher:0.5.5": diagram, node, edge


// Capitolo

= Operazioni tra linguaggi

Per finire con i *CSL* vediamo le *proprietà di chiusura* di questa classe di linguaggi. Purtroppo vedremo solo le tre *operazioni insiemistiche* base, le altre sono abbastanza pesanti.

#table(
  columns: (24%, 38%, 38%),
  align: center + horizon,
  inset: 10pt,
  [], [*DLBA*], [*LBA*],
  [*Unione*],
  [#emoji.checkmark.box \ Non deterministicamente faccio partire i due automi in parallelo e controllo che almeno uno accetti],
  [#emoji.checkmark.box \ Faccio partire il automa mantenendo l'input sul nastro, se la macchina dice NO faccio partire il secondo e controllo],

  [*Intersezione*], [#emoji.checkmark.box \ Uguale a sopra], [#emoji.checkmark.box \ Uguale a sopra],
  [*Complemento*],
  [#emoji.checkmark.box \ Abbiamo a disposizione il *teorema di Immerman-Szelepcsényi*],
  [#emoji.checkmark.box \ Risultato sorprendente perché è rimasto aperto per molti anni, ma è stato risolto nell'$86$/$87$],
)
