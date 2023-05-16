[bits 16]

%include "common/constants.inc"
%include "common/print.inc"
%include "common/macros.inc"
%include "common/disk.inc"
extern stage1

section .text
global stage0

stage0:
  mov [BOOT_DRIVE], dl

  mov bp, 0x8000
  mov sp, bp
  
  mov bx, 0x9000
  mov dh, 5
  mov dl, [BOOT_DRIVE]
  call disk_load

  call clscr

  mov cx, 23
  mov ax, 0x7000
  loop:
    mov dx, ax
    call print_hex

    mov si, spacing
    call puts

    mov dx, [eax]
    call print_hex
    call nl

    add ax, 2
  loop loop
  
  mov cx, 23
  push ax
  .wait_key:
    xor ax, ax
    int 0x16
    cmp al, 'r'
      je .reset
    cmp al, 'k'
      je .up
    cmp al, 'j'
      je .down
    cmp al, 'c'
      je cont
    jmp .wait_key

  .reset:
    pop ax
    mov ax, 0x0000
    call clscr
    jmp loop
  .up:
    pop ax
    sub ax, 92
    call clscr
    jmp loop
  .down:
    pop ax
    call clscr
    jmp loop
  .go:
    pop ax
    call read_int
    jmp loop

  cont:
  call clscr
  push es
  push word 0x9000
  retf
  jmp $

clscr:
  push ax
  push bx
  push cx
  push dx

  mov ah, 0x06
  mov al, 0
  xor bx, bx
  xor cx, cx
  xor dx, dx

  int 0x10

  pop dx
  pop cx
  pop bx
  pop ax

  ret

; reads an integer in hex
read_int:
  mov ah, 0x00
  int 0x16
  cmp al, '\n'
  je .enter
  cmp al, '\r'
  cmp al, 0x20
  jl read_int
  cmp al, 0x7F
  jg read_int
  call pushc
  mov ah, 0x0e
  int 0x10
  jmp read_int

.enter:
  push ax
  mov ah, 0x0e
  mov al, 0x0a
  int 0x10
  mov al, 0x0d
  int 0x10
  mov si, buffer
  call puts
  mov [offset], byte 0
  jmp loop
  pop ax

pushc:
  push ax
  push bx
  mov bx, [offset]
  mov [buffer + bx], al
  inc bx
  mov [offset], bx
  pop bx
  pop ax
  ret


BOOT_DRIVE: db 0x0 
spacing: db " ", 0
offset: db 0
section .bss

buffer: resb 20
