// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Lezione

= Lezione 23 [28/05]

== Linguaggi utili

Come vediamo, quando passiamo da una configurazione alla successiva, l'area in cui facciamo i cambiamenti è ristretta: di solito quello che cambia è il simbolo sulla testina, con uno spostamento opzionale di quest'ultima. Questo ci servirà per riconoscere dei linguaggi molto particolari che sono *basati sulle configurazioni*.

Definiamo un nuovo alfabeto $ Upsilon = Gamma union Q union {hash} bar.v hash in.not Gamma union Q . $

Definiamo due linguaggi che sono basati su questo nuovo alfabeto $Upsilon$.

Il primo linguaggio che definiamo è il *primo linguaggio successore* $ L'_"succ" = {alpha hash beta^R bar.v alpha,beta "configurazioni" and alpha tack beta} . $

#example()[
  Prendiamo due configurazioni $alpha$ e $beta$ con $alpha tack beta$ e $beta$ ottenuta dalla funzione di transizione con una mossa che sposta la testina avanti di una posizione.

  Questo vuol dire che $ x q a y tack x b p y $ e quindi che dentro $L'_("succ")$ abbiamo la stringa $ x q a y hash y^R p b x^R . $
]

In che posizione della gerarchia posizioniamo questo linguaggio? Dobbiamo controllare due aspetti:
- $alpha$ e $beta^R$ devono essere due configurazioni, e questo lo possiamo fare con un banale *controllo a stati finiti* che controlli che ci siano dei simboli di $Gamma$, un solo stato, e altri simboli di $Gamma$;
- $alpha tack beta$, ma questo si può fare con un *automa a pila*:
  - durante la prima passata carichiamo sulla pila i vari caratteri e capiamo, usando la funzione di transizione, quale parte della configurazione verrà modificata;
  - leggiamo il separatore $hash$;
  - iniziamo a fare il check della seconda configurazione, che, essendo scritta al contrario, è possibile fare con la pila. Inoltre, sapendo quali porzioni sono cambiate della configurazione, riusciamo a fare un controllo preciso.

Ma allora riusciamo a riconoscere $L'_"succ"$ con un *automa a pila*, addirittura *deterministico*, quindi $ L'_"succ" in DCFL . $

Il secondo linguaggio che definiamo è il *secondo linguaggio successore* $ L''_"succ" = {alpha^R hash beta bar.v alpha,beta "configurazioni" and alpha tack beta} . $

Anche in questo caso il linguaggio può essere riconosciuto da un automa a pila deterministico quindi $ L''_"succ" in DCFL . $

Abbiamo quindi due linguaggi DCFL per i quali riusciamo a costruire due automi a pila deterministici che li riconoscono, conoscendo ovviamente la MdT che definisce la configurazioni. In poche parole, abbiamo un algoritmo che costruisce questi due automi a pila.

Fissiamo ora una MdT $M$ e definiamo il *linguaggio delle computazioni valide* $ valid(M) = {alpha_1 hash alpha_2^R hash dots hash alpha_k^((R)) bar.v & #align(left)[#enum(numbering: "a.", [$forall i in {1, dots, k} quad alpha_i in Gamma^* Q Gamma^* "configurazione di" M$], [$alpha_1 = q_0 w "configurazione iniziale di" M$], [$alpha_k = x q y "configurazione finale di" M$], [$forall i in {2, dots, k} quad alpha_(i-1) tack alpha_i$])]} . $

In poche parole abbiamo "esteso" i due linguaggi precedenti, formando una *catena di configurazioni* ove la prima è una configurazione iniziale, l'ultima è una configurazione finale e in ogni coppia di configurazioni consecutive la seconda segue la prima. Questa catena di configurazioni le alterna dritte, in *posizione dispari*, e rovesciate, in *posizione pari*.

Come possiamo riconoscere questo linguaggio? Vediamo le singole condizioni:
#enum(
  numbering: "a.",
  [per la *prima condizione* ci basta una *FSM* che controlli che tra ogni coppia di $hash$ ci sia un solo stato, e che anche la prima e l'ultima configurazione abbiano un solo stato nella loro stringa. In poche parole, adattiamo il controllo a stati finiti che avevamo definito per $L'_"succ"$;],
  [per la *seconda condizione* ci basta adattare leggermente la *FSM* che abbiamo costruito per la prima condizione;],
  [per la *terza condizione* facciamo lo stesso della seconda condizione;],
  [per la *quarta condizione* possiamo riciclare il *PDA* che avevamo per $L'_"succ"$ o per $L''_"succ"$ ma solo quando abbiamo due configurazioni e basta, perché quando ne abbiamo di più e controlliamo due configurazioni consecutive usiamo la pila a disposizione ma perdiamo l'informazione per controllare quella ancora successiva.],
)

Quindi sicuramente serve almeno un *LBA* per riconoscere questo linguaggio.

Come possiamo fare? Proviamo a *scomporre* l'ultima condizione in due parti:
- condizione $d'$ che definisce la consecutività di due configurazioni ove la seconda ha un *indice pari* nella sequenza, ovvero $ forall i "pari" quad alpha_(i-1) tack alpha_i ; $
- condizione $d''$ che fa lo stesso ma lo fa per tutti gli *indici dispari*, ovvero $ forall i "dispari" quad alpha_(i-1) tack alpha_i . $

Queste singole condizioni possono essere verificate con i *DPDA* che abbiamo costruito prima per i linguaggi successore. Definiamo i linguaggi $ L' = {(a) and (b) and (c) and (d')} \ L'' = {(a) and (b) and (c) and (d'')} $ che *rispettano le condizioni* indicate. Abbiamo detto prima che questi due linguaggi sono *DCFL*. Se imponiamo che entrambe le condizioni siano verificate otteniamo il linguaggio delle computazioni valide, ovvero $ valid(M) = L' inter L'' . $

Per le proprietà di (non) chiusura dei DCFL, questa intersezione *non è DCFL*.

== Problemi di decisione

Le MdT sono molto utili come *strumento* per dimostrare che alcuni *problemi di decisione CFL* non possono essere risolti, perché se lo fossero allora potremmo risolvere alcuni *problemi di decisione sulle MdT* che non possono invece essere risolti.

Visto che una MdT ogni tanto può entrare in *loop* esistono molti problemi di decisione che non possiamo purtroppo decidere. Vediamo due famosi problemi di (non) decisione sulle MdT.

#definition([Problema dell'arresto o HALT])[
  Il *problema dell'arresto* ha come input una MdT $M$ e una stringa $w in Sigma^*$ e si chiede se $M$ termina su input $w$.

  Per risolvere questo problema, visto che una MdT è una macchina universale, possiamo eseguire con una MdT la macchina $M$ che ci viene fornita su input $w$ e vedere se termina, ma questo non lo possiamo sapere: infatti, se la macchina non ci dà risposta è perché sta ancora facendo dei conti o è perché è andata in loop?
]

#definition([Vuotezza])[
  Il *problema della vuotezza* ha come input una MdT $M$ e si chiede se $ L(M) = emptyset.rev . $

  Avevamo visto che questo problema era decidibile nelle tipo $3$ e nelle tipo $2$ grazie al pumping lemma, ma in questo caso non lo possiamo decidere.
]

Di questi due *problemi indecidibili* useremo praticamente sempre l'ultimo.

=== Intersezione vuota di DCFL

Riprendiamo il linguaggio $valid(M)$. Abbiamo detto che, data una MdT $M$, riusciamo a costruire algoritmicamente due automi a pila che riconoscono $L'$ e $L''$. Abbiamo poi detto che $valid(M)$ è l'intersezione di questi due linguaggi.

Osservando questa intersezione, se la vediamo vuota possiamo concludere che allora il linguaggio $valid(M)$ delle computazioni valide è vuoto, ovvero $ L' inter L'' = emptyset.rev sse valid(M) = emptyset.rev sse L(M) = emptyset.rev . $

Ma abbiamo detto che questo non lo possiamo decidere in una MdT, quindi non è possibile decidere se l'intersezione di due linguaggi DCFL è vuota.

=== Linguaggio ambiguo

Con l'intersezione di due DCFL non ci è andata molto bene, quindi ora proviamo con l'*unione*. Dati allora i due linguaggi $L'$ e $L''$ DCFL di prima definiamo il linguaggio $ Xi = L' union L'' . $

Per riconoscere questo linguaggio potremmo costruire un riconoscitore $A$ non deterministico che all'inizio usa una $epsilon$-mossa per far partire in parallelo i due *DPDA* e vedere se almeno uno dei due riconosce la stringa che viene data in input.

#figure(image("assets/23_riconoscitore_xi.svg", width: 75%))

I due linguaggi $L'$ e $L''$ sono *DCFL*, quindi hanno una sola computazione accettante, ma con $A$ potremmo invece avere *ambiguità* perché abbiamo inserito due $epsilon$-mosse e quindi riconoscere la stringa in due modi diversi.

Esistono delle *stringhe ambigue* nel linguaggio $Xi$, o in altri termini, il linguaggio $Xi$ è *ambiguo*?

Vediamo la catena di implicazioni: $ Xi "ambiguo" &sse exists x bar.v x "ha due computazioni accettanti in" A sse \ &sse x in L' inter L'' sse x in valid(M) sse valid(M) eq.not emptyset.rev . $

Ma siamo al punto di prima: non potendo decidere la vuotezza, e quindi anche la non vuotezza, non è possibile decidere se un linguaggio CFL è ambiguo o no. Questa proprietà si trasporta quindi di conseguenza anche sui DCFL.
