// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Lezione

= Lezione 24 [30/05]

== Breve riassunto

La scorsa volta abbiamo visto il *linguaggio delle computazioni valide* di una MdT, definito sull'alfabeto $ Delta = Q union Gamma union {hash} $ che contiene sequenze di configurazioni alternate dritte e rovesciate, ovvero $ valid(M) = {alpha_1 hash alpha_2^R hash dots hash alpha_k^((R)) bar.v & #align(left)[#enum(numbering: "a.", [$forall i in {1, dots, k} quad alpha_i in Gamma^* Q Gamma^* "configurazione di" M$], [$alpha_1 = q_0 w bar.v w in Sigma^* "configurazione iniziale di" M$], [$alpha_k in Gamma^* F Gamma^* "configurazione finale di" M$], [$forall i in {2, dots, k} quad alpha_(i-1) tack alpha_i$])]} . $

Avevamo dimostrato che $ exists L',L'' in DCFL bar.v valid(M) = L' inter L'' . $

Non abbiamo solo mostrato l'esistenza, ma abbiamo fatto vedere che si possono proprio *costruire*, ovvero esiste un *algoritmo* che costruisce due automi a pila o due grammatiche di tipo $2$ partendo da $M$. Con questa costruzione, unita a quella dell'unione, riuscivamo a rendere non decidibile l'intersezione di DCFL e l'ambiguità di un riconoscitore.

== Altri linguaggi

Prendiamo ora il *complemento* di questo linguaggio, ovvero $ (valid(M))^C = Delta^* slash valid(M) . $

Una stringa, per appartenere a questo linguaggio, deve far cadere almeno una delle *quattro condizioni*, ovvero:
#enum(
  numbering: n => [$not$#str.from-unicode(n + 96).],
  [tra due $hash$ consecutivi o nella prima o nell'ultima configurazione abbiamo $0$ o $2+$ stati, così da non avere una configurazione. Questo controllo lo possiamo fare con una *FSM* che fa da contatore;],
  [nella configurazione iniziale lo stato deve essere diverso da $q_0$, oppure non abbiamo una stringa possibile di input oppure ancora lo stato si trova in posizione diversa, ma comunque utilizziamo un *FSM* di nuovo;],
  [nella configurazione finale lo stato non deve essere finale, quindi ancora una *FSM*;],
  [dobbiamo verificare se $ exists i in {2, dots, k} bar.v not(alpha_(i-1) tack alpha_i) . $ Per verificare questa condizione possiamo usare il *non determinismo* e scommettere quale sia la coppia di configurazioni non valide. Qua è facile usare il non determinismo perché abbiamo un $exists$, quindi è possibile fare delle scommesse.La macchina risultante legge la configurazione scelta e la carica sulla pila, e poi controlla che quella dopo non sia una configurazioni tra le possibili successive. Ci serve allora un *PDA*.],
)

Abbiamo appena mostrato che $ (valid(M))^C in CFL . $

Inoltre, se ci viene data una MdT $M$ abbiamo un *algoritmo* che costruisce un PDA per questo linguaggio, perché basta guardare la descrizione della macchina $M$ per fare tutti i controlli.

== Universalità

Dato un linguaggio $L subset.eq Sigma^*$ CFL, ci chiediamo se $L = Sigma^*$.

Nei linguaggi regolari avevamo risposto positivamente alla domanda, visto che disponevamo della *chiusura rispetto al complemento*. Qua come ci comportiamo?

Per assurdo sia il *problema di universalità* decidibile. Prendiamo come linguaggio $L$ proprio il linguaggio $(valid(M))^C$. Ma questo vuol dire che $ L = Delta^* sse (valid(M))^C = Delta^* sse valid(M) = emptyset.rev sse L(M) = emptyset.rev $ che abbiamo mostrato essere indecidibile, quindi anche l'universalità nei CFL lo è.

== Equivalenza

Dati due linguaggi $L_1$ e $L_2$ CFL, ci chiediamo se $L_1 = L_2$.

Il problema di equivalenza è un *caso generale* del problema di universalità, perché scegliendo $L_2 = Delta^*$ ci possiamo ricollegare al problema precedente.

Addirittura non siamo possiamo rispondere all'*equivalenza con un regolare*, visto che $Delta^*$ è un linguaggio regolare.

== Contenimento

Dati due linguaggi $L_1$ e $L_2$ CFL, ci chiediamo se $L_1 subset.eq L_2$.

Non ho ben capito perché, ma non si può decidere.

== Regolarità

Dato $L$ un CFL, ci chiediamo se il linguaggio $L$ è regolare. Questa domanda è "lecita", visto che i regolari sono un sottoinsieme dei CFL. Il problema sembra molto simile al precedente, ma qua la situazione è leggermente diversa da prima perché in quel caso il linguaggio regolare ci veniva dato.

Per risolvere questo problema ci serve l'operazione di *quoziente tra linguaggi*.

Dati due linguaggi $L_1$ e $L_2$ definiamo l'operazione $ L_1 slash L_2 = {x in Sigma^* bar.v exists y in L_2 bar.v x y in L_1} . $ In poche parole, prendiamo tutte le stringhe nella forma $x y$ di $L_1$ e andiamo a togliere il suffisso $y$ che però dobbiamo trovare in $L_2$.

#example()[
  Ci vengono dati i seguenti linguaggi.

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$L_1 = a^+ b c^+$], [$L_2 = b c^+$], [$L_3 = c^+$],
  )

  Calcoliamo i possibili quozienti di questi linguaggi.

  #table(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$L_1 slash L_2$], [$L_1 slash L_3$], [$L_2 slash L_3$],
    [$a^+$], [$a^+ b c^*$], [$b c^*$],
  )
]

