// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Esercizi

= Esercizi lezione 21 e 22 [23/05]

== Esercizio 01

#exercise()[
  Considerate il seguente linguaggio: $ L = {a^i b^j a^k b^h bar.v (i = j and k = h) or (i = h and j = k) and i,j,k,h gt.eq 0} . $
]

#request()[
  Il linguaggio $L$ è context-free? Fornite una dimostrazione della risposta.
]

#solution()[
  Un automa a pila per questo linguaggio esegue una scommessa dopo aver caricato tutte le prime $a$ sulla pila:
  - se vale la prima condizione allora deve controllare le seguenti $b$ con le $a$ sulla pila e poi fare lo stesso con gli ultimi due blocchi;
  - se vale la seconda condizione allora carica anche le $b$ sulla pila e poi controlla le seconda $a$ con le $b$ sulla pila e le ultime $b$ con le $a$ sulla pila.
]

#request()[
  Il linguaggio $L$ è context-free deterministico? In questo caso non è richiesta una dimostrazione dettagliata, ma indicate ad alto livello quali argomenti si possono utilizzare per rispondere.
]

#solution()[
  Abbiamo a disposizione quattro criteri:
  - pumping lemma, ma non l'abbiamo visto;
  - dimostrare che $L$ è inerentemente ambiguo, e questo secondo me è vero perché se $i = j = k = h$ abbiamo due modi per riconoscere una stringa;
  - proprietà di chiusura, che però ora non mi viene in mente come fare;
  - usare la relazione $R$, ma anche qua non saprei come usarla.

  Quindi no, $L$ non è deterministico.
]

== Esercizio 02

#exercise()[]

#request()[
  Descrivete un automa a pila two-way che riconosca il linguaggio ${a^n b^m a^n b^m bar.v n,m gt.eq 0}$.
]

#solution()[
  Andiamo per casi in base ai valori di $n$ e $m$.

  [$n,m > 0$]

  Facciamo una prima passata che controlla di avere blocco di $a$, blocco di $b$, blocco di $a$ e infine blocco di $b$. Dopo questo torniamo all'inizio del nastro.

  Carichiamo le $a$ e le $b$ sulla pila, che conterrà quindi tutte le $a$ sotto e tutte le $b$ sopra. Appena leggiamo una $a$ del secondo blocco andiamo in fondo, torniamo indietro controllando le $b$ con le $b$ nella pila e le $a$ con le $a$ nella pila.

  [$n = 0 and m > 0$]

  Se leggo subito una $b$ vuol dire che la stringa è nella forma $ z = b^(2m) . $

  In questo caso dobbiamo solo vedere di avere un numero pari di $b$, che si fa facilmente.

  [$n > 0 and m = 0$]

  Uguale al caso precedente.

  [$n = 0 and m = 0$]

  Devo riconoscere $epsilon$, quindi vuol dire che all'inizio della computazione trovo $rmarker$ sulla testina.

  [Automa completo]

  Con gli stati possiamo codificare questo comportamento, quindi:
  - se leggiamo $rmarker$ accettiamo;
  - se leggiamo una $a$ andiamo a fare la passata per il primo caso e per il terzo caso;
  - se leggiamo una $b$ andiamo a fare la passata per il secondo caso.
]

#request()[
  L'automa ottenuto è deterministico?
]

#solution()[
  L'automa ottenuto è deterministico, visto non scommettiamo ma gestiamo tutto con gli stati.
]

== Esercizio 03

#exercise()[]

#request()[
  Descrivete un automa a pila two-way che riconosca il seguente linguaggio: $ L = {a^i b^j a^k b^h bar.v i,j,k,h gt.eq 0 and (i lt.eq j lt.eq k lt.eq h or i gt.eq j gt.eq k gt.eq k)} . $
]

#solution()[
  Andiamo anche qui per casi. Analizzeremo solo la prima condizione perché la seconda si ottiene nello stesso modo ma ribaltando i controlli.

  [$i,j,k,h > 0$]

  Facciamo una prima passata vedendo che abbiamo la struttura a blocchi e torniamo all'inizio.

  Ora carichiamo le $a$ sulla pila e iniziamo a leggere le $b$: prima di leggere una nuova $a$ devo aver raggiunto il simbolo iniziale della pila. Torniamo poi all'inizio delle $b$ e ripetiamo lo stesso procedimento fatto poco fa.

  [$i = 0 and j,k,h > 0$]

  Qua troviamo subito una $b$, quindi la passata di controllo parte da quel blocco. Il resto poi rimane uguale, visto che abbiamo solo perso una parte iniziale.

  [$i = j = 0 and k,h > 0$]

  Qua troviamo una $a$ come nel primo caso, ma dopo il primo blocco di $b$ troviamo $rmarker$. Il resto rimane uguale, abbiamo solo perso un blocco da controllare.

  [$i = j = k = 0 and h > 0$]

  Idem di due punti fa, ma troviamo $rmarker$ dopo le $b$, e direi che possiamo accettare subito.

  [$i = j = k = h = 0$]

  Sotto la testina abbiamo subito $rmarker$ quindi ci fermiamo e accettiamo.

  [Automa completo]

  Come prima, con gli stati possiamo codificare il comportamento in base ai caratteri che leggiamo all'inizio della computazione. Per la seconda condizione facciamo lo stesso ma dal fondo.
]

