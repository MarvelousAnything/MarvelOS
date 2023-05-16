BOOT_SIGNATURE   equ 0xAA55
SECTOR_SIZE      equ 512    ; Size of a disk sector in bytes
BOOTLOADER_LOC   equ 0x7c00 ; Location of the first sector of the bootloader in memory
SECOND_STAGE_LOC equ 0x9000 ; Location where the second-stage bootloader should be loaded
