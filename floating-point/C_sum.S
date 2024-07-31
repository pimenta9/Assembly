    .section .rodata

fmt01: .string "Soma %f maior que o limite %f (%d)\n"

    .align 8
tmp01:  .double 0.0

    .text

    .globl sum
sum:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $80, %rsp

    // save %xmm0
    movsd   %xmm0, -72(%rbp)

    // int i = 4;
    movl    $4, -4(%rbp)
    // double s = 0.0; -16(%rbp)
    movsd   tmp01, %xmm7
    movsd   %xmm7, -16(%rbp)
    // int vi[4] = {5,6,7,8}; -32(%rbp)
    movl    $5, -32(%rbp)
    movl    $6, -28(%rbp)
    movl    $7, -24(%rbp)
    movl    $8, -20(%rbp)
    // double vd[4]; -64(%rbp)

    // mult(vi, vd, i);
    leaq    -32(%rbp), %rdi # 1st argument
    leaq    -64(%rbp), %rsi # 2nd argument
    movl     -4(%rbp), %edx # 3nd argument
    call    mult
    movsd   -72(%rbp), %xmm0 # recover %xmm0

    // while (i > 0)
    _while:
    cmpl    $0, -4(%rbp)
    jle     end_while

        // s += vd[--i];
        subl    $1, -4(%rbp)
        leaq    -64(%rbp), %r8
        movslq  -4(%rbp), %r9
        imulq   $8, %r9
        addq    %r9, %r8 # %r8 <- &vd[--i];

        movsd   (%r8), %xmm1
        addsd   -16(%rbp), %xmm1
        movsd   %xmm1, -16(%rbp)

        // if (s > limit)
        ucomisd -16(%rbp), %xmm0
        jae end_if

            // printf("Soma %f maior que o limite %f (%d)\n", s, limit, i);
            movl    $2      , %eax # printf default
            movq    $fmt01  , %rdi # 1st argument
            movsd   -16(%rbp), %xmm0 # 2nd argument
            movsd   -72(%rbp), %xmm1 #3rd argument
            movl    -4(%rbp), %esi # 4th argument
            call    printf

        end_if:

    jmp _while
    end_while:

    // return s;
    movsd   -16(%rbp), %xmm0

    leave
ret
