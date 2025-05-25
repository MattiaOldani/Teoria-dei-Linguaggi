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

= Risultati particolari

== Ricorsione

Visto che i linguaggi DCFL ci consentono l'uso della *ricorsione* essi sono utili per definire i *linguaggi di programmazione*. Come gerarchia abbiamo $ LR(k) subset.eq DCFL subset.eq CFL , $ con la classe $LR(k)$ che indica degli oggetti molto tecnici, poco naturali, che sono usati nei *parser*. Se $k = 1$ allora stiamo considerando direttamente i DCFL.

I PDA li possiamo immaginare come degli automi a stati finiti a cui abbiamo aggiunto una *pila*, ovvero una struttura dati che ci permette di implementare la *ricorsione*. Questo implica che i linguaggi CFL sono i linguaggi regolari a cui è stata aggiunta la ricorsione.

#definition([Grammatiche self-embedding])[
  Prendiamo una grammatica $G = (V, Sigma, P, S)$ context-free. Diciamo che $G$ è *self-embedding* se $ exists A in V bar.v A arrow.stroked^* alpha A beta bar.v alpha,beta in (Sigma union V)^+ . $

  In poche parole, esiste una variabile che ha un albero di derivazione in cui sulle foglie ho due stringhe diverse dalla parola vuota:

  #align(center)[
    #syntree(
      child-spacing: 2em,
      layer-spacing: 2em,
      "[^$A$ $alpha$ $A$ $beta$]",
    )
  ]
]

È importante che entrambe siano diverse dal vuoto:
- se è vuota $alpha$ abbiamo ricorsione all'inizio, che si può eliminare;
- se è vuota $beta$ abbiamo ricorsione in coda, che si può eliminare.

Se anche solo una è vuota non abbiamo più una *vera ricorsione*.

#theorem()[
  Se $G$ non è self-embedding allora $L(G)$ è regolare.
]

Questo teorema ci dice che la $G$ deve usare la ricorsione per generare un linguaggio CFL. Se non la utilizza e alcune cose possono essere eliminate allora collassiamo nei linguaggi regolari.

#corollary()[
  Se $L$ è un linguaggio CFL e non regolare allora ogni $G$ per $L$ è self-embedding.
]

== Linguaggio di Dyck

Per finire, vediamo un risultato che secondo me è veramente fuori di testa.

#definition([Linguaggio di Dyck])[
  Definiamo l'alfabeto $ Omega_k = {"("_1, "("_2, dots "("_k, ")"_1, ")"_2, dots, ")"_k} $ formato da $k$ tipi di *parentesi*. Questo insieme contiene $k$ parentesi aperte e le $k$ parentesi chiuse corrispondenti, quindi $abs(Omega_k) = 2k$.

  Il *linguaggio di Dyck* $ D_k subset.eq Omega_k^* $ è l'insieme delle parentesi bilanciate costruite sull'insieme $Omega_k$.
]

Ora vediamo un teorema ideato dal nostro amico Chomsky e dal franco-tedesco Schutzenberger.

#theorem([Teorema di Chomsky-Schutzenberger])[
  Dato $L subset.eq Sigma^*$ un CFL, allora:
  - $exists k > 0$ numero intero,
  - $exists$morfismo $h : Omega_k arrow.long Sigma^*$,
  - $exists R subset.eq Omega_k^*$ linguaggio regolare

  tali che $ L = h(D_k inter R) . $
]<teorema-bellissimo>

Questo è un *teorema di rappresentazione* ed è fuori di testa: scegliamo un insieme di parentesi, prendiamo il linguaggio di Dyck corrispondente, lo filtriamo con un linguaggio regolare definito sullo stesso linguaggio, applichiamo un morfismo che trasformi le parentesi in altri caratteri e otteniamo un CFL che abbiamo sotto mano.

#example()[
  Definiamo il linguaggio $ L = {a^n b^n bar.v n gt.eq 0} . $

  Possiamo considerare il blocco iniziale di $a$ come se fosse un blocco di parentesi tonde aperte, mentre il blocco finale di $b$ lo vediamo come se fosse un blocco di parentesi tonde chiuse.

  Scegliamo quindi $k = 1$ ottenendo l'insieme $Omega_k = {"("_1, ")"_1}$ e definiamo il morfismo $h$ tale che

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$"("_1 arrow.long a$], [$")"_1 arrow.long b$],
  )

  Tra tutte le stringhe di parentesi tonde bilanciate filtriamo le sequenze in cui le parentesi aperte si trovano prima delle parentesi chiuse, quindi scegliamo $ R = "("^* ")"^* . $
]

#example()[
  Se prendiamo $L$ il linguaggio delle parentesi bilanciate, allora scegliamo l'identità come morfismo e come linguaggio regolare quello che fa passare tutto.
]

#example()[
  Definiamo il linguaggio $ L = {w w^R bar.v w in {a,b}^*} . $

  Possiamo vedere il fattore $w$ come un blocco di parentesi aperte, che poi devono essere chiuse nella seconda metà con $w^R$. Scegliamo quindi $k = 2$, definendo un tipo di parentesi per le $a$ e un tipo per le $b$, Il morfismo è tale che

  #grid(
    columns: (25%, 25%, 25%, 25%),
    align: center + horizon,
    inset: 10pt,
    [$"("_1 arrow.long a$], [$")"_1 arrow.long a$], [$"("_2 arrow.long b$], [$")"_2 arrow.long b$],
  )

  Come espressione regolare ci ispiriamo a quella di prima, quindi scegliamo $ R = bracket "("_1 + "("_2 bracket.r^* bracket ")"_1 + ")"_2 bracket.r^* . $
]

#example()[
  Definiamo infine il linguaggio PAL delle stringhe palindrome di lunghezza anche dispari. Qua dobbiamo modificare leggermente la soluzione precedente

  Scegliamo $k = 4$ usando le parentesi definite prima, alle quali aggiungiamo due parentesi, che usiamo per codificare l'eventuale simbolo centrale, che può essere una $a$ o una $b$, quindi:

  #grid(
    columns: (25%, 25%, 25%, 25%),
    align: center + horizon,
    inset: 10pt,
    [$"("_3 arrow.long a$], [$")"_3 arrow.long epsilon$], [$"("_4 arrow.long b$], [$")"_4 arrow.long epsilon$],
  )

  Come espressione regolare usiamo quella di prima, ma in mezzo possiamo avere una coppia di tipo $3$, una coppia di tipo $4$ oppure niente, quindi $ R = bracket "("_1 + "("_2 bracket.r^* bracket epsilon + "("_3 ")"_3 + "("_4 ")"_4 bracket.r bracket ")"_1 + ")"_2 bracket.r^* . $
]

Se non abbiamo a disposizione un riconoscitore per $L$, ma conosciamo tutto ciò che serve per costruirlo con il @teorema-bellissimo, ovvero conosciamo il morfismo $h$, il linguaggio di Dyck $D_k$ e il linguaggio regolare $R$, possiamo *costruire un riconoscitore* per $L$.

#figure(image("assets/09_macchina.svg", width: 90%))

Come vediamo, prima passiamo per il *morfismo inverso* $h^(-1)$, che viene anche detto *trasduttore*, ed è *non deterministico* perché il morfismo non è per forza iniettivo. Poi, l'input del trasduttore viene passato a due macchine:
- un *automa a pila* per $D_k$;
- un *automa a stati finiti* per $R$.

Se entrambe le macchine rispondono *SI*, facendo un banale $and$, allora $z in L$.

Anche questo fatto è fuori di testa: mi danno un linguaggio $L$ che non conosco, non solo lo posso definire come morfismo di un sottoinsieme di stringhe di parentesi bilanciate, ma posso anche costruire un riconoscitore per $L$ usando gli stessi ingredienti che ho usato per definire il passaggio da parentesi a caratteri di $L$.

Possiamo quindi vedere i *riconoscitori dei CFL* come delle macchine di questo tipo.
