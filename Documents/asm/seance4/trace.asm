CPU 386

GLOBAL trace

SECTION .data
    ;V DW 4, 6, 5, 10 ; Matrice carrée
    ;n DW 2 ; Taille d'une ligne

SECTION .text

trace:
    ;PUSH EBP
    ;MOV EBP, ESP
    PUSH ESI
    PUSH ECX
    PUSH EDX
    PUSH EBX

    MOV ESI, [EBP+8] ; Ajout du vecteur à sa place
    MOV ECX, [EBP+12] ; Ajout du compteur dans ECX car la diagonale a la taille
                      ; d'une ligne de la matrice.
    MOV EBX, ECX ; On stock dans ce registre 
     
    XOR EDX, EDX ; EDX va servir à savoir quel est le décalage pour calculer la trace 
    XOR EAX, EAX ; Résultat stocké dans EAX donc réinitialisation.
    JMP fin

boucle:
    ADD EAX, [ESI+ECX*EBX-EDX] ; Ligne courante plus le milieu.

    INC EDX
    DEC ECX 
    JNZ boucle 

fin:
    POP EBX
    POP EDX
    POP ECX
    POP ESI

    RET
