// Setup


// Alias

// Lezione 09

#let sc(x) = {
  let scop = math.class(
    "unary",
    $"sc"$,
  )
  $scop(#x)$
}

// Lezione 10

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

// Esercizi 11

#let pal = $"PAL"$

// Esercizi 12

#let cycle(l) = {
  let cycleop = math.class(
    "unary",
    $"cycle"$,
  )
  $cycleop(#l)$
}

#let lroot(l) = {
  let lrootop = math.class(
    "unary",
    $"root"$,
  )
  $lrootop(#l)$
}

// Esercizi 17

#let palstar = $pal"STAR"$
#let qpalstar = $"Quasi"palstar$
