TITLE LAB_9
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 13,10,"INSIRA UM TIPO DE ENTRADA(B/D/H):$"
    MSG2 DB 13,10,"COLOQUE UM NUMERO BINARIO DE 16bits:$"
    MSG3 DB 13,10,"DIGITE UM NUMERO O SINALIZANDO(-/+):$"
    MSG4 DB 13,10,"DIGITE UM NUMERO EM HEXADECIMAL(0 a 9, 'A' a 'F'):$"
    MSG5 DB 13,10,"QUAL SAIDA DESEJA ESSE NUMERO (B,D,H):$"
    MSG6 DB 13,10,"RESULTADO:$"
    MSG7 DB 13,10,"NUMERO INVALIDO, TENTE NOVAMENTE:$"
    MSG8 DB 13,10,"ENTRADA INVALIDA, TENTE NOVAMENTE:$"
    RESULTADO DW '?'
.CODE
MAIN PROC
    MOV AX,@DATA    ;acesso as mensagens
    MOV DS,AX

    MOV AH,09   ;imprimo a mensagem 1
    LEA DX,MSG1
    INT 21H 
ENTRADAS:
    MOV AH,01   ;pega o caracter digitado
    INT 21H 
;Nesta sequencia de comparação, o caracter pego do console vai ser verificado para cada correspondencia dos tipos de entradas
    CMP AL,'B'
    JE BINARIO
    CMP AL,'D'
    JE DECIMAL
    CMP AL,'H'
    JE HEXADECIMAL
    JMP ERRO    ; caso o caracter não corresponda a nenhuma das entradas acima, pular para o rotulo de erro

    BINARIO:
        CALL ENTBINARIA ;Caso a entrada for binária, chamar o procedimento que executa uma entrada binaria

    JMP SAIDAS  ; após o procedimento retornar, pular direto para a escolha de saidas para o numero digitado
    DECIMAL:
        CALL ENTDECIMAL ;Caso a entrada for decimal, chamar o procedimento que executa uma entrada decimal

    JMP SAIDAS  ; após o procedimento retornar, pular direto para a escolha de saidas para o numero digitado
    HEXADECIMAL:
        CALL ENTHEXADECIMAL ;Caso a entrada for hexadecimal, chamar o procedimento que executa uma entrada hexadecimal 

    SAIDAS: ;Neste rotulo, o usuario poderá escolher uma saida para o numero digitado na entrada

        MOV AH,09   ;exibe a mensagem perguntando qual saida o usuario quer
        LEA DX,MSG5
        INT 21H 

        MOV AH,01   ;pega o caracter digitado
        INT 21H 
;Está sequencia de comparação vai  direcionar até saida requesitada pelo usuario 
        CMP AL,'B'
        JE SAI_BINARIO

        CMP AL,'D'
        JE SAI_DECIMAL

        CMP AL,'H'
        JE SAI_HEXADECIMAL

        JMP ERRO_SAIDA; Caso o caracter digitado não corresponder a uma saida, pular para o rotuo de erro

        SAI_BINARIO:    ;Este rotulo vai chamar a saida binaria 
            MOV AH,09   ;Exibe a mensagem de resultado
            LEA DX,MSG6
            INT 21H 

            CALL SAIBINARIO
        JMP FIM ; quando o procedimento retornar, pular direto para o rotulo fim

        SAI_DECIMAL:    ;Este rotulo vai chamar a saida decimal
            MOV AH,09   ;Exibe a mensagem de resultado
            LEA DX,MSG6
            INT 21H

            CALL SAIDECIMAL
        JMP FIM ; quando o procedimento retornar, pular direto para o rotulo fim 

        SAI_HEXADECIMAL:    ;Este rotulo vai chamar a saida hexadecimal   
            MOV AH,09   ;Exibe a mensagem de resultado
            LEA DX,MSG6
            INT 21H
            
            CALL SAIHEXADECIMAL
