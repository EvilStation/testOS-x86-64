%include "memory.h"

section .bootPT
global PML4

; Page-Map Level-4 Table
PML4:
    dq V2P(PDPT) + (PAGE_PRESENT | PAGE_WRITE)
    %rep ENTRIES_PER_PT - 2
        dq 0
    %endrep
    dq V2P(PDPT) + (PAGE_PRESENT | PAGE_WRITE)

; Page-Directory-Pointer Table
PDPT:
    dq V2P(PDT) + (PAGE_PRESENT | PAGE_WRITE)
    %rep ENTRIES_PER_PT - 1
        dq 0
    %endrep 


; Page-Directory Table
PDT:
    dq V2P(PT) + (PAGE_PRESENT | PAGE_WRITE)
    %rep ENTRIES_PER_PT - 1
        dq 0
    %endrep 

; Page Table
PT: 
    %assign i 0
    %rep ENTRIES_PER_PT
        dq (i << 12) + (PAGE_PRESENT | PAGE_WRITE)
        %assign i (i + 1)
    %endrep 