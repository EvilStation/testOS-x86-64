%define PAGE_PRESENT    0x001
%define PAGE_WRITE      0x002
%define ENTRIES_PER_PT  512

section .data
global PML4

; Page-Map Level-4 Table
PML4:
    dq PDPT + (PAGE_PRESENT | PAGE_WRITE)
    %rep ENTRIES_PER_PT -1
        dq 0
    %endrep 

; Page-Directory-Pointer Table
PDPT:
    dq PDT + (PAGE_PRESENT | PAGE_WRITE)
    %rep ENTRIES_PER_PT -1
        dq 0
    %endrep 


; Page-Directory Table
PDT:
    dq PT + (PAGE_PRESENT | PAGE_WRITE)
    %rep ENTRIES_PER_PT -1
        dq 0
    %endrep 

; Page Table
PT: 
    %assign i 0
    %rep ENTRIES_PER_PT
        dq (i << 12) + (PAGE_PRESENT | PAGE_WRITE)
        %assign i (i+1)
    %endrep 