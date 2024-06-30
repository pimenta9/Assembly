    .section .rodata

fmt:.string "%d\n"

    .data

    .text

//  void show() {
    .globl show
show:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $32, %rsp

    // int i; ( %ecx )

    // for (...)
    movl    $0, %ecx # i = 0;
    _for:
        cmpl    %esi, %ecx  # if (i >= size){
        jge     end_for     # goto end_for;}

        # get v[i]
        movq    %rdi, %r8
        movslq  %ecx, %r9
        imulq   $4  , %r9
        addq    %r8 , %r9 # %r9 <-- &vet[i]

        // CALLING PRINTF
        // saving registers %ecx (int i), 
        // %rdi (v) and %esi (size)
        movq    %rcx, -8(%rbp)
        movq    %rdi, -16(%rbp)
        movq    %rsi, -24(%rbp)

        movq    $fmt , %rdi # passing first argument
        movl    (%r9), %esi #   ''   second argument
        movl    $0   , %eax # printf default

        call printf

        // recover registers
        movq    -8(%rbp), %rcx
        movq    -16(%rbp), %rdi
        movq    -24(%rbp), %rsi

        incl    %ecx # i++;
        jmp     _for
    end_for:

    leave
ret
