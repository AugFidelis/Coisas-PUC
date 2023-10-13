


;AND XX,0Fh  -> transforma valor decimal no número em si

;OR XX,30h  -> transforma número em seu valor decimal

;ADD XX,30h  -> transforma um número em valor hexadecimal para leitura

;AND XX,ODFh -> converte uma letra de minuscula pra maiuscula

;OR XX,XX -> faz a msm coisa q 'CMP XX,00h' soq é mais rápido

;TEST XX,01h -> testa se o número é par mas não altera o XX, somente as flags

;0Dh -> código ASCII hex do <enter>