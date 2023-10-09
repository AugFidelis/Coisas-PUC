TITLE LAB 04-4
.MODEL SMALL
.STACK 100h
.DATA
    LF equ 10
.CODE
MAIN PROC
    ;permite o acesso ao conteudo do .data
    MOV AX,@DATA
    MOV DS,AX

    ;copia o valor 97 (a) para DL
    MOV DL,97
    ;copia o valor 26 (numero de letras) para CX para se usar no loop
    MOV CX,26

    ;move o valor 4 para BL que é o numero de letras por linha
    MOV BH,4
        
    VOLTA:

        ;exibe uma letra
        MOV AH,02
        INT 21H
        
        ;aumenta DL por 1 para ir para a proxima letra
        INC DL
        ;diminui BH por 1 pois foi lida 1 letra das 4 por linha
        DEC BH
        ;pula para o rotulo SALTAR enquanto BH nao for 0 para não exibir o pulo de linha 
        ;até as 4 letras serem lidas
        JNZ SALTAR

        ;copia 4 para BH novamente para o próximo loop
        MOV BH,4
        
        ;copia o conteudo de DX para o topo do stack
        PUSH DX

        ;exibe um pulo de linha
        MOV DL,LF
        INT 21H
        
        ;recupera o valor de DX do topo do stack
        POP DX
    
    SALTAR:
        
        ;pula para o começo do rótulo e diminui CX por 1 até ser 0
        LOOP VOLTA
    
    
    ;termina o programa
    MOV AH,4Ch
    INT 21H



MAIN ENDP
END MAIN