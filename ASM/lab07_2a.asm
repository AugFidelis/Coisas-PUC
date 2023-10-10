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
    
    LEA SI, VETOR ;Aponta SI para o começo do vetor
    VOLTA:
        MOV DL,[SI] ;Copia o conteúdo do endereço apontado por SI para DL
        
        INC SI ;Aumenta SI para ir para o próximo valor do vetor
        
        ADD DL,30H ;Transforma DL de número para valor hexadecimal para leitura
        
        ;Exibe o número em DL
        MOV AH,02
        INT 21H
    LOOP VOLTA
    
    ;Finaliza o programa
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
