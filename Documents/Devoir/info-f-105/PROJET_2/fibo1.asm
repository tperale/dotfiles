; NOM: PERALE Thomas
; MATRICULE: 408160
; netid: tperale

CPU 386

GLOBAL main
EXTERN afficherRegistres
EXTERN afficherFlags
EXTERN afficherUns32

; SECTION .data
; Pas de .data donc pas besoin

SECTION .text

main:
    ; Le programme ne fonctionne pas pour des valeur supérieur à 2³². 
    MOV ECX, EAX ; On recherche le n-ieme nombre de fibonnacci et n est stocké dans EAX
    MOV EAX, 1 ; Cas de base, on mets dans EAX toujours le plus grand nombre.
    XOR EBX, EBX ; Cas de base, on le place à 0
    JMP boucle

boucle:
    XCHG EAX, EBX ; EAX contenant le plus grand nombre il faut que EBX contienne une valeur
                  ; plus petite et donc la valeur de EAX qui va être modifier a la prochaine
                  ; instruction
    JECXZ fin     ; Si le compteur est à zéro, on sort de la boucle.
    ADD EAX, EBX
    DEC ECX
    JMP boucle    ; On recommence la boucle et ECX est décrementé.

fin:
    NOP ; Le résultat est stocké dans EAX
