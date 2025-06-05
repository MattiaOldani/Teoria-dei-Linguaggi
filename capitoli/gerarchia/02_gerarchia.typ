// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import "@preview/cetz:0.3.4"


// Capitolo

= Gerarchia di Chomsky

Vogliamo cercare di rappresentare in maniera *finita* un oggetto potenzialmente *infinito*, come ad esempio un *linguaggio*. Per fare ciò, abbiamo a nostra disposizione due modelli potenti:
- il *modello generativo* fornisce delle regole che, applicate da un certo punto di partenza, generano tutte le parole di un linguaggio;
- il *modello riconoscitivo* utilizza un modello di calcolo che prende in input una parola e ci dice se appartiene o meno al linguaggio.

#example()[
  Consideriamo il linguaggio sull'alfabeto $Sigma = {(,)}$ delle parole ben bilanciate.

  Un *modello generativo* per questo linguaggio deve applicare delle regole a partire da una *sorgente* $S$ per derivare tutte le parole del linguaggio. Le regole potrebbero essere:
  - la parola vuota $epsilon$ è ben bilanciata;
  - se $x$ è ben bilanciata, allora anche $(x)$ è ben bilanciata;
  - se $x$ e $y$ sono ben bilanciate, allora anche $x y$ è ben bilanciata.

  Un *modello riconoscitivo* per questo linguaggio è una black-box che, presa una parola, ci dice se essa appartiene o meno al linguaggio. In realtà questa macchina potrebbe *non terminare* mai, ma ne parleremo più in fondo in questo capitolo. Una macchina per questo linguaggio deve verificare i seguenti fatti:
  - il numero di parentesi aperte è uguale al numero di parentesi chiuse, quindi $ hash_("(") (x) = hash_(")") (x) ; $
  - considerato ogni prefisso, il numero di parentesi aperte non deve superare il numero di parentesi chiuse, quindi $ forall y in Sigma^* bar.v x = y z quad hash_("(") (y) lt.eq hash_(")") (y) . $
]<esempio-tonde-bilanciate>

== Grammatiche

Le *grammatiche* sono un modello generativo molto potente: vediamo come sono definite.

#definition([Grammatica])[
  Una *grammatica* è una quadrupla $(V, Sigma, P, S)$ definita da:
  - $V$ *insieme finito* e *non vuoto* di *variabili*. Sono anche dette *simboli non terminali* (o meta-simboli) e sono usate durante il processo di generazione delle parole del linguaggio;
  - $Sigma$ *insieme finito* e *non vuoto* di *simboli terminali*. Sono chiamati così perché appaiono nelle parole generate, a differenza delle variabili che invece non possono essere presenti;
  - $P$ *insieme finito* e *non vuoto* di *regole di produzione*;
  - $S in V$ *simbolo iniziale* o *assioma*, il punto di partenza della generazione.
]

Soffermiamoci brevemente sulle *regole di produzione*: esse sono nella forma $ alpha arrow.long beta bar.v alpha in (V union Sigma)^+ and beta in (V union Sigma)^* . $ La notazione $()^+$ è praticamente l'insieme $()^*$ senza la parola vuota.

Una *regola di produzione* viene letta come _"se ho $alpha$ allora posso sostituirlo con $beta$"_.

L'applicazione delle regole di produzione è alla base del *processo di derivazione*: esso è formato infatti da una serie di *passi di derivazione*, che permettono di generare una parola del linguaggio.

#definition([Derivazione in un passo])[
  Date le stringhe $x,y in (V union Sigma)^*$ diciamo che $x$ *deriva* $y$ *in un passo*, e si indica con $ x arrow.stroked y $ se e solo se $ exists (alpha arrow.long beta) in P quad exists eta, delta in (V union Sigma)^* bar.v x = eta alpha delta and y = eta beta delta . $
]

Possiamo estendere questa definizione ad un numero definito o arbitrario di passi.

