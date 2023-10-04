ASM=nasm
ASMFLAGS=-f elf32 -F dwarf -g 
LD=x86_64-linux-gnu-ld
LDFLAGS=-g -m elf_i386 -Tlinker.ld -E -no-pie -Map out/out.map
OBJCP=x86_64-linux-gnu-objcopy
STRIP=x86_64-linux-gnu-strip
QEMU=qemu-system-i386
GDB=x86_64-elf-gdb
CC=x86_64-elf-gcc

SRCS=stage0.asm stage1.asm
LIBS=$(addprefix $(OUT_DIR)/common/,disk/disk_load.asm disk/disk_load_params.asm print/puts.asm gdt.asm)
OBJS=$(addprefix $(OUT_DIR)/,$(SRCS:.asm=.o) font.elf)
LIBS_OBJS=$(LIBS:.asm=.o)

OUT_DIR=out

$(OUT_DIR)/disk.img: $(OUT_DIR)/boot.bin $(OUT_DIR)/disk.dmg
	mv $(OUT_DIR)/disk.dmg $@
	dd if=$(OUT_DIR)/boot.bin of=$@ conv=notrunc

$(OUT_DIR)/disk.dmg:
	hdiutil create -size 10m -fs "MS-DOS FAT16" -layout NONE -type UDIF -volname BSOS -o $@ 

$(OUT_DIR)/boot.bin: $(OUT_DIR)/boot.elf
	$(OBJCP) --strip-all -O binary $^ $@

$(OUT_DIR)/boot.elf: $(LIBS_OBJS) $(OBJS)
	$(LD) $(LDFLAGS) --dependency-file=$(OUT_DIR)/dep_file.d -o $@ $^

$(OUT_DIR)/%.o: %.asm
	@mkdir -p $(@D)
	$(ASM) $(ASMFLAGS) $^ -o $@

$(OUT_DIR)/font.elf: font.c
	$(CC) -c -masm=intel -m32 -O0 -g -static -fno-common $^ -o $@

run: $(OUT_DIR)/disk.img
	$(QEMU) -fda $(OUT_DIR)/disk.img -boot a

run-debug: clean $(OUT_DIR)/disk.img
	$(QEMU) -drive format=raw,file=$(OUT_DIR)/disk.img -s -S &
	$(GDB) -ex "call ptrace(PTRACE_SEIZE, `pgrep qemu-system-i386`, NULL, NULL)" -x gdbrc.txt
	kill `pgrep qemu-system-i386`

dump: $(OUT_DIR)/boot.elf
	objdump -DS $(OUT_DIR)/boot.elf | less
	
clean:
	rm -rf $(OUT_DIR)

.PHONY: clean run
