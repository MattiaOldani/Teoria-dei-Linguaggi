// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 10 [28/03]

== Prodotto (richiamo)

Piccole osservazioni da aggiungere alla lezione precedente:
- abbiamo un suffisso e un prefisso, ma non sapendo quando finisce il primo e inizia il secondo devo scommettere quando arrivo in uno stato finale del primo automa; ci possono essere tante suddivisioni, devo indovinare quella giusta;
- l'automa $A$ che abbiamo costruito ha una prima parte deterministica, mentre la seconda è sì deterministica ma emula la costruzione per sottoinsiemi;
- non possiamo evitare il salto esponenziale: se concateniamo $(a+b)^*$ con $a (a + b)^(n-1)$ otteniamo il solito $L_n$, che ha bisogno di $2^n$ stati partendo da $n+1$.

== Chiusura di Kleene

Con questa ultima operazione chiudiamo la dimostrazione del teorema di Kleene.

Questa operazione è definita come $ L^* = union.big_(k gt.eq 0) L^k = {w in Sigma^* bar.v exists x_1, dots, x_k in L bar.v k gt.eq 0 bar.v w = x_1, dots, x_k} . $

Un automa per la star deve cercare di scomporre la stringa in ingresso in più stringhe di $L$. Possiamo prendere spunto dall'automa per la concatenazione: facciamo partire l'automa per $L$, ogni volta che arriviamo in uno stato finale lo facciamo ripartire dallo stato iniziale. Devo accettare anche la parola vuota, quindi aggiungiamo uno stato iniziale finale.

#figure(image("assets/10_kleene.svg"))

Abbiamo bisogno dello stato iniziale $q'_0$ perché dentro l'automa ci possono essere delle transizioni che mi fanno ritornare indietro e mi fanno accettare di più di quello che dovrei.

#example()[
  Consideriamo il seguente automa *sbagliato* per la chiusura di Kleene del linguaggio delle sequenze dispari di $a$ seguite da una $b$. Se vogliamo l'espressione regolare per questo linguaggio, essa è $(a a)^* a b$.

  #figure(image("assets/10_star_errata.svg"))

  Non abbiamo inserito uno stato iniziale aggiuntivo. Che succede? La stringa $a a$ adesso viene accettata, anche se palesemente non appartiene al linguaggio, così come la stringa $a b a a$.

  Un automa per la star di questo linguaggio, inoltre, è molto facile da trovare perché la lettera $b$ fa da marcatore, e il numero di stati rimane quello dell'automa di partenza.

  #figure(image("assets/10_star_corretta.svg"))
]

=== DFA

Ci piace questa soluzione, perché stiamo aumentando solo di uno il numero di stati dell'automa, ma siamo caduti nel non determinismo, e partire da DFA e finire in NFA non ci piace molto.

Purtroppo, come spesso ci succede, per tornare nei DFA dobbiamo, nel caso peggiore, applicare la costruzione per sottoinsiemi e fare un salto esponenziale nel numero degli stati. In poche parole $ sc(L^*) lt.eq 2^(nsc(L^*)) . $

=== NFA

L'abbiamo formulato nella scorsa sezione: se partiamo da NFA otteniamo ancora degli NFA, quindi ci piace, e lo facciamo in modo semplice aggiungendo solo uno stato, ovvero $ nsc(L^*) lt.eq nsc(L) + 1 . $

=== Esempi utili per dopo

Per ora abbiamo visto l'esempio del linguaggio $L = (a a)^* b$, che era estremamente comodo da scomporre per via della presenza di una sola $b$ nella stringa in input. Vediamo ora qualche altro esempio notevole per la prossima sezione.

#example()[
  Definito il linguaggio $L = a a a b a^*$, dobbiamo calcolare $L^*$.

  Questo linguaggio è _"facilmente"_ scomponibile: ogni volta che troviamo una $b$ torniamo indietro di $3$ caratteri e dividiamo la stringa in quel punto.

  Ad esempio, la stringa $ a a a b a a a a a a a b a a a b a a a a b $ viene suddivisa nel seguente modo: $ a a a b a a a a bar.v a a a b bar.v a a a b a bar.v a a a b . $

  L'automa comunque esegue un sacco di test non deterministici ogni volta che legge delle $a$ dopo una $b$, perché rimaniamo sempre in uno stato finale.
]

