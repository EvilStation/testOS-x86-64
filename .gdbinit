set disassembly-flavor intel
target remote :1234
file build/ISO/kernel

layout asm
layout regs

define q
monitor quit
end

define reset
monitor system_reset
end

define mmap
monitor info mem
end
