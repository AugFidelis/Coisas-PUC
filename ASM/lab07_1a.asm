TITLE Exercicio 1-a)
.MODEL SMALL
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
    ;Permite o acesso ao conteúdo do .DATA
    MOV AX, @DATA
    MOV DS,AX 

    XOR DL,DL ;Transforma o DL em 0
    MOV CX,6 ;Copia o valor 6 para CX, para que o LOOP se repita 6 vezes

    LEA BX, VETOR ;Faz que BX aponte para o offset do vetor (seu primeiro valor)
    VOLTA:
        
        MOV DL,[BX] ;Copia o conteúdo do endereço apontado por BX para DL (o número do vetor representado por BX)
        
        INC BX ;Incrementa 1 em BX para ir para o próximo número no próximo loop

        ADD DL, 30H ;Transforma o número de DL em valor hexadecimal para a sua leitura
        
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
