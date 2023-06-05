[bits 32]
extern putpx
global drawline

; plotLine(x0, y0, x1, y1)
;     dx = abs(x1 - x0)
;     sx = x0 < x1 ? 1 : -1
;     dy = -abs(y1 - y0)
;     sy = y0 < y1 ? 1 : -1
;     error = dx + dy
;     
;     while true
;         plot(x0, y0)
;         if x0 == x1 && y0 == y1 break
;         e2 = 2 * error
;         if e2 >= dy
;             if x0 == x1 break
;             error = error + dy
;             x0 = x0 + sx
;         end if
;         if e2 <= dx
;             if y0 == y1 break
;             error = error + dx
;             y0 = y0 + sy
;         end if
;     end while

;
; eax - x0
; ebx - y0
; ecx - x1
; edx - y1
; esi - color
;
drawline:
  push ebp
  mov ebp, esp
  sub esp, 0x30

  ; Store variables on the stack
  mov dword [ebp - 0x04], eax ; x0
  mov dword [ebp - 0x08], ebx ; y0
  mov dword [ebp - 0x0C], ecx ; x1
  mov dword [ebp - 0x10], edx ; y1
  mov dword [ebp - 0x14], esi ; color

  ; Calculate dx and dy
  mov eax, dword [ebp - 0x0C]
  sub eax, dword [ebp - 0x04]
  mov dword [ebp - 0x18], eax ; dx = x1 - x0

  mov eax, dword [ebp - 0x10]
  sub eax, dword [ebp - 0x08]
  mov dword [ebp - 0x1C], eax ; dy = y1 - y0

  ; Calculate sx and sy
  mov eax, 1
  cmp dword [ebp - 0x18], 0
  jge .sx_cont
  neg eax
  .sx_cont:
  mov dword [ebp - 0x20], eax ; sx = sign(dx)

  mov eax, 1
  cmp dword [ebp - 0x1C], 0
  jge .sy_cont
  neg eax
  .sy_cont:
  mov dword [ebp - 0x24], eax ; sy = sign(dy)

  ; Calculate initial error
  mov eax, dword [ebp - 0x18]
  mov edx, dword [ebp - 0x1C]
  add eax, edx
  mov dword [ebp - 0x28], eax ; error = dx + dy

.loop:
  ; Plot the current point
  mov eax, dword [ebp - 0x04]
  mov ebx, dword [ebp - 0x08]
  mov edx, dword [ebp - 0x14]
  call putpx

  ; Check if we have reached the end point
  mov eax, dword [ebp - 0x04]
  cmp eax, dword [ebp - 0x0C]
  je .check_y
  mov eax, dword [ebp - 0x08]
  cmp eax, dword [ebp - 0x10]
  je .done

.check_y:
  ; Calculate e2 = 2 * error
  mov eax, dword [ebp - 0x28]
  shl eax, 1
  mov dword [ebp - 0x2C], eax ; e2 = 2 * error

  ; Check if e2 >= dy
  cmp eax, dword [ebp - 0x1C]
  jl .check_x

  ; Check if x0 == x1
  mov eax, dword [ebp - 0x04]
  cmp eax, dword [ebp - 0x0C]
  je .done

  ; Update error and x0
  add eax, dword [ebp - 0x1C]
  mov dword [ebp - 0x28], eax ; error += dy

  mov eax, dword [ebp - 0x04]
  add eax, dword [ebp - 0x20] ; x0 = x0 + sx
  mov [ebp - 0x04], eax

.check_x:
  ; Check if e2 <= dx
  cmp eax, dword [ebp - 0x18]
  jg .next_iteration

  ; Check if y0 == y1
  mov eax, dword [ebp - 0x08]
  cmp eax, dword [ebp - 0x10]
  je .done

  ; Update error and y0
  add eax, dword [ebp - 0x18]
  mov dword [ebp - 0x28], eax ; error += dx

  mov eax, dword [ebp - 0x08]
  add eax, dword [ebp - 0x24] ; y0 = y0 + sy
  mov [ebp - 0x08], eax

.next_iteration:
  jmp .loop

.done:
  leave
  ret


