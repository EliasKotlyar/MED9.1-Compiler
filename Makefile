CROSS_COMPILE = C:\SysGCC\powerpc-eabi\bin\powerpc-eabi-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
READELF = $(CROSS_COMPILE)readelf
EXTRACT_MEMORY_MAP = python tools/extract_memory_map.py
BUILD_DIR = build
CFLAGS = -Wall -Iinclude -std=gnu11 -O0 -g -msdata=eabi -O0 -fno-gnu-tm


.PHONY: all clean
all: boostgauge mapswitch ramreader ramwriter

boostgauge:
	$(CC) $(CFLAGS) -c src/$@.c -o $(BUILD_DIR)/$@.elf
	$(OBJCOPY) $(BUILD_DIR)/$@.elf --only-section=.text -O binary $(BUILD_DIR)/$@.bin
	$(OBJDUMP) -S -d $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_code.txt
	$(READELF) -s $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_readelf.txt
	$(EXTRACT_MEMORY_MAP) $(BUILD_DIR)/$@_readelf.txt > $(BUILD_DIR)/$@_memorymap.json

mapswitch:
	$(CC) $(CFLAGS) -c src/$@.c -o $(BUILD_DIR)/$@.elf
	$(OBJCOPY) $(BUILD_DIR)/$@.elf --only-section=.text -O binary $(BUILD_DIR)/$@.bin
	$(OBJDUMP) -S -d $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_code.txt
	$(READELF) -s $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_readelf.txt
	$(EXTRACT_MEMORY_MAP) $(BUILD_DIR)/$@_readelf.txt > $(BUILD_DIR)/$@_memorymap.json

ramreader:
	$(CC) $(CFLAGS) -c src/$@.c -o $(BUILD_DIR)/$@.elf
	$(OBJCOPY) $(BUILD_DIR)/$@.elf --only-section=.text -O binary $(BUILD_DIR)/$@.bin
	$(OBJDUMP) -S -d $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_code.txt
	$(READELF) -s $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_readelf.txt
	$(EXTRACT_MEMORY_MAP) $(BUILD_DIR)/$@_readelf.txt > $(BUILD_DIR)/$@_memorymap.json

ramwriter:
	$(CC) $(CFLAGS) -c src/$@.c -o $(BUILD_DIR)/$@.elf
	$(OBJCOPY) $(BUILD_DIR)/$@.elf --only-section=.text -O binary $(BUILD_DIR)/$@.bin
	$(OBJDUMP) -S -d $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_code.txt
	$(READELF) -s $(BUILD_DIR)/$@.elf > $(BUILD_DIR)/$@_readelf.txt
	$(EXTRACT_MEMORY_MAP) $(BUILD_DIR)/$@_readelf.txt > $(BUILD_DIR)/$@_memorymap.json



clean:
	del /Q /S $(BUILD_DIR)\*
