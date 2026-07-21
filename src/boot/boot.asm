org 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov [boot_drive], dl

    mov ah, 0x02        
    mov al, 20         
    mov ch, 0        
    mov cl, 2    
    mov dh, 0         
    mov dl, [boot_drive] 
    mov bx, 0x7E00       
    int 0x13

    jc disk_error

    jmp 0x0000:0x7E00

disk_error:
    mov si, err_msg
    call print_str
    jmp $                

print_str:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_str
.done:
    ret

err_msg:    db "Disk read error!", 0
boot_drive: db 0

times 510 - ($ - $$) db 0
dw 0xAA55