#definition([Derivazione in $k$ passi])[
  Date le stringhe $x,y in (V union Sigma)^*$ diciamo che $x$ *deriva* $y$ *in* $k gt.eq 0$ *passi*, e si indica con $ x arrow.stroked^k y $ se e solo se $ exists x_0, dots, x_k in (V union Sigma)^* bar.v x = x_0 and y = x_k and (forall i in {1, dots, k} quad x_(i-1) arrow.stroked x_i) . $
]

Con questa definizione, se contiamo $k = 0$ andiamo a derivare $x$ da sé stessa, ma questo caso lo usiamo solo per comodità, non ha una vera e propria applicazione pratica.

Quando *non abbiamo indicazioni* sul numero di passi possiamo:
- usare la notazione $ x arrow.stroked^* y $ per indicare un processo di derivazione che avviene in un *numero generico di passi*, e questo vale se e solo se $ exists k gt.eq 0 bar.v x arrow.stroked^k y ; $
- usare la notazione $ x arrow.stroked^+ y $ per indicare un processo di derivazione che avviene in *almeno un passo*, e questo vale se e solo se $ exists k > 0 bar.v x arrow.stroked^k y . $

#definition([Linguaggio generato da una grammatica])[
  Il *linguaggio generato* dalla grammatica $G$ è l'insieme $ L(G) = {w in Sigma^* bar.v S arrow.stroked^* w} . $
]

In poche parole, $L(G)$ è l'insieme di tutte le stringhe $w$ che si possono ottenere in un certo numero di passi di derivazione a partire dall'assioma $S$ della grammatica. Notiamo che le stringhe che otteniamo sono formate dai soli *caratteri terminali*. Le stringhe intermedie che utilizziamo invece nei vari passi di derivazione sono dette *forme sentenziali*.

#definition([Grammatiche equivalenti])[
  Due grammatiche $G_1$ e $G_2$ sono *equivalenti* se e solo se $ L(G_1) = L(G_2) . $
]

Vediamo qualche grammatica come esempio.

#example()[
  Riprendiamo il linguaggio dell'@esempio-tonde-bilanciate.

  Possiamo definire una grammatica che ha le seguenti regole di produzione:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long epsilon$], [$S arrow.long (S)$], [$S arrow.long S S$],
  )
]

#example()[
  Sia $G = ({S,A,B}, {a,b}, P, S)$ una grammatica con le seguenti regole di produzione:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long a B bar.v b A$], [$A arrow.long a bar.v a S bar.v b A A$], [$B arrow.long b bar.v b S bar.v a B B$],
  )

  Questa grammatica genera il linguaggio $ L(G) = {w in Sigma^* bar.v hash_a (w) = hash_b (w)} . $ Infatti, ogni forma sentenziale $w$ che generiamo è tale che $ hash_({a,A})(w) = hash_({b,B})(w) $ e questa relazione viene poi mantenuta trasformando tutte le $A$ e le $B$ nei relativi simboli terminali $a$ e $b$.
]

#example()[
  Definiamo ora la grammatica $G = ({S,A,B,C,D,E}, {a,b}, P, S)$ che contiene le seguenti regole di produzione:

  #grid(
    columns: (33%, 33%, 33%),
    align: center + horizon,
    inset: 10pt,
    [$S arrow.long A B C$], [$A B arrow.long epsilon bar.v a A D bar.v b A E$], [$D C arrow.long B a C$],
    [$E C arrow.long B b C$], [$D a arrow.long a D$], [$D b arrow.long b D$],
    [$E a arrow.long a E$], [$E b arrow.long b E$], [$C arrow.long epsilon$],
  )

  #v(-10pt)

  #grid(
    columns: (50%, 50%),
    align: center + horizon,
    inset: 10pt,
    [$a B arrow.long B a$], [$b B arrow.long B b$],
  )

  Generando qualche parola ci si accorge che questa grammatica genera il *linguaggio pappagallo*, definito come $ L(G) = {w w bar.v w in Sigma^*} . $
]

== Gerarchia di Chomsky

Negli anni $'50$ *Noam Chomsky* studia la generazione dei linguaggi formali e crea una *gerarchia di grammatiche formali* che si basa sulla forma delle *regole di produzione* che definiscono la grammatica.

