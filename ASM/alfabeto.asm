TITLE alfabeto
.MODEL SMALL
.STACK 100h
.DATA
    msg1 db 'O alfabeto maiusculo e: $'
    msg2 db 13,10,'O alfabeto e: $'
.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    MOV AH,09
    LEA DX,msg1
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
    
    MOV AH,09
    LEA DX,msg2
    INT 21H

    MOV AL,96
    MOV BL,AL
  
    PROX:
        ADD BL,1
        
        MOV DL,BL
        MOV AH,02
        INT 21H

        CMP BL,122
        JB PROX
    
    

    MOV AH,4CH
    INT 21H 

    MAIN ENDP
    END MAIN