Dato un automa $M = (Q, Sigma, delta, q_0, F)$ che riconosce il linguaggio regolare $L_1$, possiamo costruire un automa $M' = (Q, Sigma, delta, q_0, F')$ tale che $ F' = {q in Q bar.v exists y in L_2 bar.v delta(q, y) in F} . $

In poche parole, rendiamo finali tutti gli stati dai quali, leggendo una stringa di $L_2$, riusciamo a finire in uno stato finale del primo automa.

#grid(
  columns: (50%, 50%),
  align: center + horizon,
  inset: 10pt,
  [#figure(image("assets/24_pre.svg"))], [#figure(image("assets/24_post.svg"))],
)

Questo automa $M'$ che abbiamo appena definito calcola il quoziente, ovvero $ L(M') = L_1 slash L_2 . $

Se il linguaggio $L_1$ è *regolare* anche $L_1 slash L_2$ è *regolare* per ogni $L_2$ possibile. Quindi, dato un linguaggio $L_2$ a caso, per testare se va bene dobbiamo provare qualche stringa di $L_2$.

// Se $L_2$ regolare allora dati automi per $L_1$ e $L_2$ ho un algoritmo per fare un automa per il quoziente

Torniamo al problema di *regolarità*. Abbiamo in input un CFL e vogliamo sapere se è regolare. Se sapessimo rispondere a questa domanda riusciremmo a risolvere il problema di universalità.

Infatti, sia $G = (V, Sigma, P, S)$ una grammatica per $L$. Prendiamo un linguaggio CFL ma non regolare, ovvero $L_0 in CFL slash Reg$ definito da una grammatica $G_0$.

Costruiamo il linguaggio $ L_1 = L_0 hash Sigma^* union Sigma^* hash L $ per il quale possiamo costruire una grammatica $G_1$ che è CF.

Vediamo due casi:
- se $L = Sigma^*$ allora il linguaggio $L_1$ è nella forma $ L_1 = Sigma^* hash Sigma^* $ perché la seconda parte è uguale in entrambe le parti, mentre la prima, dovendo prendere un'unione, la scegliamo come quella che ha più stringhe, quindi proprio $Sigma^*$;
- se invece $L eq.not Sigma^*$ allora esiste una stringa che non sta in $L$, ovvero scegliamo $w in Sigma^* slash L$. In questo caso definiamo il linguaggio $ L_2 = L_1 slash hash w . $ Questo linguaggio è esattamente $L_0$ perché la seconda parte dell'unione non dà contributi. Il linguaggio $L_0$ non è regolare, per ipotesi, quindi non lo è nemmeno $L_1$.

Cosa abbiamo ottenuto: se $L = Sigma^*$ abbiamo mostrato che $L_1$ è regolare, mentre se $L eq.not Sigma^*$ abbiamo ottenuto un non regolare, quindi la discriminante per dire se un linguaggio è regolare è dimostrare l'universalità, ovvero $ L = Sigma^* sse L_1 in Reg . $

Abbiamo detto che il primo problema non è decidibile, quindi non lo è nemmeno questo.

== Regolarità ma peggio

// DA CHIEDERE ASSOLUTAMENTE A PIGHIZZINI

Se il punto precedente vi è sembrato il male, possiamo andare ancora peggio.

Ci viene dato un linguaggio CFL e ci garantiscono che riconosce un linguaggio regolare. Si può costruire un automa equivalente all'automa a pila che viene fornito con il linguaggio?

La risposta è *NO*: non esiste un algoritmo che, dato un PDA per un linguaggio regolare, è in grado di costruire un automa a stati finiti equivalente. Se esistesse un algoritmo di questo tipo riusciremmo a rendere decidibili i *linguaggi non ricorsivi*, ovvero i linguaggi di tipo $0$.

Ci viene data una MdT $M$ per un linguaggio non ricorsivo, ovvero una macchina che risponde *SI*, *NO* oppure va in loop su una stringa data in input.

Ci viene data anche $w in Sigma^*$ e una grammatica $G_w$ per il linguaggio $ (valid(M, w: w))^C . $ Questo linguaggio è esattamente $valid(M)$ dove però l'input viene fissato a $w$, ovvero la configurazione iniziale è $q_0 w$. Ovviamente, prendiamo il *complemento* di questo linguaggio.

Se $w$ viene accettata da $M$ allora abbiamo (almeno) una computazione valida, ovvero $ (valid(M, w: w))^C = Delta^* slash {"computazione valida su" w} . $

Se invece $w$ non viene accettata da $M$ allora $valid(M, w: w)$ è vuoto, ovvero $ (valid(M, w: w))^C = Delta^* $ che è un linguaggio regolare, visto che dobbiamo accettare tutto.

Sappiamo che i linguaggi regolari sono *chiusi* rispetto al complemento, quindi il suo complemento è regolare, ovvero $ (valid(M, w: w))^C in Reg sse valid(M, w: w) in Reg . $

Nei regolari possiamo decidere l'universalità, ma noi sappiamo che $ (valid(M, w: w))^C = Delta^* sse w "accettata da" M $ ma questo non è possibile perché i linguaggi non ricorsivi sono semi-decidibili.

== Regolarità ma ancora peggio

Come *corollario* del punto precedente abbiamo il fatto che, sapendo che un CFL riconosce un regolare e che abbiamo sotto mano l'automa risultante, il suo numero di stati non può essere limitato da alcuna *funzione calcolabile*.

== Riassunto

#table(
  columns: (25%, 25%, 25%, 25%),
  align: center + horizon,
  [*Problema*], [*Regolari*], [*DCFL*], [*CFL*],
  [$L = emptyset.rev$], [#emoji.checkmark.box], [#emoji.checkmark.box], [#emoji.checkmark.box],
  [$L$ finito/infinito], [#emoji.checkmark.box], [#emoji.checkmark.box], [#emoji.checkmark.box],
  [$L = Sigma^*$], [#emoji.checkmark.box], [#emoji.checkmark.box], [#emoji.crossmark],
  [$L_1 = L_2$],
  [#emoji.checkmark.box \ Si usa la riduzione all'automa minimo],
  [#emoji.checkmark.box \ Risolto nel $1992$],
  [#emoji.crossmark \ Non funziona anche con $L_2$ regolare],

  [$L in "Reg"$],
  [#emoji.checkmark.box \ Non diciamo che è decidibile, è direttamente vero],
  [#emoji.checkmark.box \ Si ottiene un automa doppiamente esponenziale nella descrizione della pila],
  [#emoji.crossmark],

  [$L_1 inter L_2 = emptyset.rev$], [#emoji.checkmark.box], [#emoji.crossmark], [#emoji.crossmark],
)