#table(
  columns: (26%, 46%, 28%),
  inset: 10pt,
  align: center + horizon,
  [*Grammatica*], [*Regole*], [*Riconoscitore*],
  [*Tipo 0*], [Nessuna restrizione], [*Macchine di Turing*],
  [*Tipo 1* \ *Context-sensitive* \ Dipendenti dal contesto],
  [Se $(alpha arrow.long beta) in P$ allora $abs(alpha) lt.eq abs(beta),$ ovvero devo generare parole che *non sono più corte* di quella di partenza \ Sono dette *dipendenti dal contesto* perché ogni regola $(A arrow.long B) in P$ può essere riscritta come $alpha_1 A alpha_2 arrow.long alpha_1 B alpha_2$, con $alpha_1, alpha_2 in (V union Sigma)^*$ che rappresentano il *contesto*, $A in V$ e $B in (V union Sigma)^+$],
  [*Automi limitati linearmente*],

  [*Tipo 2* \ *Context-free* \ Libere dal contesto],
  [Le regole in $P$ sono del tipo $alpha arrow.long beta$ con $alpha in V$ e $beta in (V union Sigma)^+$],
  [*Automi a pila*],

  [*Tipo 3* \ *Regolari*],
  [Le regole in $P$ sono del tipo $A arrow.long a B bar.v a$ con $A,B in V$ e $a in Sigma$],
  [*Automi a stati finiti*],
)

La gerarchia che ha definito Chomsky è *propria*, ovvero: $ L_3 subset L_2 subset L_1 subset L_0. $

Come vedremo alla fine di questo capitolo, questa gerarchia *non esaurisce* tutti i linguaggi possibili: esistono infatti linguaggi che non sono descrivibili in maniera finita con le grammatiche.

#v(12pt)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    circle((4.5, 0), radius: (6.75, 4), fill: red.lighten(25%))
    circle((3, 0), radius: (5, 3), fill: orange.lighten(25%))
    circle((1.5, 0), radius: (3.25, 2), fill: yellow.lighten(25%))
    circle((0, 0), radius: (1.5, 1), fill: green.lighten(25%))

    content((0, 0), [*Tipo* $bold(3)$])
    content((3, 0), [*Tipo* $bold(2)$])
    content((6.25, 0), [*Tipo* $bold(1)$])
    content((9.5, 0), [*Tipo* $bold(0)$])
  })
]

#v(12pt)

#definition([Tipo di una grammatica])[
  Sia $L subset.eq Sigma^*$ un linguaggio. Allora $L$ è di tipo $i$ se e solo se esiste una grammatica $G$ di tipo $i$ tale che $ L = L(G) . $
]

La gerarchia data considera dei *modelli deterministici*, ma come cambia considerando invece dei *modelli non deterministici*? Sappiamo che:
- le grammatiche di tipo $3$ mantengono la stessa potenza computazionale, pagando un costo in termini di descrizione, quindi in *numero di stati*;
- le grammatiche di tipo $2$ hanno il modello non deterministico strettamente più potente;
- le grammatiche di tipo $1$ sono abbastanza complicate;
- le grammatiche di tipo $0$, come quelle regolari, mantengono la stessa potenza computazionale.

Il non determinismo comunque è una nozione del *riconoscitore* che sto usando:
- nel determinismo il riconoscitore può fare una scelta alla volta;
- nel non determinismo può fare più scelte contemporaneamente.

Nelle grammatiche è difficile catturare questa nozione, perché esse lo hanno *intrinsecamente*, perché le derivazioni le applico tutte assieme per ottenere le stringhe del linguaggio.

== Decidibilità

Se una grammatica é di tipo $1$ allora possiamo costruire una macchina che sia in grado di dire, in tempo finito, se una parola appartiene o meno al linguaggio generato da quella grammatica. Questa macchina è detta *verificatore*, e si dice che le grammatiche di tipo $1$ sono *decidibili*.

#theorem([Decidibilità dei linguaggi context-sensitive])[
  I linguaggi di tipo $1$ sono *ricorsivi*.
]

