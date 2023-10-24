TITLE ATIVIDADE 9
.MODEL SMALL

PULALINHA MACRO
    PUSH DX
    PUSH AX
    MOV DL,10
    MOV AH,02
    INT 21H
    POP AX
    POP DX
    ENDM

.DATA
    MSG1 DB 'QUAL BASE SERA USADA? ("b" para binario, "h" para hexadecimal e "d" para decimal): $'
    INSIRAVALOR DB 13,10,'INSIRA O VALOR: $'
    INVALIDO DB 13,10,'VALOR INVALIDO!$'
    MSGRES DB 13,10,'RESULTADO: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL LEITURA

    MOV AH,4CH
    INT 21H

MAIN ENDP

LEITURA PROC ;---------------------------------------------------------------------------------------------------

    LER:
    LEA DX,MSG1
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    CMP AL,'b'
    JE BIN

    CMP AL,'h'
    JE HEX

    CMP AL,'d'
    JE DECIM

    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    PULALINHA
    JMP LER

    BIN:
    CALL ENTBIN
    CALL SAIBIN
    RET

    HEX:
    ;CALL ENTHEX
    ;CALL SAIHEX
    RET

    DECIM:
    ;CALL ENTDEC
    ;CALL SAIDEC
    RET

LEITURA ENDP

ENTBIN PROC ;----------------------------------------------------------------------------------------------------

    LEA DX,INSIRAVALOR
    MOV AH,09
    INT 21H

    XOR BX,BX
    XOR CH,CH
    
    LER2:

    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR
    
    CMP AL,30H
    JB ERRO

    CMP AL,31H
    JA ERRO

    AND AL,0FH
    SHL BX,1
    ADD BL,AL

    INC CH
    CMP CH,16
    JE SAIR
    
    JMP LER2

    ERRO:
    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    PULALINHA
    JMP LER2
    
    SAIR:
    RET

ENTBIN ENDP ;----------------------------------------------------------------------------------------------------

SAIBIN PROC ;----------------------------------------------------------------------------------------------------

    LEA DX,MSGRES
    MOV AH,09
    INT 21H

    MOV CX,16

    IMP:
    SHL BX,1
    JC UM

    MOV DL,30H
    MOV AH,02
    INT 21H
    JMP SAIR2

    UM:
    MOV DL,31H
    MOV AH,02
    INT 21H
    
    SAIR2:
    LOOP IMP
    
    RET

SAIBIN ENDP ;----------------------------------------------------------------------------------------------------

ENTHEX PROC ;----------------------------------------------------------------------------------------------------

    XOR BX,BX

    LER3:
    LEA DX,INSIRAVALOR
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR

    CMP AL,30H
    JB ERRO2

    CMP AL,3AH
    JB CONT

    CMP AL,41H
    JB ERRO2

    CMP AL,47H
    JB CONT

    ERRO2:
    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    PULALINHA
    JMP LER3

    CONT:
    






ENTHEX ENDP

END MAIN