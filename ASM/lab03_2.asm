TITLE Lab 3
.MODEL SMALL
.STACK 100h
.DATA
    msg1 db 'Insira um caractere: $'
    LET db 13,10,'O caractere e uma letra.$'
    NUM db 13,10,'O caractere e um numero.$'
    msg2 db 13,10,'O caractere e um caractere desconhecido.$'
.CODE
    MAIN PROC
        ;permite o acesso ao conteudo do .DATA
        MOV AX,@DATA
        MOV DS,AX
        
        ;exibe a primeira mensagem
        MOV AH,09
        LEA DX,msg1
        INT 21H
    
        ;le o caractere
        MOV AH,01
        INT 21H

        ;copia a informacao do caractere para BL
        MOV BL,AL

        ;caso abaixo de 48 decimal, o caractere é caractere desconhecido
        CMP BL,48
        JB DESC
        
        ;caso o anterior for falso, caso abaixo de 58, o caractere é numero
        CMP BL,58
        JB NUMERO
        
        ;caso os anteriores forem falsos, caso abaixo de 65, o caractere é desconhecido
        CMP BL,65
        JB DESC

        ;caso os anteriores forem falsos, caso abaixo de 91 o caractere é letra
        CMP BL,91
        JB LETRA

        ;caso os anteriores forem falsos, caso abaixo de 97, o caractere é desconhecido
        CMP BL,97
        JB DESC

        ;caso os anteriores forem falsos, caso abaixo ou igual a 122, o caractere é letra
        CMP BL,122
        JBE LETRA

        ;caso os anteriores forem falsos, caso acima de 122, o caractere é desconhecido
        CMP BL,122
        JA DESC

        ;rotulo caso o caractere for letra que exibe a mensagem
        LETRA:
            MOV AH,09
            LEA DX,LET
            INT 21H
            JMP FIM
        
        ;rotulo caso o caractere for numero que exibe a mensagem
        NUMERO:
            MOV AH,09
            LEA DX,NUM
            INT 21H
            JMP FIM
        
        ;rotulo caso o caractere for desconhecido que exibe a mensagem
        DESC:
            MOV AH,09
            LEA DX,msg2
            INT 21H
        
        ;rotulo que encerra o programa
        FIM:
            MOV AH,4CH
            INT 21H
        
    MAIN ENDP
    END MAIN