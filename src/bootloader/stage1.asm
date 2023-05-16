[bits 16]
%include "common/macros.inc"
%include "common/print.inc"

section .stage1
global stage1

stage1:
  mov si, hellowrld
  call puts
  jmp $

hellowrld: db "Hello World!", ENDL, 0
