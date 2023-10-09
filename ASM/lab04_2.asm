TITLE LAB 04-2
.MODEL SMALL
.STACK 100h
.DATA
    LF equ 10
.CODE
MAIN PROC
    ;permite o acesso ao conteudo do .data
    MOV AX,@DATA
    MOV DS,AX
    
    ;copia o valor 42, valor do *, para DL
    MOV DL,42
   
    ;copia o valor 50, que é o numero de vezes que o loop sera realizado, a CL
    MOV CX,50
    
    ;loop de imprimir * 50 vezes na mesma linha
    VOLTA:
        
        ;mostra o *
        MOV AH,02
        INT 21H

        ;diminui o CX em 1 e pula de volta para o começo do rótulo
        LOOP VOLTA
    
    ;copia 50 novamente para poder fazer o proximo lop
    MOV CX,50
    
    ;aguarda o input do usuario para continuar o codigo
    MOV AH,01
    INT 21H
    
    ;loop de imprimir * 50 vezes, um em cada linha
    NOVALINHA:
        
        ;mostra o *
        MOV AH,02
        INT 21H

        ;copia o valor de dx para o topo do stack para nao se perder o valor dele durante o pulo de linha
        PUSH DX

        ;pula a linha
        MOV DL,LF
        INT 21H

        ;recupera o valor de dx do stack
        POP DX

        ;diminui o CX em 1 e pula de volta para o começo do rótulo
        LOOP NOVALINHA
    
    ;termina o programa
    MOV AH,4Ch
    INT 21H
MAIN ENDP
END MAIN