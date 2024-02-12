ENTRY(_start)

KERNEL_OFFSET = 0xFFFFFF8000000000;
KERNEL_START = 0x10000;

SECTIONS
{
  . = KERNEL_START + KERNEL_OFFSET;
  .text : AT(ADDR(.text) - KERNEL_OFFSET)
  {
    *(.multiboot)
    *(.text)
  }
  .bootGDT : AT(ADDR(.bootGDT) - KERNEL_OFFSET)
  { 
    . = ALIGN(4K);
    *(.bootGDT*)
  }
  .bootPT : AT(ADDR(.bootPT) - KERNEL_OFFSET)
  { 
    . = ALIGN(4K);
    *(.bootPT)
  }
  .bss : AT(ADDR(.bss) - KERNEL_OFFSET)
  { 
    . = ALIGN(4K);
    *(.bss)
  }
}