Con *ricorsività* non intendiamo le procedure ricorsive, ma si intende una procedura che è calcolabile automaticamente. Nei linguaggi, un qualcosa di ricorsivo intende una macchina che, data una stringa $x$ in input, riesce a rispondere a $x in L$ terminando sempre dicendo *SI* o *NO*. Si usano i termini *ricorsivo* e *decidibile* come sinonimi.

#theorem-proof()[
  In una grammatica di tipo $1$ l'unico vincolo è sulla lunghezza delle produzioni, ovvero non possono mai accorciarsi.

  In input ho una stringa $w in Sigma^*$ la cui lunghezza è $abs(w) = n$. Ho una grammatica $G$ di tipo $1$ e mi chiedo se $w in L(G)$. Per rispondere a questo, devo cercare $w$ nelle forme sentenziali, ma possiamo limitarci a quelle che non superano la lunghezza $n$: infatti, visto che la lunghezza aumenta sempre (o al massimo rimane uguale) posso arrivare al massimo alle stringhe di lunghezza $n$ e controllare solo quelle.

  Definiamo quindi gli insiemi $ T_i = {gamma in (V union Sigma)^(lt.eq n) bar.v S arrow.stroked^(lt.eq i) gamma} quad forall i gt.eq 0 . $

  Calcoliamo induttivamente questi insiemi.

  Se $i = 0$ non eseguo nessuna derivazione, quindi $ T_0 = {S} . $

  Supponiamo di aver calcolato $T_(i-1)$. Ma allora $ T_i = T_(i-1) union {gamma in (V union Sigma)^(lt.eq n) bar.v exists beta in T_(i-1) bar.v beta arrow.stroked gamma} . $

  Noi partendo da $T_0$ calcoliamo tutti i vari insiemi ottenendo una serie di $T_i$. Per come abbiamo definito gli insiemi, sappiamo che $ T_0 subset.eq T_1 subset.eq T_2 subset.eq dots subset.eq (V union Sigma)^(lt.eq n) $ e l'ultima inclusione è vera perché ho fissato la lunghezza massima, non voglio considerare di più perché vogliamo $w$ di lunghezza $n$.

  La grandezza dell'insieme $(V union Sigma)^(lt.eq n)$ è finita, quindi anche andando molto avanti con le computazioni prima o poi arrivo ad un certo punto dove non posso più aggiungere niente, ovvero vale che $ exists i in NN bar.v T_i = T_(i - 1) . $

  Ora è inutile andare avanti, questo $T_i$ è l'insieme di tutte le stringhe che riesco a generare nella grammatica. Ora mi chiedo se $w in T_i$, che posso fare molto facilmente scorrendo l'insieme.

  Ma allora $G$ è decidibile.
]

Ci rendiamo conto che questa soluzione è *altamente inefficiente*: infatti, in tempo polinomiale non riusciamo a fare questo nelle tipo $1$, ma è una soluzione che ci garantisce la decidibilità.

In che situazione si trovano invece i linguaggi di tipo $0$?

#theorem([Semi-decidibilità dei linguaggi di tipo $0$])[I linguaggi di tipo $0$ sono *ricorsivamente enumerabili*.]

