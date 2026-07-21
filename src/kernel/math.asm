
str_to_int:
    xor ax, ax
.loop:
    mov bl, [si]
    cmp bl, 0
    je .done
    sub bl, '0'
    mov dx, 10
    mul dx
    xor bh, bh
    add ax, bx
    inc si
    jmp .loop
.done:
    ret

int_to_str:
    push ax
    push bx
    push dx
    mov bx, 10
    xor cx, cx
.divide:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    test ax, ax
    jnz .divide
.write:
    pop ax
    mov [si], al
    inc si
    loop .write
    mov byte [si], 0
    pop dx
    pop bx
    pop ax
    ret
