// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

/*********************************************/
/***** DA CANCELLARE PRIMA DI COMMITTARE *****/
/*********************************************/
#set heading(numbering: "1.")

#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline(indent: auto)
/*********************************************/
/***** DA CANCELLARE PRIMA DI COMMITTARE *****/
/*********************************************/

= Espressioni regolari

== Teorema di Kleene

Con le operazioni che abbiamo visto noi possiamo creare dei nuovi linguaggi. Tra queste operazioni, possiamo raggruppare *unione*, *prodotto* e *chiusura di Kleene* sotto il cappello delle *operazioni regolari*. Come mai questo nome? Perché esse sono usate per definire i *linguaggi regolari*.

Vediamo tre versioni del seguente teorema, ma ci interesseremo solo della prima e della terza.

#theorem([Teorema di Kleene])[
  La classe dei linguaggi accettati da automi a stati finiti coincide con la più piccola classe contenente i linguaggi $ emptyset.rev quad bar.v quad {epsilon} quad bar.v quad {a} $ e chiusa rispetto alle operazioni di unione, prodotto e chiusura di Kleene.
]

Questa prima versione ci dice che possiamo costruire la classe dei linguaggi regolari partendo da tre linguaggi base e applicando in tutti i modi possibili le tre operazioni regolari.

#theorem([Teorema di Kleene])[
  La classe dei linguaggi accettati da automi a stati finiti coincide con la più piccola classe che contiene i linguaggi finiti.
]

Seconda versione carina, ma che non commentiamo.

#theorem([Teorema di Kleene])[
  La classe dei linguaggi accettati da automi a stati finiti coincide con la classe dei linguaggi espressi con le espressioni regolari.
]

Tutto bello, ma cosa sono le *espressioni regolari*?

#table(
  columns: (50%, 50%),
  align: center + horizon,
  inset: 10pt,
  [*Simbolo/espressione*], [*Linguaggio associato*],
  [$emptyset.rev$], [$emptyset.rev$],
  [$epsilon$], [${epsilon}$],
  [$a$], [${a}$],
  [$E_1 + E_2$], [$L(E_1) union L(E_2)$],
  [$E_1 dot E_2$], [$L(E_1) dot L(E_2)$],
  [$E^*$], [$(L(E))^*$],
)

Le espressioni regolari sono una *forma dichiarativa*, ovvero grazie ad esse dichiariamo come sono fatte le stringhe di un certo linguaggio. Fin'ora avevamo usato gli automi (*forma riconoscitiva*) e le grammatiche (*forma generativa*).

#example()[
  Vediamo un po' di espressioni regolari per alcuni linguaggi.

  #table(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [*Linguaggio*], [*Espressione regolare*],
    [$L = {a^n bar.v n gt.eq 0}$], [$a^*$],
    [$L = {a^(2k + 1) bar.v k gt.eq 0}$], [$(a a)^* a$],
    [$L = {a^n b bar.v n gt.eq 0}$], [$a^* b$],
    [$L = {(a^n b)^k bar.v n gt.eq 0 and k > 0}$], [$(a^* b)^k$],
    [$L_3$ terzultimo simbolo da destra è una $a$], [$(a+b)^* a (a+b) (a+b)$],
  )

  Il penultimo linguaggio ha una espressione regolare che non abbiamo visto: si tratta di una piccola estensione algebrica che ci permette di unire assieme una serie di fattori identici.
]

Andiamo ora a dimostrare il teorema di Kleene.

#theorem-proof()[
  Dobbiamo mostrare una doppia implicazione.

  [*Automa* $arrow.long$ *RegExp*]

  Dobbiamo far vedere che, dato un automa per il linguaggio $L$, possiamo costruire una operazione regolare che indica lo stesso linguaggio.

  Vedi l'esempio successivo su come fare questa operazione.

  [*RegExp* $arrow.long$ *Automa*]

  Dobbiamo far vedere che, data una espressione regolare che denota un linguaggio $L$, possiamo costruire un automa $A$ che riconosce lo stesso linguaggio.

  Vedi la sezione sulle operazioni per questa operazione.
]

=== Da automa ad espressione regolare

Vediamo un esempio di come passare da un automa ad una espressione regolare.

#example()[
  Per ricavare una espressione regolare da un automa si usa un algoritmo di *programmazione dinamica* molto simile all'algoritmo Floyd-Warshall sui grafi, che cerca i cammini minimi imponendo una serie di vincoli.

  Un altro approccio invece cerca di risolvere un *sistema di equazioni* associato all'automa.

  Dato un automa, costruiamo un sistema di $n$ equazioni, dove $n$ è il numero di stati dell'automa. Supponendo di numerare gli stati da $1$ a $n$, la $i$-esima equazione descrive i cambiamenti di stato che possono avvenire partendo dallo stato $i$.

  Ogni *cambiamento di stato* è nella forma $a B$, dove $a$ è il carattere che causa una transizione e $B$ è lo stato di arrivo. Tutti i cambiamenti di stato a partire da $i$ vanno sommati tra loro. Inoltre, se lo stato $i$-esimo è uno stato finale si aggiunge anche $epsilon$ all'equazione.

  Questa somma di cambiamenti di stati va posta uguale allo stato $i$-esimo.

  #figure(image("assets/07_regex_esempio.svg"))

  Associamo all'automa precedente un sistema di $3$ equazioni, nel quale indichiamo gli stati con le variabili $X_i$ e i caratteri sono quelli dell'alfabeto ${a,b}$. Il sistema è il seguente: $ cases(X_0 = a X_1 + b X_0, X_1 = a X_2 + b X_0, X_2 = a X_2 + b X_1 + epsilon) . $

  Ora dobbiamo risolvere questo sistema di equazioni. Per fare ciò, dobbiamo introdurre una *regola fondamentale* che ci permetterà di risolvere tutti i sistemi che vedremo.

  #figure(image("assets/07_regex_regola.svg"))

  Il sistema di equazioni per questo automa è $ cases(X = A X + B Y, Y = epsilon) . $

  Sostituendo $Y = epsilon$ nella prima equazione otteniamo $ X = A X + B . $

  L'espressione regolare per questo automa è $ A^* B . $

  Visto che le due cose che abbiamo scritto devono essere identiche, ogni volta che abbiamo una equazione nella forma $ X = A X + B $ la possiamo sostituire con l'equazione $ X = A^* B . $

  Riprendiamo il sistema dell'automa dell'esempio e andiamo a risolvere le nostre equazioni: $ cases(X_0 = a (a X_2 + b X_0) + b X_0, X_2 = a X_2 + b (a X_2 + b X_0) + epsilon) \ cases(X_0 = a a X_2 + a b X_0 + b X_0, X_2 = a X_2 + b a X_2 + b b X_0 + epsilon) \ cases(X_0 = (a b + b) X_0 + a a X_2, X_2 = (a + b a) X_2 + b b X_0 + epsilon) \ cases(X_0 = (a b + b) X_0 + a a X_2, X_2 = (a + b a)^* (b b X_0 + epsilon)) \ X_0 = (a b + b) X_0 + a a ((a + b a)^* (b b X_0 + epsilon)) \ X_0 = (a b + b) X_0 + a a (a + b a)^* b b X_0 + a a (a + b a)^* \ X_0 = (a b + b + a a (a + b a)^* b b) X_0 + a a (a + b a)^* . $

  Applicando un'ultima volta la regola fondamentale otteniamo l'espressione regolare $ (a b + b + a a (a + b a)^* b b)^* a a (a + b a)^* . $

  E pensare che l'algoritmo basato su Floyd-Warshall è anche più difficile...
]

=== Da espressione regolare ad automa

Per dimostrare questa parte dell'implicazione dobbiamo costruire un automa per ogni espressione regolare possibile, quindi per le tre espressioni base e per le tre operazioni regolari. In realtà, in questa sezione vedremo gli automi di un po' tutte le operazioni che abbiamo visto per adesso.

==== State complexity

Durante questa dimostrazione vogliamo studiare anche il numero di stati che sono *necessari* per definire un automa. Vediamo due quantità che sono chiave in questo studio.

#definition([State complexity deterministica])[
  Sia $L subset.eq Sigma^*$. Indichiamo con $ sc(L) $ il *minimo numero di stati* di un DFA completo per $L$.
]

Abbiamo poi visto che l'automa con questo numero di stati è anche *unico*.

#definition([State complexity non deterministica])[
  Sia $L subset.eq Sigma^*$. Indichiamo con $ nsc(L) $ il *minimo numero di stati* di un NFA per $L$.
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

==== Espressioni base

Costruiamo degli automi per le espressioni regolari di base e poi costruiamo gli automi per le operazioni che usiamo per chiudere questa classe di linguaggi.

#table(
  columns: (50%, 50%),
  align: center + horizon,
  inset: 10pt,
  [*Espressione regolare*], [*Automa*],
  [$emptyset.rev$], [#figure(image("assets/07_vuoto.svg"))],
  [$epsilon$], [#figure(image("assets/07_epsilon.svg"))],
  [$a$], [#figure(image("assets/07_a.svg"))],
)

Per essere precisi, dovremmo utilizzare dei DFA che sono completi, quindi dobbiamo considerare anche lo stato trappola. In realtà, se vogliamo fare un conto asintotico non ci interessa molto, ma se vogliamo il numero preciso di stati allora quello stato è necessario.

==== Operazioni insiemistiche

===== Complemento

Dato il linguaggio $L$ con $sc(L) = n$, vogliamo valutare la quantità $sc(L^C)$ del *complemento* di $L$.

====== DFA

Se abbiamo un DFA per $L$, passare a $L^C$ è molto facile: tutte le stringhe che prima accettavo ora le devo rifiutare e viceversa. Parlando in termini di dell'automa, invertiamo ogni stato finale in non finale e viceversa, mantenendo intatte le transizioni.

Dato $A = (Q, Sigma, delta, q_0, F)$ un DFA per $L$, costruisco l'automa $A' = (Q, Sigma, delta, q_0, F')$ un DFA per $L^C$ tale che $ F' = Q slash F . $

Dobbiamo imporre che $A$ sia *completo* perché ciò che andava nello stato trappola ora deve essere accettato. Ma allora $ sc(L^C) = sc(L) . $

====== NFA

Come ci comportiamo sugli NFA?

#example()[
  Sia $L_3$ l'istanza del linguaggio $L_n$ classico con $n = 3$. Andiamo a vedere un automa che cerca di calcolare $L_3^C$ con la tecnica che abbiamo appena visto nei DFA.

  #figure(image("assets/07_l3c_NFA.svg"))

  Abbiamo un problema: questo automa *accetta tutto*. Ma perché succede questo? Negli NFA accettiamo se esiste almeno un cammino accettante e rifiutiamo se ogni cammino è rifiutante. Quando accettiamo è molto probabile che ci sia, oltre al cammino accettante, anche qualche cammino rifiutante. Facendo il complemento, accettiamo ancora quando abbiamo almeno un cammino accettante, ma questo deriva da uno dei cammini rifiutanti precedenti.
]

È importantissimo avere il DFA, per via di questa asimmetria tra accettazione e non accettazione.

Ma se volessimo per forza un NFA per il complemento? Questo va molto a caso, dipende da linguaggio a linguaggio, potrebbe essere molto facile da trovare come molto difficile.

#example()[
  Sempre per il linguaggio $L_3$, diamo due NFA per riconoscere $L_3^C$.

  Una prima soluzione utilizza una serie di stati iniziali multipli.

  #figure(image("assets/07_l3c_ok01.svg"))

  Una seconda soluzione utilizza invece il non determinismo puro.

  #figure(image("assets/07_l3c_ok02.svg"))
]

Questo approccio di cercare a tutti i costi un NFA può essere difficoltoso. Vediamo un algoritmo che ci permette di avere un automa per $L^C$, per ci darà un automa deterministico.

====== Costruzione per sottoinsiemi

Sia $A = (Q, Sigma, delta, q_0, F)$ un NFA per $L$, voglio un automa per il linguaggio $L^C$. Un modo sistematico e ottimo per avere un automa sotto mano è passare al DFA di $A$ e poi eseguire la costruzione del complemento che abbiamo visto prima.

Quanti stati abbiamo? Sappiamo che abbiamo un salto esponenziale passando dall'NFA al DFA, e poi uno stesso numero di stati, quindi $ nsc(L^C) lt.eq 2^(nsc(L)) . $

Possiamo fare di meglio? Sicuramente esistono esempi di salti che non sono esattamente esponenziali, come i linguaggi delle coppie di elementi uguali/diversi a distanza $n$, che avevano un salto del tipo $ 2n + 2 arrow.long 2^n , $ ma si può costruire un esempio che faccia un salto esponenziale perfetto.

Abbiamo quindi visto che del complemento negli NFA non ce ne facciamo niente, questo proprio per la natura del non determinismo.

===== Unione

Dati due linguaggi $L',L'' subset.eq Sigma^*$ rispettivamente riconosciuti dagli automi $A' = (Q', Sigma, delta', q'_0, F')$ e $A'' = (Q'', Sigma, delta'', q''_0, F'')$, vogliamo costruire un automa per l'*unione* $ L' union L'' . $

Per risolvere questo problema pensiamo agli automi come se fossero delle scatole, che prendono l'input nello stato iniziale e poi arrivano alla fine nell'insieme degli stati finali.

#figure(image("assets/07_black_box.svg"))

L'idea per costruire l'automa l'unione è combinare i due automi $A'$ e $A''$ usando il non determinismo per scegliere in quale automa finire con una $epsilon$-mossa.

#figure(image("assets/07_unione_NFA.svg"))

Visto che il linguaggio dell'unione deve stare in almeno uno dei due, metto una scommessa all'inizio per vedere se andare nel primo o nel secondo automa. Bella soluzione, funziona, ma non ci piace tanto, come mai?

====== DFA

Non ci piace tanto questa soluzione perché se partiamo da due DFA andiamo a finire in un NFA. Infatti, la componente, non deterministica viene inserita con le due $epsilon$-mosse iniziali. La stessa componente non deterministica l'avremmo inserita con gli stati iniziali multipli, che sarebbero stati in corrispondenza dei due stati iniziali $q'_0$ e $q''_0$ senza lo stato $q_0$.

Se vogliamo rimanere nel mondo DFA dobbiamo unire i due automi con questa costruzione e poi passare al DFA con la costruzione per sottoinsiemi. Il numero di stati dell'NFA è $ nsc(L' union L'') lt.eq 1 + nsc(L') + nsc(L'') , $ quindi con la costruzione per sottoinsiemi arriveremmo ad avere un numero di stati pari a $ sc(L' union L'') lt.eq 2^(nsc(L' union L'')) . $

Questa costruzione è altamente *inefficiente*. Si può fare molto meglio.

====== Automa prodotto

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
    [#figure(image("assets/07_a_m.svg"))], [#figure(image("assets/07_b_n.svg"))],
  )

  Costruiamo l'automa prodotto per il linguaggio $L = L' union L''$.

  #figure(image("assets/07_unione_am_bn.svg"))
]

====== NFA

Negli NFA non abbiamo nessun problema: partiamo da NFA e vogliamo restare in NFA, quindi non servono ulteriori costruzioni per avere un automa di questa classe. Il numero di stati è $ nsc(L' union L'') lt.eq 1 + nsc(L') + nsc(L'') . $ Perdiamo il termine noto di questa quantità se non usiamo $epsilon$-mosse ma stati iniziali multipli.

===== Intersezione

Per l'*intersezione* di linguaggi non dobbiamo definire molto di nuovo.

Per i DFA, possiamo utilizzare la costruzione dell'automa prodotto appena definita modificando l'insieme degli stati finali $F$ rendendolo l'insieme $ F = {(q,p) bar.v q in F' and p in F''} . $

