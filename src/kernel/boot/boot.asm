%define PAGE_SIZE 2048

section .bss
resb PAGE_SIZE
BootStack:

section .text
global _start
extern PML4
extern BootGDTp
bits 32
_start:
    cli

    ; set up stack
    mov esp, BootStack 

    ; set CR4.PAE
    mov eax, cr4
    or eax, 1<<5
    mov cr4, eax

    ; load PML4
    mov eax, PML4
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
    lgdt [BootGDTp]

    ; update code selector
    jmp 0x8:long_mode_start

    bits 64
    long_mode_start:
    mov rax, 0x0
    mov ss, eax
    mov ds, eax
    mov es, eax

    jmp $