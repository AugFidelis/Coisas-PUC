TITLE PROGRAMA QUE VERIFICA SE E PAR OU IMPAR
.MODEL SMALL
.DATA
    MSG1 DB 'INSIRA UM NUMERO: $'
    NUMIMPAR DB 13,10,'O NUMERO E IMPAR $'
    NUMPAR DB 13,10,'O NUMERO E PAR $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG1
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    TEST AL,01H ;Faz um AND com AL mas não altera o valor de AL, somente alterando as flags
    JZ PAR

    LEA DX,NUMIMPAR
    MOV AH,09
    INT 21H
    JMP FIM

    PAR:
        LEA DX,NUMPAR
        MOV AH,09
        INT 21H

    FIM:
        MOV AH,4CH
        INT 21H



MAIN ENDP
END MAIN