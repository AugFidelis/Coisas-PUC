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
    

;-------------------------------------------------------------------------------------------------------------

;-------------------------------------------------------------------------------------------------------------

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


MAIN ENDP

END MAIN