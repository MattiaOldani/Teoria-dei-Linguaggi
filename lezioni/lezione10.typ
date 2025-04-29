// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 10 [28/03]

== Operazioni esotiche

=== Reversal

Sia $L subset.eq Sigma^*$ un linguaggio. Chiamiamo $ L^R = {w^R bar.v w in L} $ il linguaggio delle stringhe ottenute ribaltando tutte le stringhe di $L$, ovvero $ w = a_1 dots a_n arrow.long.double w^R = a_n dots a_1 . $

Questa operazione sul linguaggio $L$ viene detta *reversal*.

#lemma()[
  L'operazione di reversal preserva la regolarità.
]

#lemma-proof([Espressioni regolari])[
  Le espressioni regolari di base possono essere definite nel seguente modo: $ (emptyset.rev)^R = emptyset.rev \ (epsilon)^R = epsilon \ (a)^R = a . $

  // TODO: aggiungi grid

  Ora vediamo come definiamo le espressioni regolari induttive: $ (E_1 + E_2)^R = E_1^R + E_2^R \ (E_1 dot E_2)^R = E_2^R dot E_1^R \ (E^*)^R = (E^R)^* . $

  Queste espressioni sono ancora regolari, quindi reversal preserva la regolarità.
]

Possiamo dimostrare questo lemma anche usando gli *automi*. Supponiamo di avere $A = (Q, Sigma, delta, q_0, F)$ DFA che riconosce $L$. Vogliamo trovare un automa $A'$ per $L^R$: questo è facile, basta mantenere la struttura dell'automa invertendo il senso delle transizioni, rendendo finale lo stato iniziale e rendendo iniziali tutti gli stati finali.

In poche parole, definiamo l'automa $ A' = (Q, Sigma, delta', F, {q_0}) $ definito dalla funzione di transizione $delta'$ tale che $ delta'(q,a) = {p bar.v delta(p,a) = q} . $ In poche parole, visto che ho reversato le transizioni, devo vedere tutti gli stati $p$ che finivano in $q$ con $a$ per poter fare il cammino inverso.

==== DFA

Ci piace questa soluzione? *NO*: siamo partiti da un DFA e abbiamo ottenuto un NFA per via degli stati iniziali multipli $F$ e per il fatto che la funzione di transizione può mappare in più stati con la stessa lettera letta.

Se voglio ottenere un DFA devo fare il classicissimo salto esponenziale con la costruzione per sottoinsiemi. Con il reversal dell'automa non abbiamo cambiato il numero degli stati, quindi $ sc(L^R) lt.eq 2^(nsc(L^R)) . $

Possiamo fare di meglio o nel caso peggiore abbiamo questo salto esponenziale?

#example()[
  Prendiamo $ L = (a+b)^(n-1) a (a+b)^* $ il linguaggio che ha l'$n$-esimo simbolo da sinistra uguale ad una $a$, che riconosco con il seguente automa deterministico.

  #figure(image("assets/10_reversal.svg"))

  In questo caso, il numero di stati è esattamente $n$, visto che ne abbiamo $n-1$ all'inizio per eliminare gli $n-1$ caratteri iniziali e poi uno stato per verificare di avere una $a$.

  Il suo reversal è $L^R = L_n$, il solito linguaggio dell'$n$-esimo simbolo da destra uguale ad una $a$. Abbiamo visto che un NFA per $L_n$ ha $n+1$ stati mentre il DFA ha $2^n$ stati, visto che deve osservare finestre di $n$ caratteri consecutivi.
]

Il gap esponenziale non riusciamo purtroppo ad evitarlo.

#example()[
  Molto curiosa la situazione inversa: se partiamo da $L_n$ riconosciuto da un DFA di $2^n$ stati noi otteniamo un reversal $L_n^R = L$ che, minimizzato, ha $n$ stati (_escluso lo stato trappola_).
]

==== NFA

Se partiamo invece da un NFA, con la costruzione precedente manteniamo lo status di NFA, mantenendo inoltre il numero degli stati, quindi siamo contenti, ottenendo $ nsc(L^R) = nsc(L) . $

=== Shuffle

L'operazione di *shuffle*, applicata a due stringhe, le prende e le mescola, mantenendo l'ordine dei caratteri mentre le mischiamo. In poche parole, possiamo pensare di avere due *mazzieri*, ognuno dei quali tiene una stringa come lista ordinata (non lessicograficamente, ma proprio come è stata scritta) dei suoi caratteri. Ad ogni iterazione scegliamo a quale mazziere chiedere un carattere, e lo aggiungiamo alla stringa finale.

Come vediamo, l'inserimento che facciamo *non è atomico*: posso chiedere al mazziere che voglio ad ogni iterazione, l'unica cosa che mi viene chiesta è di mantenere l'ordine.

