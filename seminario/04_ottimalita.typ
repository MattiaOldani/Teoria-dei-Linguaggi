// Setup


// Capitolo

= Ottimalità

Dimostriamo che per ogni $n$ allora la nostra costruzione è ottima, ovvero che per ogni $n$ esiste un automa di $n$ stati che genera un DFA minimo con esattamente quel numero di stati.

Visto che la funzione $f(n)$ è "periodica", possiamo considerare solo tre "classi" di automi.

Partiamo con automi che hanno un numero di stati pari a $ n = 1 + 3m bar.v m gt.eq 2 . $

#figure(image("assets/dimostrazione.png"))

La funzione di transizione di questo automa è tale che $ delta(q_0, a) = delta(q_0, b) = {(0,1), dots, (0,m)} \ delta((i,j), a) = cases({(i,j+1)} quad & "se" j < m, {(0,1)} & "altrimenti") \ delta((i,j), b) = {((i+1) mod 3, j)} . $

Cosa accetta questo automa: stringa vuota sicuramente.

Ora prendiamo una stringa $w = sigma w'$ e chiamiamo $m_0$ il numero di occorrenze di $a$ in $w'$. Con il carattere $sigma$ in maniera non deterministica ci spostiamo negli stati della prima riga. Con questo stiamo guessando il valore $m_0$. Il guess giusto dipende anche dal numero di $b$:
- se $hash_b equiv 0 mod 3$ accetto;
- altrimenti rifiuto.

Notiamo che il counter però viene azzerato quando passiamo dalla colonna di destra a quella di sinistra.

Quindi accettiamo in due casi:
- se abbiamo meno di $m$ caratteri pari ad $a$ e $0$ caratteri $b$ modulo $3$;
- se la stringa $w'$ ha un suffisso di $m$ caratteri $a$ con $0$ caratteri $b$ modulo $3$.

Dimostrazione che è self-verifying.

Prendiamo l'insieme $ Q' = {{(x_1, 1), dots, (x_m, m)} bar.v x_1, dots, x_m in {0,1,2}} . $

Stiamo scegliendo una cella per ogni colonna della griglia. Se applichiamo una $a$ o una $b$ ad un insieme di $Q'$ otteniamo ancora un elemento di $Q'$. Quando noi da $q_0$ ci spostiamo in nella prima riga della griglia noi siamo in uno stato di $Q'$. Visto che stiamo selezionando solo un elemento di ogni colonna, non possiamo selezionare due stati dell'ultima, quindi siamo self-verifying.

Dimostrazione che è minimo.

Trasformiamo gli stati di $Q'$ nei vettori $(x_1, dots, x_m) in {0,1,2}^m$. Notiamo che $ delta((x_1, dots, x_m), a) = (0, x_1, dots, x_(m-1)) \ delta((x_1, dots, x_m), b) = ((x_1 + 1) mod 3, dots, (x_m + 1) mod 3) . $

Tutti questi stati sono raggiungibili:
- raggiungiamo lo stato $(0, dots, 0)$ da qualsiasi altro stato se applichiamo la stringa $a^m$ allo stato corrente, ovvero $ delta((x_1, dots, x_m), a^m) = (0, dots, 0) ; $
- raggiungiamo qualsiasi stato da $(0, dots, 0)$ usando la relazione $ delta((0, x_2 - x_1, dots, x_m - x_1), b^(x_1)) = (x_1, dots, x_m) $ e usando una dimostrazione per induzione.

Questi stati sono $1 + 3^m$. Inoltre, sono tutti distinguibili tra loro.

Infatti, se prendiamo due stati che hanno $x_i eq.not y_i$. Se partiamo dagli stati $(0,i)$ e $(1,i)$ allora questi due non sono compatibili con $a^(m-i)$. Idem se prendiamo la coppia $(0,2)$ e anche $(1,2)$ se aggiungiamo una $b$ alla stringa. Si può fare lo stesso discorso con lo stato $q_0$ e gli altri accettanti/rifiutanti.

Se invece $n = 3m + 2 bar.v m gt.eq 2$ si aggiunge lo stato $(3,1)$, mentre con $n = 3m bar.v n gt.eq 2$ si toglie lo stato $(2,1)$. In ogni caso, si ottengono i valori di $f(n-1)$.

Con $n = 1$ e $n = 2$ si hanno SVFA equivalenti a DFA, quindi il numero di stati è definito alla funzione $ g(n) = cases(1 + 3^((n-1) slash 3) & "se" n equiv 1 mod 3 and n gt.eq 4, 1 + 4 dot 3^((n-2) slash 3 - 1) quad & "se" n equiv 2 mod 3 and n gt.eq 5, 1 + 2 dot 3^(n slash 3 - 1) & "se" n equiv 0 mod 3 and n gt.eq 3, n & "se" n lt.eq 2) $
