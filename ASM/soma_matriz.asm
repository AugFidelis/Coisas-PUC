.model small
.stack 0100h
.data
    m1 db 1,1,1
       db 1,1,1
       db 1,1,1
    m2 db 1,1,1
       db 1,1,1
       db 1,1,1
    mr db 3 dup (3 dup (0))

.code
main proc
    mov ax,@data
    mov ds,ax
    lea si,m1
    lea di,m2
    lea dx,mr
    call soma_matriz
    mov ah,02
   ; mov dl,10
   ; int 21h
    lea bx,mr
    call imprime_matriz
    mov ah,4ch
    int 21h
    main endp
    
    soma_matriz proc
    mov ch,3
coluna:
    xor bx,bx
    mov cl,3
    linha:

        mov al,[si][bx]
        add al,[di][bx]
        xchg si,dx
        mov [si][bx],al
        xchg si,dx
        inc bx
        dec cl
    jnz linha
        add si,3
        add di,3
        add dx,3
        dec ch
jnz coluna
ret
soma_matriz endp
imprime_matriz proc
    mov ah,02
    mov ch,3
coluna_i:
    mov cl,3
    xor si,si
    linha_i:
    mov ah,02
        mov dl,[bx][si]
        or dl,30h
        int 21h
        mov dl,' '
        int 21h
        inc si
        dec cl
        jnz linha_i
        mov dl,10
        int 21h
        add bx,3
        dec ch
        jnz coluna_i
ret
imprime_matriz endp
end main
    