#example()[
  Date le stringhe $#text(fill: red)[$a a b b$]$ e $#text(fill: blue)[$b$]$, possiamo ottenere le stringhe

  #grid(
    columns: (20%, 20%, 20%, 20%, 20%),
    align: center + horizon,
    inset: 10pt,
    [#text(fill: blue)[$b$]#text(fill: red)[$a a b b$]],
    [#text(fill: red)[$a$]#text(fill: blue)[$b$]#text(fill: red)[$a b b$]],
    [#text(fill: red)[$a a$]#text(fill: blue)[$b$]#text(fill: red)[$b b$]],
    [#text(fill: red)[$a a b$]#text(fill: blue)[$b$]#text(fill: red)[$b$]],
    [#text(fill: red)[$a a b b$]#text(fill: blue)[$b$]],
  )

  Ovviamente, le ultime tre stringhe sono tutte uguali e vanno considerate come stringa unica.
]

#example()[
  Date le stringhe $#text(fill: red)[$a a b b$]$ e $#text(fill: blue)[$a b$]$, possiamo ottenere molte stringhe con lo shuffle. Ne vediamo un paio per vedere la non atomicità dell'operazione.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [#text(fill: blue)[$a$]#text(fill: red)[$a$]#text(fill: blue)[$b$]#text(fill: red)[$a b b$]],
    [#text(fill: red)[$a a$]#text(fill: blue)[$a$]#text(fill: red)[$b$]#text(fill: blue)[$b$]#text(fill: red)[$b$]],
  )
]

L'operazione di shuffle, se la applichiamo ai *linguaggi* $L'$ e $L''$, è il linguaggio di tutte le stringhe ottenute tramite shuffle di una stringa di $L'$ con una stringa di $L''$. Ovviamente prendiamo tutte le possibili coppie di stringhe per ottenere il linguaggio completo.

==== Alfabeti disgiunti

Consideriamo due DFA $A'$ e $A''$ per i due linguaggi appena definiti. Il caso più semplice di automa per lo shuffle parte con gli alfabeti per i due linguaggi *disgiunti*, ovvero $L'$ definito sul'alfabeto $Sigma' = {a,b}$ e $L''$ definito sull'alfabeto $Sigma'' = {c,d}$.

Prendiamo spunto dall'*automa prodotto*: uniamo i due automi e ne mandiamo avanti uno alla volta in base al carattere che leggiamo. Definiamo quindi $ A = (Q, Sigma, delta, q_0, F) $ tale che:
- gli *stati* sono tutte le possibili coppie di stati dei due automi, ovvero $ Q = Q' times Q'' ; $
- lo *stato iniziale* è formato dai due stati iniziali base, ovvero $ q_0 = (q'_0, q''_0) ; $
- l'*alfabeto* è l'unione dei due alfabeti di base, ovvero $ Sigma = Sigma' union Sigma'' ; $
- la *funzione di transizione*, in base al carattere che legge, deve mandare avanti uno dei due automi e mantenere l'altro nello stesso stato, ovvero $ delta((q,p), x) = cases((delta'(q,x), p) & "se" x in Sigma', (q, delta''(p,x)) quad & "se" x in Sigma'') quad ; $
- gli *stati finali* sono tutte le coppie formate da stati finali, perché devo riconoscere sia la prima che la seconda stringa, ovvero $ F = {(q,p) bar.v q in F' and p in F''} . $

Il numero di stati di questo automa è il prodotto del numero di stati dei due automi, ovvero $ sc(shuffle(L',L'')) = sc(L') dot sc(L'') . $

Abbiamo considerato solo il caso in cui $A'$ e $A''$ sono DFA. Per il caso non deterministico, basta modificare leggermente la funzione di transizione ma il numero di stati rimane invariato.

// TODO: fai NFA

==== Stesso alfabeto

Se invece i due linguaggi sono definiti sullo stesso alfabeto $Sigma$ come ci comportiamo? Dobbiamo fare affidamento sul *non determinismo*: dobbiamo scommettere se il carattere che abbiamo letto deve mandare avanti il primo automa o il secondo automa. Tra tutte le possibili computazioni ce ne deve essere una che termina in una coppia di stati entrambi finali. Se nessuna computazione termina in uno stato accettabile allora rifiutiamo la stringa data.

Se partiamo da due DFA otteniamo un NFA con un numero di stati uguale al prodotto degli stati dei due automi iniziali. Questa situazione non ci piace, quindi torniamo in un DFA facendo un salto esponenziale con la costruzione per sottoinsiemi, quindi $ sc(shuffle(L',L'')) lt.eq 2^(nsc(shuffle(L',L''))) . $

Invece, se partiamo da due NFA otteniamo ancora un NFA, quindi la situazione ci piace. Il numero di stati l'abbiamo già definito ed è uguale a $ nsc(shuffle(L',L'')) = nsc(L') dot nsc(L'') . $

==== Alfabeto unario

Infine, se i due linguaggi sono definiti sull'*alfabeto unario*, ovvero $ L',L'' subset.eq {a}^* $ l'operazione di shuffle collassa banalmente l'operazione di *prodotto*, perché alla fine stiamo facendo shuffle su stringhe che sono formate sempre da una e una sola lettera, quindi non conta come le mischiamo ma conta la lunghezza finale della stringa che ci esce.
