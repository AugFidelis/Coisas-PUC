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

LEITURA PROC ;------------------------------------------------------------------------------------------------------------

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
    CALL ENTHEX
    CALL SAIHEX
    RET

    DECIM:
    CALL ENTDEC
    CALL SAIDEC
    RET

LEITURA ENDP ;------------------------------------------------------------------------------------------------------------

ENTBIN PROC ;-------------------------------------------------------------------------------------------------------------

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

    LEA DX,INSIRAVALOR
    MOV AH,09
    INT 21H

    XOR BX,BX
    MOV CX,4

    LER3:

    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR3

    CMP AL,30H
    JB ERRO2

    CMP AL,3AH
    JB FX1

    CMP AL,41H
    JB ERRO2

    CMP AL,47H
    JB FX2

    CMP AL,47H
    JAE ERRO2

    ERRO2:
    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    PULALINHA
    JMP LER3

    FX1:
    
    SHL BX,4
    
    AND AL,0FH
    ADD BL,AL

    JMP REPETE

    FX2:

    SHL BX,4
    
    SUB AL,55
    ADD BL,AL

    REPETE:
    LOOP LER3
    
    SAIR3:
    RET

ENTHEX ENDP ;-------------------------------------------------------------------------------------------------------------

SAIHEX PROC ;-------------------------------------------------------------------------------------------------------------

    LEA DX,MSGRES
    MOV AH,09
    INT 21H
    
    MOV CX,4

    CONV:
    MOV DL,BH
    SHR DL,4

    CMP DL,10
    JAE FAIXA2

    OR DL,30H
    JMP IMP2

    FAIXA2:
    ADD DL,55

    IMP2:
    MOV AH,02
    INT 21H

    SHL BX,4

    LOOP CONV

    RET

SAIHEX ENDP ;-------------------------------------------------------------------------------------------------------------

ENTDEC PROC ;-------------------------------------------------------------------------------------------------------------

    LEA DX,INSIRAVALOR
    MOV AH,09
    INT 21H
    
    XOR AX,AX
    XOR BX,BX

    SINAL:
    MOV AH,01
    INT 21H

    CMP AL,'-'
    JE NEGT

    CMP AL,'+'
    JE LER4

    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    JMP SINAL

    NEGT:
    MOV CH,1

    LER4:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR4

    AND AL,0FH
    PUSH AX

    MOV AL,10
    MUL BL
    
    POP BX
    
    ADD BX,AX

    JMP LER4

    SAIR4:

    MOV AX,BX

    CMP CH,1
    JNE FIM

    NEG AX

    FIM:
    RET

ENTDEC ENDP ;-------------------------------------------------------------------------------------------------------------

SAIDEC PROC ;-------------------------------------------------------------------------------------------------------------

    LEA DX,MSGRES
    MOV AH,09
    INT 21H
    
    OR AX,AX
    JGE SEGUE

    MOV DL,'-'
    MOV AH,02
    INT 21H

    NEG AX

    SEGUE:
    XOR CX,CX
    
    MOV BL,10

    CONV2:
    DIV BL
    PUSH AX

    INC CX

    OR AL,AL
    JNE CONV2

    IMP3:
    POP AX
    MOV DL,AH

    OR DL,30H
    MOV AH,02
    INT 21H

    LOOP IMP3

    RET

SAIDEC ENDP

END MAIN