    .section .rodata

fmt:.string "a = %f, b = %f, e = %f\n"

    .text

    .globl  calc2
calc2:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $16 , %rsp

    // saving registers
    movss    %xmm0, -4(%rbp)
    movss    %xmm1, -8(%rbp)

    # cos(b)
    cvtss2sd    %xmm1, %xmm0
    call        cos

    // double e = a + cos(b);
    cvtss2sd    -4(%rbp), %xmm2
    addsd       %xmm0   , %xmm2

    // printf(...)
    movl              $3, %eax
    movq            $fmt, %rdi
    cvtss2sd    -4(%rbp), %xmm0
    cvtss2sd    -8(%rbp), %xmm1
    # %xmm2 is already 3rd floating point argument
    call        printf

    movss   -8(%rbp), %xmm0

    leave
ret
