TITLE ativ extra
.MODEL SMALL
.DATA
    msg1 db 'Insira um caractere: $'
    msg2 db 13,10,'O caractere digitado e: $'

.CODE
MAIN PROC

    ;permite o acesso as informacoes de .DATA
    MOV AX,@DATA
    MOV DS,AX

    ;exibe a primeira mensagem
    LEA DX,msg1
    MOV AH,09
    INT 21H

    ;le o caractere
    MOV AH,01
    INT 21H

    ;copia o caractere de AL para BL
    ;(MOV AH,01 retorna o valor ascii para AL)
    MOV BL,AL

    ;exibe a segunda mensagem
    LEA DX,msg2
    MOV AH,09
    INT 21H

    ;exibe o caractere
    MOV DL,BL
    MOV AH,02
    INT 21H

    ;encerra o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN