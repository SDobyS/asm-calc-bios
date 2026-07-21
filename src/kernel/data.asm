title_msg:          db "=== BIOS Calculator ===", 0
prompt1_msg:        db "Enter first number: ", 0
prompt2_msg:        db "Enter second number: ", 0
prompt3_msg:        db "1.Add 2.Sub 3.Mul 4.Div", 0
prompt4_msg:        db "Enter operation: ", 0
res_msg:            db "Result: ", 0
err_div_msg:        db "Error: div by 0!", 0
err_op_msg:         db "Error: invalid op!", 0

num1_buffer:  times 16 db 0
num2_buffer:  times 16 db 0
oper_buffer:  times 16 db 0
out_buffer:   times 16 db 0

num1: dw 0
num2: dw 0
oper: dw 0

COLOR_BLACK:         equ 0x00
COLOR_BLUE:          equ 0x01
COLOR_GREEN:         equ 0x02
COLOR_CYAN:          equ 0x03
COLOR_RED:           equ 0x04
COLOR_MAGENTA:       equ 0x05
COLOR_BROWN:         equ 0x06
COLOR_LIGHT_GRAY:    equ 0x07

COLOR_DARK_GRAY:     equ 0x08
COLOR_LIGHT_BLUE:    equ 0x09
COLOR_LIGHT_GREEN:   equ 0x0A
COLOR_LIGHT_CYAN:    equ 0x0B
COLOR_LIGHT_RED:     equ 0x0C
COLOR_LIGHT_MAGENTA: equ 0x0D
COLOR_YELLOW:        equ 0x0E
COLOR_WHITE:         equ 0x0F