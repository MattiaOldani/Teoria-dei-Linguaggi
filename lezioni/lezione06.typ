// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 06 [14/03]

== Molti esempi

Il teorema sulla distinguibilità che abbiamo visto la scorsa lezione è molto potente e ci permette di dimostrare che un linguaggio non è accettato da un automa a stati finiti se troviamo un insieme $X$ con un numero infinito di stringhe.

#example()[
  Sia $ L = {a^n b^n bar.v n gt.eq 0} . $

  Se scegliamo $X = {a^n bar.v n gt.eq 0}$, esso è un insieme di stringhe tutte distinguibili tra loro.

  Infatti, prendendo $x = a^i$ e $y = a^j$, con $i eq.not j$, basta scegliere $ z = b^i $ per avere $x z$ accettata e $y z$ non accettata.

  Ma allora $L$ non può essere riconosciuto da un automa a stati finiti.
]

Visto che siamo bravi con le scommesse, andiamo a fare un po' di sano *gambling*.

#example()[
  Definiamo $ L_n = {x in {a,b}^* bar.v exists "due simboli di" x "a distanza" n "che sono diversi"} . $

  Usiamo anche per questo linguaggio la notazione $L_n$ ma sono due linguaggi diversi.

  Vediamo un NFA per $L_3$, dove appunto viene fissato $n = 3$.

  #figure(image("assets/06_distanza_n_diversi_nfa.svg"))

  Una NFA per $L_n$ utilizza $2n + 2$ stati, più un eventuale stato trappola.
]

Per il DFA riusciamo a trovare un bound al numero di stati?

#example()[
  Dato $L_n$ il linguaggio di prima, sia $X = Sigma^n$.

  Prendiamo le stringhe $sigma = sigma_1 dots sigma_n$ e $gamma = gamma_1 dots gamma_n$ di $X$, e sia $i$ la prima posizione nella quale le due stringhe sono diverse, ovvero $sigma_i eq.not gamma_i$. Come stringa $z$ scelgo $sigma_1 dots sigma_(i-1)$: con questa scelta otteniamo le stringhe $ sigma z = sigma_1 dots sigma_(i-1) sigma_i sigma_(i+1) dots sigma_n sigma_1 dots sigma_(i-1) {a,b} \ gamma z = gamma_1 dots gamma_(i-1) gamma_i gamma_(i+1) dots gamma_n gamma_1 dots gamma_(i-1) {a,b} $

  Notiamo come le prime coppie di caratteri sono tutte uguali, nel primo caso perché sono esattamente la stessa lettera, nel secondo caso perché avevamo imposto la prima diversità in $i$. In base poi al valore di $sigma_i$ e $gamma_i$, e al valore scelto in fondo alla stringa, verrà accettata la prima o la seconda stringa.

  Ma allora ogni DFA per $L_n$ richiede almeno $2^n$ stati.
]

Vediamo ancora un esempio, ma teniamo a mente il linguaggio $L_n$ che abbiamo appena visto.

#example()[
  // Sistema, troppo lungo il linguaggio
  Dato l'alfabeto $Sigma = {a,b}$, definiamo $ L'_n = {x in Sigma^* bar.v "ogni coppia di simboli di" x "a distanza" n "è formata dallo stesso simbolo"} . $

  Notiamo che dopo che ho letto $n$ simboli essi si iniziano a ripetere fino alla fine, ma allora $ x in L'_n arrow.long.double.l.r exists w in Sigma^n and exists y in Sigma^(lt.eq n) bar.v x = w^(m gt.eq 0) y and y "suffisso di" w . $ Posso ripetere $w$ quante volte voglio, ma poi la parte finale deve ripetere in parte $w$.

  Notiamo inoltre che questo linguaggio è il complementare del precedente, ovvero $ L'_n = L_n^C . $

  Vogliamo costruire un DFA per questo linguaggio: posso usare l'insieme $X$ di prima ma cambiare il valore di verità finale. Quindi ci servono ancora $2^n$ stati per il DFA.

  Vediamo un esempio di automa con $n = 3$, un po' grossino, ma fa niente. Non viene inserito lo stato trappola per semplicità, ma ci dovrebbe essere anche quello per ogni transizione _"sbagliata"_ nell'ultima parte dell'automa.

  #figure(image("assets/06_albero_pazzo.svg"))

  Per il linguaggio generico $L'_n$, l'albero usa un numero di stati pari a $ 2^(n+1) - 1 + - 2^n (n-1) + 1 = 2^(n+1) + 2^n (n-1) . $

  Una prima versione migliore dell'automa taglia via $4$ stati facendo dei cappi negli stati $a a a 1$ e $b b b 1$, ma il numero rimane sempre esponenziale sotto steroidi.

  Una seconda versione ancora migliore taglia tutti i $2^n (n-1)$ stati finali che fanno i cicli. Come mai? Possiamo usare tutte le foglie per mantenere comunque i cicli, abbastanza pesante da vedere però un bro è fortissimo e ha visto sta cosa.

  #figure(image("assets/06_albero_meno_pazzo.svg"))

  Questa bellissima versione ha un numero di stati pari a $ 2^(n+1) - 1 + 1 = 2^(n+1) . $

  Come vediamo, in entrambi i casi abbiamo un numero esponenziale di stati, ma almeno abbiamo un automa deterministico da utilizzare.
]

