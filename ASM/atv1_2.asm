TITLE ATIVIDADE 1
.MODEL SMALL
.DATA
    msg1 db 'Entre o caractere: $'
    msg2 db 13,10,'O caractere eh: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS,AX
    MOV DX, OFFSET msg1 ;LEA faz o equivalente ao MOV __ OFFSET
    
    MOV AH,09 ;escreve o string da msg 1, guardado no DX
    INT 21H 
    
    MOV AH,01 ;isso le o caractere no AL
    INT 21H

    MOV BL,AL ;passa a informacao do AL pro BL
    MOV DX, OFFSET msg2 ;aponta pra mensagem
    MOV AH,09 ;isso le o string q tava apontado
    INT 21H
    
    ;MOV DL,10 ;nova linha
    ;MOV DL,13 ;vai pro começo da linha
    ;MOV AH,02
    ;INT 21H 

    MOV DL,BL ;passa a informacao do caractere do BL pro DL
    MOV AH,02 ;isso le o caractere q tava apontado pelo DL
    INT 21H 

    MOV AH,4CH ;termina o programa
    INT 21H
MAIN ENDP
END MAIN

;http://cssimplified.com/wp-content/uploads/2015/02/Interrupt_INT21H.jpg