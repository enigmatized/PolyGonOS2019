#include "../io/screen_io.h"
#include "../drivers/keyboard.h"
#include "../datastructurestuff/cbuf.h"

//This is a mess
//I messed around with trying to get a very of the xv6 echo working....

void echo(){
	cbuf_s* command_buffer = cbuf_create(4); 
//
//This powerful thing does only one thing:exit,
// which is 4 characters, plus a newline

	while(1){
		char newchar = get_key();

		if(is_special_key(newchar)){
			if(newchar == -125){ ///yeah this shouldn't be a negative...
				putchar('\n');

				//seeing if bugger has command
				char last_command[4];
				cbuf_peek(command_buffer, last_command, 4);

				//String comparor is needed...
				if(last_command[3] == 'e' && last_command[2] == 'x' && last_command[1] == 'i' && last_command[0] == 't'){
					printf("\n-- Ending 'echo' --\n");
					halt();
				}
			}
		}
		else{
			putchar(newchar);
			cbuf_append(command_buffer, newchar);
		}
	}

	cbuf_delete(command_buffer);

}
