[bits 32]

global putpx


; width	how many pixels you have on a horizontal line
; height	how many horizontal lines of pixels are present
; pitch	how many bytes of VRAM you should skip to go one pixel down
; depth	how many bits of color you have
; "pixelwidth"	how many bytes of VRAM you should skip to go one pixel right.

;
; eax - x
; ebx - y
; edx - color
;
putpx:
  pusha

  imul ebx, 320
  add ebx, eax

  mov edi, 0xA0000
  add edi, ebx

  mov byte [edi], dl

  popa
  ret
