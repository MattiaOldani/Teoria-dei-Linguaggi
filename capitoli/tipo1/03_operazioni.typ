// Setup


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

Come vediamo, ci va molto *meglio* dei CFL: in questi ultimi era praticamente un bagno di sangue, con tutte le operazioni che vedevano sempre (a meno dell'operazione di intersezione regolare) almeno uno dei due modelli non chiuso.

Queste proprietà di chiusura ci interessano? Praticamente no.
