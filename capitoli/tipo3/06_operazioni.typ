// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Operazioni tra linguaggi
<operazioni>

Supponiamo di avere in mano una serie di linguaggi. Vediamo un po' di *operazioni* che possiamo fare su essi per combinarli assieme e ottenere altri linguaggi importanti.

== Operazioni insiemistiche

I linguaggi sono insiemi di stringhe, quindi perché non iniziare dalle *operazioni insiemistiche*?

Fissato un alfabeto $Sigma$, siano $L', L'' subset.eq Sigma^*$ due linguaggi definiti sullo stesso alfabeto $Sigma$. Se i due alfabeti sono diversi allora si considera come alfabeto l'*unione* dei due alfabeti.

Partiamo con l'operazione di *unione*: $ L' union L'' = {x in Sigma^* bar.v x in L' or x in L''} . $

Continuiamo con l'operazione di *intersezione*: $ L' inter L'' = {x in Sigma^* bar.v x in L' and x in L''} . $

Terminiamo con l'operazione di *complemento*: $ L'^C = {x in Sigma^* bar.v x in.not L'} . $

Per ora tutto facile, sono le classiche operazioni insiemistiche.

== Operazioni tipiche

Passiamo alle *operazioni tipiche* dei linguaggi, definite comunque molto semplicemente.

Partiamo con l'operazione di *prodotto* (_o concatenazione_): $ L' dot L'' = {w in Sigma^* bar.v exists x in L' and exists y in L'' bar.v w = x y} . $ In poche parole, concateniamo in tutti i modi possibili le stringhe del primo linguaggio con le stringhe del secondo linguaggio. Questa operazione, in generale, è *non commutativa*, e lo è se $Sigma$ è formato da una sola lettera.

#example()[
  Vediamo due casi particolari e importanti di prodotto: $ L dot emptyset.rev = emptyset.rev dot L = emptyset.rev \ L dot {epsilon} = {epsilon} dot L = L . $
]

Andiamo avanti con l'operazione di *potenza*: $ L^k = underbracket(L dot dots dot L, k "volte") . $ In poche parole, stiamo prendendo $k$ stringhe da $L'$ e le stiamo concatenando in ogni modo possibile. Possiamo dare anche una definizione induttiva di questa operazione, ovvero $ L^k = cases({epsilon} & "se" k = 0, L^(k-1) dot L quad & "se" k > 0) . $

Infine, terminiamo con l'operazione di *chiusura di Kleene*, detta anche *STAR*. Questa operazione è molto simile alla potenza, ma in questo caso il numero $k$ non è fissato e quindi questa operazione di potenza viene ripetuta all'infinito. Vengono quindi concatenate un numero arbitrario di stringhe di $L$, e teniamo tutte le computazioni intermedie, ovvero $ L^* = union.big_(k gt.eq 0) L^k . $

Ecco perché scriviamo $Sigma^*$: partendo dall'alfabeto $Sigma$ andiamo ad ottenere ogni stringa possibile.

Esiste anche la *chiusura positiva*, definita come $ L^+ = union.big_(k gt.eq 1) L^k . $

Che relazione abbiamo tra le due chiusure? Questo dipende da $epsilon$, ovvero:
- se $epsilon in L$ allora $L^* = L^+$ perché $L^1 subset.eq L^+$ e visto che $epsilon in L^1$ abbiamo gli stessi insiemi;
- se $epsilon in.not L$ allora $L^+ = L^* slash {epsilon}$ perché l'unico modo di ottenere $epsilon$ sarebbe con $L^0$.

#example()[
  Vediamo una cosa simpatica: $ emptyset.rev^* = {epsilon} . $

  Abbiamo appena generato qualcosa dal nulla, fuori di testa. La generazione si blocca con la chiusura positiva, ovvero $ emptyset.rev^+ = emptyset.rev . $

  Infine, vediamo una cosa abbastanza banale sull'insieme formato dalla sola $epsilon$, ovvero $ {epsilon}^* = {epsilon}^+ = {epsilon} . $
]

Con la chiusura di Kleene, partendo da un *linguaggio finito* $L$, otteniamo una chiusura $L^*$ di cardinalità infinita, perché ogni volta andiamo a creare delle nuove stringhe.

Partendo invece da un *linguaggio infinito* $L$, otteniamo ancora una chiusura $L^*$ di cardinalità infinita ma ci sono alcune situazioni particolari.

#example()[
  Vediamo tre linguaggi infiniti che hanno comportamenti diversi.

  Consideriamo il linguaggio $ L_1 = {a^n bar.v n gt.eq 0} . $

  Calcolando la chiusura $L_1^*$ otteniamo lo stesso linguaggio $L_1$ perché stiamo concatenando stringhe che contengono solo $a$, che erano già presenti in $L_1$.

  Consideriamo ora il linguaggio $ L_2 = {a^(2k + 1) bar.v k gt.eq 0} . $

  Calcolando la chiusura $L_2^*$ otteniamo il linguaggio $L_1$ perché:
  - in $L_2^1$ ho tutte le stringhe formate da $a$ di lunghezza dispari;
  - in $L_2^2$ ho tutte le stringhe formate da $a$ di lunghezza pari (_dispari + dispari_).

  Già solo con $L_2^0 union L_2^1 union L_2^2$ generiamo tutto il linguaggio $L_1$

  Consideriamo infine $ L_3 = {a^n b bar.v n gt.eq 0} . $

  Proviamo a calcolare prima la potenza $L_3^k$ di questo linguaggio, ovvero $ L_3^k = {a^(n_1) b dots a^(n_k) b bar.v n_1, dots, n_k gt.eq 0} . $ La chiusura $L_3^*$ conterrà stringhe in questa forma con $k$ ogni volta variabili.
]

Abbiamo quindi visto diverse situazioni: nel primo linguaggio non abbiamo dovuto calcolare nessuna chiusura, nel secondo linguaggio abbiamo calcolato un paio di linguaggi, nel terzo linguaggio non ci siamo mai fermati.
