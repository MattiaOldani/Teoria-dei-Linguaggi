// Setup


// Alias

// ...

#let rel(x, R, y) = $#x space.thin #R space.thin #y$

#let indice(R) = $"indice"(#R)$

#let sse = $arrow.long.double.l.r$

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

#let sub(x) = {
  let subop = math.class(
    "unary",
    $"sub"$,
  )
  $subop(#x)$
}
