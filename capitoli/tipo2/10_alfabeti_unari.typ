// Setup

#import "../alias.typ": *

#import "@preview/lovelace:0.3.0": pseudocode-list

#let settings = (
  line-numbering: "1:",
  stroke: 1pt + blue,
  hooks: 0.2em,
  booktabs: true,
  booktabs-stroke: 2pt + blue,
)

#let pseudocode-list = pseudocode-list.with(..settings)

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"

#import "@preview/syntree:0.2.1": syntree

#import "@preview/lilaq:0.1.0" as lq
#import "@preview/tiptoe:0.3.0" as tp

#import "@preview/fletcher:0.5.5": diagram, node, edge


// Capitolo

= Alfabeti unari

In questo capitolo vediamo alcuni risultati con gli *alfabeti unari*: questi sono alfabeti molto particolari formati da un solo carattere, ovvero sono nella forma $ Sigma = {a} . $

== Linguaggi regolari

Riprendiamo in mano, dopo tanto tempo, gli *automi a stati finiti*. Se rimaniamo nel caso deterministico, da ogni stato di un *DFA* può uscire un solo arco con una certa etichetta, ovvero non posso avere più di $2$ archi uscenti con la stessa etichetta. Avendo ora un solo carattere in $Sigma$ quello che abbiamo è una sequenza (opzionale) di stati che prima o poi sfocia in un *ciclo* (opzionale).

#figure(image("assets/10_DFA_unario.svg", width: 90%))

Notiamo come l'informazione sulle parole diventa *informazione sulla lunghezza* di esse, visto che possiamo riconoscere delle stringhe che seguono un certo pattern di lunghezze.

#example()[
  Vediamo un esempio di automa a stati finiti unario.

  #figure(image("assets/10_esempio.svg"))

  Con questo automa riconosciamo $epsilon$, $a$ e poi quest'ultima a cui aggiungiamo un numero di $a$ uguali alla lunghezza del ciclo, ovvero $ L = {epsilon} union {a^(1 + 3k) bar.v k gt.eq 0} = epsilon + a (a^3)^* . $
]<esempio-iniziale>

Dal punto di vista matematico, possiamo vedere questi automi come delle *successioni numeriche/aritmetiche*, ovvero delle successioni che hanno una parte iniziale e poi un periodo che viene ripetuto.

Nel caso di *NFA* invece abbiamo un grafo arbitrario, che per essere trasformato in DFA richiede meno dei $2^n$ classici della *costruzione per sottoinsiemi*, ovvero ci costa $ e^(n ln(n)) . $ Come vediamo, è una quantità *subesponenziale* ma comunque *superpolinomiale*. Inoltre, questo bound non può essere migliorato, è la soluzione ottimale.

#example()[
  Definiamo tre linguaggi

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$L_1 = a^28 (a^3)^*$], [$L_2 = a^11 (a^3)^*$], [$L_3 = a^37 (a^3)^*$],
  )

  Cosa aggiungono questi linguaggi al linguaggio $L$ dell'@esempio-iniziale?

  Se consideriamo $L_1$ notiamo che $a^28$ può essere anche riconosciuto facendo uno step con una $a$ e poi facendo $9$ cicli da $3$, quindi riusciamo a riconoscerlo anche con $L$. Possiamo fare un discorso praticamente simile con $L_3$. Ma allora questi due linguaggi non aggiungono niente.

  Considerando invece $L_2$ questo aggiunge qualcosa ad $L$ perché riusciamo a riconoscere la stringa $a^10 = a (a^3)^3$ con $L$ ma poi rimane una $a$ fuori, che ci manda in $q_2$ e quindi ci fa accettare di più, o comunque qualcosa di diverso rispetto a $L$.

  Avremmo aggiunto altre informazioni considerando un linguaggio $ L = a^k (a^3)^* bar.v k mod 3 = 0 . $
]

Notiamo che, fissato un periodo, non possiamo unire tanti linguaggi, ma solo quelli che rimangono all'interno delle *classi di resto del periodo*.

== Equivalenza tra linguaggi regolari e CFL

Vediamo ora come si comportano i CFL. Sia $L$ un *CFL unario*, ovvero $ L subset.eq a^* . $

Applichiamo il *pumping lemma* a questo linguaggio. Prendiamo $N$ la *costante del pumping lemma* per i CF per $L$. Questo ci dice che $ forall z in L bar.v abs(z) gt.eq N $ noi possiamo decomporre $z$ come $z = u v w x y$ con:
+ $abs(v w x) lt.eq N$;
+ $v w eq.not epsilon$;
+ $forall i gt.eq 0 quad u v^i w x^i y in L$.

