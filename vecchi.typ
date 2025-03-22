// Setup

#import "template.typ": project

#show: project.with(title: "Teoria dei linguaggi")

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

// Appunti

/* INIZIO LEZIONE 09 */

= Equivalenza tra linguaggi di tipo 3 e automi a stati finiti

== Teorema di Kleene

Vediamo il *teorema fondamentale degli automi a stati finiti* (o _teorema di Kleene_), che afferma la coincidenza tra la classe degli automi a stati finiti con la classe delle espressioni regolari.

#theorem()[
  La classe di linguaggi accettati da automi a stati finiti é il più piccolo sottoinsieme di $Sigma^*$ che contiene i linguaggi finiti ed é chiusa rispetto alle operazioni di $union, dot.op$ e $*$.
]

#theorem-proof()[
  \ Dimostriamo che a partire da un automa a stati finiti per $L$ possiamo trovare un'espressione regolare per lo stesso linguaggio $L$.

  Sia $A = (Q, Sigma, delta, q_1, F)$, con $Q = {q_1, dots, q_n}$. Accetto una parola se e solo se esiste un cammino nel grafo di computazione che finisce in uno stato finale.

  Chiamo $R_(i j)^((k))$ le espressioni che iniziano nello stato $q_i$, finiscono nello stato $q_j$ e visitano stati con indice $lt.eq k$: $ q_i arrow.long.squiggly q_(h lt.eq k) arrow.long.squiggly q_j. $

  Definiamo $R_(i j)^((0))$ l'insieme di tutte le lettere che mi portano da $q_i$ a $q_j$, quindi $ R_(i j)^((0)) = {a in Sigma bar.v delta(q_i, a) = q_j}. $

  Se $i = j$ allora $ R_(i j)^((0)) = {epsilon} union {a in Sigma bar.v delta(q_i, a) = q_i}. $

  Definiamo ora $R_(i j)^((k))$ sapendo tutte le espressioni fino a $R_(i j)^((k-1))$

  Evidenzio tutti i punti del cammino che passano per lo stato $q_k$: $ q_i arrow.long.squiggly_(lt.eq k-1) q_k arrow.long.squiggly_(lt.eq k-1) dots arrow.long.squiggly_(lt.eq k-1) q_k arrow.long.squiggly_(lt.eq k-1) q_j. $

  Ma allora $ R_(i j)^((k)) = R_(i j)^((k-1)) union (R_(i k)^((k-1)) dot.op R_(k k)^((k-1)) dot.op R_(k j)^((k-1))). $

  Il linguaggio $L$ viene definito come $ L = union.big_(q_i in F) "cammini dallo stato" 1 "allo stato" q_i = union.big_(q_i in F) R_(1 i)^((n)). #qedhere $
]

/* FINE LEZIONE 09 */
