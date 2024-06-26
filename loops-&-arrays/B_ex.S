    .data
    
    // short vet[4] = {50, 10, 67, 42};
    .globl  vet
    .align  2
vet:.word   50, 10, 67, 42

    // short max = 0;
    .globl  max
    .align  2
max:.word   0

    .text

// ex01()
// {
    .globl ex01
ex01:
    pushq   %rbp
    movq    %rsp , %rbp

    // char i; --> %ax

    // for (
    // i = 0;
    movw    $0  , %ax
    // (while)(i < 4);
    _for:
    cmpw    $4  , %ax
    jge     end_for
    // {
        // get vet[i]
        movq    $vet, %r8   # %r8 = &vet[0] = vet
        movswq  %ax , %r9   # %r9 = (long)i
        imulq   $2  , %r9   # %r9 = %r9 * 2
        addq    %r9 , %r8   # %r8 = vet + 2 * (long)i
        # %r8 == &vet[i]

        _if:
    // {
        movw    (%r8), %r9w # %r9w = vet[i]
        // if (vet[i] > max)
        cmpw    max  , %r9w
        jle     end_if

        // max = vet[i];
        movw    %r9w , max

        end_if:
    //  }

    // i++
    incw    %ax

    jmp     _for

    end_for:
    // }

    leave
ret
// }
