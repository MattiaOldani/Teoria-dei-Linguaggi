// Setup

#set heading(numbering: none)


// Capitolo

= Introduzione

In questo corso studieremo dei *sistemi formali* che descrivono dei linguaggi: ci chiederemo cosa sono in grado di fare, ovvero cosa sono in grado di descrivere in termini di *linguaggi*.

Ci occuperemo anche delle *risorse utilizzate*, come il *numero di mosse* eseguite da una macchina che deve riconoscere un linguaggio, oppure il *numero di stati* che sono necessari per descrivere una macchina a stati finiti, oppure ancora lo *spazio utilizzato* da una macchina di Turing.

Un *linguaggio* è _"uno strumento di comunicazione usato da membri di una stessa comunità"_, ed è composto da due elementi:
- *sintassi*: insieme di simboli (o parole) che devono essere combinati con una serie di regole;
- *semantica*: associazione frase-significato.

Per i linguaggi naturali è difficile dare delle regole sintattiche: vista questa difficoltà, nel $1956$ *Noam Chomsky* introduce il concetto di *grammatiche formali*, che si servono di regole matematiche per la definizione della sintassi di un linguaggio.

Il primo utilizzo dei linguaggi formali risale agli stessi anni con il *compilatore Fortran*. Anche se ci hanno messo l'equivalente di $18$ anni/uomo, questa è la prima applicazione dei linguaggi formali. Con l'avvento, negli anni successivi, dei linguaggi Algol, ovvero linguaggi con strutture di controllo, la teoria dei linguaggi formali è diventata sempre più importante.

Oggi la teoria dei linguaggi formali è usata nei compilatori di compilatori, dei tool usati per generare dei compilatori per un dato linguaggio fornendo la descrizione di quest'ultimo.
