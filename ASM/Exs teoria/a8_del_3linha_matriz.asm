TITLE APAGAR TERCEIRA LINHA DE MATRIZ 3X4 E IMPRIMIR ELA
.MODEL SMALL

NOVALINHA MACRO
    MOV DL,10
    MOV AH,02
    INT 21H
    ENDM

.DATA
    MATRIZ  DW 1,2,3,4
            DW 5,6,7,8
            DW 9,10,11,12

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV SI,16
    MOV CX,4
    XOR BX,BX
    
    DELETAR:
        MOV MATRIZ[SI+BX],0
        ADD BX,2

    LOOP DELETAR

    XOR SI,SI
    MOV CH,3
    
    IMPRIMIR_COL:
        
        XOR BX,BX
        MOV CL,4

        IMPRIMIR_LIN:
            MOV DX,MATRIZ[SI+BX]
            
            OR DX,30H
            MOV AH,02
            INT 21H
            
            ADD BX,2

            DEC CL

        JNZ IMPRIMIR_LIN

        NOVALINHA

        ADD SI,8

        DEC CH
        JNZ IMPRIMIR_COL

        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN