TITLE ESTUDO AULA 12
.MODEL SMALL

PULALINHA MACRO
    PUSH DX
    PUSH AX
    MOV DL,10
    MOV AH,02
    INT 21H
    POP AX
    POP DX
    ENDM

.DATA
    VETOR DB 31H,32H,33H,34H,35H,36H
    VETOR2 DB 6 DUP(?),'$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    LEA SI,VETOR+5 ;+5 PRA COMEÇAR DO FIM E IR DE LA PRO COMEÇO
    LEA DI,VETOR2
    
    STD ; SETA DF, QUANDO 1 A DIREÇÃO DO VETOR É DO CONTRA

    MOV CX,6
    
    MOVER:
    MOVSB ;PASSA O CONTEUDO DO VETOR1 (ENDERECO EM SI) PARA O VETOR2 (ENDERECO EM DI)
    ADD DI,2 ;POR CAUSA DO STD, TD VEZ Q TEM O MOVSB ELE DECREMENTA AMBOS SI E DI, MAS QUEREMOS Q VETOR2 VA PRA FRENTE
             ;ENTAO ADICIONA 2 PRA DESFAZER O DECREMENTO E ADICIONAR MAIS UM PRA IR PRA FRENTE
    LOOP MOVER

    LEA DX,VETOR2
    MOV AH,09
    INT 21H

    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN