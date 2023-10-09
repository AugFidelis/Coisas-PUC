TITLE ATIVIDADE 2
.MODEL SMALL
.DATA
    msg1 db 'Digite um primeiro numero: $'
    msg2 db 13,10,'Digite um segundo numero: $'
    msg3 db 13,10,'A soma dos dois numeros e: $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;le a msg 1
    LEA DX,msg1 
    MOV AH,09
    INT 21H

    ;le o caractere inserido
    MOV AH,01
    INT 21H

    ;subtrai 48 do decimal, tranformando ele no numero
    SUB AL,48
    MOV BL,AL

    ;le a msg 2
    LEA DX,msg2
    MOV AH,09
    INT 21H

    ;le o segundo caractere inserido
    MOV AH,01
    INT 21H

    ;subtrai 48 do decimal novamente
    SUB AL,48
    MOV BH,AL

    ;adiciona os dois e adiciona mais 48 para obter o decimal do numero somado
    ADD BL,BH
    ADD BL,48

    ;le a msg 3
    LEA DX,msg3
    MOV AH,09
    INT 21H
    
    ;exibe a soma dos numeros
    MOV DL,BL
    MOV AH,02
    INT 21H

    ;encerra o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN




    