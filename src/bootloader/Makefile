ASM=nasm
ASMFLAGS=-f elf32 -F dwarf -O0 -g
LD=x86_64-linux-gnu-ld
LDFLAGS=-m elf_i386 -Tlinker.ld -static -no-pie -O0 -M -g
OBJCP=x86_64-linux-gnu-objcopy
STRIP=x86_64-linux-gnu-strip
QEMU=qemu-system-i386
GDB=x86_64-elf-gdb

SRCS=stage0.asm stage1.asm
LIBS=common/puts.asm common/print_hex.asm common/disk_load.asm common/nl.asm
OBJS=$(SRCS:.asm=.o)
LIBS_OBJS=$(LIBS:.asm=.o)

OUT_DIR=out

$(OUT_DIR)/disk.img: $(OUT_DIR)/boot.bin
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$^ of=$@ bs=512 count=2880 conv=notrunc

$(OUT_DIR)/boot.bin: $(OUT_DIR)/boot.elf
	$(OBJCP) --strip-all -O binary $^ $@

$(OUT_DIR)/boot.elf: $(LIBS_OBJS) $(OBJS) 
	$(LD) $(LDFLAGS) -o $@ $(addprefix $(OUT_DIR)/,$^)

%.o: %.asm always
	$(ASM) $(ASMFLAGS) $< -o $(OUT_DIR)/$@

run: clean always $(OUT_DIR)/disk.img
	$(QEMU) -fda $(OUT_DIR)/disk.img -boot a

run-debug: clean always $(OUT_DIR)/disk.img
	$(QEMU) -drive format=raw,file=$(OUT_DIR)/disk.img -s -S &
	$(GDB) -ex "call ptrace(PTRACE_SEIZE, `pgrep qemu-system-i386`, NULL, NULL)" -x gdbrc.txt
	kill `pgrep qemu-system-i386`

dump: clean always $(OUT_DIR)/boot.elf
	objdump -DS $(OUT_DIR)/boot.elf | less
	
always:
	mkdir -p out
	mkdir -p out/common

clean:
	rm -rf $(OUT_DIR)

.PHONY: always clean run
