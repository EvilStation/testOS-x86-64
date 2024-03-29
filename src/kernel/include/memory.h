#pragma once
#define KERNEL_OFFSET   0xFFFFFF8000000000

#include <stdint.h>
#define V2P(a) ((uintptr_t)(a) & ~KERNEL_OFFSET)
#define P2V(a) ((uintptr_t)(a) | KERNEL_OFFSET)

#define PAGE_PRESENT    0x001
#define PAGE_WRITE      0x002
#define PAGE_HUGE       0x080

#define PAGE_SIZE       0x1000
#define ENTRIES_PER_PT  512