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
    *(.text)
    *(.libs)
    *(.disk_load_text)
    *(.gdt)
  } > BOOTROM

  .data : {
    *(.data)
    *(.disk_load_data)
  } > BOOTROM
  
  .signature : {
    SHORT(0xAA55)
  } > SIG

  .stage1 : AT(0x7e00) {
    *(.stage1)
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

  .debug_aranges : {
    *(.debug_aranges)
  }

  .debug_pubnames : {
    *(.debug_pubnames)
  }

  .debug_info : {
    *(.debug_info)
  }

  .debug_abbrev : {
    *(.debug_abbrev)
  }

  .debug_line : {
    *(.debug_line)
  }

  .debug_frame : {
    *(.debug_frame)
  }

  .debug_loc : {
    *(.debug_loc)
  }
}
