TITLE ATIVIDADE 10
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
    VETOR1 DB 'bom dia pannain'
    VETORLER DB 15 DUP(?)
    VETORCOPIA DB 15 DUP(?)
    MSGLER DB 'INSIRA UMA STRING: $'
    MSGSTR DB 'STRING INSERIDA: $'
    MSGCOPIA DB 'STRING COPIADA: $'
    MSGIGUAL DB 'A STRING E IGUAL$'
    MSGNAOIGUAL DB 'A STRING NAO E IGUAL$'
    MSGQUANT DB 'A QUANTIDADE DE LETRAS "a" NA STRING E: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    MOV ES,AX ;inicializa ES

    CALL LER

    CALL COPIAR

    CALL COMPARAR

    CALL QUANT_A

    MOV AH,4CH ;finaliza o programa
    INT 21H

MAIN ENDP

LER PROC

    LEA DX,MSGLER
    MOV AH,09
    INT 21H
    
    CLD
    LEA DI,VETORLER ;aponta o indice de destino para o vetor

    MOV CX,15

    LER_LOOP:
    MOV AH,01 ;le um caractere
    INT 21H

    CMP AL,0DH ;compara com enter
    JE SAI

    STOSB ;copia o conteúdo de AL para o endereço do vetor apontado por DI, e aumenta ambos SI e DI
    LOOP LER_LOOP

    SAI:
    PULALINHA
    
    LEA DX,MSGSTR
    MOV AH,09
    INT 21H
    
    LEA SI,VETORLER ;aponta o indice de fonte para o vetor

    MOV CX,15

    IMP:
    LODSB ;copia o conteúdo do endereço do vetor apontado por SI para AL, aumenta SI e DI

    MOV DL,AL
    MOV AH,02 ;le o caractere em DL
    INT 21H
    LOOP IMP

    RET

LER ENDP

COPIAR PROC

    LEA SI,VETORLER ;aponta SI para o vetor que será copiado
    LEA DI,VETORCOPIA ;aponta DI para o vetor onde o conteúdo copiado será inserido

    MOV CX,15
    REP MOVSB ;repete CX número de vezes, move o conteúdo do primeiro vetor em SI para o segundo vetor em DI

    PULALINHA
    LEA DX,MSGCOPIA
    MOV AH,09
    INT 21H
    
    LEA SI,VETORCOPIA ;aponta SI para o vetor onde foi copiado o conteudo para leitura

    MOV CX,15

    IMP_COPIA:
    LODSB ;move o endereço SI do vetor para AL

    MOV DL,AL
    MOV AH,02 ;le o conteudo de DL
    INT 21H
    LOOP IMP_COPIA
    
    RET

COPIAR ENDP

COMPARAR PROC

    ;aponta os vetores a serem comparados para SI e DI
    LEA SI,VETORLER
    LEA DI,VETOR1

    MOV CX,15
    REP CMPSB ;compara os conteudos SI e DI dos vetores, caso diferentes, ZF será 1. repete CX numero de vezes
    JNZ NAOIGUAL

    PULALINHA
    LEA DX,MSGIGUAL
    MOV AH,09
    INT 21H
    JMP CONT

    NAOIGUAL:
    PULALINHA
    LEA DX,MSGNAOIGUAL
    MOV AH,09
    INT 21H

    CONT:
    RET

COMPARAR ENDP

QUANT_A PROC

    LEA DI,VETORLER ;aponta DI para o vetor que será comparado

    MOV AL,'a'
    XOR BL,BL ;prepara BL

    MOV CX,15
    
    COMP:
    SCASB ;compara o endereço DI do vetor com o conteúdo de AL, caso diferente ZF será 1.
    JNZ PULAR

    INC BL ;aumenta BL caso for igual

    PULAR:
    LOOP COMP

    PULALINHA
    LEA DX,MSGQUANT
    MOV AH,09
    INT 21H
    
    MOV AL,BL
    CALL SAIDEC

    RET

QUANT_A ENDP

SAIDEC PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AH,AH

    XOR BX,BX
    XOR CX,CX
 
    MOV BX,10

    CONV:
    XOR DX,DX ;passa o resto das divisoes pra imprimir numero por numero do resultado
    DIV BX
    PUSH DX

    INC CX

    OR AX,AX
    JNZ CONV

    IMP_SAIDEC:
    POP DX

    OR DX,30H
    MOV AH,02
    INT 21H

    LOOP IMP_SAIDEC

    POP DX
    POP CX
    POP BX
    POP AX

    RET

SAIDEC ENDP

END MAIN