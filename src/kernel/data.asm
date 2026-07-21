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