#request()[
  L'automa che avete ottenuto è deterministico? Se non è deterministico, riuscite anche ad ottenere un automa a pila two-way deterministico?
]

#solution()[
  L'automa non è deterministico perché all'inizio deve scommettere se stiamo verificando la prima o la seconda condizione. Inoltre, non possiamo trovare un automa deterministico perché $L$ è inerentemente ambiguo (credo).
]

#request()[
  Dimostrate che $L$ non può essere accettato da un automa a pila one-way.
]

#solution()[
  Supponiamo di essere nella prima condizione verificata.

  Se carichiamo le prime $a$ sulla pila poi possiamo verificare che non siano di più delle prime $b$ controllando di arrivare al simbolo iniziale della pila prima di leggere le altre $a$. Facendo questo controllo perdiamo però l'informazione sul numero di $b$.

  Stesso discorso per la seconda condizione da verificare.
]

#request()[
  Descrivete una macchina di Turing per $L$. La macchina ottenuta è un automa limitato linearmente?
]

#solution()[
  Una macchina di Turing per $L$ fa esattamente quello che fa l'automa a pila precedente. Analizziamo solo la prima condizione, la seconda è totalmente analoga.

  [$i,j,k,h > 0$]

  Facciamo una prima passata vedendo che abbiamo la struttura a blocchi e torniamo all'inizio.

  Ora marchiamo una $a$, cerchiamo una $b$, la marchiamo, cerchiamo una $a$, la marchiamo, cerchiamo una $b$ e la marchiamo. Poi ricominciamo. Quando finiamo le lettere di un blocco dobbiamo partire dal successivo. Potrebbe essere utile sapere dove finiscono i vari blocchi di lettere, magari inserendo un carattere extra.

  [$i = 0 and j,k,h > 0$]

  Qua troviamo subito una $b$, quindi la passata di controllo parte da quel blocco. Il resto poi rimane uguale, visto che abbiamo solo perso una parte iniziale.

  [$i = j = 0 and k,h > 0$]

  Qua troviamo una $a$ come nel primo caso, ma dopo il primo blocco di $b$ troviamo $rmarker$. Il resto rimane uguale, abbiamo solo perso un blocco da controllare.

  [$i = j = k = 0 and h > 0$]

  Idem di due punti fa, ma troviamo $rmarker$ dopo le $b$, e direi che possiamo accettare subito.

  [$i = j = k = h = 0$]

  Sotto la testina abbiamo subito $rmarker$ quindi ci fermiamo e accettiamo.

  [Automa completo]

  Come prima, con gli stati possiamo codificare il comportamento in base ai caratteri che leggiamo all'inizio della computazione. Per la seconda condizione facciamo lo stesso ma dal fondo.

  Se intendiamo *automa limitato linearmente* come automa nel quale possiamo scrivere solo sul nastro dove abbiamo l'input, allora si può fare ma è molto complicato. Se invece intendiamo un automa che ha un nastro esterno che è proporzionale alla lunghezza dell'input allora possiamo inserire i marker per dividere i blocchi e farlo come è stato descritto.
]

== Esercizio 04

#exercise()[]

#request()[
  Descrivete un automa a pila two-way deterministico e automa linear bounded in grado di riconoscere il linguaggio ${w w bar.v w in {a,b}^*}$.
]

#solution()[
  Visto a lezione.
]

== Esercizio 05

#exercise()[]

#request()[
  Descrivete un automa a pila two-way deterministico e un automa linear bounded in grado di riconoscere il linguaggio ${w w^R bar.v w in {a,b}^*}$.
]

#solution()[
  Un automa a pila two-way deve:
  - spostarsi a metà stringa con la tecnica vista a lezione;
  - caricare $w^R$ sulla pila, che quindi diventa $w$;
  - spostarsi all'inizio del nastro;
  - controllare la parte iniziale con la pila.

  Un automa linear bounded deve:
  - marcare la prima cella con una $X$ e controllare l'ultima cella, marcandola con una $X$ se i caratteri letti sono uguali;
  - marcare la penultima cella con una $X$ e controllare la seconda cella, marcandola con una $X$ se i caratteri letti sono uguali;
  - ripartire dal punto iniziale ma dalla terza cella.
]

== Esercizio 06

#exercise()[]

#request()[
  Descrivete un automa linear bounded in grado di riconoscere il linguaggio ${a^n^2 bar.v n gt.eq 0}$.

  _Suggerimento_. Si può sfruttare l'uguaglianza $n^2 = sum_(i=1)^n (2i + 1)$, per $n gt.eq 1$.
]

#solution()[
  Non lo so.
]
