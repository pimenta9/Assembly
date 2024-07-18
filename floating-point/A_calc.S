    .text

    .globl  calc1
calc1:
    pushq   %rbp
    movq    %rsp, %rbp

    # (a + b)
    cvtss2sd    %xmm1, %xmm2
    addsd       %xmm0, %xmm2

    # (a - b)
    cvtss2sd    %xmm1, %xmm1
    subsd       %xmm1, %xmm0

    mulsd       %xmm2, %xmm0

    leave
ret
