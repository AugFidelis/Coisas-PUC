TITLE EXEMPLO DE ENTDEC E SAIDEC
.MODEL SMALL

NOVALINHA MACRO
    MOV DL,10
    MOV AH,02
    INT 21H
    ENDM

.STACK 100H
.DATA
.CODE
MAIN PROC

    CALL ENTDEC

    CALL SAIDEC

    MOV AH,4CH
    INT 21H


MAIN ENDP

ENTDEC PROC ;----------------------------------------------------------------------------------------------------
    
    XOR BX,BX

    MOV DL,'?'
    MOV AH,02
    INT 21H
    
    LER:

    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR

    AND AL,0FH

    PUSH AX

    MOV AX,10
    MUL BX
    
    POP BX
    ADD BX,AX

    JMP LER

    SAIR:
    RET

ENTDEC ENDP ;----------------------------------------------------------------------------------------------------

SAIDEC PROC ;----------------------------------------------------------------------------------------------------
    
    NOVALINHA

    XOR CX,CX

    MOV DL,'='
    MOV AH,02
    INT 21H

    MOV AX,BX
    MOV BL,10

    DIVIDIR:

    XOR AH,AH
    DIV BL

    PUSH AX

    INC CX

    OR AL,AL
    JNE DIVIDIR

    IMPRIMIR:
    POP AX

    MOV DL,AH
    OR DL,30H

    MOV AH,02
    INT 21H

    LOOP IMPRIMIR

    RET

SAIDEC ENDP

END MAIN