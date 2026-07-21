
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

print_char: 
    push ax 
    mov ah, 0Eh 
    mov al, bl 
    int 10h 
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