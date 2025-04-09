// Setup


// Alias

// Lezione 07

#let rel(x, R, y) = $#x space.thin #R space.thin #y$

#let indice(R) = $"indice"(#R)$

#let sse = $arrow.long.double.l.r$

// Lezione 09

#let sc(x) = {
  let scop = math.class(
    "unary",
    $"sc"$,
  )
  $scop(#x)$
}

#let nsc(x) = {
  let nscop = math.class(
    "unary",
    $"nsc"$,
  )
  $nscop(#x)$
}

// Lezione 10

#let gh(x) = {
  let ghop = math.class(
    "unary",
    $"gh"$,
  )
  $ghop(#x)$
}

#let shuffle(l1, l2) = {
  let shuffleop = math.class(
    "unary",
    $"shuffle"$,
  )
  $shuffleop(#l1, #l2)$
}

// Esercizi 08, 09 e 10

#let pref(l) = {
  let prefop = math.class(
    "unary",
    $"Pref"$,
  )
  $prefop(#l)$
}

#let suff(l) = {
  let suffop = math.class(
    "unary",
    $"Suff"$,
  )
  $suffop(#l)$
}

#let fact(l) = {
  let factop = math.class(
    "unary",
    $"Fact"$,
  )
  $factop(#l)$
}

#let perfectShuffle(l1, l2) = {
  let perfectshuffleop = math.class(
    "unary",
    $"perfectShuffle"$,
  )
  $perfectshuffleop(#l1, #l2)$
}

// Lezione 11

#let sub(x) = {
  let subop = math.class(
    "unary",
    $"sub"$,
  )
  $subop(#x)$
}

// Esercizi 11

#let pal = $"PAL"$

// Lezione 13

#let lmarker = $triangle.filled.r$
#let rmarker = $triangle.filled.l$
