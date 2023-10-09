TITLE ativ extra 
.MODEL SMALL
.DATA
    msg1 db 'Insira um valor: $'
    msg2 db 13,10,'Insira outro valor: $'
    msg3 db 13,10,'A soma dos valores e: $'

.CODE
MAIN PROC

    ;acessa as informacoes do .DATA
    MOV AX,@DATA
    MOV DS,AX

    ;exibe a primeira mensagem
    LEA DX,msg1
    MOV AH,09
    INT 21H

    ;le o caractere 
    MOV AH,01
    INT 21H

    ;copia o caractere para BL
    MOV BL,AL
    
    ;subtrai 48 do valor decimal do caractere para transformar ele no mesmo que o numero
    SUB BL,48

    ;exibe a segunda mensagem
    LEA DX,msg2
    MOV AH,09
    INT 21H

    ;le o segundo caractere
    MOV AH,01
    INT 21H

    ;subtrai 30 do valor hexadecimal do caractere
    ;funciona igual ao anterior porem em hexa ao inves de decimal
    SUB AL,30H

    ;adiciona os dois valores e adiciona 48 decimal para retornar o valor correto do resultado
    ADD BL,AL
    ADD BL,48

    ;exibe a terceira mensagem
    LEA DX,msg3
    MOV AH,09
    INT 21H
    
    ;exibe o resultado da soma
    MOV DL,BL
    MOV AH,02
    INT 21H

    ;encerra o programa
    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN