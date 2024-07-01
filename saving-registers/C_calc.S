    .section .rodata

fmt: .string "%d: sum = %ld\n"
fmt2:.string "retorno = %ld\n"

    .data

    // short v[5] = {1, 2, 3, 4, 5};
    .globl  v
    .align  2
v:  .word   1, 2, 3, 4, 5

    // short max = 0;
    .globl  max
    .align  2
max:.word   0

    .text

# ----------------------------------------------------

//  ... calc(...) {
    .globl  calc
calc:
    pushq   %rbp
    movq    %rsp, %rbp

    subq    $64, %rsp

    // %r12, %r13, %r14 : callee-saved :
    // before using the registers we have to save them
    movq    %r12, -8(%rbp)
    movq    %r13, -16(%rbp)
    movq    %r14, -24(%rbp)

    // short value; %r12w
    // int i = 0;
    movl    $0, %r13d
    // long sum = 0;
    movq    $0, %r14

    // while (i < size)
    _while:
    cmpl    %esi, %r13d
    jge     end_while

        // get v[i]
        movslq  %r13d, %r9 # %r9 = (long)i
        imulq   $2   , %r9 # %r9 = 2 * (long)i
        addq    %rdi , %r9 # %r9 = &v[i]

        // value = vet[i];
        movw    (%r9), %r12w

        // if (*max < value)
        cmpw    %r12w, (%rcx)
        jge     end_if

            // *max = value;
            movw    %r12w, (%rcx)

        end_if:

        // sum = (long)(*max * (short)factor);
        movw    %dx, %r14w # (word) sum = (short) factor
        imulw   (%rcx), %r14w # (word) sum *= *max
        movswq  %r14w, %r14 # sum = (long)sum

        // CALLING PRINTF
        # save %rdi, %rsi, %rdx, %rcx, %r8
        movq    %rdi, -32(%rbp)
        movq    %rsi, -40(%rbp)
        movq    %rdx, -48(%rbp)
        movq    %rcx, -56(%rbp)
        movq    %r8 , -64(%rbp)

        # printf arguments
        movq    $fmt , %rdi
        movl    %r13d, %esi
        movq    %r14 , %rdx
        movl    $0   , %eax # printf default
        
        call printf

        // i++;
        incl    %r13d

        # recover %r8
        movq    -32(%rbp), %rdi
        movq    -40(%rbp), %rsi
        movq    -48(%rbp), %rdx
        movq    -56(%rbp), %rcx
        movq    -64(%rbp), %r8

    jmp     _while
    end_while:

    // if (option == 1)
    cmpb    $1, %r8b
    jne     end_if2

    // return 1
    movq    %r14, %rax
    jmp     _return

    end_if2:

    // return 0
    movq    $0, %rax

    _return:
    // recovering registers
    movq     -8(%rbp), %r12
    movq    -16(%rbp), %r13
    movq    -24(%rbp), %r14

    leave
ret

# ----------------------------------------------------

    .globl main
main:
    pushq   %rbp
    movq    %rsp, %rbp

    // calling calc(...)
    movq    $v  , %rdi
    movl    $5  , %esi
    movl    $2  , %edx
    movq    $max, %rcx
    movb    $1  , %r8b

    call calc

    // calling printf(...)
    movq    $fmt2, %rdi # 1st argument
    movq    %rax, %rsi # 2nd argument

    movl    $0  , %eax # printf default
    call printf

    // return 0;
    movl    $0, %eax

    leave
ret
