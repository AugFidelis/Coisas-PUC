TITLE ATIVIDADE 8 EXERCICIO 3
.MODEL SMALL
.STACK 100H
.DATA
    MATRIZ  DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
    SOMAT DB ?
    NOVALINHA DB 13,10,'$'
    MSGLER DB 'INSIRA OS VALORES DA MATRIZ 4x4: $'
    MSGERRO DB '(!)$'
    MSGMATRIZ DB 13,10,'MATRIZ: $'
    MSGSOMA DB 13,10,'SOMA: $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL LEITURA
    CALL IMPRIME

    CALL SOMA
    
    CALL SAIDEC
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP

LEITURA PROC ;--------------------------------------------------------------------------------------------------
    
    LEA DX,MSGLER
    MOV AH,09
    INT 21H

    CALL PULA_LINHA
    
    MOV CH,4
    XOR SI,SI
    
    COLUNA:
        
        MOV CL,4
        XOR BX,BX

        LINHA:
            
            MOV AH,01
            INT 21H

            CMP AL,30H
            JB ERRO

            CMP AL,36H
            JA ERRO

            AND AL,0FH
            
            MOV BYTE PTR MATRIZ[SI+BX],AL

            INC BX
            DEC CL
            
        OR CL,CL
        JNZ LINHA

    CALL PULA_LINHA
    
    ADD SI,4
    DEC CH
    
    OR CH,CH
    JNZ COLUNA

    RET

    ERRO:
        LEA DX,MSGERRO
        MOV AH,09
        INT 21H
        XOR AX,AX
    JMP LINHA

LEITURA ENDP

SOMA PROC ;----------------------------------------------------------------------------------------------------

    XOR SI,SI
    MOV CH,4
    XOR AX,AX

    SOMAR_COL:
        MOV CL,4
        XOR BX,BX

        SOMAR_LIN:
            
           ADD AL,MATRIZ[SI+BX]

            INC BX
            DEC CL

            OR CL,CL
            JNZ SOMAR_LIN

    
    ADD SI,4
    DEC CH

    OR CH,CH
    JNZ SOMAR_COL
    MOV SOMAT,AL
    RET

    SOMA ENDP
    
SAIDEC PROC ;---------------------------------------------------------------------------------------------------
    
    XOR AX,AX
    MOV AL,SOMAT
    
    @END_IF1:
        XOR CX,CX ; contador de d?gitos
        MOV BX,10 ; divisor
        
        @REP1:
            XOR AH,AH ; prepara parte alta do dividendo
            DIV BX ; AX = quociente DX = resto
            PUSH AX ; salva resto na pilha
            INC CX ; contador = contador +1
            ;until
            OR AL,AL ; quociente = 0?
            JNE @REP1 ; nao, continua
            ; converte digito em caractere
            MOV AH,2
            ; for contador vezes
        
        @IMP_LOOP:
            POP AX ; digito em DL
            
            MOV DL,AH
            OR DL,30H
            INT 21H
        
        LOOP @IMP_LOOP
        ; fim do for
        
SAIDEC ENDP

IMPRIME PROC ;-------------------------------------------------------------------------------------------
    CALL PULA_LINHA

    LEA DX,MSGMATRIZ
    MOV AH,09
    INT 21H

    CALL PULA_LINHA
    
    ;Zera SI
    XOR SI,SI
    
    ;Copia o valor 4 para CH para repetir o laço de fora 4 vezes
    MOV CH,4
    
    LACO_FORA:
        MOV AH,2 ;Prepara o comando de leitura de caractere
        
        ;Copia o valor 4 para CL para repetir o laço de dentro 4 vezes
        MOV CL,4
        
        ;Zera BX
        XOR BX,BX

        LACO_DENTRO:
            ;Copia o valor do endereço [SI,BX] da matriz para DL
            MOV DL, MATRIZ[SI+BX]
            ADD DL, 30H
            INT 21H ;Le o caractere
            
            ;Copia o valor de 'ESPAÇO' para DL e lê
            MOV DL,20H
            INT 21H 
            
            INC BX ;Aumenta BX para ir para o próximo endereço da linha
            DEC CL ;Diminui CL para seguir o loop
        JNZ LACO_DENTRO
        
        CALL PULA_LINHA ;Chama a função de pular linha
        
        ADD SI,4 ;Aumenta SI em 4 para pular para a próxima coluna
        DEC CH ;Diminui CH para seguir o loop externo
    JNZ LACO_FORA

    RET ;Retorna para MAIN
IMPRIME ENDP

PULA_LINHA PROC ;-----------------------------------------------------------------------------------------------
    ;Exibe LINHA, que pula uma linha
    LEA DX, NOVALINHA
    MOV AH,9
    INT 21H
    
    RET ;Retorna para IMPRIME
PULA_LINHA ENDP

END MAIN