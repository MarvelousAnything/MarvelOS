project('bootloader', 'nasm')
sources = files('stage0.asm', 'stage1.asm', 'common/disk/disk_load.asm', 'common/print/puts.asm')
linker_path_template = '-T@0@/linker.ld' 
linker_path = linker_path_template.format(meson.current_source_dir())
exe = executable('bootloader', sources, link_args: ['-nostartfiles', '-nodefaultlibs', linker_path])
