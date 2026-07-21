cls:
    push ax
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    pop ax
    ret

newline:
    push ax
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    pop ax
    ret

print_char_colored:
    push ax
    push bx
    push cx
    mov ah, 09h
    mov al, bl
    mov bh, 0
    mov bl, [current_color]
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    mov ah, 02h
    mov bh, 0
    int 10h
    pop cx
    pop bx
    pop ax
    ret

print_str:
.loop:
    lodsb
    or al, al
    jz .done
    mov bl, al
    call print_char_colored
    jmp .loop
.done:
    ret

input_char:
    push bx
    mov ah, 0x00
    int 0x16
    mov ah, 0x0E
    mov bh, 0
    mov bl, 0x07
    int 0x10
    pop bx
    ret

input_str:
    mov di, si
.loop:
    call input_char
    cmp al, 13
    je .done
    mov [di], al
    inc di
    jmp .loop
.done:
    mov byte [di], 0
    ret
