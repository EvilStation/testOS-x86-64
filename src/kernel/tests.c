#include "minunit.h"
#include "boot/debug.c"

#define BUFFER_SIZE 16

char vga_recv[BUFFER_SIZE];
char serial_recv[BUFFER_SIZE];
int i;
int j;

void test_setup(void) 
{
	for(int i = 0; i < BUFFER_SIZE; i++)
	{
			vga_recv[i] = '\0';
			serial_recv[i] = '\0';
	}
  	i = 0;
	j = 0;
}

void test_teardown(void) 
{
	/* Nothing */
}

void vga_write(char c)
{
  	vga_recv[i++] = c;
}
void serial_write(uint16_t port, uint8_t c)
{
  	serial_recv[j++] = (char)c;
}

MU_TEST(putch_sends_character_to_vga)
{
	char input = 'a';
  	debug_putch(input);
  	mu_assert_int_eq(vga_recv[0], input);
}

MU_TEST(putch_sends_character_to_serial)
{	
	char input = 'a';
  	debug_putch(input);
  	mu_assert_int_eq(serial_recv[0], input);
}

MU_TEST(putsn_writes_string)
{
  	char *str = "hello";
  	debug_putsn(str, 5);
  	mu_assert_string_eq(vga_recv, str);
}

MU_TEST(putsn_writes_correct_number_of_characters)
{
  	char *str = "1234567890";
  	debug_putsn(str, 5);
  	mu_assert_string_eq(vga_recv, "12345");
}


MU_TEST_SUITE(test_suite) 
{
	MU_SUITE_CONFIGURE(&test_setup, &test_teardown);
  	MU_RUN_TEST(putch_sends_character_to_vga);
	MU_RUN_TEST(putch_sends_character_to_serial);
	MU_RUN_TEST(putsn_writes_string);
	MU_RUN_TEST(putsn_writes_correct_number_of_characters);
}

int main() 
{
	MU_RUN_SUITE(test_suite);
	MU_REPORT();
	return MU_EXIT_CODE;
}