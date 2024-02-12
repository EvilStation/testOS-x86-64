%include "GDT.h"

section .bootGDT
global BootGDTp

BootGDT:
    dd 0,0
    dd 0,(GDT_PRESENT | GDT_CODE | GDT_LONG)
BootGDT_end:

BootGDTp:
    dw BootGDT_end - BootGDT - 1
    dq BootGDT