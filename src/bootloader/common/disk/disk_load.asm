[bits 16]

%include "common/macros.inc"
%include "common/print.inc"

section .text
global disk_load

; load DH sectors to ES:BX from drive DL
disk_load:
  push dx

  mov ah, 0x02
  mov al, dh
  mov ch, 0x00 ; Cylinder 0
  mov dh, 0x00 ; Head 0
  mov cl, 0x02 ; Sector 2

  int 0x13

  jc .disk_error

  pop dx
  cmp dh, al
  jne .disk_error
  ret

.disk_error:
  mov si, DISK_ERROR_MSG
  call puts
  jmp $

section .data
DISK_ERROR_MSG db "Disk read error!", ENDL, 0
