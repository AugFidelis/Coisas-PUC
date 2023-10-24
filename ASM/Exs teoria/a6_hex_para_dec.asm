TITLE ODEIO MINHA VIDA
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'INSIRA UM VALOR HEXADECIMAL: $'
    CONTINUAR DB 13,10,'DESEJA CONTINUAR O PROGRAMA? (INSIRA "S" CASO SIM): $'
    MSGDEC DB 13,10,'VALOR DECIMAL: $'
    NOVALINHA DB 13,10,'$'
    MSGERRO DB 13,10,'VALOR INVALIDO!$'
    MSGMORTE DB 13,10,'SE FUDEU$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LER:
    LEA DX,MSG1
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    CMP AL,30H
    JB ERRO

    CMP AL,3AH
    JB CONT

    CMP AL,41H
    JB ERRO

    CMP AL,47H
    JB CONT

    ;CMP AL,61H
    ;JB ERRO 

    ;CMP AL,7BH
    ;JB CONT

    ERRO:
    LEA DX,MSGERRO
    MOV AH,09
    INT 21H

    LEA DX,NOVALINHA
    MOV AH,09
    INT 21H

    INC CH
    CMP CH,3
    JE QUEBRA

    JMP LER

    QUEBRA:
    LEA DX,MSGMORTE
    MOV AH,09
    INT 21H
    JMP FIM

    CONT:
    SUB AL,55
    MOV DL,AL

    PUSH DX

    LEA DX,MSGDEC
    MOV AH,09
    INT 21H

    POP DX
    
    MOV AH,02
    INT 21H

    FIM:
    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN