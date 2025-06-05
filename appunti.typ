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
#pagebreak()
#include "capitoli/tipo3/11_automi_two_way.typ"
#pagebreak()


// Linguaggi context-free

#parte("Linguaggi context-free")
#pagebreak()

#include "capitoli/tipo2/01_automi_a_pila.typ"
#pagebreak()
#include "capitoli/tipo2/02_equivalenza.typ"
#pagebreak()
#include "capitoli/tipo2/03_forme_normali.typ"
#pagebreak()
#include "capitoli/tipo2/04_pumping_lemma.typ"
#pagebreak()
#include "capitoli/tipo2/05_lemma_di_ogden.typ"
#pagebreak()
#include "capitoli/tipo2/06_ambiguita.typ"
#pagebreak()
#include "capitoli/tipo2/07_operazioni.typ"
#pagebreak()
#include "capitoli/tipo2/08_CFL_vs_DCFL.typ"
#pagebreak()
#include "capitoli/tipo2/09_risultati_matti.typ"
#pagebreak()
#include "capitoli/tipo2/10_alfabeti_unari.typ"
#pagebreak()
#include "capitoli/tipo2/11_automi_two_way.typ"
#pagebreak()
#include "capitoli/tipo2/12_problemi_di_decisione.typ"
#pagebreak()


// Linguaggi context-sensitive

#parte("Linguaggi context-sensitive")
#pagebreak()

#include "capitoli/tipo1/01_automi_limitati_linearmente.typ"
#pagebreak()
#include "capitoli/tipo1/02_equivalenza.typ"
#pagebreak()
#include "capitoli/tipo1/03_operazioni.typ"
#pagebreak()


// Linguaggi non regolari

#parte("Linguaggi senza restrizioni")
#pagebreak()

#include "capitoli/tipo0/01_macchine_turing.typ"
#pagebreak()
#include "capitoli/tipo0/02_problemi_decisione.typ"
