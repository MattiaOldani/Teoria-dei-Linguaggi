// Setup

#import "alias.typ": *


// Capitolo

= Definizione

Definizione formale di un SVFA:
- tupla $A = (Q, Sigma, delta, q_0, F^a, F^r)$;
- proprietà:
  - almeno una computazione che accetta/rifiuta;
  - non ci sono risposte discordanti;
  - riprendi il discorso sul nome self-verifying;
- linguaggio riconosciuto, rifiutato e relazione $L^a (A) = (L^r (A))^C$.

Numero di stati:
- se mi vengono dati due NFA;
- se mi viene dato un SVFA;
- relazione $max(nsc(L), nsc(L^C)) lt.eq svsc(L) lt.eq 1 + nsc(L) + nsc(L^C)$.
