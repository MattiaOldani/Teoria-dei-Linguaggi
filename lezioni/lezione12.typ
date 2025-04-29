// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.3"


// Lezione

= Lezione 12 [04/04]

== Problemi di decisione per i linguaggi regolari

I *problemi di decisione* sono dei problemi che hanno come unica risposta *SI* oppure *NO*. Sui linguaggi regolari abbiamo una serie di problemi di decisione interessanti che possono essere risolti in maniera automatica. Questa lista di problemi diventerà ancora più briosa quando andremo nei linguaggi context-free.

=== Linguaggio vuoto e infinito

Dato un linguaggio $L$ possiamo chiederci se $L eq.not emptyset.rev$, ovvero se $L$ *non è vuoto*, o se $L$ è *infinito*.

#lemma()[
  Sia $L$ un linguaggio regolare e sia $N$ la costante del pumping lemma per $L$. Allora:
  + $L eq.not emptyset.rev sse L$ contiene almeno una stringa di lunghezza $< N$;
  + $L$ è infinito $sse L$ contiene almeno una stringa $z$ con $N lt.eq abs(z) < 2N$.
]

#lemma-proof()[
  Partiamo con la dimostrazione del punto $1$.

  [$arrow.long.double.l$] Se $L$ contiene una stringa di lunghezza $< N$ allora banalmente $L eq.not emptyset.rev$.

  [$arrow.long.double$] Se $L eq.not emptyset.rev$ sia $z in L$ la stringa di lunghezza minima in $L$. Per assurdo sia $abs(z) gt.eq N$, ma allora per il pumping lemma possiamo dividere $z$ come $z = u v w$. Sappiamo dal terzo punto che possiamo ripetere un numero arbitrario di volte la stringa $v$ e stare comunque in $L$. Ripetiamo $v$ un numero di volte pari a $0$: otteniamo la stringa $z' = u w$ che appartiene a $L$ per il pumping lemma. Avevamo detto che $z$ era la stringa più corta di $L$, ma abbiamo appena mostrato che $abs(z') < abs(z)$: questo è assurdo e quindi $abs(z) < N$.

  Dimostriamo ora il punto $2$.

  [$arrow.long.double.l$] Se $L$ contiene una stringa $z$ di lunghezza $N lt.eq abs(z) lt.eq 2N$, visto che $abs(z) gt.eq N$ applichiamo il pumping lemma per scomporre $z$ in $z = u v w$. Per il terzo punto possiamo ripetere un numero arbitrario di volte il fattore $v$ e rimanere comunque in $L$. Ma allora $L$ è infinito.

  [$arrow.long.double$] Se $L$ è infinito, sicuramente esiste una stringa $z$ che è lunga almeno $N$. Tra tutte queste stringhe, scegliamo la più corta di tutte. Per assurdo sia $abs(z) gt.eq 2N$, ma allora possiamo scomporre $z$ come $z = u v w$ con $abs(u v) lt.eq N$ e $v eq.not epsilon$. Adesso andiamo a ripetere un numero di volte pari a $0$ il fattore $v$, ottenendo $z' = u w in L$. Quale è la sua lunghezza? Possiamo dire che $abs(z') = abs(z) - abs(v)$ ma $abs(v)$ è al massimo $N$ per il primo punto analizzato, quindi $abs(z')$ è almeno $N$ e al massimo $2N$, ma questo è assurdo perché $z$ era la più corta tra tutte le stringhe e, per assurdo, l'avevamo posta di lunghezza $gt.eq 2N$.
]

Questo lemma ci dice che se vogliamo sapere se un linguaggio non è vuoto basta generare tutte le stringhe di lunghezza fino a $N$ escluso e vedere se ne abbiamo una nel linguaggio, mentre se vogliamo sapere se un linguaggio è infinito basta generare tutte le stringhe di lunghezza compresa tra $N$ incluso e $2N$ escluso e vedere se ne abbiamo una nel linguaggio.

