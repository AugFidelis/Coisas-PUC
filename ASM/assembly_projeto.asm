TITLE PROJETO ASSEMBLY - AUGUSTO FIDELIS
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
    ALUNOS DB 5 DUP(15 DUP(?))
    NOTAS DB 5 DUP(3 DUP(?))
    MSGNOME DB 'INSIRA OS NOMES DOS ALUNOS: $'
    MSGPROVA DB 13,10,'INSIRA AS NOTAS DO ALUNO: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;Suponha uma sala com 5 alunos, e com 3 provas. O programa deverá permitir a inserção dos nomes dos
    ;alunos, de suas notas e calcular a média ponderada. Supor trabalhar só com números inteiros. Deverá
    ;também permitir a correção das notas, através do nome e da avaliação. Deverá permitir a impressão da
    ;planilha de notas. Usar conceitos de procedimentos, macros, endereçamento de matrizes e outros. O
    ;programa deverá ser comentado e dentro do arquivo deverá ter os nomes dos participantes.

    CALL LERALUNO

    CALL IMPALUNO

    MOV AH,4CH
    INT 21H


MAIN ENDP

LERALUNO PROC

    LEA DX,MSGNOME
    MOV AH,09
    INT 21H
    PULALINHA

    MOV CH,5
    XOR SI,SI

    LER_COLUNA:
    MOV DL,'-'
    MOV AH,02
    INT 21H
    
    XOR BX,BX
    MOV CL,15

    LER_LINHA:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR_AL

    MOV ALUNOS[SI+BX],AL

    INC BX
    DEC CL
    JNZ LER_LINHA
    
    SAIR_AL:
    CALL LERNOTAS

    ADD SI,15
    DEC CH
    JNZ LER_COLUNA

    RET


LERALUNO ENDP

LERNOTAS PROC

    PUSH SI
    PUSH BX
    PUSH CX

    LEA DX,MSGPROVA
    MOV AH,09
    INT 21H

    MOV CX,3

    LE_NOTAS:
    MOV AH,01
    INT 21H

    MOV DL,20H
    MOV AH,02
    INT 21H

    MOV NOTAS[DI],AL

    INC DI
    LOOP LE_NOTAS

    POP CX
    POP BX
    POP SI

    PULALINHA

    RET

LERNOTAS ENDP

IMPALUNO PROC
    
    PULALINHA

    XOR DI,DI
    XOR SI,SI
    MOV CH,5

    IMP_AL1:
    PULALINHA
    XOR BX,BX
    MOV CL,15

    IMP_AL2:
    MOV AL,ALUNOS[SI+BX]
    
    CMP AL,?
    JE NOVACOLUNA
    
    MOV DL,AL
    MOV AH,02
    INT 21H

    INC BX
    DEC CL
    JNZ IMP_AL2

    NOVACOLUNA:
    
    CALL IMPNOTAS

    ADD SI,15
    DEC CH
    JNZ IMP_AL1

    RET

IMPALUNO ENDP

IMPNOTAS PROC

    PUSH SI
    PUSH BX
    PUSH CX

    MOV CX,3

    IMP_NOTAS:

    MOV DL,NOTAS[DI]

    MOV AH,02
    INT 21H

    INC DI
    LOOP IMP_NOTAS

    POP CX
    POP BX
    POP SI

    RET

IMPNOTAS ENDP

END MAIN