#example()[
  Definito invece il linguaggio $L = a (b + b a a b) a^*$, dobbiamo calcolare $L^*$.

  Questo linguaggio invece è più difficile da scomporre. Ad esempio, data la stringa $ a b a a b a a a a a b a a b a $ essa la possiamo dividere in $ a b a bar.v a b a a a a bar.v a b a a b a $ oppure la possiamo dividere in $ a b a a b a a a a bar.v a b a a b a . $

  Per questa stringa abbiamo già due modi di scomposizione possibili.

  Cambiamo la stringa: data la stringa $ a b a a b a a b a a b a a a b a $ essa la possiamo dividere in $ a b a bar.v a b a bar.v a b a bar.v a b a a bar.v a b a $ oppure la possiamo dividere in $ a b a a b a bar.v a b a a b a a bar.v a b a . $

  In generale, si possono creare delle stringhe che hanno un numero di suddivisioni enorme.
]

=== Codici

A cosa servono i tre esempi che abbiamo introdotto nella sezione precedente?

#definition([Codice])[
  Dato $X subset.eq Sigma^*$, diciamo che $X$ è un *codice* se e solo se $ forall w in X^* quad exists! "decomposizione di" w "come" x_1 dots x_k bar.v x_i in L and k gt.eq 0 . $
]

Dei tre esempi che abbiamo visto, solo i primi due sono dei codici: è facile dimostrare che lo sono, soprattutto il primo per via della $b$ che fa da delimitatore. L'ultimo esempio, invece, abbiamo visto che ha delle stringhe scomponibili in più modi, quindi non è un codice.

Tra tutti i codici a noi interessano quelli che possono essere *decomposti in tempo reale*: essi sono chiamati *codici prefissi*, e sono dei codici tali che $ forall i eq.not j quad x_i "non è prefisso di" x_j . $ In poche parole, il codice contiene parole che *non* sono prefisse di altre. Essi sono i più *efficienti*.

Dei due codici che abbiamo a disposizione, il primo è un codice prefisso: ogni volta che troviamo una $b$ sappiamo che dobbiamo dividere. Il secondo, invece, deve aspettare una $b$ e poi tornare indietro di $3$ posizioni per avere la decomposizione.

=== Star height

Per definire le espressioni regolari abbiamo a disposizione le tre operazioni $ + quad bar.v quad dot quad bar.v quad  ()^* $

Concentriamoci un secondo sulla chiusura di Kleene e vediamo un esempio.

#example()[
  Date le espressioni regolari

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$(a^* b^*)^*$], [$(a + b)^*$], [$(a b^*)^*$],
  )

  ci chiediamo che linguaggio stanno denotando. Questo è facile: ${a,b}^*$. Ognuna lo fa a modo proprio, in base a come ha risolto il sistema delle equazioni dell'automa associato.
]

Nell'esempio abbiamo visto diverse espressioni per lo stesso linguaggio, ma quante star mi servono per definire completamente un linguaggio?

#definition([Star height])[
  La *star height* è il massimo numero di star innestate in una espressione regolare. Possiamo definire la quantità induttivamente, ovvero $ h(emptyset.rev) = h(epsilon) = h(a) &= 0 \ h(E' + E'') = h(E' dot E'') &= max{h(E'), h(E'')} \ h(E^*) &= 1 + h(E) . $
]

Nell'esempio precedente, le espressioni regolari hanno star height rispettivamente $2$, $1$ e $2$. A noi piacerebbe scrivere un'espressione regolare con la minima star height.

Sia $L$ un linguaggio regolare. Definiamo con $h(L)$ la *minima altezza* delle espressioni regolari che definiscono $L$, ovvero $ h(L) = min{h(E) bar.v L = L(E)} . $ Questa quantità, nei linguaggi infiniti, è almeno $1$, non posso usare meno star.

#theorem([Un bro nel 1966])[
  Vale $ forall q > 0 quad exists W_q in {a,b}^* bar.v h(W_q) = q . $
]

Il linguaggio $W_q$ è definito come $ W_q = {w in {a,b}^* bar.v hash_a (w) equiv hash_b (w) mod 2^q} . $

#example()[
  Proviamo a disegnare $W_q$ per $q = 1$.

  #figure(image("assets/10_w1.svg"))

  La sua espressione regolare, dopo un po' di conti, è la seguente: $ L = (a (b b)^* a + a (b b)^* b a (a a + a b (b b)^* b a)^* a b (b b)^* a)^* (a (b b)^* b a (a a + a b (b b)^* b a)^* a b (b b)^* b) . $

  A quanto pare ho sbagliato a risolvere il sistema, sono scarso scusate.
]

Abbiamo quindi fatto vedere che se fissiamo il numero $q > 0$ di star che vogliamo usare in una espressione regolare, riusciamo a trovare un linguaggio $W_q$ che usa quel numero di star.

#theorem()[
  Se $abs(Sigma) = 1$ è sufficiente una star innestata per definire completamente $L$, ovvero vale che $ forall L subset.eq {a}^* "regolare" quad h(L) lt.eq 1 . $
]

