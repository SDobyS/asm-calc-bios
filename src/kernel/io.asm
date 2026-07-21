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
    mov al, 0x0A
    int 0x10
    mov al, 0x0d
    int 0x10
    pop ax
    ret

print_char_colored:
    push ax
    push bx
    push cx
    mov ah, 0x09
    mov al, bl
    mov bh, 0
    mov bl, [current_color]
    mov cx, 1
    int 0x10
    mov ah, 0x03
    mov bh, 0
    int 0x10
    inc dl
    mov ah, 0x02
    mov bh, 0
    int 0x10
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
    mov bl, COLOR_LIGHT_GRAY
    int 0x10
    pop bx
    ret

input_str:
    mov di, si
.loop:
    mov ah, 0x00
    int 0x16
    cmp al, 0x0D
    je .done
    cmp al, 0x08
    je .backspace
    mov bx, si
    add bx, 15
    cmp di, bx
    jae .loop
    mov [di], al
    inc di
    mov ah, 0x0E
    int 0x10
    jmp .loop
.backspace:
    cmp di, si
    je .loop
    dec di
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp .loop
.done:
    mov byte [di], 0
    ret
