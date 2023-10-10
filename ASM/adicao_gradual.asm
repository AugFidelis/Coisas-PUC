TITLE VETOR
.MODEL SMALL
.DATA 
    VETOR DW 1,3,1,0,1,2
    LF EQU 10
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    XOR BX,BX
    XOR AX,AX
    MOV CX,6
    
    INICIO:
        ADD AX,VETOR[BX]
        ADD BX,2
        
        MOV DL,AL
        
        OR DL,30H
        MOV AH,02
        INT 21H

        PUSH AX
        
        MOV DL,LF
        INT 21H

        POP AX
        
    LOOP INICIO

    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN