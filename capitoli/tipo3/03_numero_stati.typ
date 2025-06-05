// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@preview/syntree:0.2.1": syntree


// Capitolo

= Numero minimo di stati
<capitolo03-tipo3>

Come anticipato nell'@esempio-terzultimo-a del @capitolo01-tipo3[Capitolo], in questo capitolo andiamo ad analizzare alcune *tecniche* per conoscere il *minimo numero di stati* che deve avere un automa per riconoscere un certo linguaggio.

== Distinguibilità

Vediamo prima di tutto un esempio per introdurre alcuni concetti utili.

#example()[
  Vogliamo trovare un automa che riconosca il linguaggio $ L = {x in {a,b}^* bar.v hash_a (x) "pari" and hash_b (x) "dispari"} $

  #figure(image("assets/03/a_pari_b_dispari.svg"))

  Ogni stato si ricorda il numero di $a$ e $b$ modulo $2$ che ha incontrato.

  Possiamo usare *meno stati* per descrivere un automa per questo linguaggio?
]<esempio-a-pari-b-dispari>

Per rispondere alla domanda dell'@esempio-a-pari-b-dispari ci serve un *criterio* da applicare facilmente e a qualsiasi linguaggio ci capiti davanti. Abbiamo detto _"qualsiasi linguaggio"_ perché il criterio che andiamo a descrivere ora lavora sui *linguaggi* e non sugli automi.

#definition([Distinguibilità])[
  Sia $L subset.eq Sigma^*$ un linguaggio e siano $x,y in Sigma^*$ due stringhe. Allora $x$ e $y$ sono *distinguibili* per $L$ se $ exists z in Sigma^* bar.v (x z in L and y z in.not L) or (x z in.not L and y z in L) . $
]

In poche parole, due stringhe sono *distinguibili* se riesco a trovare una terza stringa $z$ che, attaccata alle due stringhe $x$ e $y$, da una parte mi fa stare in $L$ mentre dall'altra mi manda fuori.

#theorem([Teorema della distinguibilità])[
  Sia $L subset.eq Sigma^*$ e sia $X subset.eq Sigma^*$ un insieme tale che tutte le coppie di stringhe $x,y in X$, con $x eq.not y$, sono distinguibili. Allora ogni automa deterministico che accetta $L$ ha almeno $abs(X)$ stati.
]<teorema-distinguibilita>

#theorem-proof()[
  Sia $X = {x_1, dots, x_n}$ e sia $A = (Q, Sigma, delta, q_0, F)$ un DFA che accetta il linguaggio $L$. Definiamo gli stati $ p_i = delta(q_0, x_i) quad forall i = 1, dots, n $ che raggiungiamo dallo stato iniziale usando le stringhe $x_i$ di $X$. Graficamente abbiamo $ q_0 arrow.long.squiggly^(x_0) p_0 \ dots \ q_0 arrow.long.squiggly^(x_n) p_n $

  Per assurdo, supponiamo che $abs(Q) < n$. Ma allora esistono due stati tra i vari $p_i$ che sono raggiunti da due stringhe diverse, ovvero $ exists i eq.not j bar.v p_i = p_j . $

  Per ipotesi $x_i$ e $x_j$ sono due stringhe distinguibili, quindi esiste una stringa $z in Sigma^*$ che le distingue. Ma partendo dallo stesso stato $p_i = p_j$ e applicando $z$ vado per entrambe le stringhe in uno stato finale o in uno stato non finale.

  Ma questo è un assurdo perché va contro la definizione di distinguibilità, quindi non può succedere che $ abs(Q) < n arrow.long.double abs(Q) gt.eq n . qedhere $
]

== Applicazioni del concetto di distinguibilità

Andiamo ad applicare il @teorema-distinguibilita a qualche linguaggio.

#example()[
  Riprendiamo il linguaggio dell'@esempio-a-pari-b-dispari e cerchiamo di costruire un insieme $X$ di stringhe distinguibili.

  #set math.mat(delim: none, gap: 7.5pt)

  $
    mat(, epsilon, a, b, a b; epsilon, -, b, b, b; a, b, -, a b, a b; b, b, a b, -, epsilon; a b, b, a b, epsilon, -; augment: #(vline: (1, 2, 3, 4), hline: (1, 2, 3, 4))) .
  $

  Un approccio comodo per creare un insieme di stringhe distinguibili è usare una stringa *per ogni stato* dell'automa a disposizione.
]

