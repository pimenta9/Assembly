    .section .rodata

fmt:.string "sum = %ld\n"    

    .text

    .globl  sum
sum:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $48, %rsp

    # save nodes
    movq    %rdi, -8(%rbp)
    # save size
    movl    %esi, -12(%rbp)
    // int i => -16(%rbp)
    // int j => -20(%rbp)
    // void *h = new_sum();
    call    new_sum
    movq    %rax, -32(%rbp)

    // for (i = 0; i < size; i++)
    movl    $0, -16(%rbp)
    _forI:
    movl    -16(%rbp), %r10d
    cmpl    -12(%rbp), %r10d
    jge     end_forI

        // for (j = 0; j < nodes[i].used; j++)
        movl    $0, -20(%rbp)
        _forJ:

        movq    -8(%rbp), %rdi
        movslq  -16(%rbp), %r8
        imulq   $56, %r8
        addq    %rdi, %r8
        leaq    48(%r8), %rdi

        movl    -20(%rbp), %r10d
        cmpl    (%rdi), %r10d
        jge     end_forJ

            // add_sum(h, nodes[i].values[j]);
            addq    $8, %r8
            movslq  -20(%rbp), %r9
            imulq   $8, %r9
            addq    %r8, %r9
            movq    (%r9), %rsi # 2nd argument
            movq    -32(%rbp), %rdi # 1st argument
            # save %r8
            movq    %r8, -40(%rbp)
            call    add_sum
            # recover %r8
            movq   -40(%rbp), %r8

        incl    -20(%rbp)
        jmp     _forJ
        end_forJ:

    incl    -16(%rbp)
    jmp     _forI
    end_forI:

    // return get_sum(h);
    movq    -32(%rbp), %rdi
    call    get_sum

    leave
ret

    .globl  main
main:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $112, %rsp

    // node_t nodes[2] => -112(%rbp)

    // init(nodes);
    movq    %rbp, %rdi
    subq    $112, %rdi
    call    init

    // printf("sum = %ld\n", sum(nodes, 2));
        # sum(...)
        leaq    -112(%rbp), %rdi
        movl    $2, %esi
        call    sum
    movq    $fmt, %rdi
    movq    %rax, %rsi
    movl    $0, %eax
    call    printf

    // return 0;
    movl    $0, %eax
    leave
ret
