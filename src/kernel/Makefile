.PHONY: kernel tests clean install

CC := x86_64-elf-gcc
AS := nasm
CC_T := gcc

SRC   := $(filter-out $(SRC_T), $(wildcard **/*.c) $(wildcard **/*.asm))
OBJ   := $(patsubst %, %.o, $(basename $(SRC)))
SRC_T := tests.c

CFLAGS 		:= -Wall -Wextra -pedantic -ffreestanding
CFLAGS 		+= -ggdb -O0 -mcmodel=large
CFLAGS_T    := -lm -ggdb -O0
CPPFLAGS	:= -I include
LDFLAGS 	:= -n -nostdlib -lgcc -T Link.ld 
ASFLAGS 	:= -g -F dwarf -f elf64 -i include/asm

PREFIX 	:= ../../build
ISOTDIR := $(PREFIX)/ISO

export PATH := $(HOME)/opt/cross/bin:$(PATH)

kernel: $(OBJ)
	$(LINK.o) $^ -o $@

%.o: %.asm
	$(COMPILE.s) $^ -o $@

tests: $(SRC_T)
	$(CC_T) $(CPPFLAGS) $(CFLAGS_T) $^ -o $@

clean:
	rm -f $(OBJ) kernel tests

install_t: tests
	install -D $^ $(PREFIX)/$^

install: kernel install_t 
	install -D kernel $(ISOTDIR)/kernel

