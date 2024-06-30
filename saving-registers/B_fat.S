    .text

//  ... fat(...) {
    .globl fat
fat:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $16, %rsp

    // if (n > 0) {
    _if:
    cmpl    $0, %edi
    jle     end_if

    // save register %rdi
    movq    %rdi, -8(%rbp)

    # 1st (and only) argument
    subl    $1, %edi # %edi = (n - 1)

    call fat

    // recover %rdi

    movq    -8(%rbp), %rdi

    imull   %edi, %eax # return (n * fat(n - 1));

    leave
ret

    end_if:
    // return 1;
    movl    $1, %eax

    leave
ret
