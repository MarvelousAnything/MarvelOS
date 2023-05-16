ENTRY(stage0)

MEMORY {
  BOOTROM (rx) : ORIGIN = 0x7c00, LENGTH = 510
  SIG (r) : ORIGIN = 0x7dfe, LENGTH = 2
  STAGE1 (rx) : ORIGIN = 0x9000, LENGTH = 32768
  BIOSROM (rx) : ORIGIN = 0xf0000, LENGTH = 65536
  VGABUF (rw) : ORIGIN = 0xb8000, LENGTH = 16384
}

SECTIONS {
  .text : {
    *(.text)
    *(.libs)
    *(.print_hex_text)
    *(.disk_load_text)
    *(.nl_text)
  } > BOOTROM

  .data : {
    *(.data)
    *(.print_hex_data)
    *(.disk_load_data)
    *(.bss)
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

  .vgabuf : {
    *(.vgabuf)
  } > VGABUF

  .debug_aranges : {
    *(.debug_aranges)
  } > default

  .debug_pubnames : {
    *(.debug_pubnames)
  } > default

  .debug_info : {
    *(.debug_info)
  } > default

  .debug_abbrev : {
    *(.debug_abbrev)
  } > default

  .debug_line : {
    *(.debug_line)
  } > default

  .debug_frame : {
    *(.debug_frame)
  } > default

  .debug_loc : {
    *(.debug_loc)
  } > default
}
