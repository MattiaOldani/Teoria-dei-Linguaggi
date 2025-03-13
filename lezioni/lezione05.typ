// Setup

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 05 [12/03]

== Distinguibilità

#example()[
  Sia $Sigma = {a,b}$ e vogliamo un automa che riconosca il linguaggio $ L = {x in Sigma^* bar.v hash_a (x) "pari" and hash_b (x) "dispari"} $

  #figure(image("assets/05_a_pari_b_dispari.svg"))

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
    mat(,epsilon,a,b,a b; epsilon,-,b,b,b; a,b,-,a b,a b; b,b,a b,-,epsilon; a b,b,a b,epsilon, -; augment: #(vline: (1,2,3,4), hline: (1,2,3,4))) .
  $

  È comodo usare una stringa per ogni stato dell'automa.
]

Come vediamo, questo teorema è un'arma molto potente: oltre alla possibilità di dare dei *lower bound* al numero di stati di un automa, questo ci permette anche di dire se un linguaggio è di tipo $3$ o meno. Infatti, se riusciamo a trovare un insieme $X$ per un linguaggio $L$ che ha un numero infinito di stringhe distinguibili, allora $L$ non può essere riconosciuto da un automa a *STATI FINITI*.

== Linguaggio $L_n$

#example()[
  Riprendiamo il linguaggio della scorsa lezione e diamogli un nome. Dato l'alfabeto $Sigma = {a,b}$, sia $ L_3 = {x in Sigma^* bar.v "il terzo simbolo di" x "da destra è una" a} . $

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

  #figure(image("assets/05_ln_nfa.svg"))

  Il numero totale di stati è $n+1$.
]

Per $L_n$ abbiamo quindi visto che il numero di stati richiesti per un NFA è $n+1$, mentre per un DFA è almeno $2^n$ grazie al teorema sulla distinguibilità. Il salto che abbiamo fatto è quindi *esponenziale*.

Tutto bello, ma questo salto esponenziale è evitabile? Possiamo fare di meglio? Possiamo cioè migliorare questa costruzione?

#example()[
  Dato il seguente NFA, costruire il DFA associato.

  #figure(image("assets/05_esercizio.svg"))

  Usando la costruzione per sottoinsiemi otteniamo il seguente DFA.

  #figure(image("assets/05_esercizio_DFA.svg"))
]

Escludendo lo stato trappola siamo riusciti ad usare meno stati di quelli del salto $n arrow 2^n$, quindi vuol dire che forse si riesce a fare meglio. E invece *NO*. Esiste un caso peggiore, un automa che esegue un salto preciso da $n$ a $2^n$ preciso preciso.

Come per la teoria della complessità, dobbiamo considerare sempre il caso peggiore, quindi vedremo un salto da $n$ a $2^n$ esaurendo completamente tutti i possibili sottoinsiemi di $n$. Poi si può fare di meglio, ma in generale si fa tutto il salto visto che esiste un controesempio.

== Automa di Meyer-Fischer

L'*automa di Meyer-Fischer*, ideato da questi due bro nel $1971$, sarà il nostro NFA salvatore che ci permetterà di dimostrare quanto detto fino ad adesso.

Sia $M_n = (Q, Sigma, delta, q_0, F)$ tali che:
- $Q = {0, dots, n-1}$ insieme di $n$ stati;
- $Sigma = {a,b}$;
- $q_0 = 0$ stato iniziale e anche unico stato finale.

La funzione di transizione è tale che $ delta(i, x) = cases({(i + 1) mod n} quad & "se" x = a, {i,0} & "se" x = b, emptyset.rev & "se" x = b and i = 0) . $

L'automa $M_n$ lo possiamo disegnare in questo modo.

#figure(image("assets/05_meyer_fischer.svg"))

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
