KERNEL_C_SOUCES = ${wildcard kernel/*.c drivers/*.c programs/*.c synch/*.c mem/*.c threads/*.c io/*.c datastructurestuff/*.c syscalls/*.c}
KERNEL_OBJ = ${KERNEL_C_SOUCES:.c=.o}

all: os-image.bin
#Got rid of gbd stuff
##added a Bochs command.
##Get it! super hellpful
os-image.bin: bootsect.bin kernel.bin
	#concat the boot sector with the kernel to create the image
	cat bootsect.bin kernel.bin > os-image.bin
	#make sure the image is 16 sectors, one for boot and 15 for kernel
	#This can be modfied, but for now don't change
	truncate --size=32768 os-image.bin

kernel.bin: kernel_entry.o interrupts_util.o paging_util.o context_switch.o ${KERNEL_OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 --oformat binary $^

kernel_entry.o: kernel/kernel_entry.asm
	#compile the kernel entry point but dont link, we need the contents of kernel.c
	nasm kernel/kernel_entry.asm -f elf -o kernel_entry.o

interrupts_util.o: kernel/interrupts_util.asm
	nasm kernel/interrupts_util.asm -f elf -o interrupts_util.o

context_switch.o: threads/context_switch.asm
	nasm threads/context_switch.asm -f elf -o context_switch.o

paging_util.o: mem/paging_util.asm
	nasm mem/paging_util.asm -f elf -o paging_util.o

%.o: %.c
	#compiling kernel soucres... getting that std=c99 is beyond my willpower
	gcc -ffreestanding -m32 -std=c99 -Wall -c $< -o $@

bootsect.bin: boot/bootsect.asm
	#compile the boot loader
	nasm boot/bootsect.asm -f bin -o bootsect.bin

clean:
	rm *.o *.bin
	rm ${KERNEL_OBJ}

qemu: os-image.bin
	qemu-system-i386 os-image.bin -d cpu_reset

bochs: os-image.bin bochsrc
	bochs

run: qemu

disasm: kernel.bin
	ndisasm -b 32 kernel.bin | less
