TITLE Ativ 3
.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB 'Digite um caractere: $'
    SIM DB 10,13,'O caractere digitado e uma letra minuscula.$'
    NAO DB 10,13,'O caractere digitado nao e uma letra minuscula.$'
.CODE
    MAIN PROC
    ;permite o acesso ao conteudo do .DATA
    MOV AX,@DATA
    MOV DS,AX
    
    ;exibe a primeira mensagem
    MOV AH,09
    LEA DX,MSG1
    INT 21h
    
    ;le um caractere
    MOV AH,01
    INT 21h
    
    ;move o conteudo de AL para BL
    MOV BL,AL
    
    ;compara o caractere de BL com o valor 97 decimal
    CMP BL,97
    ;pula para o rotulo caso for menor que 97
    JB NAOEMINUSCULO
    
    ;compara o caractere de BL com o valor 122 decimal
    CMP BL,122
    ;pula para o rotulo caso for maior que 122
    JA NAOEMINUSCULO
    
    ;exibe a mensagem caso for uma letra minuscula
    MOV AH,9
    LEA DX,SIM
    INT 21h
    
    ;pula para o rotulo FIM para evitar o rotulo NAOEMINUSCULO
    JMP FIM
    
    ;rotulo caso nao for minuscula que exibe a mensagem NAO
    NAOEMINUSCULO:
        MOV AH,9
        LEA DX,NAO
        INT 21h
    
    ;rotulo que encerra o programa
    FIM:
        MOV AH,4Ch
        INT 21h

MAIN ENDP
END MAIN