FIM:
    MOV AH,4CH  ;finalizo o programa
    INT 21H  

    ERRO:   ;Este rotulo vai exibir uma mensagem falando que a entrada digitada é invalida e vai pular para o rotulo ENTRADAS para selecionar denovo uma entrada
        MOV AH,09
        LEA DX,MSG8
        INT 21H 
    JMP ENTRADAS
    ERRO_SAIDA: ;Este rotulo cai exibir uma mensagem falando que a saida digitada é invalida e vai pular para o rotulo SAIDAS 
        MOV AH,09
        LEA DX,MSG8
        INT 21H
    JMP SAIDAS 
MAIN ENDP

ENTBINARIA PROC;Procedimento de entrada binaria ---------------------------------------
    ;Zero bx,cx e dx
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX

    MOV CX,16   ;movo 16 ao meu contador, representando uma entrada binaria  de 16 bits

    MOV AH,09   ;exibo a mensagem de orientação ao usuario, requisitando que ele digite codigo binario de até 16 bits
    LEA DX,MSG2
    INT 21H
NUMERO_BI:  ;rotulo que vai ler a entrada binário dada pelo usuário
    MOV AH,01
    INT 21H 
    
    CMP AL,0DH  ;comparo al com enter
    JE FIM_ENTBI   ;caso o caracter em al corresponder ao 'enter', pular para o fim do procedimento de entrada binaria
    CMP AL,'0'  ;caso o caracter for menor que zero, pular para a mensagem de erro
    JB ERRO_BI
    CMP AL,'1'  ;caso o caracter for maior que um, pular para a mensagem de erro
    JA ERRO_BI

    AND AL,0FH  ;transformar os caracteres digitados em numeros 
    SHL BX,1    ;passo uma casa de bx para esquerda 
    ADD BL,AL   ;adiciono o numero localizado no registrador al em bl
LOOP NUMERO_BI  ;faço esse looping até cx zerar

FIM_ENTBI:  ;fim do procedimento de entrada binaria
    MOV RESULTADO,BX    ;guardo o resultado de bx em uma variavel
    RET ;retorno a main

ERRO_BI:    ;exibe uma mensagem de erro caso o caracter for diferente de 1 ou 0

    MOV AH,09
    LEA DX,MSG7 
    INT 21H 

JMP NUMERO_BI   ;pulo direto para o rotulo numero_bi
ENTBINARIA ENDP;---------------------------------------------------------

SAIBINARIO PROC;Procedimento que exxecuta uma saida binaria ---------------------------------------------------------
    MOV CX,16   ;movo 16 para meu contador, simulando um numero binário de 16 bits

    @SAI_BINARIO:
        OR CX,CX    ;comparo cx para verificar se ele é igual a zero    
        JZ FIM_BINARIO  ;caso cx for zero, ir para o fim do procedimento

        XOR AX,AX   ;zero ax
        SHL BX,1    ;movo uma casa do registrador bx para esquerda
        JC UM   ;caso o carry for um, pular para o  rotulo UM
        ;caso não tiver carry, continuar o codigo
            XOR DX,DX   ; zero DX
            OR DL,30H   ;transformo o zero em DL em um caracter
            MOV AH,02   ;imprimo esse caracter 
            INT 21H 
            DEC CX ;deccremento cx
        JMP @SAI_BINARIO    ;pulo para o inicio do rotulo novamente 

        UM: ;este rotulo vai imprimir o numero um no console
            XOR DX,DX   ;zero dx
            INC DL  ;incremento DX
            OR DL,30H   ;transformo o numero em caracter 
            MOV AH,02   ;imprimo o caracter
            INT 21H 
            DEC CX  ;decremento CX
        JMP @SAI_BINARIO    ;volto para o rotulo @SAI_BINARIO, para verificar o proximo bit de bx

    FIM_BINARIO:    ;fim do procedimento
        RET ;retorno o procedimento a main
SAIBINARIO  ENDP;--------------------------------------------------------------------------

ENTDECIMAL  PROC;Procedimento que executa uma entrada decimal --------------------------------------------------------------------------
    @INICIO:

    XOR BX,BX   ;Zero os registradores bx e cx
    XOR CX,CX

    MOV AH,09   ;imprimo uma mensagem para orientar o usuario como colocar o numero decimal
    LEA DX,MSG3
    INT 21H

    MOV AH,01   ;pego o caracter digitado, que faz referencia ao numero digitado for negativo ou não
    INT 21H

    CMP AL,'-'  ;caso o caracter lido for um sinal de menos
    JE NUM_NEGATIVO    ;pular para o rotulo de negativo
    CMP AL,'+'  ;caso o caracter lido corresponder a um sinal positivo
    JE NUM_POSITIVO    ;pular para o rotulo de positivo
    JMP @NUMERO_DECIMAL     ;Caso o usuario digitar um caracter invaalido, o programa vai continuar e pedir novamente que ele insira um caracter 
    NUM_NEGATIVO:
    MOV CX,1    ;mov 1 para cx
    NUM_POSITIVO:
    INT 21H ;pede a entra de um caracter que seja um numero

    @NUMERO_DECIMAL:

    CMP AL, '0' ;Compara se os numeros digitados estão entre 0 e 9
    JNGE @ERRO  ;caso o numero não estiver nesse intervalo, o programa vai pedir que o usuário digite outro caracter
    CMP AL, '9'
    JNLE @ERRO

    AND AX,000FH    ;converte o caracter em numero 
    PUSH AX ;guardo o numero na pilha

    MOV AX,10   ;movo 10 para o registrador AX
    MUL BX  ;multiplico BX por 10, que esta guardado em AX 
    POP BX  ;pego o numero guardado na pilha e coloco ele em bx
    ADD BX,AX ;Adiciono ax em bx

    MOV AH,1    ;peço a entrada de um novo caracter
    INT 21H
    CMP AL,13 ;Caso o caracter digitado não corresponder a um 'enter', pular para o inicio do rotulo @NUMERO_DECIMAL
    JNE @NUMERO_DECIMAL ;caso o caracter for um 'enter', o programa vai continuar e não vai pular para o rotulo

    OR CX,CX    ;checa se cx é igual a zero
    JZ @SAI ;caso CX for igual a zero, pular para o rotulo que leva ao final do procedimento

    NEG BX  ;se CX não for igual a zero, o programa irá continuar e vai inverter todos os bits de BX, para tornar o numero dentro do registrador negativo

    @SAI:  
    MOV RESULTADO,BX    ;movo o conteudo de BX para uma variavel
    RET ; retorna o procedimento a main
    @ERRO:  ;caso algum caracter digitado for invaalido, o programa vai exibir uma mensagem de erro, e pedirá  uma nova entrada ao usuário
; se caractere ilegal
    MOV AH,2
    MOV DL, 0DH ;passa para outra linha
    INT 21H
    MOV DL, 0AH 
    INT 21H
    JMP @INICIO ;pula direto para o  rotulo @INICIO
ENTDECIMAL ENDP;--------------------------------------------------------------------------

SAIDECIMAL PROC;--------------------------------------------------------------------------
    MOV AX,RESULTADO  ;Movo o conteudo guardado na variavel para AX
    
    CMP AX,0
    JGE SEGUE

    PUSH AX
    
    MOV DL,'-'
    MOV AH,02
    INT 21H
    
    POP AX
    NEG AX
    
    SEGUE:
    XOR BX,BX   ;zero os registradores 
    XOR CX,CX
    XOR DX,DX
    ;XOR AX,AX   
    

    XOR CX,CX   ;zero cx
    MOV BX,10   ;movo 10 para bx para dividir o resultado por 10

    SAI_1:
        XOR DX,DX   ;zero dx 
        DIV BX  ;divido o resultado que esta em AX por bx

        PUSH DX ;guardo o resultado na pilha 
        INC CX ;incremento cx

        OR AX,AX    ;Checo se AX é igual a zero
        JNZ SAI_1   ;caso ax não for igual a zero, pular para o inicio do rotulo SAI_1
    SAI_2:

        POP DX  ;pego o valor armazenado na pilha e guardo em DX

        OR DL,30H
        MOV AH,02   ;imprime o resultado
        INT 21H
    LOOP SAI_2  ;volto para o começo de SAI_2, até CX ser zero
