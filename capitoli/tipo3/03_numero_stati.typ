// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Capitolo

= Numero minimo di stati
<capitolo03-tipo3>

== Distinguibilità

Vediamo un esempio per introdurre il concetto di questa sezione.

#example()[
  Sia $Sigma = {a,b}$ e vogliamo un automa che riconosca il linguaggio $ L = {x in Sigma^* bar.v hash_a (x) "pari" and hash_b (x) "dispari"} $

  #figure(image("assets/03_a_pari_b_dispari.svg"))

  Ogni stato si ricorda il numero di $a$ e $b$ modulo $2$ che ha incontrato.
]

Possiamo usare meno stati per scrivere un automa per questo linguaggio? Sembra di no, ma non siamo rigorosi. Vediamo un criterio per dire ciò. Ragioniamo sui linguaggi e non sugli automi.

#definition([Distinguibilità])[
  Sia $L subset.eq Sigma^*$ un linguaggio. Date $x,y in Sigma^*$, allora esse sono *distinguibili* per $L$ se $ (x z in L and y z in.not L) or (x z in.not L and y z in L) . $
]

In poche parole, riesco a trovare una stringa $z in Sigma^*$ tale che, se attacco $z$ alle due stringhe $x$ e $y$, da una parte mi trovo in $L$, dall'altra sono fuori $L$.

#theorem([Teorema della distinguibilità])[
  Sia $L subset.eq Sigma^*$ e sia $X subset.eq Sigma^*$ un insieme tale che tutte le coppie di stringhe $x,y in X$, con $x eq.not y$, sono distinguibili. Allora ogni automa deterministico che accetta $L$ ha almeno $abs(X)$ stati.
]

#theorem-proof()[
  Sia $X = {x_1, dots, x_n}$ e sia $A = (Q, Sigma, delta, q_0, F)$ un DFA che accetta il linguaggio $L$. Definiamo gli stati $ p_i = delta(q_0, x_i) quad forall i = 1, dots, n $ che raggiungiamo dallo stato iniziale usando gli stati $x_i$ di $X$. In poche parole, $ q_0 arrow.long.squiggly^(x_0) p_0 \ dots \ q_0 arrow.long.squiggly^(x_n) p_n $

  Per assurdo, supponiamo che $abs(Q) < n$. Ma allora esistono due stati tra i vari $p_i$ che sono raggiunti da due stringhe diverse, ovvero $ exists i eq.not j bar.v p_i = p_j . $

  Per ipotesi $x_i$ e $x_j$ sono due stringhe distinguibili, quindi esiste una stringa $z in Sigma^*$ che le distingue. Ma partendo dallo stesso stato $p_i = p_j$ e applicando $z$ vado per entrambe le stringhe in uno stato finale o in uno stato non finale.

  Ma questo è un assurdo perché va contro la definizione di distinguibilità, quindi non può succedere che $ abs(Q) < n arrow.long.double abs(Q) gt.eq n . qedhere $
]

#example()[
  Trovare un insieme di stringhe distinguibili per il linguaggio precedente.

  #set math.mat(delim: none)

  $
    mat(, epsilon, a, b, a b; epsilon, -, b, b, b; a, b, -, a b, a b; b, b, a b, -, epsilon; a b, b, a b, epsilon, -; augment: #(vline: (1, 2, 3, 4), hline: (1, 2, 3, 4))) .
  $

  È comodo usare una stringa per ogni stato dell'automa.
]

Come vediamo, questo teorema è un'arma molto potente: oltre alla possibilità di dare dei *lower bound* al numero di stati di un automa, questo ci permette anche di dire se un linguaggio è di tipo $3$ o meno. Infatti, se riusciamo a trovare un insieme $X$ per un linguaggio $L$ che ha un numero infinito di stringhe distinguibili, allora $L$ non può essere riconosciuto da un automa a *STATI FINITI*.

#example()[
  Riprendiamo il linguaggio della $a$ in terza posizione da destra e diamogli un nome. Dato l'alfabeto $Sigma = {a,b}$, sia $ L_3 = {x in Sigma^* bar.v "il terzo simbolo di" x "da destra è una" a} . $

  Avevamo visto un DFA per $L$ che prendeva una finestra di $3$ simboli, usando $8$ stati. Possiamo farlo con meno di $8$ stati? Usiamo il teorema precedente e vediamo che succede.

  Se scegliamo $X = Sigma^3$, date due stringhe $sigma,gamma in X$ tali che $ sigma = sigma_1 sigma_2 sigma_3 quad bar.v quad gamma = gamma_0 gamma_1 gamma_2 $ allora queste due stringhe le riusciamo a distinguere in base ad una delle posizioni nelle quali hanno un carattere diverso. Infatti, visto che $ exists i bar.v sigma_i eq.not gamma_i $ possiamo affermare che:
  - se $i = 1$ allora scelgo $z = epsilon$;
  - se $i = 2$ allora scelgo $z in {a,b}$;
  - se $i = 3$ allora scelgo $z in {a,b}^2$.

  Con questa costruzione, noi _"rimuoviamo"_ i caratteri prima della posizione $i$ e aggiungiamo in fondo una qualsiasi sequenza della stessa lunghezza. Abbiamo ottenuto una stringa della stessa lunghezza che però ora ha in prima posizione i due caratteri diversi esattamente nella posizione dove dovremmo avere una $a$.
]

