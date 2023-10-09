TITLE LAB5 1
MODEL SMALL
STACK 100H
.DATA
.CODE
MAIN PROC

    ;Rótulo usado para pular caso a condição não seja atendida
    INICIO:

    ;Le um caractere
    MOV AH,01
    INT 21h

    ;Compara com o valor decimal 13, que é o ENTER, e repete o código anterior até o valor inserido for igual.
    CMP AL,13
    JNE INICIO

    ;Finaliza o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN