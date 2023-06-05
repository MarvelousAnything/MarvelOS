section .gdt
global gdt
global gdt.ptr
global CODE_SEG
global DATA_SEG

gdt:
  ;
  ; null descriptor
  ;
  .null: dq 0

  ;
  ; Kernel Mode Code Segment
  ;
  .kernel_cs:
    dw 0xfffff
    dw 0
    db 0
    db 0b10011010
    db 0b11001111
    db 0

  ;
  ; Kernel Mode Data Segment
  ;
  .kernel_ds:
    dw 0x0ffff
    dw 0
    db 0
    db 0b10010010
    db 0b11001111
    db 0

  .end:
  
  .ptr:
    dw gdt.end - gdt.null - 1
    dq gdt.null

CODE_SEG: equ gdt.kernel_cs - gdt
DATA_SEG: equ gdt.kernel_ds - gdt
