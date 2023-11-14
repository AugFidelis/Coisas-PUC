TITLE ENTRADA E SAIDA DECIMAL
.MODEL SMALL
.DATA
    INSIRAVALOR DB 13,10,'INSIRA O VALOR: $'
    INVALIDO DB 13,10,'VALOR INVALIDO!$'
    MSGRES DB 13,10,'RESULTADO: $'
    MSGSINAL DB 13,10,'INSIRA O SINAL: $'
    RESULTADO DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL ENTDEC

    CALL SAIDEC

    MOV AH,4CH
    INT 21H


MAIN ENDP

ENTDEC PROC ;-------------------------------------------------------------------------------------------------------------
    
    INICIO:
    XOR BX,BX
    XOR CX,CX

    LEA DX,INSIRAVALOR
    MOV AH,09
    INT 21H

    LER:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR

    CMP AL,'0'
    JNGE ERRO

    CMP AL,'9'
    JNLE ERRO

    AND AX,000FH
    PUSH AX

    MOV AX,10 ;converte todos os numeros digitados em um numero só
    MUL BX
    
    POP BX
    
    ADD BX,AX

    JMP LER

    SAIR:
    RET

    ERRO:
    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    JMP INICIO

ENTDEC ENDP ;-------------------------------------------------------------------------------------------------------------

SAIDEC PROC ;-------------------------------------------------------------------------------------------------------------

    LEA DX,MSGRES 
    MOV AH,09
    INT 21H
    
    MOV AX,BX

    PUSH AX

    XOR BX,BX
    XOR CX,CX
 
    MOV BX,10

    CONV:
    XOR DX,DX ;passa o resto das divisoes pra imprimir numero por numero do resultado
    DIV BX
    PUSH DX

    INC CX

    OR AX,AX
    JNZ CONV

    IMP:
    POP DX

    OR DX,30H
    MOV AH,02
    INT 21H

    LOOP IMP

    RET

SAIDEC ENDP ;-------------------------------------------------------------------------------------------------------------

END MAIN