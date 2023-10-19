TITLE ATIVIDADE 8 EXERCICIO 3
.MODEL SMALL
.STACK 100H
.DATA
    MATRIZ  DB 4 DUP(4 DUP(?))
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

    CALL LEITURA ;Chama a função de leitura
    
    CALL IMPRIME ;Chama a função de exibição da matriz

    CALL SOMA ;Chama a função de cálculo da soma
    
    CALL SAIDEC ;Chama a função de exibição do resultado da soma
    
    ;Finaliza o programa
    MOV AH,4CH
    INT 21H
    
MAIN ENDP

LEITURA PROC ;--------------------------------------------------------------------------------------------------
    
    ;Exibe a mensagem
    LEA DX,MSGLER
    MOV AH,09
    INT 21H

    CALL PULA_LINHA ;Chama a função que pula uma linha
    
    MOV CH,4 ;Faz com que o loop externo se repita 4 vezes
    XOR SI,SI ;Prepara SI
    
    COLUNA:
        
        MOV CL,4 ;loop interno repete 4 vezes
        XOR BX,BX ;prepara BX

        LINHA:
            
            MOV AH,01 ;le caractere
            INT 21H

            CMP AL,30H ;caso menor que 0, da erro e não registra o numero
            JB ERRO

            CMP AL,36H ;caso maior que 6, da erro e não registra o numero
            JA ERRO

            AND AL,0FH ;transforma valor ASCII no número
            
            MOV BYTE PTR MATRIZ[SI+BX],AL ;copia o valor colocado pelo usuário na posição SI,BX

            INC BX ;aumenta bx para seguir para o próximo valor da linha
            DEC CL ;avança o loop
            JNZ LINHA

    CALL PULA_LINHA
    
    ADD SI,4 ;pula para a próxima coluna
    DEC CH ;avança o loop externo
    JNZ COLUNA

    RET

    ERRO:
        LEA DX,MSGERRO ;exibe uma mensagem de erro
        MOV AH,09
        INT 21H
    JMP LINHA

LEITURA ENDP

SOMA PROC ;----------------------------------------------------------------------------------------------------

    XOR SI,SI ;prepara SI
    MOV CH,4 ;faz com que o loop repita 4 vezes
    XOR AX,AX ;prepara AX

    SOMAR_COL:
        MOV CL,4 ;loop interno repete 4 vezes
        XOR BX,BX ;prepara BX

        SOMAR_LIN:
            
            ADD AL,MATRIZ[SI+BX] ;adiciona o valor atual da matriz a AL

            INC BX ;pula para o prox endereço da linha
            DEC CL ;continua o loop
            JNZ SOMAR_LIN ;checa se CL é zero e reinicia o loop caso não

    
    ADD SI,4 ;pula para a prox coluna
    DEC CH ;continua o loop
    JNZ SOMAR_COL
    
    MOV SOMAT,AL ;copia o valor acumulado de AL para a variavel SOMAT
    
    RET ;retorna para MAIN

SOMA ENDP
    
SAIDEC PROC ;---------------------------------------------------------------------------------------------------
    
    CALL PULA_LINHA
    
    LEA DX,MSGSOMA
    MOV AH,09
    INT 21H
    
    XOR AX,AX ;prepara AX
    MOV AL,SOMAT ;copia o valor de SOMAT de volta para AL para a divisão
    
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