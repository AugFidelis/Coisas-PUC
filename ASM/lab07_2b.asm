TITLE Exercicio 2-a)
.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
    ;Permite o acesso ao conteúdo de .DATA
    MOV AX, @DATA
    MOV DS,AX
    
    XOR DL, DL ;Zera DL
    MOV CX,6 ;Da o valor 6 para CX para repetir o loop 6 vezes
    
    XOR DI,DI ;Zera DI
    
    VOLTA:
        MOV DL,VETOR[DI] ;Copia o conteúdo do vetor na posição especificada por DI
        
        INC DI ;Aumenta DI para ir para a próxima posição
        
        ADD DL,30H ;Transforma DL de número para valor hexadecimal para leitura
        
        ;Exibe o número em DL
        MOV AH, 02
        INT 21H
    LOOP VOLTA
    
    ;Finaliza o programa
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
