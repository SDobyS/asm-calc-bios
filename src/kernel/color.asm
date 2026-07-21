current_color: db 0x07

set_color:
    mov [current_color], bl
    ret

reset_color:
    mov byte [current_color], 0x07
    ret