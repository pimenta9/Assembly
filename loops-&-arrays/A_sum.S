    .data

    // int s = 0;
    .globl s
    .align 4
s:  .int 0

    // int nums[4] = {65, -105, 111, 34};
    .globl nums
    .align 4
nums:.int 65, -105, 111, 34

    .text

// sum()
// {
    .globl sum
sum:
    pushq   %rbp
    movq    %rsp, %rbp

    // int i = 0;
    movl    $0, %eax

    // while (i < 4)
    // {
    loop_while:
        cmpl    $4, %eax
        jge     end_while

        # %r8 = nums
        movq    $nums, %r8
        # %r9 = 4 * (long)i
        movslq  %eax, %r9
        imulq   $4, %r9
        # %r8 = nums + (4 * i) = &nums[i]
        addq    %r9, %r8

        // s = s + nums[i];
        movl    (%r8), %r10d
        addl    %r10d, s

        // i++;
        incl    %eax

        jmp     loop_while

    end_while:
    // }

    leave
ret
// }
