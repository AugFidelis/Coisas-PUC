TITLE LAB 04-3
.MODEL SMALL
.STACK 100h
.DATA
    msg1 db 'O alfabeto maiusculo e: $'
    msg2 db 13,10,'O alfabeto e: $'
.CODE
MAIN PROC
    ;permite o acesso as informacoes do .data
    MOV AX,@DATA
    MOV DS,AX

    ;exibe a primeira mensagem
    MOV AH,09
    LEA DX,msg1
    INT 21H
    
    ;copia o valor 65 decimal para DL que equivale ao valor de 'A'
    MOV DL,65
    ;copia o valor 26 para CX, que é o numero de letras e vezes que o loop sera repetido
    MOV CX,26
    
    MPROX:

        ;exibe a letra na tela
        MOV AH,02
        INT 21H
        
        ;aumenta DL em 1, indo para a proxima letra
        INC DL
        ;repete o rótulo até as 26 letras serem exibidas
        LOOP MPROX
    
    ;exibe a segunda mensagem
    MOV AH,09
    LEA DX,msg2
    INT 21H

    ;copia o valor 97 decimal para DL que equivale ao valor de 'a'
    MOV DL,97
    ;copia o valor 26 para CX, que é o numero de letras e vezes que o loop sera repetido
    MOV CX,26
  
    PROX:
        
        ;exibe a letra na tela
        MOV AH,02
        INT 21H

        ;aumenta DL em 1, indo para a proxima letra
        INC DL
        ;repete o rótulo até as 26 letras serem exibidas
        LOOP PROX

    ;termina o programa
    MOV AH,4CH
    INT 21H 

    MAIN ENDP
    END MAIN