Cerchiamo di generalizzare questo concetto.

#example()[
  Dato l'alfabeto $Sigma = {a,b}$, chiamiamo $ L_n = {x in Sigma^* bar.v "l'"n"-esimo simbolo di" x "da destra è una" a} . $

  Come prima, definisco $X = Sigma^n$ insieme di stringhe nella forma $sigma = sigma_1 dots sigma_n$.

  Date due stringhe $sigma,gamma in Sigma^n$ allora $ exists i bar.v sigma_i eq.not gamma_i . $ Questa posizione può essere la prima o una a caso, è totalmente indifferente.

  Scelgo di attaccare una stringa $ z in Sigma^(i - 1) $ che mi permette di distinguere: infatti, come prima, _"isoliamo"_ i primi $i-1$ caratteri, li _"spostiamo"_ alla fine in un'altra forma e consideriamo solo gli $n$ caratteri di destra. In questa nuova _"configurazione"_ abbiamo l'$n$ esimo carattere della stringa che è quello che era in posizione $i$, che in una stringa vale $a$ e in una vale $b$, quindi le due stringhe sono distinguibili.

  Ma allora ogni DFA per $L_n$ usa almeno $2^(abs(X)) = 2^n$ stati.
]

Cosa cambia se invece utilizziamo un NFA per $L_n$?

#example()[
  Per il linguaggio $L_n$ usiamo uno stato che fa la scommessa di essere arrivati all'$n$-esimo carattere da destra e uno stato che si ricorda di aver letto una $a$. Servono poi $n-1$ stati per leggere i restanti $n-1$ caratteri della stringa.

  #figure(image("assets/03_ln_nfa.svg"))

  Il numero totale di stati è $n+1$.
]

Per $L_n$ abbiamo quindi visto che il numero di stati richiesti per un NFA è $n+1$, mentre per un DFA è almeno $2^n$ grazie al teorema sulla distinguibilità. Il salto che abbiamo fatto è quindi *esponenziale*.

Tutto bello, ma questo salto esponenziale è evitabile? Possiamo fare di meglio? Possiamo cioè migliorare questa costruzione?

#example()[
  Dato il seguente NFA, costruire il DFA associato.

  #figure(image("assets/03_esercizio.svg"))

  Usando la costruzione per sottoinsiemi otteniamo il seguente DFA.

  #figure(image("assets/03_esercizio_DFA.svg"))
]

Escludendo lo stato trappola siamo riusciti ad usare meno stati di quelli del salto $n arrow 2^n$, quindi vuol dire che forse si riesce a fare meglio. E invece *NO*. Esiste un caso peggiore, un automa che esegue un salto preciso da $n$ a $2^n$ preciso preciso.

Come per la teoria della complessità, dobbiamo considerare sempre il caso peggiore, quindi vedremo un salto da $n$ a $2^n$ esaurendo completamente tutti i possibili sottoinsiemi di $n$. Poi si può fare di meglio, ma in generale si fa tutto il salto visto che esiste un controesempio.

=== Automa di Meyer-Fischer

L'*automa di Meyer-Fischer*, ideato da questi due bro nel $1971$, sarà il nostro NFA salvatore che ci permetterà di dimostrare quanto detto fino ad adesso.

Sia $M_n = (Q, Sigma, delta, q_0, F)$ tali che:
- $Q = {0, dots, n-1}$ insieme di $n$ stati;
- $Sigma = {a,b}$;
- $q_0 = 0$ stato iniziale e anche unico stato finale.

La funzione di transizione è tale che $ delta(i, x) = cases({(i + 1) mod n} quad & "se" x = a, {i,0} & "se" x = b, emptyset.rev & "se" x = b and i = 0) . $

L'automa $M_n$ lo possiamo disegnare in questo modo.

// SISTEMA
#figure(image("assets/03_meyer_fischer.svg"))

#theorem()[
  Ogni DFA equivalente a $M_n$ deve avere almeno $2^n$ stati.
]

#theorem-proof()[
  Sia $S subset.eq {0, dots, n-1}$. Definiamo la stringa $ w_S = cases(b & "se" S = emptyset.rev, a^i & "se" S = {i}, a^(e_k - e_(k-1)) b a^(e_(k-1) - e_(k-2)) b dots.c b a^(e_2 - e_1) b a^(e_1) quad & "se" S = {e_1, dots, e_k} bar.v k > 1 and e_1 < dots < e_k) . $

  Si può dimostrare che per ogni $S subset.eq {0, dots, n-1}$ vale $ delta(q_0, w_S) = S . $

  Si può dimostrare inoltre che dati $S,T subset.eq {0, dots, n-1}$, se $S eq.not T$ allora $w_S$ e $w_T$ sono distinguibili per il linguaggio $L(M_n)$.

  Viste queste due proprietà, l'insieme di tutte le stringhe $w_S$ associate ai vari insiemi $S$ è formato da stringhe indistinguibili tra loro a coppie. Definiamo quindi $ X = {w_S bar.v S subset.eq {0, dots, n-1}} $ insieme di stringhe distinguibili tra loro per $L(M_n)$.

  Il numero di stringhe in $X$ dipende dal numero di sottoinsiemi di ${0, dots, n-1}$: questi sono esattamente $2^n$, quindi anche $abs(X) = 2^n$. Ma allora, per il teorema sulla distinguibilità, ogni DFA per $M_n$ deve usare almeno $2^n$ stati.
]

Formalizziamo un attimo le due proprietà utilizzate. Vediamo la prima.

#lemma()[
  Per ogni $S subset.eq {0, dots, n-1}$ vale $ delta(q_0, w_S) = S . $
]

#example()[
  Sia $M_5$ una istanza dell'automa di Meyer-Fischer.

  Se scegliamo $S = {1,3,4}$ allora $ w_S = a^(4 - 3) b a^(3 - 1) b a^1 = a b a a b a . $

  Facciamo girare l'automa $M_5$ sulla stringa $w_S$. Visto che Cetz fa cagare e non funziona niente, ogni stato $i$ viene trasformato nello stato $q_i$.

  #align(center)[
    #cetz.canvas({
      import cetz.tree

      tree.tree((
        [$q_0$],
        (
          [$q_1$],
          ([$q_0$], ([$q_1$], ([$q_2$], ([$q_0$], [$q_1$]), ([$q_2$], [$q_3$])))),
          ([$q_1$], ([$q_2$], ([$q_3$], ([$q_0$], [$q_1$]), ([$q_3$], [$q_4$])))),
        ),
      ))
    })
  ]

  Notiamo come l'insieme degli stati finali possibili sia esattamente $S$.
]

E ora vediamo la seconda e ultima proprietà.

#lemma()[
  Dati $S,T subset.eq {0, dots, n-1}$, se $S eq.not T$ allora $w_S$ e $w_T$ sono distinguibili per il linguaggio $L(M_n)$.
]

#lemma-proof()[
  Se $S eq.not T$ allora sia $x in S slash T$ uno degli elementi che sta in $S$ ma non in $T$. Vale anche il simmetrico, quindi consideriamo questo caso per ora.

  Per il lemma precedente, sappiamo che $ delta(q_0, w_S) = S quad bar.v quad delta(q_0, w_T) = T . $

  Se siamo nello stato $x$, se vogliamo finire nello stato finale basta leggere la stringa $a^(n-x)$. Infatti, dato l'insieme $S$ che contiene $x$, allora $ w_S a^(n-x) in L(M_n) $ perché lo stato $x$ finisce nello stato finale.

  Ora, visto che $x in.not T$, allora $w_T a^(n-x) in.not L(M_n)$ perché l'unico modo per finire in $0$ leggendo $a^(n-x)$ è essere nello stato $x$, come visto poco fa.

  Ma allora $w_S$ e $w_T$ sono distinguibili.
]

=== Esempi

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

  #figure(image("assets/03_distanza_n_diversi_nfa.svg"))

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

  #figure(image("assets/03_albero_pazzo.svg"))

  Per il linguaggio generico $L'_n$, l'albero usa un numero di stati pari a $ 2^(n+1) - 1 + - 2^n (n-1) + 1 = 2^(n+1) + 2^n (n-1) . $

  Una prima versione migliore dell'automa taglia via $4$ stati facendo dei cappi negli stati $a a a 1$ e $b b b 1$, ma il numero rimane sempre esponenziale sotto steroidi.

  Una seconda versione ancora migliore taglia tutti i $2^n (n-1)$ stati finali che fanno i cicli. Come mai? Possiamo usare tutte le foglie per mantenere comunque i cicli, abbastanza pesante da vedere però un bro è fortissimo e ha visto sta cosa.

  #figure(image("assets/03_albero_meno_pazzo.svg"))

  Questa bellissima versione ha un numero di stati pari a $ 2^(n+1) - 1 + 1 = 2^(n+1) . $

  Come vediamo, in entrambi i casi abbiamo un numero esponenziale di stati, ma almeno abbiamo un automa deterministico da utilizzare.
]

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

=== Esempi

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

  #figure(image("assets/03_triangolo.svg"))

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
