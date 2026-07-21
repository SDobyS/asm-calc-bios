org 0x7E00

start:
    call cls

    mov bl, 0x0A  
    call set_color
    mov si, title_msg
    call print_str
    call reset_color
    call newline
    
    mov bl, 0x0B  
    call set_color
    mov si, prompt1_msg
    call print_str
    call reset_color
    mov si, num1_buffer
    call input_str
    mov si, num1_buffer
    call str_to_int
    mov [num1], ax
    call newline
    
    mov bl, 0x0B
    call set_color
    mov si, prompt2_msg
    call print_str
    call reset_color
    mov si, num2_buffer
    call input_str
    mov si, num2_buffer
    call str_to_int
    mov [num2], ax
    call newline
    
    mov bl, 0x0B
    call set_color
    mov si, prompt3_msg
    call print_str
    call newline
    mov si, prompt4_msg
    call print_str
    call reset_color
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
    
    call reset_color
    mov bl, 0x0C 
    call set_color
    mov si, err_op_msg
    call print_str
    call reset_color
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
    call reset_color
    mov bl, 0x0C 
    call set_color
    mov si, err_div_msg
    call print_str
    call reset_color
    jmp halt

print_result:
    push ax
    mov bl, 0x0A
    call set_color
    mov si, res_msg
    call print_str
    pop ax
    mov si, out_buffer
    call int_to_str
    mov si, out_buffer
    call print_str
    call reset_color
    jmp halt

halt:
    hlt
    jmp halt

%include "color.asm"
%include "io.asm"
%include "math.asm"
%include "data.asm"