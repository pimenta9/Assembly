    .section .rodata

fmt:.string "Hello"

    .data

    // int val = 432;
    .globl  val
    .align  4
val:.int    432

    // short age = 4;
    .globl  age
    .align  2
age:.word   4

    // int r = 0;
    .globl  r
    .align  4
r:  .int    0

    // long err = 2048;
    .globl  err
    .align  8
err:.long   2048

    .text

//  main()
    .globl main
main:
    pushq   %rbp
    movq    %rsp, %rbp

    // CALLING SUM
    movq    $fmt, %rdi # 1st argument: "Hello"
    movl    val , %esi # 2nd argument: val
    movw    age , %dx # 3rd argument: age
    movq    $r  , %rcx # 4th argument: &r

    call    sum
    // val = sum(...)
    movl    %eax, val

    // CALLING SHOW
    movq    err , %rdi # 1st argument
    movl    val , %esi # 2nd argument
    movl    r   , %edx # 3rd argument

    call    show

    # return 0;
    movq    $0, %rax

    leave
ret
