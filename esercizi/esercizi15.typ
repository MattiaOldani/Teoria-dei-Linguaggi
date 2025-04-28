// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Esercizi

= Esercizi lezione 15 [23/04]

== Esercizio 01

#exercise()[
  Sia $Sigma = {a,b}$ e $L = {w in Sigma^+ bar.v hash_a (w) = hash_b (w)}$, dove $hash_sigma (w)$ indica il numero di occorrenze del simbolo $sigma$ nella stringa $w$, con $sigma in Sigma$. Siano inoltre $L_a = {w in Sigma^+ bar.v hash_a (w) = hash_b (w) + 1}$ e $L_b = {w in Sigma^+ bar.v hash_b (w) = hash_a (w) + 1}$.
]

#request()[
  Si fornisca una definizione induttiva per le stringe nei linguaggi $L$, $L_a$, $L_b$.

  _Suggerimento_. Ispiratevi all'esempio presentato a lezione per il linguaggio delle parentesi bilanciate, utilizzando affermazioni come "Una stringa di $L$ inizia con una $b$ seguita da una stringa di $L_a$, oppure inizia con ...".
]

#solution()[
  Vediamo le definizioni induttive dei tre linguaggi.

  Per $L_a$ possiamo dire che:
  - $a$ è stringa di $L_a$;
  - se $X$ è una stringa di $L_a$, allora anche $a X b$ e $b X a$ e $b a X$ e $a b X$ e $X a b$ e $X b a$ lo sono.

  Per $L_b$ possiamo dire che:
  - $b$ è stringa di $L_b$;
  - se $X$ è una stringa di $L_b$, allora anche $a X b$ e $b X a$ e $b a X$ e $a b X$ e $X a b$ e $X b a$ lo sono.

  Per $L$ possiamo dire che:
  - $a b$ e $b a$ sono stringhe di $L$;
  - se $X$ è una stringa di $L$, allora anche $a X b$ e $b X a$ e $b a X$ e $a b X$ e $X a b$ e $X b a$ lo sono;
  - se $X$ è una stringa di $L_a$, allora $b X$ e $X b$ sono in $L$;
  - se $X$ è una stringa di $L_b$, allora $a X$ e $X a$ sono in $L$;
  - se $X$ è una stringa di $L_a$ e $Y$ è una stringa di $L_b$ allora $X Y$ e $Y X$ sono in $L$.

  In realtà questa ultima mi sa che si può evitare, o si può evitare la prima.
]

#request()[
  Dalla definizione ricavate una grammatica per il linguaggio $L$.

  _Suggerimento_. Per ricavare la grammatica potete considerare una variabile per ognuno dei tre linguaggi. Una delle possibili soluzioni vi permetterà di ottenere la grammatica per $L$ presentata a lezione.
]

#solution()[
  Definiamo la grammatica $G = ({S, A, B}, {a, b}, P, S)$ con regole di produzione nella forma $ S arrow.long a B bar.v b A bar.v a b S bar.v b a S bar.v S a b bar.v S b a bar.v a S b bar.v b S a \ A arrow.long a bar.v a A b bar.v b A a bar.v a b A bar.v b a A bar.v A a b bar.v A b a \ B arrow.long b bar.v a B b bar.v b B a bar.v a b B bar.v b a B bar.v B a b bar.v B b a . $
]

== Esercizio 02

#exercise()[]

#request()[
  Ripetete l'esercizio precedente, sostituendo $w in Sigma^*$ a $w in Sigma^+$ nella definizione dei linguaggi. Osservate che è sufficiente un unico caso base in tutta la definizione ricorsiva.
]

#solution()[
  Aggiungiamo che in $L$ abbiamo anche $epsilon$ e come regola aggiuntiva mettiamo $S arrow.long epsilon$, molto molto semplice (troppo semplice per essere giusto).
]
