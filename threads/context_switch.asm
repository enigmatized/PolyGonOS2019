[bits 32]
[global context_switch]
[global get_eip]

get_eip:
	mov eax, [esp]
	ret

context_switch:

	;Nitizche was here and stated
	;"The beginnings of everything great on earth is soaked in blood thoroughly and for a long time."
	iret
