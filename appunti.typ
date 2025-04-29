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
#pagebreak()

#include "capitoli/tipo3/02_nfa.typ"
#pagebreak()

#include "capitoli/tipo3/03_numero_stati.typ"
#pagebreak()

#include "capitoli/tipo3/04_automi_g3.typ"
#pagebreak()

#include "capitoli/tipo3/05_automa_minimo.typ"
#pagebreak()

#include "capitoli/tipo3/06_operazioni.typ"
#pagebreak()

#include "capitoli/tipo3/07_regex.typ"
#pagebreak()

#include "capitoli/tipo3/08_operazioni_esotiche.typ"
#pagebreak()

#include "capitoli/tipo3/09_pumping_lemma.typ"
#pagebreak()

#include "capitoli/tipo3/10_problemi_decisione.typ"
