%define GDT_CODE      (3<<11)
%define GDT_PRESENT   (1<<15)
%define GDT_LONG      (1<<21)

section .rodata
global BootGDTp

BootGDT:
    dd 0,0
    dd 0,(GDT_PRESENT | GDT_CODE | GDT_LONG)
BootGDT_end:

BootGDTp:
    dw BootGDT_end - BootGDT - 1
    dq BootGDT