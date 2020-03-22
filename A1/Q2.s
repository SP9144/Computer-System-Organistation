.global _start

_start:	 
    movq $0, %rax       # x stored in %rax, x = 9
    movq $1, %rdi       # i stored in %rdi, i = 1
    movq $1, %rbx       # fact stored in %rbx, set fact = 1
    jmp .test           # goto test

.loop:
    imulq %rdi, %rbx    # Compute fact *= i
    movq %rax, %rcx     # Move x from %rax to %rcx
    movq %rbx, %rax     # Move fact from %rbx to %rax
    movq $0, %rdx       # Set rdx to all 0s
    divq %rcx           # Compute fact/x 
    movq %rcx, %rax     # Move x back from %rcx to %rax
    test %rdx, %rdx     # Compare fact%x : 0
    je exit             # If 0, goto exit
    addq $1, %rdi       # Increment i

.test:
    cmpq %rdi, %rax     # Compare i:x
    jge .loop           # If <, goto loop
    jmp exit

exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall 
    