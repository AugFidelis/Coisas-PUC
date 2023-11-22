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

.DATA
    ALUNOS DB 5 DUP(15 DUP(?))
    NOTAS DB 5 DUP(3 DUP(?))
    ALUNOALT DB 15 DUP(?)
    MEDIAS DB 5 DUP(?)
    DIF DB 0
    MSGNOME DB 'INSIRA O NOME DO ALUNO: $'
    MSGPROVA DB 13,10,'INSIRA AS 3 NOTAS DO ALUNO: $'
    MSGIMPRIMIR DB 13,10,'ALUNOS:        NOTAS:     MEDIA:$'
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

    ;MEMBROS DO GRUPO: Augusto Fidelis - RA: 23004589

    XOR SI,SI ;prepara SI fora do procedimento para uso dentro da função de alterar notas 
    CALL LERALUNO

    CALL IMPALUNO

    ;exibe a mensagem perguntando se deseja alterar as notas de algum aluno
    LEA DX,MSGALTERAR
    MOV AH,09
    INT 21H

    ;le o caractere e caso for 's', segue para a chamada de alterar notas
    MOV AH,01
    INT 21H

    CMP AL,73H
    JNE FINALIZAR

    XOR SI,SI ;prepara SI
    
    ;caso 's' foi inserido, ele chama o procedimento de alterar notas e o de ler a matriz da sala alterada
    CALL ALTERARNOTAS 
    CALL IMPALUNO

    ;finaliza o programa
    FINALIZAR:
    MOV AH,4CH
    INT 21H


MAIN ENDP

LERALUNO PROC ;-----------------------------------------------------------------------------------------------------------

    MOV CH,5 ;move 5 para CH para as 5 linhas da matriz

    LER_COLUNA:
    LEA DX,MSGNOME 
    MOV AH,09
    INT 21H
    PULALINHA
    
    MOV DL,'-'
    MOV AH,02
    INT 21H

    ESPACO
    
    ;prepara bx e move 15 para CL para cada caractere do nome
    XOR BX,BX
    MOV CL,15

    LER_LINHA:
    MOV AH,01
    INT 21H

    CMP AL,0DH ;caso for 'enter', pula para o fim da leitura de nomes
    JE SAIR_AL

    MOV ALUNOS[SI+BX],AL ;move o caractere inserido para a matriz de nomes

    INC BX ;aumenta bx para ir para o proximo caractere
    DEC CL
    JNZ LER_LINHA
    
    SAIR_AL:
    CALL LERNOTAS ;chama a função para ler as notas do aluno atual

    ADD DI,3 ;adiciona 3 a di para mover a posição na matriz de notas do aluno

    ADD SI,15 ;pula para a proxima linha da matriz (próximo aluno)
    DEC CH
    JNZ LER_COLUNA

    CALL CALCMEDIA ;chama a função de calculo de medias após a leitura das notas

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

    MOV CX,3 ;move 3 para CX para realizar o loop de ler a nota 3 vezes
    XOR BX,BX ;zera bx

    LE_NOTAS:
    MOV DL,'-'
    MOV AH,02
    INT 21H
    
    ESPACO

    CALL ENTDEC ;chama a função de leitura decimal

    ;caso a nota for menor que 0 ou maior que 10, pula para a mensagem de erro
    CMP AL,0 
    JB ERRONOTA
    
    CMP AL,10
    JA ERRONOTA

    OR AL,30H ;transforma o número em valor ascii
    MOV NOTAS[DI+BX],AL ;move o conteúdo lido para a matriz de notas

    INC BX ;pula para a proxima nota de um aluno na matriz de notas
    LOOP LE_NOTAS

    POP CX
    POP BX
    POP SI

    PULALINHA

    RET

    ERRONOTA:
    LEA DX,NOTAINVALIDA ;le a mensagem de erro
    MOV AH,09
    INT 21H
    PULALINHA
    JMP LE_NOTAS

LERNOTAS ENDP ;-----------------------------------------------------------------------------------------------------------

CALCMEDIA PROC ;----------------------------------------------------------------------------------------------------------

    XOR SI,SI
    XOR AX,AX
    XOR DI,DI

    MOV CH,5 ;move 5 para CH para as 5 linhas da matriz de notas

    CALC_MEDIA:
    XOR BX,BX ;zera BX

    MOV CL,3 ;move 3 para CL para as 3 notas em cada linha
    SOMAR:
    MOV DL,NOTAS[SI+BX] ;move o valor da nota para DL
    AND DL,0FH ;transforma em valor decimal
    ADD AL,DL ;adiciona em AL 
    
    INC BX
    DEC CL
    JNZ SOMAR

    XOR AH,AH ;zera AH
    MOV BL,3
    DIV BL ;divide o valor acumulado das 3 notas por 3

    OR AL,30H ;transforma o resultado em AL em valor ascii
    MOV MEDIAS[DI],AL ;move o conteúdo de AL para o vetor de medias
    INC DI

    ADD SI,3 ;pula para a próxima linha de notas

    XOR AX,AX ;zera ax para o próximo loop

    DEC CH
    JNZ CALC_MEDIA

    RET

CALCMEDIA ENDP ;----------------------------------------------------------------------------------------------------------

IMPMEDIA PROC

    PUSH DI
    
    ESPACO ;imprime 2 espaços para alinhar as médias corretamente
    ESPACO
    
    XOR AX,AX ;zera AX
    MOV AL,DH ;move o número acumulado em DH para AL
    MOV DI,AX ;move o conteúdo de AX para DI para apontar para a média de um certo aluno
    MOV AL,MEDIAS[DI] ;move o conteúdo do endereço DI do vetor de médias para AL
    AND AL,0FH ;transforma em valor decimal
    CALL SAIDEC ;chama o procedimento de saída de número decimal

    POP DI

    RET

IMPMEDIA ENDP

IMPALUNO PROC ;-----------------------------------------------------------------------------------------------------------
    
    PULALINHA

    LEA DX,MSGIMPRIMIR
    MOV AH,09
    INT 21H

    ;prepara DX, DI e SI
    XOR DX,DX
    XOR DI,DI
    XOR SI,SI
    
    MOV CH,5 ;move 5 para CH para a leitura das linhas de nomes

    IMP_AL1:
    PULALINHA
    XOR BX,BX
    MOV CL,15 ;move 15 para CL para a leitura das letras de cada nome

    IMP_AL2:
    MOV AL,ALUNOS[SI+BX] ;move a letra atual para AL
    
    ;compara AL com ?, caso for igual ele termina a leitura daquele nome e pula para o próximo
    CMP AL,? 
    JE NOVACOLUNA
    
    ;faz a leitura da letra
    MOV DL,AL
    MOV AH,02
    INT 21H

    INC BX
    DEC CL
    JNZ IMP_AL2
    ;caso não houver mais '?' pelo nome ocupar os 15 espaços da linha, pula direto para a leitura das notas e media
    JMP LEITURA 

    NOVACOLUNA:

    ESPACO
    
    DEC CL
    JNZ IMP_AL2
    
    LEITURA:
    CALL IMPNOTAS ;chama o procedimento de imprimir as notas do aluno atual
    ADD DI,3 ;adiciona 3 a DI para pular para próxima linha de notas para o próximo aluno

    CALL IMPMEDIA ;chama o procedimento de imprimir a média do aluno atual
    INC DH ;aumenta DH para pular para a média do próximo aluno

    ADD SI,15 ;pula para o próximo nome
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

    MOV AL,NOTAS[DI+BX] ;move o valor da nota atual para AL
    AND AL,0FH ;transforma o valor em número decimal

    ;compara AL com 10, caso igual ou maior, pula para a parte onde se imprime apenas um espaço
    ;para alinhas as notas independente do tamanho delas
    CMP AL,10  
    JAE PULAR
    CALL SAIDEC

    ESPACO
    ESPACO
    JMP CONT

    PULAR:
    CALL SAIDEC ;chama o procedimento de imprimir valor decimal

    ESPACO

    CONT:
    INC BX
    LOOP IMP_NOTAS

    POP DI
    POP CX
    POP BX
    POP SI

    RET

IMPNOTAS ENDP ;-----------------------------------------------------------------------------------------------------------

ENTDEC PROC ;-------------------------------------------------------------------------------------------------------------
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

    AND AX,0FH
    PUSH AX

    MOV AX,10 ;converte todos os numeros digitados em um numero só
    MUL BX
    
    POP BX
    
    ADD BX,AX

    JMP LER
    
    SAIR:
    MOV AX,BX

    POP DX
    POP CX
    POP BX
    
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
    
    MOV CX,15 ;realiza o loop 15 vezes
    XOR BX,BX ;zprepara BX

    LER_ALT:
    MOV AH,01 ;le um caractere
    INT 21H

    CMP AL,0DH ;compara com 'enter' para terminar a leitura
    JE SAIR_ALT1
    
    MOV ALUNOALT[BX],AL ;move o conteúdo de AL para o vetor de nome a ser pesquisado, vetor que
                        ;será comparado com o nome do aluno

    INC BX
    LOOP LER_ALT

    SAIR_ALT1:
    ;zera os registradores
    XOR CX,CX
    XOR DI,DI
    XOR AX,AX
    XOR SI,SI
    XOR DX,DX
    
    MOV CH,5 ;prepara CH para as 5 linhas da matriz de nomes
    
    COLUNA_ALT:
    XOR BX,BX
    MOV CL,15 ;prepara CL para os 15 caracteres do nome atual
    MOV DIF,0 ;zera o registrador que aumenta caso os caracteres comparados forem diferentes

    LINHA_ALT:
    MOV AL,ALUNOS[SI+BX] ;move um caractere do nome do aluno atual para AL
    CMP AL,? ;compara com ? para pular para o próximo nome
    JE FIMLINHA
    
    MOV DL,ALUNOALT[BX] ;move um caractere do nome a ser comparado para DL
    
    ;compara os caracteres, caso igual ele segue para o próximo caractere e caso diferente
    ;ele pula para a parte onde se aumenta o valor no registrador DIF
    CMP AL,DL
    JNE NAOIGUAL
    
    INC BX
    DEC CL
    JNZ LINHA_ALT
    JMP FIMLINHA ;pula a parte de aumentar DIF caso nenhuma comparação der diferente

    NAOIGUAL:
    MOV DIF,1

    FIMLINHA:
    CMP DIF,1 ;compara DIF com 1, caso igual os nomes são diferentes e ele pula para o próximo nome para comparar
    JE PROXCOL
    
    XOR BX,BX ;zera BX
    
    ;chama as funções de ler nota e calcular média com os valores de DI e DH acumulados com os loops
    CALL LERNOTAS
    CALL CALCMEDIA
    JMP FIM_ALT

    PROXCOL:
    ADD SI,15 ;aumenta SI para ir para o próximo nome
    ADD DI,3 ;aumenta DI para ir para a próxima linha de notas
    INC DH ;aumenta DH para ir para a próxima média
    DEC CH
    JNZ COLUNA_ALT

    LEA DX,MSG_N_ENC ;caso nenhum nome for igual ao pesquisado, le a mensagem de que o aluno não foi encontrado
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