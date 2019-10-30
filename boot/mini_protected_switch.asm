[bits 16]
;G: I note "mini" is miss leading
;;G: This left mini after context switching
;;G:which is similiar to this
;switches to protected mode
switch_to_protected:
  cli ;disable interrupts
  lgdt [gdt_descriptor] ;pass the gdt to the cpu

  mov eax, cr0 ;set the first bit of cr0 to 1 to switch to protected mode
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_pm

[bits 32]
init_pm: ; we are now using 32-bit instructions
  mov ax, DATA_SEG ;does nothing
  mov ds, ax ;moving flow of segment
  mov ss, ax ;This is moving to where GDT did its solid work
  mov es, ax
  mov fs, ax
  mov gs, ax
			;G: (10/29)I messed around with this so much I lost my mind
			;G: I beleive I change this from OS tutorial
						
			;G:(10/26) I changed the position?
			;G:for paging implementation
  mov ebp, 0x90000 ; update the stack right at the top of the free space
  mov esp, ebp ;<- I left the same structure as Cefenllaso(spelling?)

  call BEGIN_PM
