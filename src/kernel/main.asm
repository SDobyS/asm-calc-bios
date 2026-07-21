org 0x7E00

start:
    call cls

    mov si, title_msg
    call print_str
    call newline

    mov si, prompt1_msg
    call print_str
    mov si, num1_buffer
    call input_str
    mov si, num1_buffer
    call str_to_int
    mov [num1], ax
    call newline

    mov si, prompt2_msg
    call print_str
    mov si, num2_buffer
    call input_str
    mov si, num2_buffer
    call str_to_int
    mov [num2], ax
    call newline

    mov si, prompt3_msg
    call print_str
    call newline
    mov si, prompt4_msg
    call print_str
    mov si, oper_buffer
    call input_str
    mov si, oper_buffer
    call str_to_int
    mov [oper], ax
    call newline

    mov ax, [oper]
    cmp ax, 1
    je case_add
    cmp ax, 2
    je case_sub
    cmp ax, 3
    je case_mul
    cmp ax, 4
    je case_div

    mov si, err_op_msg
    call print_str
    jmp halt

case_add:
    mov ax, [num1]
    add ax, [num2]
    jmp print_result

case_sub:
    mov ax, [num1]
    sub ax, [num2]
    jmp print_result

case_mul:
    mov ax, [num1]
    imul ax, [num2]
    jmp print_result

case_div:
    cmp word [num2], 0
    je div_zero
    mov ax, [num1]
    cwd
    idiv word [num2]
    jmp print_result

div_zero:
    mov si, err_div_msg
    call print_str
    jmp halt

print_result:
    mov si, res_msg
    call print_str
    mov si, out_buffer
    call int_to_str
    mov si, out_buffer
    call print_str
    call newline
    jmp halt


cls:
    push ax
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    pop ax
    ret

newline:
    push ax
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    pop ax
    ret

print_str:
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
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

title_msg:    db "=== BIOS Calculator ===", 0
prompt1_msg:  db "Enter first number: ", 0
prompt2_msg:  db "Enter second number: ", 0
prompt3_msg:  db "1.Add 2.Sub 3.Mul 4.Div", 0
prompt4_msg:  db "Enter operation: ", 0
res_msg:      db "Result: ", 0
err_div_msg:  db "Error: div by 0!", 0
err_op_msg:   db "Error: invalid op!", 0

num1_buffer:  times 16 db 0
num2_buffer:  times 16 db 0
oper_buffer:  times 16 db 0
out_buffer:   times 16 db 0

num1: dw 0
num2: dw 0
oper: dw 0

halt:
    hlt
    jmp halt