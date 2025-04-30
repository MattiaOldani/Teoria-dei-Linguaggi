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

// Lezione 11

#let sub(x) = {
  let subop = math.class(
    "unary",
    $"sub"$,
  )
  $subop(#x)$
}

// Lezione 13

#let lmarker = $triangle.filled.r$
#let rmarker = $triangle.filled.l$

// Lezione 14

#let NL = $"NL"$

#let PF(x) = {
  let pfop = math.class(
    "unary",
    $"PF"$,
  )
  $pfop(#x)$
}

// Lezione 15

#let FNG = $"FNG"$

// Lezione 16

#let push(x) = {
  let pushop = math.class(
    "unary",
    $"push"$,
  )
  $pushop(#x)$
}

#let pop = "pop"