Ma allora la state complexity vale $ sc(L' inter L'') lt.eq sc(L') dot sc(L'') . $

#example()[
  Riprendendo i due linguaggi di prima, l'automa prodotto viene costruito nello stesso modo, ma cambia l'insieme degli stati finali, che si riduce al singleton ${00}$.

  #figure(image("assets/07_intersezione_am_bn.svg"))
]

Per gli NFA, possiamo riutilizzare la costruzione dell'automa prodotto per permetterci di navigare tutte le possibile coppie di cammini, e scommettendo bene su entrambi i cammini possiamo accettare la stringa. Va sistemata un pelo la definizione della funzione di transizione, ma la costruzione rimane uguale. Vale quindi $ nsc(L' inter L'') lt.eq nsc(L') dot nsc(L'') . $

==== Operazioni tipiche

===== Prodotto

Riprendiamo velocemente la definizione di *prodotto* di linguaggi. Dati due linguaggi $L'$ e $L''$, allora $ L' dot L'' = {w bar.v exists x in L' and exists y in L'' bar.v w = x y} . $

Sfruttiamo la rappresentazione black box degli automi: mettendoli in serie utilizzando le $epsilon$-mosse.

#figure(image("assets/07_prodotto.svg"))

In poche parole, ogni volta che arriviamo in uno stato finale di $A'$ facciamo partire la computazione su $A''$, ma in $A'$ andiamo avanti a scandire la stringa. Stiamo scommettendo di essere arrivati alla fine della stringa $x$ e di dover iniziare a leggere la stringa $y$.

Bella costruzione, ma ci va veramente bene una roba del genere?

====== DFA

La risposta, come prima, è *NO*: se partiamo da due DFA andiamo a finire in un NFA, che non ci va bene perché per poi tornare in un DFA ci costa un salto esponenziale. Visto che $ nsc(L' dot L'') = nsc(L') + nsc(L''), $ possiamo dire che $ sc(L' dot L'') lt.eq 2^(nsc(L' dot L'')) . $

Come prima, possiamo ottimizzare questa costruzione, anche se non di molto stavolta.

====== Costruzione senza nome

Il problema dell'esplosione del doppio esponenziale deriva dal fatto che, quando arrivo in uno stato finale del primo automa, devo far partire il secondo automa, ma il primo continua ancora a scandagliare la stringa perché deve scommettere.

La soluzione inefficiente di prima prendeva i due automi $A'$ e $A''$, li univa in un NFA ed effettuava la costruzione per sottoinsiemi. La soluzione che facciamo adesso *incorpora* i sottoinsiemi nei passi del DFA, così da evitare l'esecuzione non deterministica.

Costruisco l'automa $A = (Q, Sigma, delta, q_0, F)$ che, ogni volta che $A'$ finisce in uno stato finale, avvia anche $A''$ dal punto nel quale si trova. Esso è definito da:
- gli *stati* sono tutte le coppie di stati di $A'$ con i sottoinsiemi di $A''$, così da incorporare i sottoinsiemi nel DFA direttamente, ovvero $ Q = Q' times 2^Q'' ; $
- lo *stato iniziale* dipende se siamo già in una configurazione che permette lo start di $A''$, ovvero $ q_0 = cases((q'_0, emptyset.rev) & "se" q'_0 in.not F', (q'_0, {q''_0}) quad & "se" q'_0 in F') ; $
- la *funzione di transizione* deve lavorare sulla prima componente ma anche su tutte quelle presenti nella seconda componente, quindi essa è definita come $ delta((q, alpha), a) = cases((delta'(q,a), {delta''(p,a) bar.v p in alpha}) & "se" delta'(q,a) in.not F', (delta'(q,a), {delta''(p,a) bar.v p in alpha} union {q''_0}) quad & "se" delta'(q,a) in F') ; $
- gli *stati finali* sono quelli nei quali riusciamo ad arrivare con il secondo automa, ovvero $ F = {(q,alpha) bar.v alpha inter F'' eq.not emptyset.rev} . $

La prima componente la mandiamo avanti deterministicamente, ma la manteniamo sempre accesa per far partire la seconda computazione. Quest'ultima è anch'essa deterministica, ma simula un po' il comportamento non deterministico.

Il numero di stati massimo che abbiamo è $ sc(L' dot L'') = sc(L') 2^(sc(L'')) , $ che rappresenta comunque un gap esponenziale ma abbiamo abbassato di un po' la complessità.

====== NFA

Come per l'unione, qua siamo molto tranquilli: partiamo da NFA e arriviamo in NFA, quindi a noi va tutto bene. La state complexity, come visto prima, è $ nsc(L' dot L'') lt.eq nsc(L') + nsc(L'') . $

Piccole osservazioni da aggiungere alla lezione precedente:
- abbiamo un suffisso e un prefisso, ma non sapendo quando finisce il primo e inizia il secondo devo scommettere quando arrivo in uno stato finale del primo automa; ci possono essere tante suddivisioni, devo indovinare quella giusta;
- l'automa $A$ che abbiamo costruito ha una prima parte deterministica, mentre la seconda è sì deterministica ma emula la costruzione per sottoinsiemi;
- non possiamo evitare il salto esponenziale: se concateniamo $(a+b)^*$ con $a (a + b)^(n-1)$ otteniamo il solito $L_n$, che ha bisogno di $2^n$ stati partendo da $n+1$.

===== Chiusura di Kleene

Con questa ultima operazione chiudiamo la dimostrazione del teorema di Kleene.

Questa operazione è definita come $ L^* = union.big_(k gt.eq 0) L^k = {w in Sigma^* bar.v exists x_1, dots, x_k in L bar.v k gt.eq 0 bar.v w = x_1, dots, x_k} . $

Un automa per la star deve cercare di scomporre la stringa in ingresso in più stringhe di $L$. Possiamo prendere spunto dall'automa per la concatenazione: facciamo partire l'automa per $L$, ogni volta che arriviamo in uno stato finale lo facciamo ripartire dallo stato iniziale. Devo accettare anche la parola vuota, quindi aggiungiamo uno stato iniziale finale.

#figure(image("assets/07_kleene.svg"))

Abbiamo bisogno dello stato iniziale $q'_0$ perché dentro l'automa ci possono essere delle transizioni che mi fanno ritornare indietro e mi fanno accettare di più di quello che dovrei.

#example()[
  Consideriamo il seguente automa *sbagliato* per la chiusura di Kleene del linguaggio delle sequenze dispari di $a$ seguite da una $b$. Se vogliamo l'espressione regolare per questo linguaggio, essa è $(a a)^* a b$.

  #figure(image("assets/07_star_errata.svg"))

  Non abbiamo inserito uno stato iniziale aggiuntivo. Che succede? La stringa $a a$ adesso viene accettata, anche se palesemente non appartiene al linguaggio, così come la stringa $a b a a$.

  Un automa per la star di questo linguaggio, inoltre, è molto facile da trovare perché la lettera $b$ fa da marcatore, e il numero di stati rimane quello dell'automa di partenza.

  #figure(image("assets/07_star_corretta.svg"))
]

