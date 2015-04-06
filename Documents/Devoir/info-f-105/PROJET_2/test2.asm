CPU 386

GLOBAL main

SECTION .text

main:
    MOV ECX, EBX ; Comme l'on doit conserver EBX l'on travaille sur ECX
    XOR EAX, EAX ; Initialise EAX à 0
    SHR ECX, 1 ; On décale de 1 vers la droite.
    JC fin ; En faisant l'opération précédente le carry est mis a 1
           ; si l'on avait un nombre impaire.

    INC EAX ; Mit à 1
    SHR ECX, 1 ; On décale de 1 vers la droite.
    JC fin ; On test si il est multiple de 2.

    INC EAX ; Mit à 2
    SHR ECX, 1 ; On décale de 1 vers la droite.
    JC fin ; On test si il est multiple de 4.

    INC EAX ; Mit à 3
    JC fin ; Si aucun des autres test n'a réussi, ça veut
            ; dire que EBX est divisible par 8.
    INC EAX ; à 4
    JMP fin ; Comme aucune consigne n'est donnée pour les autres chiffres j'ai décidé
            ; que les multiples d'autres puissance de 2 vont prendre la valeur 4

    ; J'aurais pu utiliser une boucle aussi mais ça m'a semblé inutile
    ; Comme l'on connait à l'avance le nombre de test à faire et qu'un
    ; jump demande plus de temps.

fin:
    NOP
