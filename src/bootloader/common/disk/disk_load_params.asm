[bits 16]

%include "common/macros.inc"
%include "common/print.inc"

extern bpb.sects_per_track
extern bpb.heads_count

section .text
global disk_load_params

; DL: drive
disk_load_params:
  push dx
  push bx
  push es
  mov ah, 0x08
  int 0x13
  jc .error
  pop es

  and cl, 0x3F
  xor ch, ch
  ; sector count
  mov [bpb.sects_per_track], cx

  inc dh
  ; head count
  mov [bpb.heads_count], dh
  pop bx
  pop dx
  ret

  .error:
    mov si, msg_read_failed
    call puts
    jmp $
    hlt

section .data
msg_read_failed: db "Read from disk failed!", ENDL, 0