====== DFA

Ci piace questa soluzione, perché stiamo aumentando solo di uno il numero di stati dell'automa, ma siamo caduti nel non determinismo, e partire da DFA e finire in NFA non ci piace molto.

Purtroppo, come spesso ci succede, per tornare nei DFA dobbiamo, nel caso peggiore, applicare la costruzione per sottoinsiemi e fare un salto esponenziale nel numero degli stati. In poche parole $ sc(L^*) lt.eq 2^(nsc(L^*)) . $

====== NFA

L'abbiamo formulato nella scorsa sezione: se partiamo da NFA otteniamo ancora degli NFA, quindi ci piace, e lo facciamo in modo semplice aggiungendo solo uno stato, ovvero $ nsc(L^*) lt.eq nsc(L) + 1 . $

== Codici

Per ora abbiamo visto l'esempio del linguaggio $L = (a a)^* b$, che era estremamente comodo da scomporre per via della presenza di una sola $b$ nella stringa in input. Vediamo ora qualche altro esempio notevole.

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

A cosa servono i tre esempi che abbiamo introdotto nella sezione precedente?

#definition([Codice])[
  Dato $X subset.eq Sigma^*$, diciamo che $X$ è un *codice* se e solo se $ forall w in X^* quad exists! "decomposizione di" w "come" x_1 dots x_k bar.v x_i in L and k gt.eq 0 . $
]

