TITLE INTERTER CARACTERES USANDO STACK
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC

    XOR CX,CX

    MOV DL,'?'
    MOV AH,02
    INT 21H

    MOV DL,10
    MOV AH,02
    INT 21H

    LER:
        MOV AH,01
        INT 21H

        CMP AL,0DH
        JE IMPRIMIR
        
        PUSH AX
        INC CX

        JMP LER

    IMPRIMIR:
        POP DX

        MOV AH,02
        INT 21H

        LOOP IMPRIMIR

    MOV AH,4CH
    INT 21H

        

MAIN ENDP
END MAIN