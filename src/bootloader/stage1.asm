[bits 16]
%include "common/macros.inc"
%include "common/print.inc"
%include "common/gdt.inc"

section .stage1
global stage1

hello: db "Hello World!", ENDL, 0

stage1:
  mov si, hello
  call puts
  mov ah, 0x0
  mov al, 0x13
  int 0x10

  cli
  lgdt [gdt.ptr]

  mov eax, cr0
  or eax, 1
  mov cr0, eax
  jmp CODE_SEG:start_protected_mode

%include "common/pixel/putrect.asm"
%include "common/pixel/putpx.asm"
%include "common/pixel/drawline.asm"

[bits 32]
start_protected_mode:
  ; mov eax, 0
  ; mov ebx, 0
  ; mov ecx, 320
  ; mov edx, 20
  ; mov esi, 0x0a
  ; call putrect

  mov eax, 100   ; x1
  mov ebx, 100   ; y1
  mov ecx, 0   ; x2
  mov edx, 50   ; y2
  mov esi, 0x04 ; color
  call drawline
  jmp $
