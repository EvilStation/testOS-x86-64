#define PORT_COM1 1
#include <stdint.h>
#include <stddef.h>
#include <stdarg.h>

void debug_putch(char c)
{
  vga_write(c);
  serial_write(PORT_COM1, c);
}

void debug_putsn(char *s, size_t n)
{
  while(n--)
    debug_putch(*s++);
}