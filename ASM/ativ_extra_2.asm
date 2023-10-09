TITLE atividade extra
.MODEL SMALL
.DATA
    msg1 db 'Insira uma letra: $'
    msg2 db 13,10,'A letra maiuscula e: $'
.CODE
MAIN PROC

    ;permite o acesso as informacoes do .DATA
    MOV AX,@DATA
    MOV DS,AX

    ;exibe a primeira mensagem
    LEA DX,msg1
    MOV AH,09
    INT 21H

    ;le o caractere
    MOV AH,01
    INT 21H

    ;subtrai 32 do valor decimal para transforma-lo na letra equivalente maiuscula
    SUB AL,32
    MOV BL,AL

    ;exibe a segunda mensagem
    LEA DX,msg2
    MOV AH,09
    INT 21H
    
    ;exibe o caractere maiusculo
    MOV DL,BL
    MOV AH,02
    INT 21H

    ;encerra o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN