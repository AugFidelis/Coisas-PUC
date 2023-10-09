TITLE ATIVIDADE 2
.MODEL SMALL
.DATA
    msg1 db 'Digite uma letra minuscula: $'
    msg2 db 13,10,'A letra maiuscula correspondente e: $'
.CODE
MAIN PROC
    ;exibe o conteudo da msg1
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX,msg1 ;passa o conteudo da msg1 para o DX
    MOV AH,09 ;le o conteudo do DX
    INT 21H

    ;le o caractere inserido (salvo no AL)
    MOV AH,01 
    INT 21H 

    ;transforma o caractere em mauisculo 
    ;(diminui o endereço decimal por 32 para indicar o endereço da maiuscula)
    SUB AL,32
    
    ;passa o conteudo do AL para BL
    MOV BL,AL

    ;exibe o conteudo da msg2
    LEA DX,msg2
    MOV AH,09
    INT 21H

    ;exibe o caractere maiusculo
    MOV DL,BL
    MOV AH,02 ;le o conteudo do DL
    INT 21H

    ;encerra o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN



