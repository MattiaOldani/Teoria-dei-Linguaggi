// Setup


// Capitolo

= Conversione

Uso della *subset construction* per l'equivalenza.

Togliamo tutti gli stati non raggiungibili dell'automa $A$ dato.

Definizione di $L_q^a$ e $L_q^r$ di uno stato $q$ come l'insieme delle stringhe accettate/rifiutate da $A$ partendo dallo stato $q$. Proprietà di:
- *completezza* $L_(q_0)^a union L_(q_0)^r = Sigma^*$;
- *consistenza* $L_(q_0)^a inter L_(q_0)^r = emptyset.rev$.

Estendi queste definizioni usando un sottoinsieme $alpha$ come stato.

Migliorare il *numero di stati* della subset construction: vogliamo trovare il numero di sottoinsiemi raggiungibili usando una *relazione di compatibilità*.

Due stati sono *compatibili* se due computazioni che partono da questi due stati non danno risposte discordanti, ovvero se $ (L_p^a union L_q^a) inter (L_p^r union L_q^r) = emptyset.rev . $

*Grafo di compatibilità* e cricche del grafo come sottoinsiemi. Visto che gli stati presenti in un sottoinsieme $alpha$ devono essere compatibili allora per il DFA risultante possiamo vedere il numero di queste cricche.

Numero di stati pari a $ 1 + f(n-1) $ dove $f(n)$ è il massimo numero di cricche in un grafo di $n$ nodi. La funzione $f$ è tale che $ f(n) = cases(3^(floor(n slash 3)) & "se" n equiv 0 mod 3, 4 dot 3^(floor(n slash 3) - 1) quad & "se" n equiv 1 mod 3, 2 dot 3^(floor(n slash 3)) & "se" n equiv 2 mod 3) quad forall n gt.eq 2 . $