== Espressioni regolari estese

Cosa succede se nelle espressioni regolari, oltre alle operazioni regolari di unione, concatenazione e chiusura, utilizziamo anche le operazioni di *intersezione* e *negazione*?

Esse sono definite *espressioni regolari estese*, e sono molto potenti ma devono essere usate con cautela. Vediamo il perché con qualche esempio.

#example()[
  Sia $ L = {w in {a,b}^* bar.v hash_a (w) "pari" and hash_b (w) "pari"} . $

  Se mi chiedono l'espressione regolare di questo linguaggio mi mandano a quel paese, ma usando le espressioni regolari estese questo è molto facile.

  Per il linguaggio $L_a = {w in {a,b}^* bar.v hash_a (w) "pari"}$ possiamo scrivere l'espressione regolare $(b + a b^* a)^*$, mentre per il linguaggio $L_b = {w in {a,b}^* bar.v hash_b (w) "pari"}$ possiamo scrivere l'espressione regolare $(a + b a^* b)^*$.

  Utilizzando l'intersezione possiamo banalmente concatenare le due espressioni, ovvero $ (b + a b^* a)^* inter (a + b a^* b)^* . $
]

#example()[
  Vogliamo un'espressione regolare per le stringhe che *non* contengono tre $a$ consecutive. Per fare ciò, costruiamo un automa e poi ricaviamo l'espressione regolare.

  Partiamo da automi che accettano stringhe con tre $a$ consecutive e poi complementiamo. In ordine, vediamo un NFA e un DFA per questo linguaggio di transizione.

  #figure(image("assets/10_estese_NFA.svg"))

  Avevamo visto che il complemento non si comportava bene con gli NFA, quindi diamo un DFA, che invece funzionava bene con il complemento.

  #figure(image("assets/10_estese_DFA.svg"))

  Siamo rimasti in un numero di stati accettabile. Andiamo a complementare questo DFA, che manterrà lo stesso numero di stati, fortunatamente.

  #figure(image("assets/10_estese_complemento.svg"))

  Ora di questo dovrei farci l'espressione regolare. Sicuramente esce una bestiata enorme, con un po' di star qua e là visto che il linguaggio è infinito.

  Con le espressioni regolari estese possiamo evitare l'uso delle star. Prima prendiamo tutte le stringhe che hanno tre $a$ consecutive: esse sono nella forma $ (a+b)^* a a a (a + b)^* . $ Dobbiamo applicare il complemento a questa espressione per ottenere $L$, quindi $ overline((a+b)^* a a a (a+b)^*) . $ L'insieme di tutte le stringhe su un alfabeto lo possiamo vedere come il complemento dell'insieme vuoto rispetto all'insieme delle stringhe su quell'alfabeto, ovvero $ (a+b)^* = overline(emptyset.rev) . $ Ma allora l'espressione regolare diventa $ overline(overline(emptyset.rev) a a a overline(emptyset.rev)) , $ che come vediamo è un'espressione che non utilizza alcuna star.
]

Siamo stati in grado di non usare le star per un linguaggio infinito, cosa che nelle espressioni regolari classiche non è possibile. Bisogna stare attenti però: il complemento è molto comodo ma è anche molto insidioso perché fa saltare il numero di stati esponenzialmente se usiamo degli NFA.

Come nelle espressioni regolari, possiamo chiederci il *minimo numero di star* che sono necessarie per descrivere completamente un linguaggio.

#definition([Star height generalizzata])[
  L'*altezza generalizzata*, o star height generalizzata, è il massimo numero di star innestate di una espressione regolare estesa. Possiamo definire la quantità induttivamente, ovvero $ gh(emptyset.rev) = gh(epsilon) = gh(a) &= 0 \ gh(E' + E'') = gh(E' dot E'') = gh(E' inter E'') &= max{gh(E'), gh(E'')} \ gh(E^C) &= gh(E) \ gh(E^*) &= 1 + gh(E) . $
]

Come prima, dato un linguaggio $L$, possiamo definire la quantità $ gh(L) = min{g(E) bar.v L = L(E)} $ come la minima star height generalizzata di tutte le espressioni regolari estese che generano $L$.

Le espressioni regolari estese sono molto comode, ma di queste non si sa quasi niente:
- si sa che esistono linguaggi di altezza $0$ (pefforza);
- si sa che esistono linguaggi di altezza $1$;
- non si sa niente sui linguaggi di altezza almeno $2$.

Quale è il cambio di marcia tra le espressioni regolari estese e quelle classiche? L'operazione di *not*: questa ci permette di dichiarare cosa non ci interessa, mentre nelle espressioni regolari classiche noi possiamo solo dire cosa vogliamo, avendo un modello dichiarativo.

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
