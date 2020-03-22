.global _start

_start:	 
    movq $15, %rbx      # A stored in %rbx, A = 30
    movq $3, %rcx       # B stored in %rcx, B = 8
    movq %rbx, %r8      # X stored in %r8, X = A = 30
    movq %rcx, %r9      # i stored in %r9, i = B

    jmp .main_test           # goto test

.main_test:
    cmpq $1, %r8        # Compare X:1
    jge .div_check      # if X>=1, goto div_check
    movq $1, %rdx       # else, Answer = %rdx = 1
    jmp exit

.div_check: 
    movq %rbx, %rax     # Move A to %rax for division
    movq $0, %rdx       # Set rdx to all 0s
    divq %r8            # Compute A/X
    test %rdx, %rdx     # Check if A%X==0
    je .gcd_test1       # if A%X == 0, goto gcd
    subq $1, %r8        # else, X = X-1
    jmp .main_test

.gcd_test1:
    movq %r8, %rax      # Move X to %rax for division
    movq $0, %rdx       # Set rdx to all 0s
    divq %r9            # Compute X/i
    test %rdx, %rdx     # Check if X%i==0
    je .gcd_test2       # if X%i== 0, goto gcd_test2
    subq $1, %r9        # else, i = i-1
    jmp .gcd_test1      # goto gcd_test1

.gcd_test2:
    movq %rcx, %rax     # Move B to %rax for division
    movq $0, %rdx       # Set rdx to all 0s
    divq %r9            # Compute B/i
    test %rdx, %rdx     # Check if B%i==0
    je .gcd_ans         # if B%i== 0, goto gcd_ans
    subq $1, %r9        # else, i = i-1
    jmp .gcd_test1      # goto gcd_test1

.gcd_ans:
    cmpq $1, %r9        # Compare i:1
    je .sum_digit       # if i != 1, goto main_test
    subq $1, %r8        # X = X-1
    jmp .main_test      # goto main_test

.sum_digit:
    movq $10, %r10      # Set %r10 = 10
    movq $0, %r11       # Set Sum = %r11 = 0 
    jmp .sum_loop       # goto sum_loop

.sum_loop:
    movq %r8, %rax      # Move X to %rax for division
    movq $0, %rdx       # Set rdx to all 0s
    divq %r10           # Compute X/10
    addq %rdx, %r11     # Sum = Sum + X%10
    movq %r11, %rdx     # Answer = %rdx = Sum = %r11
    test %rax, %rax     # Check if X == 0
    je exit             # if X==0, goto exit
    movq %rax, %r8      # Set %rax = %r8 = X/10 
    jmp .sum_loop       # goto sum_loop

exit:
    mov     $60, %rax               # system call 60 is exit
    xor     %rdi, %rdi              # we want return code 0
    syscall 
    



    
    