#theorem-proof()[
  In una grammatica di tipo $0$ non abbiamo vincoli da considerare.

  In input ho una stringa $w in Sigma^*$ la cui lunghezza è $abs(w) = n$. Ho una grammatica $G$ di tipo $0$ e, come prima, mi chiedo se $w in L(G)$. Per rispondere a questo, devo cercare $w$ nelle forme sentenziali, ma a differenza di prima non possiamo limitarci a quelle che non superano la lunghezza $n$: infatti, visto che le forme sentenziali si possono accorciare posso anche superare di molto la lunghezza $n$ e poi sperare di tornare indietro in qualche modo.

  Definiamo quindi gli insiemi $ U_i = {gamma in (V union Sigma)^* bar.v S arrow.stroked^(lt.eq i) gamma} quad forall i gt.eq 0 . $

  Calcoliamo induttivamente questi insiemi.

  Se $i = 0$ non eseguo nessuna derivazione, quindi $ U_0 = {S} . $

  Supponiamo di aver calcolato $U_(i-1)$. Vogliamo calcolare $ U_i = U_(i-1) union {gamma in (V union Sigma)^* bar.v exists beta in U_(i-1) bar.v beta arrow.stroked gamma} . $

  Noi partendo da $U_0$ calcoliamo tutti i vari insiemi ottenendo una serie di $U_i$. Per come abbiamo definito gli insiemi, sappiamo che $ U_0 subset.eq U_1 subset.eq U_2 subset.eq dots subset.eq (V union Sigma)^* . $

  A differenza di prima, la grandezza dell'insieme $(V union Sigma)^*$ è infinita, quindi non ho più l'obbligo di stopparmi ad un certo punto per esaurimento delle stringhe generabili.

  Come rispondiamo a $w in L(G)$? Iniziamo a costruire i vari insiemi $U_i$ e ogni volta che termino la costruzione mi chiedo se $w in U_i$: se questo è vero allora rispondo *SI*, in caso contrario vado avanti con la costruzione.

  Vista la cardinalità infinita dell'insieme che fa da container, potrei andare avanti all'infinito (_a meno di ottenere due insiemi consecutivi identici, in tale caso rispondo *NO*_).

  Ma allora $G$ è semi-decidibile.
]

Usiamo la dicitura *ricorsivamente enumerabile* perché ogni volta che costruisco un insieme $U_i$ posso prendere le stringe $w in Sigma^*$ appena generate ed elencarle, quindi *enumerarle* una per una.

== Introduzione della parola vuota

Introduciamo il *problema della parola vuota*. Dalle grammatiche di tipo $1$ a salire abbiamo il vincolo di non poter scendere di lunghezza con le derivazioni, quindi diciamo che la parola vuota $epsilon$ non la vedremo mai come lato destro di una derivazione. Eppure, ogni tanto la parola vuota dovrebbe appartenere al linguaggio generato da una grammatica. Come possiamo risolvere questo problema, senza far crollare l'intera gerarchia?

Una possibile soluzione è *spezzare le regole di produzione*.

Partiamo da una grammatica $G = (V, Sigma, P, S)$ di tipo $1$ e definiamo una nuova grammatica $ G' = (V', Sigma, P', S') $ tale che $L(G) = L(G')$. Vediamo le componenti di questa grammatica:
- l'*insieme delle variabili* contiene un nuovo elemento, il *nuovo assioma* $S'$, ovvero $ V' = V union {S'} ; $
- l'*insieme delle produzioni* mantiene le regole vecchie ma ne aggiunge due nuove, ovvero $ P' = P union {S' arrow.long epsilon} union {S' arrow.long S} $ dove:
  - la prima regola permette di generare la parola vuota $epsilon$;
  - la seconda regola permette di far partire la computazione della vecchia grammatica;
- l'*assioma* $S'$ ci permette la generazione della parola vuota ma dobbiamo garantire che non appaia mai nel lato destro delle produzioni.

Con questi accorgimenti ora riusciamo a generare anche la *parola vuota*: infatti, questo lo possiamo fare all'inizio partendo da $S'$. Se non ci interessa la parola vuota facciamo partire, sempre da $S'$, la computazione della vecchia grammatica.

Come cambia la gerarchia considerando anche la parola vuota? Abbiamo che:
- le grammatiche di tipo $1$ mantengono la clausola $abs(alpha) lt.eq abs(beta)$ ma è possibile ottenere $epsilon$ da $S'$ purché $S'$ non appaia mai nel lato destro delle produzioni;
- le grammatiche di tipo $2$ modificano la notazione $()^+$ in $()^*$ nel lato destro delle produzioni senza isolare in modo specifico $epsilon$ perché questo non crea problemi;
- le grammatiche di tipo $3$ seguono le precedenti.

Queste particolari produzioni che considerano la parole vuota sono dette $epsilon$*-produzioni*.

== Linguaggi non esprimibili tramite grammatiche finite

Vediamo infine dei linguaggi che non possiamo esprimere tramite *grammatiche finite*. Per fare ciò useremo la famosissima *dimostrazione per diagonalizzazione* di Cantor.

#example()[
  Sono più i numeri pari o i numeri dispari? Sono più i numeri pari o i numeri interi? Sono più le coppie di numeri naturali o i naturali stessi?
]

Per rispondere a queste domande si usa la definizione di *cardinalità*, e tutti questi insiemi che abbiamo citato ce l'hanno uguale. Anzi, diciamo di più: tutti questi insiemi sono grandi quanto i naturali, perché esistono funzioni biettive tra questi insiemi e l'insieme $NN$.

#example()[
  Sono più i sottoinsiemi di naturali o i naturali stessi?
]

In questo caso, sono di più i sottoinsiemi, che hanno la *cardinalità del continuo*. Per dimostrare questo useremo una dimostrazione per diagonalizzazione.

#theorem()[
  Vale $ NN tilde.not 2^NN . $
]

#theorem-proof()[
  Per assurdo sia $NN tilde 2^NN$, ovvero ogni elemento di $2^NN$ è *listabile*.

  Creiamo una tabella booleana $M$ indicizzata sulle righe dai sottoinsiemi di naturali $S_i$ e indicizzata sulle colonne dai numeri naturali. Per ogni insieme $S_i$ abbiamo sulla riga la funzione caratteristica, ovvero $ M[i,j] = cases(1 & "se" j in S_i, 0 quad & "se" j in.not S_i) . $

  Creiamo l'insieme $ S = {x in NN bar.v x in.not S_x} , $ ovvero l'insieme che prende tutti gli elementi $0$ della diagonale di $M$. Questo insieme non è presente negli insiemi $S_i$ listati perché esso è diverso da ogni $S_i$ in almeno una posizione, ovvero la diagonale.

  Abbiamo ottenuto un assurdo, ma allora $NN tilde.not 2^NN$.
]

Siamo quasi pronti per l'ultima dimostrazione di questo capitolo.

#example()[
  Sono più le stringhe o i numeri naturali?
]

Questi insiemi hanno la stessa cardinalità perché possiamo trasformare ogni stringa data in un numero naturale usando una qualche codifica. Con questa nozione e tutte quelle precedenti siamo pronti per dimostrare un teorema molto importante.

#theorem()[
  Esistono linguaggi che non sono descrivibili da grammatiche finite.
]

#theorem-proof()[
  Prendiamo una grammatica $G = (V, Sigma, P, S)$.

  Per descriverla devo dire come sono formati i vari campi della tupla. Cosa uso per descriverla? Sto usando dei simboli come lettere, numeri, parentesi, eccetera, quindi la grammatica è una descrizione che possiamo fare sotto forma di stringa. Visto quello che abbiamo da poco "dimostrato", ogni grammatica la possiamo descrivere come una stringa, e quindi come un numero intero. Siano $G_i$ tutte queste grammatiche, che sono appunto listabili.

  Consideriamo ora per ogni grammatica $G_i$ l'insieme $L(G_i)$ delle parole generate dalla grammatica $G_i$, ovvero il linguaggio generato da $G_i$. Mettiamo dentro $L$ tutti questi linguaggi.

  Per assurdo, siano tutti questi linguaggi listabili, ovvero $NN tilde L$.

  Come prima, creiamo una tabella $M$ indicizzata sulle righe dai linguaggi $L(G_i)$ e indicizzata sulle colonne dalle stringhe $x_i$ che possiamo però considerare come naturali. La matrice $M$ ha sulla riga $i$-esima la funzione caratteristica di $L(G_i)$, ovvero $ M[i,j] = cases(1 & "se" x_j in L(G_i), 0 quad & "se" x_j in.not L(G_i)) . $ In poche parole, abbiamo $1$ nella cella $M[i,j]$ se e solo se la stringa $x_j$ viene generata da $G_i$.

  Costruiamo ora l'insieme $ "LG" = {x_i in NN bar.v x_i in.not L(G_i)} , $ ovvero l'insieme di tutte le stringhe $x_i$ che non sono generate dalla grammatica $G_i$ con lo stesso indice $i$. Come prima, questo insieme non è presente in $L$ perché differisce da ogni insieme presente in almeno una posizione, ovvero quello sulla diagonale.

  Siamo ad un assurdo, ma allora $NN tilde.not L$.
]