Pesante questo pezzo, ma rendiamolo ancora più pesante: se volessimo fare un NFA? Questa domanda è un po' pallosa perché il non determinismo è buono quando la scommessa da fare è una sola, non quando le scommesse sono da fare sempre, come in questo caso che abbiamo un _"per ogni"_.

== Fooling set

Avevamo visto un criterio di distinguibilità per i DFA, ma ne esiste uno anche per gli NFA.

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

Come vediamo, è una versione un pelo più rilassata: prima chiedevo che, presa ogni prima parte di indice $i$, ogni concatenazione con seconde parti di indice $j$ mi desse una stringa fuori dal linguaggio. Ora invece me ne basta solo uno dei due versi.

#theorem([Teorema del fooling set])[
  Se $P$ è un extended fooling set per il linguaggio $L$ allora ogni NFA per $L$ deve avere almeno $abs(P)$ stati.
]

#theorem-proof()[
  Concentriamoci solo sui cammini accettanti che possiamo avere in un NFA per il linguaggio $L$. Grazie alla prima proprietà di $P$, sappiamo che le stringhe $z = x_i y_i$ stanno in $L$. Calcoliamo i cammini per ogni coppia di $P$, che sono $N$: $ q_0 arrow.long.squiggly^(x_1) p_1 arrow.long.squiggly^(y_1) f_1 \ dots.v \ q_0 arrow.long.squiggly^(x_N) p_N arrow.long.squiggly^(y_N) f_N $

  Per assurdo sia $A$ un NFA con meno di $N$ stati. Ma allora esistono due stringhe $x_i eq.not x_j$ che mi fanno andare in $p_i = p_j$. Sappiamo che:
  - da $p_i$ con $y_i$ vado in uno stato finale;
  - da $p_j$ con $y_j$ vado in uno stato finale.

  Sappiamo che $p_i = p_j$, ma quindi $x_i y_j$ è una stringa che finisce in uno stato finale, ma questo è un assurdo perché contraddice la seconda proprietà del fooling set.

  Quindi ogni NFA deve avere almeno $N$ stati.
]

Usiamo questo teorema per valutare un NFA per il linguaggio precedente.

#example()[
  Dato il linguaggio $L'_n$ definiamo l'insieme $ P = {(x,x) bar.v x in Sigma^n} $ extended fooling set per $L'_n$. Infatti, ogni stringa $z = x x$ appartiene a $L'_n$, mentre ogni _"stringa incrociata"_ $z = x y$, con $x eq.not y$, non appartiene a $L'_n$ perché in almeno una posizione a distanza $n$ ho un carattere diverso.

  Il numero di elementi di $P$ è $2^n$, che è il numero di configurazioni lunghe $n$ di $2$ caratteri, quindi ogni NFA per $L'_n$ ha almeno $2^n$ stati.
]

Vediamo un mini *riassunto* dei due linguaggi visti di recente.

#table(
  columns: (33%, 33%, 33%),
  align: center + horizon,
  inset: 10pt,
  [*Linguaggio*], [*DFA*], [*NFA*],
  [$L_n$], [$gt.eq 2^n$], [$lt.eq 2n + 2$],
  [$L'_n$], [$gt.eq 2^n and lt.eq 2^(n+1)$], [$gt.eq 2^n$],
)

Finiamo con un ultimo esempio.

#example()[
  Dato il linguaggio $Sigma = {0,1,2}$, definiamo il linguaggio $ L_n = {0^i 1^i 2^i bar.v 0 lt.eq i lt.eq n} . $

  Diamo un DFA per questo linguaggio, fissando $n = 3$.

  #figure(image("assets/06_triangolo.svg"))

  Il numero di stati del linguaggio $L_n$ generico è $ sum_(i=1)^n i + sum_(i=1)^(n-1) i = frac(n (n+1), 2) + frac(n (n-1), 2) = frac(n^2 + n + n^2 - n, 2) = frac(2n^2, 2) = n^2 . $

  Possiamo mangiare qualche stato, facendo rientrare le computazioni più lunghe in quelle più corte quando stiamo leggendo dei $2$, ma il numero rimane comunque $O(n^2)$.

  Per finire diamo un NFA per il linguaggio $L_n$. Visto che non sappiamo su cosa scommettere, diamo un lower bound al numero di stati dei nostri NFA.

  Creiamo un fooling set $ P = {(0^i 1^j, 1^(i-j) 2^i) bar.v i = 1, dots, n and j = 1, dots, i} . $

  Questo è un fooling set per $L_n$:
  - una coppia ci dà la stringa $z = 0^i 1^(j + i - j) 2^i = 0^i 1^i 2^i$ che appartiene al linguaggio;
  - prendendo due elementi da due coppie diverse:
    - se sono diverse le $i$ abbiamo un numero di $0$ e $2$ diversi;
    - se sono uguali le $i$ allora sono diverse le $j$, ma allora la stringa $0^i 1^(j + i - j') 2^i$ non appartiene al linguaggio perché $j + i - j' eq.not i$.

  Il numero di stati di $P$ è ancora una somma di Gauss, quindi $ sum_(i=1)^n = frac(n (n+1), 2) , $ quindi ogni NFA per $L_n$ ha almeno un numero quadratico di stati.
]
