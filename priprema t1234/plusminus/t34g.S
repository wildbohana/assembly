# void potprogram(unsigned char *s1, unsigned char *s2, char *r)


.section .data
	maxl = 21
	t1: .ascii "Unesite S1: \0"
	t1l = . - t1
	t2: .ascii "Unesite S2: \0"
	t2l = . - t2
	s1: .fill maxl, 1, 42
	s1l: .long 0
	s2: .fill maxl, 1, 42
	s2l: .long 0
	brp: .long 0
	brm: .long 0
	r: .byte 0
	gotovo: .long 0
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $t1, %ecx
	movl $t1l, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $s1, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, s1l			# unet prvi
	
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2l, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $s2, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, s2l			# unet drugi
	
poziv:
	pushl $r
	pushl $s2
	pushl $s1
	call counting
	addl $12, %esp

kraj:
	movl $1, %eax
	movl r, %ebx
	int $0x80
