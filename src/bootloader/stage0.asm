[bits 16]

%include "common/constants.inc"
%include "common/print.inc"
%include "common/macros.inc"
%include "common/disk.inc"

extern stage1

section .text
global stage0

stage0:
  ; setup segment registers for tiny memory model
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax

  ; init stack
  mov sp, 0x7c00

  ; transfer control to .setup
  push ax
  push word .setup
  retf

  .setup:
    mov [drive], dl

    mov bx, 0x9000 ; make sure this is consistent with the ORIGIN value for STAGE1 in linker.ld
    mov dh, 5
    mov dl, [drive]
    call disk_load

    ; transfer control to stage1
    push es
    push word stage1
    retf
    jmp $ ; hang if the bootloader somehow gets back here. 

section .data
drive: db 0x0 
