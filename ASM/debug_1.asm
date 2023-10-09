TITLE alfabeto
.MODEL SMALL
.STACK 100h
.DATA
    msg1 db 'O alfabeto e: $'
    msg2 db 13,10,'O alfabeto maiusculo e: $'
    LF equ 10
.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    MOV AH,09
    LEA DX,msg1
    INT 21H

    MOV DL,97
  
    PROX:

        PUSH DX
        
        MOV AH,01
        
        MOV DL,LF
        INT 21H

        POP DX
        
        MOV AH,02
        INT 21H

        INC DL

        CMP DL,122
        JB PROX
    
    MOV AH,09
    LEA DX,msg2
    INT 21H
    
    MOV AL,64
    MOV BL,AL

    MPROX:
        ADD BL,1

        MOV DL,BL
        MOV AH,02
        INT 21H
        
        CMP BL,90
        JB MPROX

    MOV AH,4CH
    INT 21H 

    MAIN ENDP
    END MAIN