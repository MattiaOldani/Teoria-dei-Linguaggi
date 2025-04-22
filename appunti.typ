// Titolo e indice

#import "template.typ": *

#show: project.with(title: "Teoria dei Linguaggi")

#pagebreak()


// Introduzione

#include "capitoli/00_introduzione.typ"
#pagebreak()


// Gerarchia di Chomsky

#parte("Gerarchia di Chomsky")
#pagebreak()

#include "capitoli/gerarchia/01_ripasso.typ"
#pagebreak()

#include "capitoli/gerarchia/02_gerarchia.typ"
#pagebreak()


// Linguaggi regolari

#parte("Linguaggi regolari")
#pagebreak()

#include "capitoli/tipo3/01_dfa.typ"
