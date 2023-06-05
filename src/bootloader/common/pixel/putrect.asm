[bits 32]
global putrect

;
; eax - x
; ebx - y
; ecx - width
; edx - height
; esi - color
;
putrect: 
  pusha

  ; calculate starting addr of rect
  mov edi, ebx
  imul edi, 320
  add edi, eax
  add edi, 0xA0000

  mov eax, esi
  mov ebx, ecx
  mov ecx, edx
  .lines:
    push ecx
    mov ecx, ebx
    rep stosb
    add edi, 320
    sub edi, ebx
    pop ecx
    loop .lines

  popa
  ret
