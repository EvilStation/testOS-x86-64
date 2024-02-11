.PHONY: kernel iso qemu qemu_dbg all clean

PREFIX := build
ISO = $(PREFIX)/testOS.iso

all: kernel iso

kernel:
	$(MAKE) -C src/kernel install

iso:
	sh mkiso.sh

qemu:
	GTK_PATH= qemu-system-x86_64 -cdrom $(ISO)

qemu_dbg:
	GTK_PATH= gnome-terminal -e "gdb -q -x gdbinit"
	GTK_PATH= qemu-system-x86_64 -s -S -cdrom $(ISO) -curses
	

clean:
	rm -fr $(PREFIX)/*
	$(MAKE) -C src/kernel clean