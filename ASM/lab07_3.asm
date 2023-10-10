TITLE ATIVIDADE 7 EXERCICIO 3
.MODEL SMALL
.DATA
    VETOR DB 1, 2, 3, 4, 5, 6, 7
.CODE
MAIN PROC
    ;Permite o acesso ao conteúdo de .DATA
    MOV AX,@DATA
    MOV DS,AX

    MOV CX,03 ;Faz com que CX seja 3 para que o loop se repita 3 vezes
    ;O loop se repete apenas 3 vezes (metade) para evitar que o vetor se espelhe ao inverter ele

    XOR SI,SI ;Zera SI
    MOV DI,06 ;Copia o valor 6 para DI para começar ele no fim do vetor

    INVERTER:
        
        MOV AL,VETOR[SI] ;Move o número do vetor na sequência normal para AL
        MOV BL,VETOR[DI] ;Move o número do vetor na sequência invertida para BL

        XCHG AL,BL ;Inverte o valor atual de AL com o de BL
    
        MOV VETOR[SI],AL ;Move o número invertido de volta para o vetor na sequência normal
        MOV VETOR[DI],BL ;Move o número invertido de volta para o vetor na sequência invertida
        ;Isso é feito para a primeira metade e a segunda metade dos vetores se inverterem e não serem perdidos

        INC SI ;Aumenta SI para ir para a próxima posição
        DEC DI ;Diminui DI para voltar uma posição na sequência inversa
        
        LOOP INVERTER ;Pula de volta para o rótulo e diminui CX por 1

    MOV CX,07 ;Copia o valor 7 para CX para repetir o loop 7 vezes
    XOR SI,SI ;Zera SI para ler o vetor invertido a partir da primeira posição
    
    IMPRIMIR:
        
        MOV DL,VETOR[SI] ;Copia o valor do vetor na posição SI para DL
        
        INC SI ;Aumenta SI para ir para a próxima posição
        
        OR DL,30H ;Transforma DL de número para valor hexadecimal

        ;Exibe o valor de DL
        MOV AH,02
        INT 21H

    LOOP IMPRIMIR ;Repete o processo até CX ser 0

    ;Finaliza o programa
    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN
