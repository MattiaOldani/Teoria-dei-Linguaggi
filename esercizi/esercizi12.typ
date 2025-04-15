// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Esercizi lezione 12 [04/04]

== Esercizio 01

#exercise()[
  Dato un linguaggio $L$ indichiamo con $cycle(L)$ il linguaggio ottenuto ruotando ciclicamente in tutti i modi possibili le stringhe di $L$, i.e., $ cycle(L) = {v u in Sigma^* bar.v u v in L} . $
]

#request()[
  Dimostrate che se $L$ è regolare allora anche $cycle(L)$ è regolare, fornendo una costruzione per ottenere un automa che accetti $cycle(L)$ a partire da un automa che accetta $L$.
]

#solution()[
  Non so da che parte sono girato.
]

== Esercizio 02

#exercise()[
  Dato un linguaggio $L$ indichiamo con $1/2 L$ il linguaggio formato dalla prima metà delle stringhe di $L$ (di lunghezza pari), i.e., $ 1/2 L = {x in Sigma^* bar.v exists y in Sigma^* bar.v abs(y) = abs(x) and x y in L} . $
]

#request()[
  Dimostrate che se $L$ è regolare allora anche $1/2 L$ è regolare, fornendo una costruzione per ottenere un automa che accetti $1/2 L$ a partire da un automa che accetta $L$.
]

#solution()[
  Vedi teoria.
]

== Esercizio 03

#exercise()[
  Dimostrate che se $L$ è un linguaggio regolare, allora sono regolari anche i seguenti linguaggi.
]

#request()[
  $1 1 / 3 L = {x in Sigma^* bar.v exists y,z in Sigma^* bar.v abs(x) = abs(y) = abs(z) and x y z in L}$.
]

#solution()[
  Dato l'automa $A$ per $L$, costruiamo l'automa $ A' = (Q', Sigma, delta', q'_0, F') $ definito da:
  - l'*insieme degli stati* $ Q' = Q^3 times 2^Q times 2^Q $ è formato da una serie di quintuple nella forma $ [p, s_1, s_2, q, r] $ con:
    - $p$ stato nel quale si trova l'automa $A$;
    - $s_1$ scommessa sullo stato nel quale si trova $A$ dopo aver letto $x$;
    - $s_2$ scommessa sullo stato nel quale si trova $A$ dopo aver letto $y$ partendo dallo stato $q$
    - $q$ stati nei quali si trova l'automa $A$ partendo da $s_1$ mentre crea $y$;
    - $r$ stati nei quali si trova l'automa $A$ partendo da $s_2$ mentre crea $z$;
  - lo *stato iniziale* è un insieme di quintuple $ q'_0 = {[q_0, p, q, {p}, {q}] bar.v forall p,q in Q}; $
  - la *funzione di transizione* deve mandare avanti l'automa $A$ su $x$ in maniera deterministica, mentre $y$ e $z$ le deve creare, come nel caso di $1/2 L$, quindi $ delta'([p,s_1,s_2,q,r], a) = [delta(p,a), s_1, s_2, union.big_(q_1 in q and sigma in Sigma) delta(q_1,sigma), union.big_(r_1 in r and sigma in Sigma) delta(r_1,sigma)] ; $
  - l'*insieme degli stati finali* deve controllare le scommesse fatte, ovvero il primo automa finisce in $s_1$, il secondo automa finisce in $s_2$, il terzo automa finisce in uno stato finale. Formalmente lo scriviamo come $ F' = {[s_1, s_1, s_2, q, r] bar.v s_2 in q and r inter F eq.not emptyset.rev} . $
]

#request()[
  $2 1 / 3 L = {y in Sigma^* bar.v exists x,z in Sigma^* bar.v abs(x) = abs(y) = abs(z) and x y z in L}$.
]

#solution()[
  Dato l'automa $A$ per $L$, costruiamo l'automa $ A' = (Q', Sigma, delta', q'_0, F') $ definito da:
  - l'*insieme degli stati* $ Q' = 2^Q times Q^3 times 2^Q $ è formato da una serie di quintuple nella forma $ [p, s_1, s_2, q, r] $ con:
    - $p$ stati nei quali si trova l'automa $A$ mentre crea $x$;
    - $s_1$ scommessa sullo stato nel quale si trova $A$ dopo aver letto $x$;
    - $s_2$ scommessa sullo stato nel quale si trova $A$ dopo aver letto $y$ partendo dallo stato $q$
    - $q$ stato nel quale si trova l'automa $A$ partendo da $s_1$ mentre riconosce $y$;
    - $r$ stati nei quali si trova l'automa $A$ partendo da $s_2$ mentre crea $z$;
  - lo *stato iniziale* è un insieme di quintuple $ q'_0 = {[{q_0}, p, q, p, {q}] bar.v forall p,q in Q}; $
  - la *funzione di transizione* deve creare $x$ e $z$ considerando tutti i possibili cammini, mentre manda avanti l'automa per $y$ considerando solo il carattere che viene letto, quindi $ delta'([p,s_1,s_2,q,r], a) = [union.big_(p_1 in p and sigma in Sigma) delta(p_1, sigma), s_1, s_2, delta(q,a), union.big_(r_1 in r and sigma in Sigma) delta(r_1,sigma)] ; $
  - l'*insieme degli stati finali* deve controllare le scommesse fatte, ovvero il primo automa finisce in $s_1$, il secondo automa finisce in $s_2$, il terzo automa finisce in uno stato finale. Formalmente lo scriviamo come $ F' = {[p, s_1, s_2, s_2, r] bar.v s_1 in p and r inter F eq.not emptyset.rev} . $
]

#request()[
  $3 1 / 3 L = {z in Sigma^* bar.v exists x,y in Sigma^* bar.v abs(x) = abs(y) = abs(z) and x y z in L}$.
]

#solution()[
  Dato l'automa $A$ per $L$, costruiamo l'automa $ A' = (Q', Sigma, delta', q'_0, F') $ definito da:
  - l'*insieme degli stati* $ Q' = 2^Q times Q^2 times 2^Q times Q $ è formato da una serie di quintuple nella forma $ [p, s_1, s_2, q, r] $ con:
    - $p$ stati nei quali si trova l'automa $A$ mentre crea $x$;
    - $s_1$ scommessa sullo stato nel quale si trova $A$ dopo aver letto $x$;
    - $s_2$ scommessa sullo stato nel quale si trova $A$ dopo aver letto $y$ partendo dallo stato $q$
    - $q$ stati nei quali si trova l'automa $A$ partendo da $s_1$ mentre crea $y$;
    - $r$ stato nel quale si trova l'automa $A$ partendo da $s_2$ mentre riconosce $z$;
  - lo *stato iniziale* è un insieme di quintuple $ q'_0 = {[{q_0}, p, q, {p}, q] bar.v forall p,q in Q}; $
  - la *funzione di transizione* deve creare $x$ e $y$ considerando tutti i possibili cammini, mentre manda avanti l'automa per $z$ considerando solo il carattere che viene letto, quindi $ delta'([p,s_1,s_2,q,r], a) = [union.big_(p_1 in p and sigma in Sigma) delta(p_1, sigma), s_1, s_2, union.big_(q_1 in q and sigma in Sigma) delta(q_1,sigma), delta(r,a)] ; $
  - l'*insieme degli stati finali* deve controllare le scommesse fatte, ovvero il primo automa finisce in $s_1$, il secondo automa finisce in $s_2$, il terzo automa finisce in uno stato finale. Formalmente lo scriviamo come $ F' = {[p, s_1, s_2, q, r] bar.v s_1 in p and s_2 in q and r in F} . $
]

== Esercizio 04

#exercise()[]

#request()[
  Dimostrate che se $L$ è un linguaggio regolare, allora è regolare anche il seguente linguaggio: $ log(L) = {x in Sigma^* bar.v exists y in Sigma^* bar.v abs(y) = 2^(abs(x)) and x y in L}. $
]

#solution()[
  Non so da che parte sono girato.
]

== Esercizio 05

#exercise()[]

#request()[
  Dimostrate che se $L$ è un linguaggio regolare, allora è regolare anche il seguente linguaggio: $ lroot(L) = {w in Sigma^* bar.v w^(abs(w)) in L} . $
]

#solution()[
  Ancora peggio.
]
