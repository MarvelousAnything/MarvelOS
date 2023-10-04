[bits 16]

section .text
global puts
;
; Puts a string to the screen
; Parameters:
;   si - string to print
;   ax - color
;
puts:
    push si
    push ax
    push bx

    .loop:
        lodsb
        or al, al
        jz .done

        mov ah, 0x0e
        mov bh, 0           ; set page number to 0
        int 0x10

        jmp .loop

    .done:
        pop bx
        pop ax
        pop si
        ret
