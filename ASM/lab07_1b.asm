TITLE Exercicio 1-b)
.MODEL SMALL
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
    ;Permite o acesso ao conteúdo de .DATA
    MOV AX, @DATA
    MOV DS,AX
    
    XOR DL,DL ;Transforma DL em 0
    MOV CX,6 ;Faz com que o loop repita 6 vezes
    
    XOR BX,BX ;Transforma BX em 0
    VOLTA:
        MOV DL,VETOR[BX] ;Passa o valor do vetor na posição BX para DL
        
        INC BX ;Aumenta BX para ir para a próxima posição do vetor no próximo loop
        
        ADD DL,30H ;Transforma DL em valor hexadecimal
        
        ;Exibe o número em DL
        MOV AH,02
        INT 21H
        
        ;Pula de volta para o começo do rótulo e diminui CX por 1
        LOOP VOLTA
    
    ;Finaliza o programa
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
