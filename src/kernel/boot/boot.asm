%include "memory.h"

section .bss
resb PAGE_SIZE
BootStack:

section .text
global _start
extern PML4
extern BootGDTp
extern kmain
bits 32
_start:
    cli

    ; set up stack
    mov esp, V2P(BootStack)

    ; set CR4.PAE
    mov eax, cr4
    or eax, 1<<5
    mov cr4, eax

    ; load PML4
    mov eax, V2P(PML4)
    mov cr3, eax

    ; set EFER.LME
    mov ecx, 0x0C0000080
    rdmsr
    or eax, 1<<8
    wrmsr

    ; set CR0.PG
    mov eax, cr0
    or eax, 1<<31
    mov cr0, eax

    ; load new GDT
    lgdt [V2P(BootGDTp)]

    ; update code selector
    jmp 0x8:V2P(long_mode_start)

    bits 64
    long_mode_start:

        ; clear all other selectors
        xor rax, rax
        mov ss, rax
        mov ds, rax
        mov es, rax
        mov fs, rax
        mov gs, rax

        ; remove identity mapping before
        ; jumping to higher half, because
        ; nasm uses mcmodel=kernel 
        xor rax, rax
        mov qword [V2P(PML4)], rax

        ; jump to kernel address space
        mov rax, upper_memory
        jmp rax

    upper_memory:

        ; move stack pointer to kernel space
        mov rax, KERNEL_OFFSET
        add rsp, rax

        ; update page tables
        mov rax, cr3
        mov cr3, rax

        ; reload GDT, because GDT register
        ; still points to physical address
        mov rax, BootGDTp
        lgdt[rax]

        ; reload CS
        ; there are no long jumps in long mode
        ; so we need to use ret
        mov rax, .reload_cs
        push 0x8
        push rax
        ret

    .reload_cs:
        call kmain
        hlt