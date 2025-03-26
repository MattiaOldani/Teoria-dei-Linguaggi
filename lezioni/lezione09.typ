// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 09 [26/03]

== Fine dimostrazione

Per finire la dimostrazione del *teorema di Kleene* dobbiamo essere in grado di passare dalle espressioni regolari ai linguaggi di tipo $3$.

#theorem([Teorema di Kleene])[
  Vedi lezione scorsa.
]

#theorem-proof()[
  Costruiamo degli automi per le espressioni regolari di base e poi costruiamo gli automi per le operazioni che usiamo per chiudere questa classe di linguaggi.

  #table(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [*Espressione regolare*], [*Automa*],
    [$emptyset.rev$], [#figure(image("assets/09_vuoto.svg"))],
    [$epsilon$], [#figure(image("assets/09_epsilon.svg"))],
    [$a$], [#figure(image("assets/09_a.svg"))],
  )

  Per essere precisi, dovremmo utilizzare dei DFA che sono completi, quindi dobbiamo considerare anche lo stato trappola. In realtà, se vogliamo fare un conto asintotico non ci interessa molto, ma se vogliamo il numero preciso di stati allora quello stato è necessario.

  Per vedere la composizione di questi stati usando le operazioni lineari, penso vada bene il prossimo capitolo sulle operazioni.
]

== State complexity

Vogliamo studiare il numero di stati che sono necessari per definire un automa. Vediamo due quantità che sono chiave in questo studio.

#definition([State complexity deterministica])[
  Sia $L subset.eq Sigma^*$. Indichiamo con $ sc(L) $ il minimo numero di stati di un DFA completo per $L$.
]

Abbiamo poi visto che l'automa con questo numero di stati è anche *unico*.

#definition([State complexity non deterministica])[
  Sia $L subset.eq Sigma^*$. Indichiamo con $ nsc(L) $ il minimo numero di stati di un NFA per $L$.
]

In questo caso abbiamo visto che l'NFA minimo *non è unico*. Inoltre, non abbiamo la nozione di *completo* perché la funzione di transizione associa ad ogni passo di computazione una serie di scelte, che può essere anche la scelta vuota.

#lemma()[
  Se $L$ non è un linguaggio regolare allora $ sc(L) = nsc(L) = infinity . $
]

#lemma()[
  Se $L$ è un linguaggio regolare allora $ sc(L) < infinity and nsc(L) < infinity . $
]

Avevamo inoltre il bound per passare da NFA a DFA, che nel caso peggiore trasformava $n$ stati di un NFA in $2^n$ stati di un DFA con l'automa di *Meyer-Fischer*.

#example()[
  Sia $L_n$ il solito linguaggio dell'$n$-esimo simbolo da destra uguale ad $a$.

  Avevamo visto un NFA che utilizzava $n+1$ stati, quindi $ nsc(L_n) lt.eq n + 1 . $

  Si dimostra poi l'uguaglianza dei due valori utilizzando un fooling set.

  Avevamo poi visto un DFA che utilizzava $2^n$ stati, quindi $ sc(L_n) = 2^n . $

  Con un insieme di stringhe distinguibili avevamo mostrato che servivano almeno $2^n$ stati, ma con la realizzazione effettiva abbiamo uguagliato il bound.
]

== Operazioni

Estendiamo la nozione di state complexity alle operazioni sui linguaggi. Data un'operazione che preservi la *regolarità* su $n$ linguaggi, ognuno con la propria state complexity, ci chiediamo quale sia la state complexity dell'operazione considerata sui linguaggi dati.

=== Complemento

Dato il linguaggio $L$ con $sc(L) = n$, vogliamo valutare la quantità $sc(L^C)$ del *complemento* di $L$.

==== DFA

Se abbiamo un DFA per $L$, passare a $L^C$ è molto facile: tutte le stringhe che prima accettavo ora le devo rifiutare e viceversa. Parlando in termini di dell'automa, invertiamo ogni stato finale in non finale e viceversa, mantenendo intatte le transizioni.