Dei tre esempi che abbiamo visto, solo i primi due sono dei codici: è facile dimostrare che lo sono, soprattutto il primo per via della $b$ che fa da delimitatore. L'ultimo esempio, invece, abbiamo visto che ha delle stringhe scomponibili in più modi, quindi non è un codice.

Tra tutti i codici a noi interessano quelli che possono essere *decomposti in tempo reale*: essi sono chiamati *codici prefissi*, e sono dei codici tali che $ forall i eq.not j quad x_i "non è prefisso di" x_j . $ In poche parole, il codice contiene parole che *non* sono prefisse di altre. Essi sono i più *efficienti*.

Dei due codici che abbiamo a disposizione, il primo è un codice prefisso: ogni volta che troviamo una $b$ sappiamo che dobbiamo dividere. Il secondo, invece, deve aspettare una $b$ e poi tornare indietro di $3$ posizioni per avere la decomposizione.

== Star height

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

  #figure(image("assets/07_w1.svg"))

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

  #figure(image("assets/07_estese_NFA.svg"))

  Avevamo visto che il complemento non si comportava bene con gli NFA, quindi diamo un DFA, che invece funzionava bene con il complemento.

  #figure(image("assets/07_estese_DFA.svg"))

  Siamo rimasti in un numero di stati accettabile. Andiamo a complementare questo DFA, che manterrà lo stesso numero di stati, fortunatamente.

  #figure(image("assets/07_estese_complemento.svg"))

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
