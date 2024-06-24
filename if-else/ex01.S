.section .rodata

.data

    .globl a
    .align 4
a:  .int 30

    .globl b
    .align 4
b:  .int 45

    .globl c
    .align
c:  .int -60

    .globl d
    .align 4
d:  .int 25

.text

.globl ex01
ex01:
    pushq %rbp
    movq  %rsp, %rbp

if01:
    cmpl b, a
    jle endif01

    imull $-1, c
    
    movl c, %eax
    

endif01:

    leave
    ret
