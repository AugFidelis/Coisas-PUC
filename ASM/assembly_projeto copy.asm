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

ESPACO MACRO
    PUSH DX
    PUSH AX
    MOV DL,20H
    MOV AH,02
    INT 21H
    POP AX
    POP DX
    ENDM

;.STACK 100H
.DATA
    ALUNOS DB 5 DUP(15 DUP(?))
    NOTAS DB 5 DUP(3 DUP(?))
    RESULTADO DB ?
    ALUNOALT DB 15 DUP(?)
    MEDIAS DB 5 DUP(?)
    MSGNOME DB 'INSIRA O NOME DO ALUNO: $'
    MSGPROVA DB 13,10,'INSIRA AS 3 NOTAS DO ALUNO: $'
    MSGIMPRIMIR DB 13,10,'ALUNOS:        NOTAS:     MEDIA:$'
    SOMAT DB 0
    INVALIDO DB '(!)$'
    NOTAINVALIDA DB 'NOTA INVALIDA! INSIRA UMA NOTA ENTRE 0 E 10.$'
    MSGALTERAR DB 13,10,'DESEJA ALTERAR AS NOTAS DE UM ALUNO? (digite "s" caso sim) $'
    MSGNOMEALT DB 13,10,'INSIRA O NOME DO ALUNO A ALTERAR AS NOTAS: $'
    MSG_N_ENC DB 13,10,'O ALUNO INSERIDO NAO PODE SER ENCONTRADO$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;Suponha uma sala com 5 alunos, e com 3 provas. O programa deverá permitir a inserção dos nomes dos
    ;alunos, de suas notas e calcular a média ponderada. Supor trabalhar só com números inteiros. Deverá
    ;também permitir a correção das notas, através do nome e da avaliação. Deverá permitir a impressão da
    ;planilha de notas. Usar conceitos de procedimentos, macros, endereçamento de matrizes e outros. O
    ;programa deverá ser comentado e dentro do arquivo deverá ter os nomes dos participantes.

    XOR SI,SI
    CALL LERALUNO

    CALL IMPALUNO

    LEA DX,MSGALTERAR
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    CMP AL,73H
    JNE FINALIZAR

    XOR SI,SI
    CALL ALTERARNOTAS
    CALL IMPALUNO

    FINALIZAR:
    MOV AH,4CH
    INT 21H


MAIN ENDP

LERALUNO PROC ;-----------------------------------------------------------------------------------------------------------

    MOV CH,5

    LER_COLUNA:
    LEA DX,MSGNOME
    MOV AH,09
    INT 21H
    PULALINHA
    
    MOV DL,'-'
    MOV AH,02
    INT 21H

    ESPACO
    
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
    
    CALL CALCMEDIA

    ADD DI,3

    ADD SI,15
    DEC CH
    JNZ LER_COLUNA

    RET


LERALUNO ENDP ;-----------------------------------------------------------------------------------------------------------

LERNOTAS PROC ;-----------------------------------------------------------------------------------------------------------

    PUSH SI
    PUSH BX
    PUSH CX

    LEA DX,MSGPROVA
    MOV AH,09
    INT 21H

    PULALINHA

    MOV CX,3
    XOR BX,BX

    LE_NOTAS:
    MOV DL,'-'
    MOV AH,02
    INT 21H
    
    ESPACO

    CALL ENTDEC

    CMP RESULTADO,0
    JB ERRONOTA
    
    CMP RESULTADO,10
    JA ERRONOTA

    MOV AL,RESULTADO
    MOV NOTAS[DI+BX],AL

    AND AL,0FH
    ADD SOMAT,AL

    INC BX
    LOOP LE_NOTAS


    POP CX
    POP BX
    POP SI

    PULALINHA

    RET

    ERRONOTA:
    LEA DX,NOTAINVALIDA
    MOV AH,09
    INT 21H
    PULALINHA
    JMP LE_NOTAS

LERNOTAS ENDP ;-----------------------------------------------------------------------------------------------------------

CALCMEDIA PROC ;----------------------------------------------------------------------------------------------------------

    PUSH AX
    PUSH BX

    MOV BL,3
    
    MOV AL,SOMAT
    DIV BL

    AND AL,0FH
    MOV MEDIAS[DI],AL

    MOV SOMAT,0
    
    POP BX
    POP AX

    RET

CALCMEDIA ENDP ;----------------------------------------------------------------------------------------------------------

IMPALUNO PROC ;-----------------------------------------------------------------------------------------------------------
    
    PULALINHA

    LEA DX,MSGIMPRIMIR
    MOV AH,09
    INT 21H

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

    ESPACO
    
    DEC CL
    JNZ IMP_AL2
    
    CALL IMPNOTAS
    ADD DI,3

    CALL IMPMEDIA

    ADD SI,15
    DEC CH
    JNZ IMP_AL1

    RET

IMPALUNO ENDP ;----------------------------------------------------------------------------------------------------------

IMPNOTAS PROC ;----------------------------------------------------------------------------------------------------------

    PUSH SI
    PUSH BX
    PUSH CX
    PUSH DI

    MOV CX,3
    XOR BX,BX

    IMP_NOTAS:

    MOV AL,NOTAS[DI+BX]

    CMP AL,10
    JAE PULAR

    CALL SAIDEC

    ESPACO
    ESPACO
    JMP CONT

    PULAR:
    CALL SAIDEC

    ESPACO

    CONT:
    INC BX
    LOOP IMP_NOTAS

    ;CALL IMPMEDIA

    POP DI
    POP CX
    POP BX
    POP SI

    RET

IMPNOTAS ENDP ;-----------------------------------------------------------------------------------------------------------

IMPMEDIA PROC

    MOV AL,MEDIAS[DI]
    SUB AL,170
    CALL SAIDEC

    RET

IMPMEDIA ENDP

ENTDEC PROC ;-------------------------------------------------------------------------------------------------------------
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    INICIO:
    XOR BX,BX
    XOR CX,CX

    LER:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR

    CMP AL,'0'
    JNGE ERRO

    CMP AL,'9'
    JNLE ERRO

    AND AX,000FH
    PUSH AX

    MOV AX,10 ;converte todos os numeros digitados em um numero só
    MUL BX
    
    POP BX
    
    ADD BX,AX

    JMP LER

    
    SAIR:
    MOV RESULTADO,BL

    POP DX
    POP CX
    POP BX
    POP AX
    
    RET

    ERRO:
    LEA DX,INVALIDO
    MOV AH,09
    INT 21H
    JMP INICIO

ENTDEC ENDP ;-------------------------------------------------------------------------------------------------------------

SAIDEC PROC ;-------------------------------------------------------------------------------------------------------------

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    ;MOV AX,BX
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

    IMP:
    POP DX

    OR DX,30H
    MOV AH,02
    INT 21H

    LOOP IMP

    POP DX
    POP CX
    POP BX
    POP AX

    RET

SAIDEC ENDP ;-------------------------------------------------------------------------------------------------------------

ALTERARNOTAS PROC ;-------------------------------------------------------------------------------------------------------

    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI

    LEA DX,MSGNOMEALT
    MOV AH,09
    INT 21H
    
    MOV CX,15
    XOR BX,BX

    LER_ALT:
    MOV AH,01
    INT 21H

    CMP AL,0DH
    JE SAIR_ALT1
    
    MOV ALUNOALT[BX],AL

    INC BX
    LOOP LER_ALT

    SAIR_ALT1:
    XOR CX,CX
    XOR DI,DI
    XOR AX,AX
    
    MOV CH,5
    
    COLUNA_ALT:
    XOR BX,BX
    XOR SI,SI
    MOV CL,15

    LINHA_ALT:
    MOV AL,ALUNOS[SI+BX]
    ;CMP AL,?
    ;JE PROXCOL
    
    MOV BL,ALUNOALT[BX]
    CMP AL,BL
    JNE PROXCOL
    
    INC BX
    DEC CL
    JNZ LINHA_ALT

    XOR BX,BX
    CALL LERNOTAS
    JMP FIM_ALT

    PROXCOL:
    ADD SI,15
    ADD DI,3
    DEC CH
    JNZ COLUNA_ALT

    LEA DX,MSG_N_ENC
    MOV AH,09
    INT 21H

    FIM_ALT:
    POP DI
    POP SI
    POP CX
    POP BX
    RET

ALTERARNOTAS ENDP

END MAIN