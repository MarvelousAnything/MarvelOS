[bits 16]
%include "common/macros.inc"
%include "common/print.inc"
%include "common/gdt.inc"

section .text
global stage1

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
extern bpb.oem
extern font
start_protected_mode:
  mov eax, 0
  mov ebx, 0
  mov ecx, 320
  mov edx, 20
  mov esi, 0x0a
  call putrect
  lea edi, [font]
  mov esi, hello
  print_loop:
    lodsb
    cmp al, 0
    je done

    imul eax, eax, 13
    mov word [0xA0000], ax
    inc edi
    jmp print_loop
  done:

  jmp $

section .data
hello: db "Hello World!", ENDL, 0
