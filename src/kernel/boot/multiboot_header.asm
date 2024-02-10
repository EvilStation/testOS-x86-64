%define MBOOT2_MAGIC 0xE85250D6
%define MBOOT2_ARCH 0
%define MBOOT2_LENGTH (Multiboot2HeaderEnd - Multiboot2Header)
%define MBOOT2_CHECKSUM -(MBOOT2_MAGIC + MBOOT2_ARCH + MBOOT2_LENGTH)

section .multiboot
align 0x8
Multiboot2Header:
    dd MBOOT2_MAGIC
    dd MBOOT2_ARCH
    dd MBOOT2_LENGTH
    dd MBOOT2_CHECKSUM
    dw 0
    dw 0
    dd 8
Multiboot2HeaderEnd: