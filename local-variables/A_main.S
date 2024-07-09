    .section .rodata

fmt:.string "Soma: %ld\n"
    
    .data

    .text

    .globl  main
main:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $48 , %rsp

    // save %rbx, %r12
    movq    %rbx, -8(%rbp)
    movq    %rbx, -48(%rbp)

    // short s;     =>  %bx
    // int i;       =>  -20(%rbp)
    // long l;      =>  -16(%rbp)

    // s = (short)constante();
    call    constante
    movsbw    %al , %bx

    // init(s, &l, &i);
    movw    %bx , %di // s
    movq    %rbp, %rsi
    subq    $16 , %rsi // &l
    leaq    -20(%rbp), %rdx // &i
    call    init

    // printf("Soma: %ld\n", l + i + s);
    movq    $fmt, %rdi
    movswq  %bx , %rbx
    movslq   -20(%rbp), %r12
    movq    -16(%rbp), %rsi
    addq    %r12, %rsi
    addq    %rbx, %rsi
    call    printf

    // return 0;
    movl    $0, %eax

    // recover callee-saved registers
    movq    -8(%rbp), %rbx
    movq    -48(%rbp), %r12

    leave
ret
