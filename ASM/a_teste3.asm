TITLE ATIVIDADE 7 EXERCICIO 3
.MODEL SMALL
.DATA
    VETOR DW 1, 2, 3, 4, 5, 6, 7
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV CX,03

    XOR SI,SI
    MOV DI,06

    INVERTER:
        
        MOV AX,VETOR[SI]
        MOV BX,VETOR[DI]

        XCHG AX,BX
        ;MOV CL,AL
        ;MOV AL,BL
        ;MOV BL,CL

        MOV VETOR[SI],AX
        MOV VETOR[DI],BX

        ADD SI,2
        SUB DI,2
        
        LOOP INVERTER

    MOV CX,07
    XOR SI,SI
    
    IMPRIMIR:
        
        MOV AX,VETOR[SI]
        MOV DL,AL
        
        ADD SI,2
        
        OR DL,30H

        MOV AH,02
        INT 21H

    LOOP IMPRIMIR

    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN
