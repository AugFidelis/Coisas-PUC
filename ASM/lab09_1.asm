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
    MSG1 DB 'QUAL ENTRADA SERA USADA? ("b" para binario, "h" para hexadecimal e "d" para decimal): $'
    MSG2 DB 'QUAL SAIDA SERA USADA? ("b" para binario, "h" para hexadecimal e "d" para decimal): $'
    INSIRAVALOR DB 13,10,'INSIRA O VALOR: $'
    INVALIDO DB 13,10,'VALOR INVALIDO!$'
    MSGRES DB 13,10,'RESULTADO: $'
    MSGSINAL DB 13,10,'INSIRA O SINAL: $'
    RESULTADO DW ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL ENTRADA

    CALL SAIDA

    MOV AH,4CH
    INT 21H

MAIN ENDP

ENTRADA PROC ;------------------------------------------------------------------------------------------------------------

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
    RET

    HEX:
    CALL ENTHEX
    RET

    DECIM:
    CALL ENTDEC
    RET

ENTRADA ENDP ;------------------------------------------------------------------------------------------------------------

SAIDA PROC ;------------------------------------------------------------------------------------------------------------

    PULALINHA
    
    SLER:
    LEA DX,MSG2
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    CMP AL,'b'
    JE SBIN

    CMP AL,'h'
    JE SHEX

    CMP AL,'d'
    JE SDECIM

    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    PULALINHA
    JMP SLER

    SBIN:
    CALL SAIBIN
    RET

    SHEX:
    CALL SAIHEX
    RET

    SDECIM:
    CALL SAIDEC
    RET

SAIDA ENDP ;------------------------------------------------------------------------------------------------------------

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
    ADD BL,AL ;adiciona AL a BL para evitar perda dos valores anteriores

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
    JC UM ;caso houver carry apos o deslocamento do MSB para fora, imprime o numero 1

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

    CMP AL,47H ;somente permite numeros de 0 a 9 e letras de A a F
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
    
    CMP BX,0 ;compara ax com 0 e caso menor imprime o sinal negativo
    JGE SEGUEHX

    PUSH BX
    
    MOV DL,'-'
    MOV AH,02
    INT 21H
    
    POP BX
    NEG BX
    
    SEGUEHX:
    MOV CX,4

    CONV:
    MOV DL,BH
    SHR DL,4

    CMP DL,10
    JAE FAIXA2 ;caso maior que 10, le na faixa de A a F

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

    SINAL:
    LEA DX,MSGSINAL
    MOV AH,09
    INT 21H
    
    XOR BX,BX
    XOR CX,CX

    MOV AH,01
    INT 21H

    CMP AL,'-'
    JE NEGT

    CMP AL,'+'
    JE POSIT

    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    JMP SINAL

    NEGT:
    MOV CX,1

    POSIT:
    LEA DX,INSIRAVALOR
    MOV AH,09
    INT 21H

    LER4:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR4

    CMP AL,'0'
    JNGE ERRO3

    CMP AL,'9'
    JNLE ERRO3

    AND AX,000FH
    PUSH AX

    MOV AX,10 ;converte todos os numeros digitados em um numero só
    MUL BX
    
    POP BX
    
    ADD BX,AX

    JMP LER4

    SAIR4:

    OR CX,CX
    JZ FIM

    NEG BX

    FIM:
    RET

    ERRO3:
    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    JMP SINAL

ENTDEC ENDP ;-------------------------------------------------------------------------------------------------------------

SAIDEC PROC ;-------------------------------------------------------------------------------------------------------------

    LEA DX,MSGRES 
    MOV AH,09
    INT 21H
    
    MOV AX,BX
    
    CMP AX,0 ;compara ax com 0 e caso menor imprime o sinal negativo
    JGE SEGUE

    PUSH AX
    
    MOV DL,'-'
    MOV AH,02
    INT 21H
    
    POP AX
    NEG AX

    SEGUE:
    XOR BX,BX
    XOR CX,CX
 
    MOV BX,10

    CONV2:
    XOR DX,DX ;passa o resto das divisoes pra imprimir numero por numero do resultado
    DIV BX
    PUSH DX

    INC CX

    OR AX,AX
    JNZ CONV2

    IMP3:
    POP DX

    OR DX,30H
    MOV AH,02
    INT 21H

    LOOP IMP3

    RET

SAIDEC ENDP

END MAIN