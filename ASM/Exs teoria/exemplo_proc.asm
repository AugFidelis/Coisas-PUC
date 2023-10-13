TITLE MULTIPLICACAO POR SOMA E
.MODEL SMALL
.STACK 100h
.DATA
NUM1 DB 2
NUM2 DB 3
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AL,NUM1
    MOV BL,NUM2
    
    CALL MULTIPLICA
    CALL IMPRIME
    
    MOV AH,4Ch
    INT 21h
MAIN ENDP
MULTIPLICA PROC
    ;multiplica dois numeros
    ;A e B por soma e deslocamento
    ;entradas: AX = A, BX = B,
    ; numeros na faixa 00h - FFh
    ;saida: DX = A*B (produto)
    PUSH AX
    PUSH BX ;salva os conteudos de AX e BX
    
    AND DX,0 ;inicializa DX em 0
    ;repeat if B e' impar
    
    TOPO:
        TEST BX,1 ;LSB de BX = 1?
        JZ PT1 ;nao, (LSB = 0)
        ;then
        ADD DX,AX ;sim, entao
        ;produto = produto + A
        ;end_if
    PT1:
        SHL AX,1 ;desloca A para a esquerda 1 bit
        SHR BX,1 ;desloca B para a direita 1 bit
        ;until
        JNZ TOPO ;fecha o loop repeat
        POP BX
        POP AX ;restaura os conteudos de BX e AX
        RET ;retorno para o ponto de chamada
MULTIPLICA ENDP
IMPRIME PROC
    ; imprime um numero decimal de 1 digito
    ; entrada DL
    ; saída nao ha
    PUSH AX ; SALVA AX E DX NA PILHA
    PUSH DX
    
    MOV AH,02H
    OR DL,30h
    INT 21h ;IMPRIME CARACTER NUMERICO
    
    POP DX ; RESTAURA DX E AX
    POP AX
    
    RET ;retorno para o ponto de chamada
IMPRIME ENDP
END MAIN
