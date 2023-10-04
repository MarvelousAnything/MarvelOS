ENTRY(stage0)

MEMORY {
  BOOTROM (rx) : ORIGIN = 0x7c00, LENGTH = 510
  SIG (r) : ORIGIN = 0x7dfe, LENGTH = 2
  STAGE1 (rx) : ORIGIN = 0x9000, LENGTH = 32768
  BIOSROM (rx) : ORIGIN = 0xf0000, LENGTH = 65536
  VGATXTBUF (rw) : ORIGIN = 0xb8000, LENGTH = 16384
  VGAPXBUF (rw) : ORIGIN = 0xa0000, LENGTH = 16384
}

SECTIONS {
  .text : {
    *stage0.o(.text)
    *(.gdt)
  } > BOOTROM

  .data : {
    *stage0.o(.data)
  } > BOOTROM
  
  .signature : {
    SHORT(0xAA55)
  } > SIG

  .text : AT(0x7e00) {
    *stage1.o(.text)
    *stage1.o(.data)
    *(.font_data)
  } > STAGE1

  .biosrom : {
    *(.biosrom)
  } > BIOSROM

  .vgatxtbuf : {
    *(.vgatxtbuf)
  } > VGATXTBUF

  .vgapxbuf : {
    *(.vgapxbuf)
  } > VGAPXBUF
}
