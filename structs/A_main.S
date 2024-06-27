    .section .rodata
fmt:.string "color: %ld, filled: %d\n"
    
    .data

    // struct Circle c1;
    .globl c1
    .align 8
c1:
    .int 0 # int x
    .int 0 # int y
    .byte 0 # char filled
    .zero 7 # padding
    .quad 0 # long color

    .text

//  main()
    .globl main
main:
    pushq   %rbp
    movq    %rsp, %rbp

    // get &c1
    movq    $c1 , %r8 # %r8 = &c1

    // c1.x = 10;
    movl    $10 , (%r8)

    // c1.y = 2 * c1.x;
    movl    (%r8), %eax
    imull   $2, %eax
    movl    %eax, 4(%r8)

    // c1.filled = 1;
    movb    $1, 8(%r8)

    // if ()
    _if:
    cmpl    $15, 4(%r8)
    jle     _else

        // c1.color = RED;
        movq    $2, 16(%r8)

    jmp     end_if_else
    _else:

        // c1.color = BLUE;
        movq    $1, 16(%r8)

    end_if_else:

    // CALL PRINTF
    movq    $fmt    , %rdi # 1st argument
    movq    16(%r8) , %rsi # 2nd argument
    movsbl  8(%r8)  , %edx # 3rd argument
    movl    $0, %eax
    call    printf

    // return 0;
    movl    $0, %eax

    leave
ret