Quale è il problema? Sicuramente è un approccio *inefficiente*, visto che dobbiamo generare un numero esponenziale di casi da analizzare. Possiamo fare di meglio? *SI*: per vedere se un linguaggio non è vuoto devo cercare un *cammino* dallo stato iniziale ad uno stato finale, mentre per vedere se un linguaggio è infinito potrei cercare i *cicli* sui cammini del punto precedente. Ci siamo quindi ricondotti a dei *problemi su grafi*, che sappiamo risolvere efficientemente.

=== Appartenenza

Dato $L$ un linguaggio regolare e $x in Sigma^*$ una stringa, il problema di *appartenenza* si chiede se $x in L$. Questo lo sappiamo fare tranquillamente in tempo lineare: basta eseguire il DFA (se ce l'abbiamo) e vedere se finiamo in uno stato finale.

=== Universalità

Dato $L$ un linguaggio regolare, il problema di *universalità* si chiede se $L = Sigma^*$, ovvero $L$ contiene tutte le stringhe della chiusura di Kleene dell'alfabeto $Sigma$. Questo sembra difficile, ma possiamo sfruttare le operazioni che rendono chiusi i linguaggi regolari: infatti, possiamo chiederci invece se $ L = Sigma^* sse L^C = emptyset.rev $ e questo lo sappiamo fare grazie al lemma precedente.

=== Inclusione e uguaglianza

Infine, l'ultimo problema che vediamo prende due linguaggi $L_1$ e $L_2$ regolari e si chiede se $L_1 subset.eq L_2$. Questo problema si chiama problema dell'*inclusione* e lo possiamo risolvere manipolando quello che ci viene chiesto: infatti, al posto dell'inclusione, possiamo chiederci se $ L_1 subset.eq L_2 sse L_1 inter L_2^C = emptyset.rev , $ che sappiamo fare tranquillamente grazie al lemma.

Se non volessimo utilizzare le proprietà di chiusura, possiamo costruire un *automa prodotto* che ha come stati finali tutte le coppie di stati dove il primo accetta $L_1$ e il secondo rifiuta $L_2$.

E se invece volessimo risolvere il problema di *uguaglianza*, ovvero quello che si chiede se $L_1 = L_2$? Basta dimostrare la doppia inclusione $L_1 subset.eq L_2 and L_2 subset.eq L_1$ e siamo a cavallo. Un algoritmo diverso utilizza le classi di equivalenza, ma non lo vedremo.

== Varianti di automi

Per finire questa lezione infinita, vediamo qualche *variante* di automi.

=== Automi pesati

La prima variante che vediamo sono gi *automi pesati*. Essi associano ad ogni transizione un peso. Il *peso di una stringa* viene calcolato come la somma dei pesi delle transizioni che la stringa attraversa per essere accettata. Questo peso poi può essere usato in problemi di ottimizzazione, come trovare il cammino di peso minimo, ma questo ha senso solo su NFA.

=== Automi probabilistici

Un tipo particolare di automi pesati sono gli *automi probabilistici*, che come pesi sulle transizioni hanno la probabilità di effettuare quella transizione. Visto che parliamo di *probabilità*, i pesi sono nel range $[0,1]$ e, dato uno stato, tutte le transizioni uscenti sommano a $1$. In realtà, potremmo sommare a meno di $1$ se nascondiamo lo stato trappola. Con questi automi possiamo chiederci con che probabilità accettiamo una stringa.

Questi automi li possiamo usare come *riconoscitori a soglia*: tutte le parole oltre una certa soglia le accettiamo, altrimenti le rifiutiamo.

Questi automi comunque non sono più potenti dei DFA: si può dimostrare che se la soglia $lambda$ è *isolata*, ovvero nel suo intorno non cade nessuna parola, allora possiamo trasformare questi automi probabilistici in DFA. Se la soglia non è isolata riusciamo a riconoscere una strana classe di linguaggi, che però ora non ci interessa.