Dato $A = (Q, Sigma, delta, q_0, F)$ un DFA per $L$, costruisco l'automa $A' = (Q, Sigma, delta, q_0, F')$ un DFA per $L^C$ tale che $ F' = Q slash F . $

Dobbiamo imporre che $A$ sia *completo* perché ciò che andava nello stato trappola ora deve essere accettato. Ma allora $ sc(L^C) = sc(L) . $

==== NFA

Come ci comportiamo sugli NFA?

#example()[
  Sia $L_3$ l'istanza del linguaggio $L_n$ classico con $n = 3$. Andiamo a vedere un automa che cerca di calcolare $L_3^C$ con la tecnica che abbiamo appena visto nei DFA.

  #figure(image("assets/09_l3c_NFA.svg"))

  Abbiamo un problema: questo automa *accetta tutto*. Ma perché succede questo? Negli NFA accettiamo se esiste almeno un cammino accettante e rifiutiamo se ogni cammino è rifiutante. Quando accettiamo è molto probabile che ci sia, oltre al cammino accettante, anche qualche cammino rifiutante. Facendo il complemento, accettiamo ancora quando abbiamo almeno un cammino accettante, ma questo deriva da uno dei cammini rifiutanti precedenti.
]

È importantissimo avere il DFA, per via di questa asimmetria tra accettazione e non accettazione.

Ma se volessimo per forza un NFA per il complemento? Questo va molto a caso, dipende da linguaggio a linguaggio, potrebbe essere molto facile da trovare come molto difficile.

#example()[
  Sempre per il linguaggio $L_3$, diamo due NFA per riconoscere $L_3^C$.

  Una prima soluzione utilizza una serie di stati iniziali multipli.

  #figure(image("assets/09_l3c_ok01.svg"))

  Una seconda soluzione utilizza invece il non determinismo puro.

  #figure(image("assets/09_l3c_ok02.svg"))
]

Questo approccio di cercare a tutti i costi un NFA può essere difficoltoso. Vediamo un algoritmo che ci permette di avere un automa per $L^C$, per ci darà un automa deterministico.

==== Costruzione per sottoinsiemi

Sia $A = (Q, Sigma, delta, q_0, F)$ un NFA per $L$, voglio un automa per il linguaggio $L^C$. Un modo sistematico e ottimo per avere un automa sotto mano è passare al DFA di $A$ e poi eseguire la costruzione del complemento che abbiamo visto prima.

Quanti stati abbiamo? Sappiamo che abbiamo un salto esponenziale passando dall'NFA al DFA, e poi uno stesso numero di stati, quindi $ nsc(L^C) lt.eq 2^(nsc(L)) . $

Possiamo fare di meglio? Sicuramente esistono esempi di salti che non sono esattamente esponenziali, come i linguaggi delle coppie di elementi uguali/diversi a distanza $n$, che avevano un salto del tipo $ 2n + 2 arrow.long 2^n , $ ma si può costruire un esempio che faccia un salto esponenziale perfetto.

Abbiamo quindi visto che del complemento negli NFA non ce ne facciamo niente, questo proprio per la natura del non determinismo.

=== Unione

Dati due linguaggi $L',L'' subset.eq Sigma^*$ rispettivamente riconosciuti dagli automi $A' = (Q', Sigma, delta', q'_0, F')$ e $A'' = (Q'', Sigma, delta'', q''_0, F'')$, vogliamo costruire un automa per l'*unione* $ L' union L'' . $

Per risolvere questo problema pensiamo agli automi come se fossero delle scatole, che prendono l'input nello stato iniziale e poi arrivano alla fine nell'insieme degli stati finali.

#figure(image("assets/09_black_box.svg"))

L'idea per costruire l'automa l'unione è combinare i due automi $A'$ e $A''$ usando il non determinismo per scegliere in quale automa finire con una $epsilon$-mossa.

#figure(image("assets/09_unione_NFA.svg"))

Visto che il linguaggio dell'unione deve stare in almeno uno dei due, metto una scommessa all'inizio per vedere se andare nel primo o nel secondo automa. Bella soluzione, funziona, ma non ci piace tanto, come mai?

==== DFA

