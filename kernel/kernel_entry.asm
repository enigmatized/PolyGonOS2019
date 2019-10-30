; Entry point for the kernel. 
;NOTE: The actual location of kernel has little meaning with paging

;This was the previous file
;______
;_start:
;    [extern kernel_main]
;_____
;new
[bits 32]
[extern main];Calling the kernal main func
;must have main func now
call main
jmp $;never reaches here

