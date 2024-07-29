    .text

    .globl  compare_guid
compare_guid:
    pushq   %rbp
    movq    %rsp, %rbp

    // if (id1->part1 != id2->part1)
    movl    (%rdi), %ecx
    movl    (%rsi), %edx
    cmpl    %ecx, %edx
    je      end_if1

        // return 0;
        movl    $0, %eax
        leave
        ret

    end_if1:

    // if (id1->part2 != id2->part2)
    leaq    4(%rdi), %rcx
    movw    (%rcx), %cx
    leaq    4(%rsi), %rdx
    movw    (%rdx), %dx
    cmpw    %cx, %dx
    je      end_if2

        // return 0;
        movl    $0, %eax
        leave
        ret

    end_if2:

    // if (id1->part3 != id2->part3)
    leaq    6(%rdi), %rcx
    movw    (%rcx), %cx
    leaq    6(%rsi), %rdx
    movw    (%rdx), %dx
    cmpw    %cx, %dx
    je      end_if3

        // return 0;
        movl    $0, %eax
        leave
        ret

    end_if3:

    // for (int i = 0 ; i < 8 ; i++)
    movl    $0, %eax
    _for:
    cmpl    $8, %eax
    jge     end_for

        movslq    %eax, %rax
        // if (id1->part4[i] != id2->part4[i])
        leaq    8(%rdi), %rcx
        addq    %rax, %rcx
        movb    (%rcx), %cl
        leaq    8(%rsi), %rdx
        addq    %rax, %rdx
        movb    (%rdx), %dl

        cmpb    %cl, %dl
        je      end_if4

            // return 0;
            movl    $0, %eax
            leave
            ret

        end_if4:

    incl    %eax
    jmp _for
    end_for:

    // return 1;
    movl    $1, %eax
    leave
    ret