Non ci piace tanto questa soluzione perché se partiamo da due DFA andiamo a finire in un NFA. Infatti, la componente, non deterministica viene inserita con le due $epsilon$-mosse iniziali. La stessa componente non deterministica l'avremmo inserita con gli stati iniziali multipli, che sarebbero stati in corrispondenza dei due stati iniziali $q'_0$ e $q''_0$ senza lo stato $q_0$.

Se vogliamo rimanere nel mondo DFA dobbiamo unire i due automi con questa costruzione e poi passare al DFA con la costruzione per sottoinsiemi. Il numero di stati dell'NFA è $ nsc(L' union L'') lt.eq 1 + nsc(L') + nsc(L'') , $ quindi con la costruzione per sottoinsiemi arriveremmo ad avere un numero di stati pari a $ sc(L' union L'') lt.eq 2^(nsc(L' union L'')) . $

Questa costruzione è altamente *inefficiente*. Si può fare molto meglio.

==== Automa prodotto

Utilizzando una costruzione particolare, la *costruzione dell'automa prodotto*, siamo in grado di abbassare di brutto la complessità in stati dei DFA per l'unione di linguaggi.

L'*automa prodotto* fa partire in parallelo i due automi, e alla fine controlla che almeno uno dei due abbia dato un cammino accettante. Definiamo quindi $A = (Q, Sigma, delta, q_0, F)$ tale che:
- gli *stati* rappresentano i due automi che viaggiano in parallelo, come se avessi due pc davanti, ognuno che lavora da solo. Gli stati sono quindi l'insieme $ Q = Q' times Q'' ; $
- lo *stato iniziale* è la coppia di stati iniziali, ovvero $ q_0 = (q'_0, q''_0) ; $
- la *funzione di transizione* lavora ora sulle coppie di stati, che deve portare avanti in parallelo, quindi $ delta((q,p), a) = (delta'(q,a), delta''(p,a)) ; $
- gli *stati finali* sono tutte le coppie dove riesco a finire in almeno uno stato finale, ovvero $ F = {(q,p) bar.v q in F' or p in F''} . $

Come cambia la complessità dell'automa rispetto alla costruzione per sottoinsiemi? Qua il numero di stati è $ sc(L' union L'') lt.eq sc(L') dot sc(L'') , $ quindi abbiamo una soluzione notevolmente migliore. Inoltre, non si può fare meglio di così.

#example()[
  Fissati due valori $m,n$ positivi, definiamo i linguaggi $ L' = {x in {a,b}^* bar.v hash_a (x) "è multiplo di" m} \ L'' = {x in {a,b}^* bar.v hash_b (x) "è multiplo di" n} . $

  I due automi $A'$ e $A''$ per $L'$ e $L''$ sono molto semplici, devono solo contare il numero di $a$ e $b$. Vediamo un esempio con $m = n = 2$.

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [#figure(image("assets/09_a_m.svg"))], [#figure(image("assets/09_b_n.svg"))],
  )

  Costruiamo l'automa prodotto per il linguaggio $L = L' union L''$.

  #figure(image("assets/09_unione_am_bn.svg"))
]

==== NFA

Negli NFA non abbiamo nessun problema: partiamo da NFA e vogliamo restare in NFA, quindi non servono ulteriori costruzioni per avere un automa di questa classe. Il numero di stati è $ nsc(L' union L'') lt.eq 1 + nsc(L') + nsc(L'') . $ Perdiamo il termine noto di questa quantità se non usiamo $epsilon$-mosse ma stati iniziali multipli.

=== Intersezione

Per l'*intersezione* di linguaggi non dobbiamo definire molto di nuovo.

Per i DFA, possiamo utilizzare la costruzione dell'automa prodotto appena definita modificando l'insieme degli stati finali $F$ rendendolo l'insieme $ F = {(q,p) bar.v q in F' and p in F''} . $

Ma allora la state complexity vale $ sc(L' inter L'') lt.eq sc(L') dot sc(L'') . $

#example()[
  Riprendendo i due linguaggi di prima, l'automa prodotto viene costruito nello stesso modo, ma cambia l'insieme degli stati finali, che si riduce al singleton ${00}$.

  #figure(image("assets/09_intersezione_am_bn.svg"))
]

Per gli NFA, possiamo riutilizzare la costruzione dell'automa prodotto per permetterci di navigare tutte le possibile coppie di cammini, e scommettendo bene su entrambi i cammini possiamo accettare la stringa. Va sistemata un pelo la definizione della funzione di transizione, ma la costruzione rimane uguale. Vale quindi $ nsc(L' inter L'') lt.eq nsc(L') dot nsc(L'') . $

=== Prodotto

Riprendiamo velocemente la definizione di *prodotto* di linguaggi. Dati due linguaggi $L'$ e $L''$, allora $ L' dot L'' = {w bar.v exists x in L' and exists y in L'' bar.v w = x y} . $

Sfruttiamo la rappresentazione black box degli automi: mettendoli in serie utilizzando le $epsilon$-mosse.

#figure(image("assets/09_prodotto.svg"))

In poche parole, ogni volta che arriviamo in uno stato finale di $A'$ facciamo partire la computazione su $A''$, ma in $A'$ andiamo avanti a scandire la stringa. Stiamo scommettendo di essere arrivati alla fine della stringa $x$ e di dover iniziare a leggere la stringa $y$.

Bella costruzione, ma ci va veramente bene una roba del genere?

==== DFA

La risposta, come prima, è *NO*: se partiamo da due DFA andiamo a finire in un NFA, che non ci va bene perché per poi tornare in un DFA ci costa un salto esponenziale. Visto che $ nsc(L' dot L'') = nsc(L') + nsc(L''), $ possiamo dire che $ sc(L' dot L'') lt.eq 2^(nsc(L' dot L'')) . $

Come prima, possiamo ottimizzare questa costruzione, anche se non di molto stavolta.

==== Costruzione senza nome

Il problema dell'esplosione del doppio esponenziale deriva dal fatto che, quando arrivo in uno stato finale del primo automa, devo far partire il secondo automa, ma il primo continua ancora a scandagliare la stringa perché deve scommettere.

La soluzione inefficiente di prima prendeva i due automi $A'$ e $A''$, li univa in un NFA ed effettuava la costruzione per sottoinsiemi. La soluzione che facciamo adesso *incorpora* i sottoinsiemi nei passi del DFA, così da evitare l'esecuzione non deterministica.

Costruisco l'automa $A = (Q, Sigma, delta, q_0, F)$ che, ogni volta che $A'$ finisce in uno stato finale, avvia anche $A''$ dal punto nel quale si trova. Esso è definito da:
- gli *stati* sono tutte le coppie di stati di $A'$ con i sottoinsiemi di $A''$, così da incorporare i sottoinsiemi nel DFA direttamente, ovvero $ Q = Q' times 2^Q'' ; $
- lo *stato iniziale* dipende se siamo già in una configurazione che permette lo start di $A''$, ovvero $ q_0 = cases((q'_0, emptyset.rev) & "se" q'_0 in.not F', (q'_0, {q''_0}) quad & "se" q'_0 in F') ; $
- la *funzione di transizione* deve lavorare sulla prima componente ma anche su tutte quelle presenti nella seconda componente, quindi essa è definita come $ delta((q, alpha), a) = cases((delta'(q,a), {delta''(p,a) bar.v p in alpha}) & "se" delta'(q,a) in.not F', (delta'(q,a), {delta''(p,a) bar.v p in alpha} union {q''_0}) quad & "se" delta'(q,a) in F') ; $
- gli *stati finali* sono quelli nei quali riusciamo ad arrivare con il secondo automa, ovvero $ F = {(q,alpha) bar.v alpha inter F'' eq.not emptyset.rev} . $

La prima componente la mandiamo avanti deterministicamente, ma la manteniamo sempre accesa per far partire la seconda computazione. Quest'ultima è anch'essa deterministica, ma simula un po' il comportamento non deterministico.

Il numero di stati massimo che abbiamo è $ sc(L' dot L'') = sc(L') 2^(sc(L'')) , $ che rappresenta comunque un gap esponenziale ma abbiamo abbassato di un po' la complessità.

==== NFA

Come per l'unione, qua siamo molto tranquilli: partiamo da NFA e arriviamo in NFA, quindi a noi va tutto bene. La state complexity, come visto prima, è $ nsc(L' dot L'') lt.eq nsc(L') + nsc(L'') . $