Le stringhe di $L$ sono formate da sole $a$, quindi se scambiamo dei fattori nella stringa non lo notiamo. Modifichiamo l'ultima condizione del pumping lemma con $ forall i gt.eq 0 quad u w y (v x)^i in L . $

Mettendo insieme le prime due condizioni possiamo dire che $ 1 lt.eq abs(v x) lt.eq N . $

La stringa $z$ la possiamo dividere in una *parte fissa* e in una *parte pompabile*, ovvero $ abs(z) = abs(u w y) + abs(v x) = s_z + t_z . $

Grazie alla terza condizione sappiamo che $ forall i gt.eq 0 quad a^(s_z) (a^(t_z))^i in L arrow.long.double a^(s_z) (a^(t_z))^* in L . $

Possiamo fare un'ulteriore divisione, stavolta sulle stringhe di $L$: infatti, possiamo scrivere $L$ come unione di due insiemi $L'$ e $L''$ tali che $ L = L' union L'' . $

Nell'insieme $L'$ mettiamo tutte le stringhe che non fanno parte del pumping lemma, ovvero $ L' = {z in L bar.v abs(z) < N} . $ Nell'insieme $L''$ mettiamo invece tutte le stringhe pompate, ovvero $ L'' = {z in L bar.v abs(z) gt.eq N} subset.eq union.big_(z in L'') a^(s_z) (a^(t_z))^* . $

Analizziamo separatamente i due insiemi:
- $L'$ è un linguaggio *finito*, quindi lo possiamo riconoscere con un automa a stati finiti;
- $L''$ invece sembra un'unione infinita, ma abbiamo visto che il periodo $t_z$ del pumping lemma è boundato con le classi di resto, ovvero $ 1 lt.eq t_z lt.eq N , $ quindi questo linguaggio, che è unione finita di linguaggi regolari, è anch'esso *finito*.

Ma allora il linguaggio $L$ è *regolare*.

#theorem()[
  Sia $L subset.eq a^*$ un CFL. Allora $L$ è regolare.
]

Questo va d'accordo con quello che abbiamo visto nello scorso capitolo: i CFL hanno la *ricorsione*, ma se abbiamo un solo carattere non possiamo aprire e chiudere le parentesi, quindi collassiamo nei linguaggi regolari.

== Teorema di Parikh

Vediamo, per finire, una serie di concetti un po' strani e che non dimostreremo.

#definition([Immagine di Parikh sulle stringhe])[
  Sia $Sigma = {sigma_1, dots, sigma_n}$ un alfabeto. L'*immagine di Parikh* sulle stringhe è la funzione $ psi : Sigma^* arrow.long NN^abs(Sigma) $ tale che $ psi(x) = (hash_(sigma_1) (x), dots, hash_(sigma_n) (x)) . $
]

In poche parole, questa funzione conta le *occorrenze* di ogni lettera di $Sigma$ dentro la stringa $x$.

#example()[
  Definiamo $Sigma = {a, b}$. Data $z = a a b a b a$, calcoliamo $ psi(z) = (4, 2) . $
]

Con l'immagine di Parikh sulle stringhe possiamo definire un insieme di queste immagini.

#definition([Immagine di Parikh])[
  Dato $L$ un linguaggio generico, l'*immagine di Parikh* è l'insieme $ psi(L) = {psi(x) bar.v x in L} . $
]

In poche parole, l'immagine di Parikh è l'insieme di tutte le immagini di Parikh sulle stringhe di $L$.

#example()[
  Vediamo tre linguaggi e le loro immagini di Parikh associate.

  #table(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [*Linguaggio*], [*Immagine di Parikh*],
    [$L = {a^n b^n bar.v n gt.eq 0}$], [${(n,n) bar.v n gt.eq 0}$],
    [$L = a^* b^*$], [${(i,j) bar.v i,j gt.eq 0}$],
    [$L = (a b)^*$], [${(n,n) bar.v n gt.eq 0}$],
  )

  Notiamo come il primo e il terzo insieme sono uguali, anche se vengono generati da due linguaggi gerarchicamente diversi: il primo è un tipo $2$, il terzo è un tipo $3$.
]

L'ultima osservazione fatta genera quello che è il *teorema di Parikh*.

#theorem([Teorema di Parikh])[
  Se $L$ è un CFL allora $exists R$ regolare tale che $ psi(L) = psi(R) . $
]

In poche parole, se non ci interessa l'*ordine* con cui scriviamo i caratteri di una stringa, allora i *linguaggi regolari* e i *CFL* sono la stessa cosa, collassano nella stessa classe.
