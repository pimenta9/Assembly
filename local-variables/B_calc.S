    .data

    .text

    .globl  calc
calc:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $64, %rsp

    // save %rbx, %r12
    movq    %rbx, -8(%rbp)
    movq    %r12, -16(%rbp)

    // int i = 0;
    movl    $0, %ebx

    // int j = 4;
    movl    $4, %r12d

    // int sum;         =>  -20(%rbp)
    // int vet1[5];     =>  -40(%rbp)
    // short vet2[5];   =>  -50(%rbp)

    // filli(vet1, 5, i);
    leaq    -40(%rbp), %rdi
    movl    $5, %esi
    movl    %ebx, %edx
    call    filli

    // fills(vet2, 5, j);
    leaq    -50(%rbp), %rdi
    movl    $5, %esi
    movl    %r12d, %edx
    call    fills

    // sum = 0;
    movl    $0, -20(%rbp)

    // for (...)
    _for:
    cmpl    $5, %ebx    // compare (5, i)
    jge     end_for     // if (i >= 5), go to end_for

        // sum += vet1[i] + vet2[j];
        
        // get vet1[i]
        leaq    -40(%rbp), %r8
        movslq  %ebx, %r9
        imulq  $4, %r9
        addq    %r8, %r9

        // get vet2[j]
        leaq    -50(%rbp), %r10
        movslq  %r12d, %r11
        imulq   $2, %r11
        addq    %r10, %r11

        movswl  (%r11), %r10d
        addl    (%r9), %r10d
        addl    %r10d, -20(%rbp)

    incl    %ebx // i++
    subl    $1, %r12d // j--
    jmp _for
    end_for:

    // return sum;
    movl    -20(%rbp), %eax

    // recover callee-saved registers
    movq    -8(%rbp), %rbx
    movq    -16(%rbp), %r12

    leave
ret
