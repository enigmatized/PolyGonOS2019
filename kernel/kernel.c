#include "../drivers/keyboard.h"
#include "../kernel/system.h"

#include "../programs/programs.h"

#include "../io/screen_io.h"

/*
 * We have landed!
 */
void main(){
	interrupts_disable();
	clear_screen();
	interrupts_init();
	syscall_init();
	time_init(10); //You can control time.....
	heap_init_page_frame_heap((void*) 0x100000, 0xfffff);
	paging_init();
	keyboard_init();

	interrupts_enable();
	printf("This is easier\n");
	printf("Than remaking the C library....\n");
	printf("Throw print statements everywhere, ");
	printf("Good for seeing what is actually under the hood");

	thread_init(100);

	THREAD* prog = thread_create(&clock);
	thread_queue(prog);
	

}
