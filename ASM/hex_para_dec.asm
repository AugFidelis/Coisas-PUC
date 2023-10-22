TITLE ODEIO MINHA VIDA
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'INSIRA UM VALOR HEXADECIMAL: $'
    CONTINUAR DB 13,10,'DESEJA CONTINUAR O PROGRAMA? (INSIRA "S" CASO SIM): $'
    MSGDEC DB 13,10,'VALOR DECIMAL: $'
    NOVALINHA DB 13,10,'$'
    VALOR DB ?
    VALORCONV DB ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG1
    MOV AH,09
    INT 21H

    CALL ENTDEC

    CALL CONVERTE

    CALL SAIDEC
    
    
    MOV AH,4CH
    INT 21H



MAIN ENDP

ENTDEC PROC

    XOR BL,BL
    
    LER:
        MOV AH,01
        INT 21H

        CMP AL,0DH
        JE SAIR

        AND AL,0FH
        PUSH AX

        MOV AL,10
        MUL BL
        POP BX
        ADD BL,AL

        JMP LER

    SAIR:

        MOV VALOR,BL

        RET


ENTDEC ENDP

CONVERTE PROC

    MOV AL,VALOR

    VEZES:
            
        XOR AH,AH ;zera AH
        DIV BL ;divide AL por BL
        PUSH AX ;guarda AX na pilha
        INC CX ;aumenta CX para o loop de impressão
        
        OR AL,AL ;compara com 0 e pula caso for igual
        JNE VEZES
    
    POTENCIA:

        POP AX
        MOV AL,AH
        MOV BL,16

        MUL BL
        LOOP POTENCIA

        MOV VALORCONV,AL
        RET
    
    

CONVERTE ENDP

SAIDEC PROC

    CALL PULA_LINHA
    
    LEA DX,MSGDEC
    MOV AH,09
    INT 21H
    
    XOR AX,AX ;prepara AX
    MOV AL,VALORCONV ;copia o valor de SOMAT de volta para AL para a divisão
    
    XOR CX,CX ;prepara CX
    MOV BX,10 ;copia 10 para BX como divisor
        
    @REP1:
        XOR AH,AH ;zera AH
        DIV BL ;divide AL por BL
        PUSH AX ;guarda AX na pilha
        INC CX ;aumenta CX para o loop de impressão
    
        OR AL,AL ;compara com 0 e pula caso for igual
        JNE @REP1 
            
        
    @IMP_LOOP:
        POP AX ;pega o conteúdo guardado na pilha
            
        MOV DL,AH ;copia o conteúdo do resto da divisão guardado em AH para DL
        OR DL,30H

        MOV AH,02 ;le o conteúdo de DL
        INT 21H
        
    LOOP @IMP_LOOP

    RET

SAIDEC ENDP

PULA_LINHA PROC ;-----------------------------------------------------------------------------------------------
    ;Exibe LINHA, que pula uma linha
    LEA DX, NOVALINHA
    MOV AH,9
    INT 21H
    
    RET ;Retorna para IMPRIME
PULA_LINHA ENDP

END MAIN