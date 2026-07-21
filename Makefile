ASM      := nasm
QEMU     := qemu-system-i386

SRC_DIR  := src
BIN_DIR  := bin
BOOT_DIR := $(SRC_DIR)/boot
KERNEL_DIR := $(SRC_DIR)/kernel

ASMFLAGS := -f bin -i $(KERNEL_DIR)/

BOOT_SRC := $(BOOT_DIR)/boot.asm
KERNEL_SRC := $(KERNEL_DIR)/main.asm
BOOT_BIN := $(BIN_DIR)/boot.bin
KERNEL_BIN := $(BIN_DIR)/kernel.bin
DISK_IMG := $(BIN_DIR)/disk.img

all: $(DISK_IMG)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

$(BOOT_BIN): $(BOOT_SRC) | $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

$(KERNEL_BIN): $(KERNEL_SRC) | $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

$(DISK_IMG): $(BOOT_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$@ bs=512 count=2880 2>/dev/null
	dd if=$(BOOT_BIN) of=$@ conv=notrunc 2>/dev/null
	dd if=$(KERNEL_BIN) of=$@ bs=512 seek=1 conv=notrunc 2>/dev/null

run: $(DISK_IMG)
	$(QEMU) -fda $<

debug: $(DISK_IMG)
	$(QEMU) -fda $< -d int -D debug.log

clean:
	rm -rf $(BIN_DIR)

re: clean all

.PHONY: all run debug clean re