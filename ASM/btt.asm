.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'TOMAR NO CU$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG1
    MOV AH,09
    INT 21H

    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN