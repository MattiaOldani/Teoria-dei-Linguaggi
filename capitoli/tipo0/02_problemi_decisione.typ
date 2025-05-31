// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Problemi di decisione

Abbiamo visto che la computazione di una MdT è un susseguirsi di *configurazioni*, che racchiudono l'input, lo stato corrente della macchina e anche la posizione della testina, implicitamente usando una divisione della stringa di input.

Quando però passiamo da una configurazione alla successiva, l'area in cui facciamo i cambiamenti è ristretta: di solito quello che cambia è il simbolo sulla testina, con uno spostamento opzionale di quest'ultima.

== Definizioni preliminari

Quanto detto fin'ora ci servirà per riconoscere dei linguaggi molto particolari che sono *basati sulle configurazioni* di una MdT generica.

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

Fissiamo ora una MdT $M$ e definiamo il *linguaggio delle computazioni valide* $ valid(M) = {alpha_1 hash alpha_2^R hash dots hash alpha_k^((R)) bar.v & #align(left)[#enum(numbering: "a.", [$forall i in {1, dots, k} quad alpha_i in Gamma^* Q Gamma^* "configurazione di" M$], [$alpha_1 = q_0 w bar.v w in Sigma^* "configurazione iniziale di" M$], [$alpha_k = Gamma^* F Gamma^* "configurazione finale di" M$], [$forall i in {2, dots, k} quad alpha_(i-1) tack alpha_i$])]} . $

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

Come possiamo fare? Proviamo a *scomporre* l'ultima condizione in due parti
- condizione $d'$ che definisce la consecutività di due configurazioni ove la seconda ha un *indice pari* nella sequenza, ovvero $ forall i "pari" quad alpha_(i-1) tack alpha_i ; $
- condizione $d''$ che fa lo stesso ma lo fa per tutti gli *indici dispari*, ovvero $ forall i "dispari" quad alpha_(i-1) tack alpha_i . $

Queste singole condizioni possono essere verificate con i *DPDA* che abbiamo costruito in maniera *algoritmica* prima per i linguaggi successore. Definiamo i linguaggi $ L' = {(a) and (b) and (c) and (d')} \ L'' = {(a) and (b) and (c) and (d'')} $ che *rispettano le condizioni* indicate. Abbiamo detto prima che questi due linguaggi sono *DCFL*. Se imponiamo che entrambe le condizioni siano verificate otteniamo il linguaggio delle computazioni valide, ovvero $ valid(M) = L' inter L'' . $

Per le proprietà di (non) chiusura dei DCFL, questa intersezione *non è DCFL*.

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

#figure(image("assets/02_riconoscitore_xi.svg", width: 75%))

I due linguaggi $L'$ e $L''$ sono *DCFL*, quindi hanno una sola computazione accettante, ma con $A$ potremmo invece avere *ambiguità* perché abbiamo inserito due $epsilon$-mosse e quindi riconoscere la stringa in due modi diversi.

Esistono delle *stringhe ambigue* nel linguaggio $Xi$, o in altri termini, il linguaggio $Xi$ è *ambiguo*?

Vediamo la catena di implicazioni: $ Xi "ambiguo" &sse exists x bar.v x "ha due computazioni accettanti in" A sse \ &sse x in L' inter L'' sse x in valid(M) sse valid(M) eq.not emptyset.rev . $

Ma siamo al punto di prima: non potendo decidere la vuotezza, e quindi anche la non vuotezza, non è possibile decidere se un linguaggio CFL è ambiguo o no. Questa proprietà si trasporta quindi di conseguenza anche sui DCFL.

=== Universalità

Dato un linguaggio $L subset.eq Sigma^*$ CFL, ci chiediamo se $L = Sigma^*$.

Nei linguaggi regolari avevamo risposto positivamente alla domanda, visto che disponevamo della *chiusura rispetto al complemento*. Qua come ci comportiamo?

Per assurdo sia il *problema di universalità* decidibile. Prendiamo come linguaggio $L$ proprio il linguaggio $(valid(M))^C$. Ma questo vuol dire che $ L = Delta^* sse (valid(M))^C = Delta^* sse valid(M) = emptyset.rev sse L(M) = emptyset.rev $ che abbiamo mostrato essere indecidibile, quindi anche l'universalità nei CFL lo è.

=== Equivalenza

Dati due linguaggi $L_1$ e $L_2$ CFL, ci chiediamo se $L_1 = L_2$.

Il problema di equivalenza è un *caso generale* del problema di universalità, perché scegliendo $L_2 = Delta^*$ ci possiamo ricollegare al problema precedente.

Addirittura non siamo possiamo rispondere all'*equivalenza con un regolare*, visto che $Delta^*$ è un linguaggio regolare.

=== Contenimento

Dati due linguaggi $L_1$ e $L_2$ CFL, ci chiediamo se $L_1 subset.eq L_2$.

Non ho ben capito perché, ma non si può decidere.

=== Regolarità

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
  [#figure(image("assets/02_pre.svg"))], [#figure(image("assets/02_post.svg"))],
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

=== Regolarità ma peggio

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

=== Regolarità ma ancora peggio

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