RET
SAIDECIMAL ENDP;--------------------------------------------------------------------------


ENTHEXADECIMAL PROC;----------------------------------------------------------------------
    
    XOR BX,BX   ;Zero os registradores 
    XOR CX,CX
    XOR DX,DX

    MOV AH,09   ;Exibe uma mensagem que guia o usuario para colocar os caracteres em hexadecimal  
    LEA DX,MSG4  
    INT 21H 

    MOV CX,4    ;Movo 4 para meu contador

    LER_HEXA:
        OR CX,CX ;checa se CX zerou 
        JZ FIM_ENTHEXA  ;Caso CX for zero, pular para o fim do procedimento

        MOV AH,01   ; peço que o usuario digite uma caracter 
        INT 21H 

        CMP AL,0DH  ; comparo o caracter com o 'enter'
        JE FIM_ENTHEXA  ; caso o caracter corresponder ao 'enter', pular para o fim do procedimento
        
        CMP AL,'0'  ;Comparo o caracter com o zero 
        JLE NUMEROS ;caso o caracter for igual ou acima de zero, pular para o rotulo numeros

        CMP AL,'9'  ;caso o caracter for abaixo ou igual  a nove, pular para o rotulo NUMEROS
        JNG NUMEROS

        CMP AL,'A'  ;caso o caracter for acima ou igual a 'A', pular para o rotulo LETRAS
        JLE LETRAS

        CMP AL,'F'  ;caso o caracter for abaixo ou igual a 'F', pular para o rotulo LETRAS
        JNG LETRAS

        MOV AH,09   ;Imprime uma mensagem de erro, caso o caracter digitado não atender nenhuma das condições
        LEA DX,MSG7
        INT 21H 
        JMP LER_HEXA    ;pula direto para o inivio do rotulo LER_HEXA

    NUMEROS:
        SHL BX,4    ;Dentro do rgistrador move quatro casas
        AND AL,0FH
        ADD BL,AL
        DEC CX
    JMP LER_HEXA
    
    LETRAS: 
        SHL BX,4
        SUB AL,37H
        ADD BL,AL
        DEC CX
    JMP LER_HEXA

    FIM_ENTHEXA:
        MOV RESULTADO,BX
        RET
ENTHEXADECIMAL ENDP;----------------------------------------------------------------------

SAIHEXADECIMAL PROC;----------------------------------------------------------------------
    MOV BX,RESULTADO

    MOV CX,4

    IMPRIMIR_HEXA:
        OR CX,CX
        JZ FIM_SAIHEXA  
        XOR DX,DX 

        ADD DL,BH
        SHR DX,4

        CMP DL,0
        JLE TRANS_NUM

        CMP DL,9
        JNG TRANS_NUM

        CMP DL,0AH
        JLE TRANS_LETRAS

        CMP DL,0FH
        JNG TRANS_LETRAS 
    
        TRANS_NUM:
            OR DL,30H
            MOV AH,02
            INT 21H
            SHL BX,4
            DEC CX
        JMP IMPRIMIR_HEXA
        TRANS_LETRAS:
            ADD DL,37H
            MOV AH,02
            INT 21H
            SHL BX,4
            DEC CX
        JMP IMPRIMIR_HEXA
    FIM_SAIHEXA:    
        RET
SAIHEXADECIMAL ENDP;-----------------------------------------------------------------------------------
END MAIN