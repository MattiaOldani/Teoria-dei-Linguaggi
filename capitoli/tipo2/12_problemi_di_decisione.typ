// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Problemi di decisione

Vediamo in questo capitolo qualche *problema di decisione*. Per ora vedremo i problemi a cui sappiamo rispondere con quello che sappiamo, questo perché alcuni dei problemi di decisione richiedono conoscenze delle *macchine di Turing*, che vedremo nell'ultima parte delle dispense.

== Appartenenza

Dato $L$ un CFL e una stringa $x in Sigma^*$, ci chiediamo se $x in L$.

Questo è molto facile: sappiamo che i CFL sono *decidibili* perché lo avevamo mostrato per i linguaggi di tipo $1$. Come *complessità* come siamo messi?

Sia $n = abs(x)$. Esistono algoritmi semplici che permettono di decidere in tempo $ T(n) = O(n^3) . $

L'*algoritmo di Valiant*, quasi incomprensibile, riconduce il problema di riconoscimento a quello di prodotto tra matrici $n times n$, che con l'algoritmo di Strassen possiamo risolvere in tempo $ T(n) = O(n^(log_2(7))) = O(n^(2.81...)) . $

L'algoritmo di Strassen in realtà poi è stato superato da altri algoritmi ben più sofisticati, che impiegano tempo quasi quadratico, ovvero $ T(n) = O(n^(2.3...)) . $

Una domanda aperta si chiede se riusciamo ad abbassare questo bound al livello quadratico, e questo sarebbe molto comodo: infatti, negli algoritmi di parsing avere degli algoritmi quadratici è apprezzabile, e infatti spesso di considerano sottoclassi per avvicinarsi a complessità lineari.

== Linguaggio vuoto e infinito

Sia $L$ un CFL, ci chiediamo se $L eq.not emptyset.rev$ oppure se $abs(L) = infinity$.

Vediamo un teorema praticamente identico a uno che avevamo già visto.

#theorem()[
  Sia $L subset.eq Sigma^*$ un CFL, e sia $N$ la costante del pumping lemma per $L$. Allora:
  + $L eq.not emptyset.rev sse exists z in L bar.v abs(z) < N$;
  + $abs(L) = infinity sse exists z in L bar.v N lt.eq abs(z) < 2N$.
]

Gli algoritmi per verificare la non vuotezza o l'infinità non sono molto efficienti: infatti, prima di tutto bisogna trovare $N$, e se ho una grammatica è facile (basta passare in tempo lineare per la FN di Chomsky), ma se non ce l'abbiamo è un po' una palla. Poi dobbiamo provare tutte le stringhe fino alla costante, che sono $2^N$, e con questo rispondiamo alla non vuotezza. Per l'infinità è ancora peggio.

Si possono implementare delle tecniche che lavorano sul *grafo delle produzioni*, ma sono molto avanzate e (penso) difficili da utilizzare.

== Universalità

Dato $L$ un CFL, vogliamo sapere se $L = Sigma^*$, ovvero vogliamo sapere se siamo in grado di generare tutte le stringhe su un certo alfabeto.

Nei linguaggi regolari passavamo per il complemento per vedere se il linguaggio era vuoto, ma nei CFL *non abbiamo il complemento*, quindi non lo possiamo utilizzare.

Infatti, questo problema *non si può decidere*: non esistono algoritmi che stabiliscono se un PDA riesce a riconoscere tutte le stringhe, o se una grammatica riesce a generare tutte le stringhe.

== Altri problemi

Per vedere altri problemi di decisione sui CFL guardate il capitolo sui *problemi di decisione delle macchine di Turing*.
