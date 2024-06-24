    .data

    .globl c
    .align 1
c:  .byte 67

    .globl s
    .align 2
s:  .short 23

    .globl i
    .align 4
i:  .int 0

    .globl j
    .align 4
j:  .int 0

    .globl l
    .align 8
l:  .quad 1023

    .globl ui
    .align 4
ui: .int 2047

    .globl ul
    .align 8
ul: .quad 4095

	.text


#---------------------------------------------------------------------------------

	.globl atribuicoes
atribuicoes:
	pushq %rbp
	movq  %rsp, %rbp

	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:
	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11
    movb $93, c
    movw $75, s
    movl $52, j
    movq $7265, l
    movl j, %eax
    movl %eax, i

	leave
	ret

#---------------------------------------------------------------------------------
	.globl cast
cast:
	pushq %rbp
	movq  %rsp, %rbp

	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:
	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

    # ui = i;
    movl i, %eax
    movl %eax, ui

    # j = s;
    movswl s, %eax
    movl %eax, j

    # ul = ui;
    movslq ui, %rax
    movq %rax, ul

    # s = c + j;
    movsbl c, %eax
    addl j, %eax
    movw %ax, s

	leave
	ret

#---------------------------------------------------------------------------------
	.globl expressoes
expressoes:
	pushq %rbp
	movq  %rsp, %rbp

	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:
	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

	# i = j * s;
    movswl s, %eax
    imull j, %eax
    movl %eax, i

    # j = 1 + (s * 3);
    movswl s, %eax
    imull $3, %eax
    addl $1, %eax
    movl %eax, j

    # ui = 2 * (i + s * 2);
    movswl s, %eax
    imull $2, %eax
    addl i, %eax
    imull $2, %eax
    movl %eax, ui

    # ul = (l + j * 3) - (s + 1024);
    # (l + (long)j * 3)
    movslq j, %rax
    imulq $3, %rax
    addq l, %rax
    # ((long)s + 1024)
    movswq s, %rbx
    addq $1024, %rbx

    subq %rbx, %rax
    movq %rax, ul

	leave
	ret

#---------------------------------------------------------------------------------
	.globl bitAbit
bitAbit:
	pushq %rbp
	movq  %rsp, %rbp


	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:
	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

	# c = c & 0x0F;
    andb $0x0F, c
    # s = s | 0x80;
    orw $0x80, s
    # i = i ^ 0x55;
    xorl $0x55, i
    # j = (j | s) ^ c;
    movswl s, %eax
    orl %eax, j
    movsbl c, %eax
    xorl %eax, j
    # l = l >> 2;
    shr $2, l
    # ui = ui << 1;
    shl $1, ui
    # ul = ul >> 4;
    sar $4, ul

	leave
	ret

#---------------------------------------------------------------------------------
	.globl ponteiros
ponteiros:
	pushq %rbp
	movq  %rsp, %rbp

	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:
	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11
    movq $s, %r8
    movw $128, (%r8)

	leave
	ret
