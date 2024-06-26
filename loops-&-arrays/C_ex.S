    .data

    // unsigned char letters[] = "abcdefghij";
    .globl letters
    .align 1
letters:.string "abcdefghij"

    // int even = 0;
    .globl even
    .align 4
even:.int  0

    // int odd = 0;
    .globl odd
    .align 4
odd:.int   0

    .text

// ex02()
// {
    .globl ex02
ex02:
    pushq   %rbp
    movq    %rsp, %rbp

    // unsigned int count = 0;
    movl    $0, %eax

    // while ()
    // {
    _while:
    // get letters[count]
    movq    $letters, %r8
    movslq  %eax   , %r9
    # char is already 1
    addq    %r9 , %r8
    # at this point, %r8 = &vet[0] + count

    # (if letters[count] == 0) jmp end_while
    cmpb    $0, (%r8)
    je      end_while

    // if (letter[count++] & 1)
    _if:
    testb   $1, (%r8)
    jz      else

        incl    odd # odd++;

        jmp     end_if_else

    else:

        incl    even # even ++;

    end_if_else:

    incl    %eax   # count++;

    jmp _while
    end_while:
    // }

    leave
ret
// } end of ex02
