TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE MATRIZES, imprime uma matriz
.MODEL SMALL
.STACK 100H
.DATA
    MATRIZ4X4   DB 1,2,3,4
                DB 4,3,2,1
                DB 5,6,7,8
                DB 8,7,6,5
    LINHA DB 13,10,'$'
.CODE
MAIN PROC
    ;Permite o acesso ao conteúdo de .DATA
    MOV AX, @DATA
    MOV DS,AX
    
    CALL IMPRIME ;Chama a função de impressão da matriz
    
    ;Finaliza o programa
    MOV AH,4CH
    INT 21H
MAIN ENDP

PULA_LINHA PROC
    ;Exibe LINHA, que pula uma linha
    LEA DX, LINHA
    MOV AH,9
    INT 21H
    
    RET ;Retorna para IMPRIME
PULA_LINHA ENDP

IMPRIME PROC
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
            MOV DL, MATRIZ4X4[SI+BX]
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

END MAIN