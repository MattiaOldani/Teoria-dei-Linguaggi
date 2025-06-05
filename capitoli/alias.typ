// Setup


// Alias

// Generali

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

#let lmarker = $triangle.filled.r$
#let rmarker = $triangle.filled.l$


// Linguaggi regolari

#let Reg = "Reg"
#let DFA = "DFA"

#let rel(x, R, y) = $#x space.thin #R space.thin #y$

#let indice(R) = $"indice"(#R)$

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


// Linguaggi context-free

#let CFL = "CFL"
#let DCFL = "DCFL"
#let NPDA = "NPDA"
#let DPDA = "DPDA"

#let NL = $"NL"$

#let PAL = "PAL"

#let FNG = $"FNG"$

#let PF(x) = {
  let pfop = math.class(
    "unary",
    $"PF"$,
  )
  $pfop(#x)$
}

#let push(x) = {
  let pushop = math.class(
    "unary",
    $"push"$,
  )
  $pushop(#x)$
}

#let pop = "pop"

#let LR(k) = {
  let LRop = math.class(
    "unary",
    $"LR"$,
  )
  $LRop(#k)$
}


// Linguaggi context-sensitive

#let CS = "CS"
#let LBA = "LBA"
#let DLBA = "DLBA"

#let NSPACE(n) = {
  let NSPACEop = math.class(
    "unary",
    $"NSPACE"$,
  )
  $NSPACEop(#n)$
}

#let DSPACE(n) = {
  let DSPACEop = math.class(
    "unary",
    $"PSPACE"$,
  )
  $DSPACEop(#n)$
}


// Linguaggi senza restrizioni

#let blank = $bitcoin$

#let valid(M, w: none) = {
  let validop = math.class(
    "unary",
    $"valid"$,
  )

  if w == none {
    $validop(#M)$
  } else {
    $validop(#M, #w)$
  }
}
