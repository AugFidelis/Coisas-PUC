TITLE Atividade 6
.MODEL SMALL
.STACK 100h
.DATA
    LF equ 10
.CODE
MAIN PROC
    ;permite o acesso ao conteudo do .data
    MOV AX,@DATA
    MOV DS,AX
    
    ;copia o valor 4 para CX para que o LOOP se repita 4 vezes
    MOV CX,04

    REPETIR:
    
    ;le o caractere
    MOV AH,01
    INT 21H

    ;copia o valor de AL para DL para a leitura do caractere
    MOV DL,AL

    ;compara DL com o valor decimal de 'A', e caso igual pula para a parte de transformar em '*'
    CMP DL,65
    JE AMIN

    ;caso não for 'A', compara com o valor de 'a' e caso diferente pula a parte de transformar em '*'
    CMP DL,97
    JNE PULAR

    ;pula a comparação de 'a' caso for 'A'
    AMIN:
    
    ;copia o valor de '*' para DL para impressao
    MOV DL,42
    
    PULAR:

    ;le o caractere
    MOV AH,02
    INT 21H

    ;pula para a proxima linha
    MOV DL,LF
    INT 21H

    ;repete o loop até CX ser 0
    LOOP REPETIR

    ;encerra o programa
    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN