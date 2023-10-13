TITLE PROGRAMA QUE VERIFICA SE E PAR OU IMPAR COM DESLOCAMENTO
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

    SHR AL,1 ;Desloca os bits do numero pra direita, com o LSB indo pra fora e sendo guardado no CF (carry flag)
    JNC PAR ;Pula caso o CF for 0 (jump not carry)

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