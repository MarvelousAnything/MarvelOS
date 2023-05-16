[bits 16]

section .nl_text
global nl

; outputs a newline and carriage return
nl:
  push ax
  push bx

  mov ah, 0x0E
  mov bl, 0
  mov bh, 0

  mov al, 0x0A
  int 0x10

  mov al, 0x0D
  int 0x10

  pop bx
  pop ax

  ret
