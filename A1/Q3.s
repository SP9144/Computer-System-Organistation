.global _start

_start:	 
    movq $5, %r8       # a stored in %r8
    movq $8, %r9       # b stored in %r9
    movq $10, %r10      # n stored in %r10

    movq $1, %r11       # acc stored in %r11, set acc = 1

    movq $0, %rdx       # Set rdx to all 0s
    movq %r8, %rax      # Move a to %rax for division
    divq %r10           # Compute a/n
    movq %rdx, %r8      # Set a = a%n
    
    jmp .while_test     # goto test

.loop:
    shrq $1, %r9        # Compute b = b/2
    imulq %r8, %r8      # a = a*a
    movq $0, %rdx       # Set rdx to all 0s
    movq %r8, %rax      # Move a to %rax for division
    divq %r10           # Compute a/n
    movq %rdx, %r8      # Set a = (a*a)%n
    jmp .while_test     # goto while_test

.odd:
    movq %r9, %rcx       # copy b to %rcx
    and $1, %rcx         # b = b&1 
    cmp $0, %rcx         # Compare value of rbx with 0
    je .loop             # If even, goto loop

    imulq %r8, %r11      # Compute acc = acc*a
    movq %r11, %rax      # Move a to %rax for division 
    movq $0, %rdx        # Set rdx to all 0s
    divq %r10            # Compute acc/n
    movq %rdx, %r11      # Set acc = (acc*a)%n
    jmp .loop            # goto odd

.while_test:
    cmp $0, %r9       # Compare 0:b
    jg .odd           # If >, goto loop
    jmp exit

exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall 
