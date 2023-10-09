TITLE TENTATIVA
MODEL SMALL
STACK 100H
.DATA
    msg1 db 'Insira o dividendo: $'
    msg2 db 13,10,'Insira o divisor: $'
    msg3 db 13,10,'Quociente: $'
    msg4 db 13,10,'Resto: $'
.CODE
MAIN PROC
    ;permite o acesso ao conteúdo do .DATA
    MOV AX,@DATA
    MOV DS,AX

    ;exibe a primeira mensagem
    LEA DX,msg1
    MOV AH,09
    INT 21H
    
    LER1:

    ;le o dividendo
    MOV AH,01
    INT 21H

    CMP AL,48
    JB LER1

    CMP AL,57
    JA LER1

    ;move o conteúdo de BL para AL para não se perder com a leitura do divisor
    MOV BL,AL

    ;exibe a segunda mensagem
    LEA DX,msg2
    MOV AH,09
    INT 21H

    LER2:
    
    ;le o divisor
    MOV AH,01
    INT 21H

    CMP AL,48
    JB LER2

    CMP AL,57
    JA LER2

    ;faz com que o valor decimal deles seja igual ao número em si para serem usados na operação
    AND BL,0Fh
    AND AL,0Fh

    ;rótulo da operação, o pulo irá repetir isso até a condição ser falsa
    OPERACAO:
        ;aumenta o quociente com cada repetição
        INC BH
        
        ;subtrai o valor do divisor do dividendo
        SUB BL,AL

        ;compara os dois e repete o processo até o valor do dividendo for menor que o dividendo,
        ;resultando no resto da operação, pois é menor que o divisor e não pode mais ser dividido
        CMP BL,AL
        JAE OPERACAO

    ;restaura o valor decimal dos números
    OR BL,30H
    OR BH,30H
    
    ;exibe a terceira mensagem
    LEA DX,msg3
    MOV AH,09
    INT 21H
    
    ;exibe o valor do quociente
    MOV DL,BH
    MOV AH,02
    INT 21H

    ;exibe a quarta mensagem
    LEA DX,msg4
    MOV AH,09
    INT 21H

    ;exibe o valor do resto da divisão
    MOV DL,BL
    MOV AH,02
    INT 21H

    ;finaliza o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN