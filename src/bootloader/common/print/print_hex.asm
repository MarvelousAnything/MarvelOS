[bits 16]

section .print_hex_text
global print_hex

; prints the value of DX as hex
print_hex:
  push ax
  push bx
  push cx
  push dx

  xor bx, bx
  mov cx, 4

  .next_digit:
    rol dx, 4
    mov bl, dl
    and bl, 0x0F
    mov al, byte [hex_table + bx]
    mov ah, 0x0E
    int 0x10
    loop .next_digit

  pop dx
  pop cx
  pop bx
  pop ax
  ret

section .print_hex_data
hex_table db "0123456789ABCDEF", 0
