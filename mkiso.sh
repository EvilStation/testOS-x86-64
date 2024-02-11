#!/bin/sh -e

build=build
isodir=${build}/ISO
iso=${build}/testOS.iso

mkdir -p ${isodir}/boot/grub
cat > ${isodir}/boot/grub/grub.cfg << EOF
set timeout=2
set default=0

menuentry "testOS x86-64" {
  multiboot2 /kernel
}

EOF

grub-mkrescue -o ${iso} ${isodir}