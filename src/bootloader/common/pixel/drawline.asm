[bits 32]
extern putpx
global drawline

;
; eax - x0
; ebx - y0
; ecx - x1
; edx - y1
; esi - color
;
drawline:
  push esi
  push edx
  push ecx
  push ebx
  push eax

  pop edx ; edx = x0
  sub edx, ecx ; dx = x0 - x1
  mov ebx, edx ; ebx = dx
  neg ebx ; ebx = -dx

  pop ecx ; ecx = y0
  sub ecx, edx ; ecx = y0 - dx
  mov eax, ecx
  neg eax

  add eax, ebx ; init error

  .loop:
    push ebx

    push esi ; color
    push ebx
    push eax
    push edx

    mov edx, esi
    call putpx
    
    pop edx
    pop eax
    pop ebx
    pop esi

    ; cmp eax, 0 ; eax == 0
    ; je .exit

    shl eax, 1
    jc .skip_dx

    cmp eax, ebx
    jg .skip_dy

    add eax, ecx
    inc ecx

    .skip_dy:
      pop ebx

      add ebx, edx
      inc edx

      jmp .loop

    .skip_dx:
      pop ebx

      add eax, ebx
      inc ebx

      jmp .loop

  .exit:
    pop ebx
    pop ecx
    pop edx
    pop esi

    ret

