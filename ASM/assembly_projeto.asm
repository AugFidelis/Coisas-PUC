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
    MSGNOME DB 'INSIRA O NOME DO ALUNO: $'
    MSGPROVA DB 13,10,'INSIRA A NOTA DA PROVA: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;Suponha uma sala com 5 alunos, e com 3 provas. O programa deverá permitir a inserção dos nomes dos
    ;alunos, de suas notas e calcular a média ponderada. Supor trabalhar só com números inteiros. Deverá
    ;também permitir a correção das notas, através do nome e da avaliação. Deverá permitir a impressão da
    ;planilha de notas. Usar conceitos de procedimentos, macros, endereçamento de matrizes e outros. O
    ;programa deverá ser comentado e dentro do arquivo deverá ter os nomes dos participantes.

    


MAIN ENDP

LERALUNO PROC

    MOV CX,15

    LER_AL:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR_AL

    MOV ALUNOS[SI+BX],AL

    INC BX

    LOOP LER_AL

    SAIR_AL:
    INC SI
    RET


LERALUNO ENDP

IMPALUNO PROC

    

IMPALUNO ENDP



END MAIN