#example()[
  Consideriamo il linguaggio che ha una $a$ in terza posizione da destra e diamogli un nome: $ L_3 = {x in {a,b}^* bar.v "il terzo simbolo di" x "da destra è una" a} . $

  Avevamo visto un DFA per $L_3$ che prendeva una finestra di $3$ simboli, usando $8$ stati. Possiamo farlo con meno di $8$ stati? Vediamo se troviamo dei bound al numero di stati.

  Se scegliamo $X = Sigma^3$, date due stringhe $sigma,gamma in X$ tali che $ sigma = sigma_1 sigma_2 sigma_3 quad bar.v quad gamma = gamma_0 gamma_1 gamma_2 $ allora queste due stringhe le riusciamo a distinguere in base ad una delle posizioni nelle quali hanno un carattere diverso. Infatti, visto che $ exists i bar.v sigma_i eq.not gamma_i $ possiamo affermare che:
  - se $i = 1$ allora scelgo $z = epsilon$;
  - se $i = 2$ allora scelgo $z in {a,b}$;
  - se $i = 3$ allora scelgo $z in {a,b}^2$.

  Con questa costruzione, noi _"rimuoviamo"_ i caratteri prima della posizione $i$ e aggiungiamo in fondo una qualsiasi sequenza della stessa lunghezza. Abbiamo ottenuto una stringa della stessa lunghezza che però ora ha in prima posizione i due caratteri diversi esattamente nella posizione dove dovremmo avere una $a$.
]

Cerchiamo di generalizzare questo concetto.

#example()[
  Definiamo il linguaggio $ L_n = {x in {a,b}^* bar.v "l'"n"-esimo simbolo di" x "da destra è una" a} . $

  Come prima, definiamo $X = Sigma^n$ insieme di stringhe nella forma $sigma = sigma_1 dots sigma_n$.

  Date due stringhe $sigma,gamma in Sigma^n$ allora $ exists i bar.v sigma_i eq.not gamma_i . $ Questa posizione può essere la prima o una a caso, è totalmente indifferente. Come stringa da attaccare scegliamo $ z in Sigma^(i - 1) . $

  Con questa stringa riusciamo a distinguere $sigma$ da $gamma$: infatti, come prima, _"isoliamo"_ i primi $i-1$ caratteri, li _"spostiamo"_ alla fine in un'altra forma e consideriamo solo gli $n$ caratteri di destra. In questa nuova _"configurazione"_ abbiamo l'$n$ esimo carattere della stringa che è quello che era in posizione $i$, che in una stringa vale $a$ e in una vale $b$, quindi le due stringhe sono distinguibili.

  Ma allora ogni DFA per $L_n$ usa almeno $2^(abs(X)) = 2^n$ stati.
]<linguaggio-Ln>

Visto che siamo bravi con le scommesse, andiamo a fare un po' di sano *gambling*.

#example()[
  Definiamo $ D_n = {x in {a,b}^* bar.v exists "due simboli di" x "a distanza" n "che sono diversi"} . $

  Vediamo un NFA per $D_3$, dove appunto viene fissato $n = 3$.

  #figure(image("assets/03/distanza_n_diversi_nfa.svg"))

  Una NFA per $L_n$ utilizza $2n + 2$ stati, più un eventuale stato trappola.
]<linguaggio-Dn>

#example()[
  Riusciamo a trovare un bound al numero di stati di ogni DFA per il linguaggio dell'@linguaggio-Dn precedente con un $n$ generico?

  Sia $X = Sigma^n$ un insieme di stringhe distinguibili per $D_n$.

  Prendiamo le stringhe $sigma = sigma_1 dots sigma_n$ e $gamma = gamma_1 dots gamma_n$ di $X$, e sia $i$ la prima posizione nella quale le due stringhe sono diverse, ovvero $sigma_i eq.not gamma_i$. Come stringa $z$ scegliamo $ z = sigma_1 dots sigma_(i-1) {a,b} $

  Con questa scelta otteniamo le stringhe $ sigma z = sigma_1 dots sigma_(i-1) sigma_i sigma_(i+1) dots sigma_n sigma_1 dots sigma_(i-1) {a,b} \ gamma z = gamma_1 dots gamma_(i-1) gamma_i gamma_(i+1) dots gamma_n gamma_1 dots gamma_(i-1) {a,b} . $

  Tutti i simboli $sigma_1 dots sigma_(i-1)$ sono uguali in entrambe le stringhe, mentre i simboli $sigma_i$ e ${a,b}$ saranno in una stringa uguali e in una diversi, quindi verrà accettata la prima o la seconda stringa e l'altra no.

  Ma allora ogni DFA per $D_n$ richiede almeno $2^n$ stati.
]

Vediamo ancora un esempio, ma teniamo a mente il linguaggio $D_n$ che abbiamo appena visto.

#example()[
  Dato l'alfabeto $Sigma = {a,b}$, definiamo $ D'_n = {x in Sigma^* bar.v "ogni coppia di simboli di" x "a distanza" n "contiene lo stesso simbolo"} . $

  Notiamo che dopo che ho letto $n$ simboli essi si iniziano a ripetere fino alla fine, ma allora $ x in D'_n sse exists w in Sigma^n and exists y in Sigma^(lt.eq n) bar.v x = w^(m gt.eq 0) y and y "suffisso di" w . $ Possiamo ripetere $w$ quante volte voglio, ma poi la parte finale deve ripetere in parte $w$.

  Notiamo inoltre che questo linguaggio è il complementare del precedente, ovvero $ D'_n = D_n^C . $

  Vogliamo costruire un DFA per questo linguaggio: posso usare l'insieme $X$ usato per $D_n$ ma cambiare il valore di verità finale. Quindi ci servono ancora $2^n$ stati per il DFA.

  Vediamo un esempio di automa con $n = 3$, un po' grossino, ma fa niente. Non viene inserito lo stato trappola per semplicità, ma ci dovrebbe essere anche quello per ogni transizione _"sbagliata"_ nell'ultima parte dell'automa.

  #figure(image("assets/03/albero_pazzo.svg", width: 80%))

  Per il linguaggio generico $D'_n$, l'albero usa un numero di stati pari a $ 2^(n+1) - 1 + - 2^n (n-1) + 1 = 2^(n+1) + 2^n (n-1) . $

  Una prima versione migliore dell'automa taglia via $4$ stati facendo dei cappi negli stati $a a a 1$ e $b b b 1$, ma il numero rimane sempre esponenziale sotto steroidi.

  Una seconda versione ancora migliore taglia tutti i $2^n (n-1)$ stati finali che fanno i cicli. Come mai? Possiamo usare tutte le foglie per mantenere comunque i cicli, abbastanza pesante da vedere però un bro è fortissimo e ha visto sta cosa.

  #figure(image("assets/03/albero_meno_pazzo.svg"))

  Questa bellissima versione ha un numero di stati pari a $ 2^(n+1) - 1 + 1 = 2^(n+1) . $

  Come vediamo, in entrambi i casi abbiamo un numero esponenziale di stati, ma almeno abbiamo un automa deterministico da utilizzare.
]<linguaggio-Dn-primo>

Come vediamo, questo teorema è un'arma molto potente: oltre alla possibilità di dare dei *lower bound* al numero di stati di un automa, questo ci permette anche di dire se un linguaggio è di tipo $3$ o meno. Infatti, se riusciamo a trovare un insieme $X$ per un linguaggio $L$ che ha un numero infinito di stringhe distinguibili, allora $L$ non può essere riconosciuto da un automa a *STATI FINITI*.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n bar.v n gt.eq 0} . $

  Se scegliamo $X = {a^n bar.v n gt.eq 0}$, esso è un insieme di stringhe tutte distinguibili tra loro.

  Infatti, date $x = a^i$ e $y = a^j$, con $i eq.not j$, basta scegliere $ z = b^i $ per avere $x z$ accettata e $y z$ non accettata.

  Ma allora $L$ non può essere riconosciuto da un automa a stati finiti.
]

== Automa di Meyer-Fischer

Abbiamo visto qualche applicazione del @teorema-distinguibilita. Osserviamo che spesso il numero di stringhe nell'insieme $X$ (circa) corrisponde al numero di stati che otteniamo trasformando un NFA (minimo) in un DFA con la *costruzione per sottoinsiemi*. In un DFA costruito in questo modo però non servono sempre tutti i sottoinsiemi. Possiamo quindi dare un bound alla costruzione per sottoinsiemi, affermando quindi che il salto esponenziale è solo teorico? La risposta sarà *NO*, ma per capire perché vediamo qualche esempio.

#example()[
  Riprendiamo il linguaggio dell'@linguaggio-Ln e costruiamo un NFA: per fare ciò basta adattare l'NFA che avevamo già costruito per $L_3$ nell'@esempio-terzultimo-a-nd del @capitolo02-tipo3[Capitolo] in cui venivano presentati gli NFA.

  Usiamo quindi uno stato che fa la scommessa di essere arrivati all'$n$-esimo carattere da destra e uno stato che si ricorda di aver letto una $a$. Servono poi $n-1$ stati per leggere i restanti $n-1$ caratteri della stringa.

  #figure(image("assets/03/ln_nfa.svg"))

  Il numero totale di stati è quindi $n+1$.
]

Per $L_n$ abbiamo quindi visto che il numero di stati richiesti per un NFA è $n+1$, mentre per un DFA è almeno $2^n$ grazie al @teorema-distinguibilita. Il salto che abbiamo fatto è quindi *esponenziale*.

#example()[
  Dato il seguente NFA, costruire il DFA associato.

  #figure(image("assets/03/esercizio.svg"))

  Usando la costruzione per sottoinsiemi otteniamo il seguente DFA.

  #figure(image("assets/03/esercizio_DFA.svg", width: 75%))
]

Escludendo lo stato trappola siamo riusciti ad usare meno stati di quelli del salto $n arrow.long 2^n$, quindi vuol dire che forse si riesce a fare meglio. E invece *NO*. Esiste un caso peggiore, un automa che esegue un salto preciso da $n$ a $2^n$ preciso preciso.

Come per la teoria della complessità, dobbiamo considerare sempre il *caso peggiore*, quindi vedremo un salto da $n$ a $2^n$ esaurendo completamente tutti i possibili sottoinsiemi di $n$. Poi si può fare di meglio, ma in generale si fa tutto il salto visto che esiste un controesempio.

L'automa che viene portato come sacrificio per questa causa è l'automa di Meyer-Fischer.

L'*automa di Meyer-Fischer*, ideato da questi due bro nel $1971$, sarà il nostro NFA salvatore che ci permetterà di dimostrare quanto detto fino ad adesso.

Sia $M_n = (Q, Sigma, delta, q_0, F)$ tali che:
- $Q = {0, dots, n-1}$ insieme di $n$ stati;
- $Sigma = {a,b}$;
- $q_0 = 0$ stato iniziale e anche unico stato finale.

La funzione di transizione è tale che $ delta(i, x) = cases({(i + 1) mod n} quad & "se" x = a, {i,0} & "se" x = b, emptyset.rev & "se" x = b and i = 0) . $

L'automa $M_n$ lo possiamo disegnare in questo modo.

#figure(image("assets/03/meyer_fischer.svg"))

#theorem()[
  Ogni DFA equivalente a $M_n$ deve avere almeno $2^n$ stati.
]

#theorem-proof()[
  Sia $S subset.eq {0, dots, n-1}$. Definiamo la stringa $ w_S = cases(b & "se" S = emptyset.rev, a^i & "se" S = {i}, a^(e_k - e_(k-1)) b a^(e_(k-1) - e_(k-2)) b dots.c b a^(e_2 - e_1) b a^(e_1) quad & "se" S = {e_1, dots, e_k} bar.v k > 1 and e_1 < dots < e_k) . $

  Si può dimostrare -- @primo-lemma -- che per ogni $S subset.eq {0, dots, n-1}$ vale $ delta(q_0, w_S) = S . $

  Si può dimostrare inoltre -- @secondo-lemma -- che dati $S,T subset.eq {0, dots, n-1}$, se $S eq.not T$ allora $w_S$ e $w_T$ sono distinguibili per il linguaggio $L(M_n)$.

  Viste queste due proprietà, l'insieme di tutte le stringhe $w_S$ associate ai vari insiemi $S$ è formato da stringhe indistinguibili tra loro a coppie. Definiamo quindi $ X = {w_S bar.v S subset.eq {0, dots, n-1}} $ insieme di stringhe distinguibili tra loro per $L(M_n)$.

  Il numero di stringhe in $X$ dipende dal numero di sottoinsiemi di ${0, dots, n-1}$: questi sono esattamente $2^n$, quindi anche $abs(X) = 2^n$. Ma allora, per il teorema sulla distinguibilità, ogni DFA per $M_n$ deve usare almeno $2^n$ stati.
]

