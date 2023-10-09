.MODEL SMALL
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS,AX
    
    XOR DL, DL
    MOV CX,6
    LEA BX, VETOR
    
    VOLTA:
        MOV DL, [BX]
        INC BX
        
        ADD DL,30H ;transforma o número em valor hexadecimal para leitura
        MOV AH, 02
        INT 21H
        LOOP VOLTA
    
    MOV AH,4CH
    INT 21H ;saida para o DOS
MAIN ENDP
END MAIN
