# nzd poziv potprograma

.section .data
	a: .long 123
	b: .long 567
	r: .long 0
.section .text
.globl main

main:
	pushl b
	pushl a
	call nzd
	addl $8, %esp
	movl %eax, r
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
