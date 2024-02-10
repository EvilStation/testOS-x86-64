.PHONY: kernel clean install

CC := x86_64-elf-gcc
AS := nasm

SRC := $(wildcard **/*.c) $(wildcard **/*.asm)
OBJ := $(patsubst %, %.o, $(basename $(SRC)))

CFLAGS := -Wall -Wextra -pedantic -ffreestanding -ggdb -O0
CPPFLAGS := -I include
LDFLAGS := -n -nostdlib -lgcc -T Link.ld
ASFLAGS := -f elf64 -i include -g

ISOTDIR ?= ../../build/ISO

export PATH := $(HOME)/opt/cross/bin:$(PATH)

kernel: $(OBJ)
	$(LINK.o) $^ -o $@

%.o: %.asm
	$(COMPILE.s) $^ -o $@

clean:
	rm -f $(OBJ) kernel

install: kernel
	install -D $^ $(ISOTDIR)/$^