Formalizziamo un attimo le due proprietà utilizzate. Vediamo la prima.

#lemma()[
  Per ogni $S subset.eq {0, dots, n-1}$ vale $ delta(q_0, w_S) = S . $
]<primo-lemma>

#example()[
  Sia $M_5$ un'istanza dell'automa di Meyer-Fischer.

  Se scegliamo $S = {1,3,4}$ allora $ w_S = a^(4 - 3) b a^(3 - 1) b a^1 = a b a a b a . $

  Facciamo girare l'automa $M_5$ sulla stringa $w_S$.

  #align(center)[
    #syntree(
      child-spacing: 2em,
      layer-spacing: 2em,
      "[$0$ [$1$ [$0$ [$1$ [$2$ [$0$ $1$] [$2$ $3$]]]] [$1$ [$2$ [$3$ [$0$ $1$] [$3$ $4$]]]]]]",
    )
  ]

  Notiamo come l'insieme degli stati finali possibili sia esattamente $S$.
]

E ora vediamo la seconda e ultima proprietà.

#lemma()[
  Dati $S,T subset.eq {0, dots, n-1}$, se $S eq.not T$ allora $w_S$ e $w_T$ sono distinguibili per il linguaggio $L(M_n)$.
]<secondo-lemma>

#lemma-proof()[
  Se $S eq.not T$ allora sia $x in S backslash T$ uno degli elementi che sta in $S$ ma non in $T$. Vale anche il simmetrico, quindi consideriamo questo caso per ora.

  Per il @primo-lemma, sappiamo che $ delta(q_0, w_S) = S quad bar.v quad delta(q_0, w_T) = T . $

  Se siamo nello stato $x$, se vogliamo finire nello stato finale basta leggere la stringa $a^(n-x)$. Infatti, dato l'insieme $S$ che contiene $x$, allora $ w_S a^(n-x) in L(M_n) $ perché lo stato $x$ finisce nello stato finale.

  Ora, visto che $x in.not T$, allora $w_T a^(n-x) in.not L(M_n)$ perché l'unico modo per finire in $0$ leggendo $a^(n-x)$ è essere nello stato $x$, come visto poco fa.

  Ma allora $w_S$ e $w_T$ sono distinguibili.
]

== Fooling set

Abbiamo visto un criterio di distinguibilità per i DFA, ma ne esiste uno anche per gli NFA.

#definition([Fooling set])[
  Sia $L subset.eq Sigma^*$. Definiamo $ P = {(x_i, y_i) bar.v i = 1, dots, N} subset.eq Sigma^* times Sigma^* $ un insieme di $N$ coppie formate da stringhe di $Sigma^*$.

  L'insieme $P$ è un *fooling set* per $L$ se:
  + $forall i in {1, dots, N} quad x_i y_i in L$;
  + $forall i,j in {1, dots, N} bar.v i eq.not j quad x_i y_j in.not L$.
]

Cosa ci stanno dicendo queste due proprietà? La prima ci dice che la concatenazione degli elementi della stessa coppia forma una stringa che appartiene al linguaggio, mentre la seconda ci dice che la concatenazione della prima parte di una coppia con la seconda parte di un'altra coppia forma una stringa che non appartiene al linguaggio.

Noi useremo una versione leggermente diversa del fooling set.

#definition([Extended fooling set])[
  Un *extended fooling set* è un fooling set nel quale viene modificata la seconda proprietà, ovvero:
  + $forall i in {1, dots, N} quad x_i y_i in L$;
  + $forall i,j in {1, dots, N} bar.v i eq.not j quad x_i y_j in.not L or x_j y_i in.not L$.
]

Come vediamo, è una versione un pelo più rilassata: prima chiedevamo che, presa ogni prima parte di indice $i$, ogni concatenazione con seconde parti di indice $j$ ci desse una stringa fuori dal linguaggio. Ora invece me ne basta solo uno dei due versi.

#theorem([Teorema del fooling set])[
  Se $P$ è un extended fooling set per il linguaggio $L$ allora ogni NFA per $L$ deve avere almeno $abs(P)$ stati.
]<fooling-set>

#theorem-proof()[
  Concentriamoci solo sui cammini accettanti che possiamo avere in un NFA per il linguaggio $L$. Grazie alla prima proprietà di $P$, sappiamo che le stringhe $z = x_i y_i$ stanno in $L$. Calcoliamo i cammini per ogni coppia di $P$, che sono $N$: $ q_0 arrow.long.squiggly^(x_1) p_1 arrow.long.squiggly^(y_1) f_1 \ dots.v \ q_0 arrow.long.squiggly^(x_N) p_N arrow.long.squiggly^(y_N) f_N $

  Per assurdo sia $A$ un NFA con meno di $N$ stati. Ma allora esistono due stringhe $x_i eq.not x_j$ che mi fanno andare in $p_i = p_j$. Sappiamo che:
  - da $p_i$ con $y_i$ vado in uno stato finale;
  - da $p_j$ con $y_j$ vado in uno stato finale.

  Sappiamo che $p_i = p_j$, ma quindi $x_i y_j$ è una stringa che finisce in uno stato finale, ma questo è un assurdo perché contraddice la seconda proprietà del fooling set.

  Quindi ogni NFA deve avere almeno $N$ stati.
]

== Applicazioni del concetto di fooling set

Usiamo il @fooling-set per valutare un NFA.

#example()[
  Dato il linguaggio $D'_n$ dell'@linguaggio-Dn-primo, definiamo l'insieme $ P = {(x,x) bar.v x in Sigma^n} $ extended fooling set per $D'_n$. Infatti, ogni stringa $z = x x$ appartiene a $D'_n$, mentre ogni "stringa incrociata" $z = x y$, con $x eq.not y$, non appartiene a $D'_n$ perché in almeno una posizione a distanza $n$ ho un carattere diverso.

  Il numero di elementi di $P$ è $2^n$, che è il numero di configurazioni lunghe $n$ di $2$ caratteri, quindi ogni NFA per $D'_n$ ha almeno $2^n$ stati.
]

Vediamo un mini *riassunto* dei due linguaggi visti di recente.

#figure(
  table(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [*Linguaggio*], [*DFA*], [*NFA*],
    [$D_n$], [$gt.eq 2^n$], [$lt.eq 2n + 2$],
    [$D'_n$], [$gt.eq 2^n and lt.eq 2^(n+1)$], [$gt.eq 2^n$],
  ),
)<riassunto-Dn>

Finiamo con un ultimo esempio.

#example()[
  Dato il linguaggio $Sigma = {0,1,2}$, definiamo il linguaggio $ T_n = {0^i 1^i 2^i bar.v 0 lt.eq i lt.eq n} . $

  Diamo un DFA per questo linguaggio, fissando $n = 3$.

  #figure(image("assets/03/triangolo.svg"))

  Il numero di stati del linguaggio $T_n$ generico è $ sum_(i=0)^n (2i+1) = n^2 . $

  Per finire diamo un NFA per il linguaggio $T_n$. Visto che non sappiamo su cosa scommettere, diamo un lower bound al numero di stati dei nostri NFA.

  Creiamo un fooling set $ P = {(0^i 1^j, 1^(i-j) 2^i) bar.v i = 1, dots, n and j = 1, dots, i} . $

  Questo è un fooling set per $T_n$:
  - una coppia ci dà la stringa $z = 0^i 1^(j + i - j) 2^i = 0^i 1^i 2^i$ che appartiene al linguaggio;
  - prendendo due elementi da due coppie diverse:
    - se sono diverse le $i$ abbiamo un numero di $0$ e $2$ diversi;
    - se sono uguali le $i$ allora sono diverse le $j$, ma allora la stringa $0^i 1^(j + i - j') 2^i$ non appartiene al linguaggio perché $j + i - j' eq.not i$.

  Il numero di stati di $P$ è ancora una somma di Gauss, quindi ogni NFA per $T_n$ ha almeno un numero *quadratico* di stati.
]
