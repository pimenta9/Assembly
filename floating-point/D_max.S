    .section .rodata

    .align  8
tmp:.double 0.0
    
    .text

    .globl  max_prod
max_prod:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $32, %rsp

    # save ptr
    movq    %rdi, -8(%rbp)

    // double m = 0.0;
    movsd   tmp, %xmm7
    movsd   %xmm7, -16(%rbp)

    // while (ptr->id)
    _while:
    movq    -8(%rbp), %rdi
    cmpl    $0, (%rdi)
    je      end_while

        // double tmp = floor(ptr->value);
        addq    $8, %rdi
        movsd    (%rdi), %xmm0
        call    floor

        // if (m < tmp)
        ucomisd -16(%rbp), %xmm0
        jbe     end_if

            // m = tmp;
            movsd   %xmm0, -16(%rbp)

        end_if:

        // ptr++;
        addq    $16, -8(%rbp)

    jmp     _while
    end_while:

    // return m;
    movsd   -16(%rbp), %xmm0
    leave
ret
