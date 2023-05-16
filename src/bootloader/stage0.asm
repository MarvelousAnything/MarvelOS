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

  push es
  push word 0x9000
  retf
  jmp $

BOOT_DRIVE: db 0x0 
