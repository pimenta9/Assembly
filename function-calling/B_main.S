    .data

    // int i = 0;
    .globl  i
    .align  4
i:  .int    0

    // long bias = 256;
    .globl  bias
    .align  8
bias:.quad  256

    // unsigned char vet[LEN] = {12, 3, 20, 8};
    .globl  vet
    .align  1
vet:.byte   12, 3, 20, 8

    .text

// main()
    .globl main
main:
    pushq   %rbp
    movq    %rsp, %rbp

    // for (
    // i = 0;
    movl    $0, i
    _for:
    // (while i < 4)
    cmpl    $4, i
    jge     end_for
// {
    # get vet[i]
    movq    $vet, %r8   # %r8 = &vet[0]
    movslq  i   , %r9   # %r9 = (long)i
    # sizeof(char) == 1 byte
    addq    %r9 , %r8   # %r8 = &vet[i]

    // CALLING FILTRO()
    movb    (%r8), %dil # 1st argument
    movw    $10   , %si # 2nd argument
    movq    bias , %rdx # 3rd argument
    call    filtro
    movl    %eax , bias # bias = filtro(...)

    incl    i # i++;
    jmp     _for # loop
    end_for:
// }

    // return 0;
    movq    $0, %rax

    leave
ret
