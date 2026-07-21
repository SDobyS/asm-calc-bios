str_to_int:
    xor ax, ax
    xor cx, cx
    mov bl, [si]
    cmp bl, '-'
    jne .loop
    mov cx, 1
    inc si
.loop:
    mov bl, [si]
    test bl, bl
    jz .done
    sub bl, '0'
    mov dx, ax
    shl ax, 1
    shl dx, 3
    add ax, dx
    xor bh, bh
    add ax, bx
    inc si
    jmp .loop
.done:
    test cx, cx
    jz .ret
    neg ax
.ret:
    ret

int_to_str:
    push ax
    push bx
    push dx
    push cx
    mov bx, 10
    xor cx, cx
    mov di, si 
    test ax, ax
    jns .positive
    neg ax
    mov byte [di], '-'
    inc di
    mov si, di
.positive:
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
    pop cx
    pop dx
    pop bx
    pop ax
    ret
