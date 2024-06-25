    .section .rodata

    .data

    .globl a
    .align 4
a:  .int 30

    .globl b
    .align 4
b:  .int 5

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

if1:
    movl a, %eax
    cmpl b, %eax
    jle end_if1

    # c = -c;
    movl c, %eax
    negl %eax
    movl %eax, c

    # d = c / 3;
    movl c, %eax
    cltd
    movl $3, %ecx
    idivl %ecx
    movl %eax, d

end_if1:

    // if (b >= a)
if2:
    movl b, %eax
    cmpl a, %eax
    jl end_if2

    # c = (a + b) * c;
    movl a, %eax
    addl b, %eax
    imull c, %eax
    movl %eax, c

    # d = 1024;
    movl $1024, d

end_if2:

    leave
    ret
