#pragma once

#include "../kernel/types.h"
#include "../kernel/interrupts.h"

#include "../syscalls/syscall.h"

#include "../synch/synch.h"

#include "../mem/paging.h"
#include "../mem/heap.h"

#include "../threads/threads.h"

#define assert(condition) ;
#define halt() for(;;);
