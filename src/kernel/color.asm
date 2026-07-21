current_color: db COLOR_LIGHT_GRAY

set_color:
    mov [current_color], bl
    ret

reset_color:
    mov byte [current_color], COLOR_LIGHT_GRAY
    ret