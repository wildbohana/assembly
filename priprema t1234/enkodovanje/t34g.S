# void potprogram(unsigned char *unos)

.section .data
	maxl = 51
	t1: .ascii "Unesite Vaš string: \0"
	t1l = . - t1
	t2: .ascii "Enkodovan string: \0"
	t2l = . - t2
	unos: .fill maxl, 1, 42
	unosl: .long 0
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
	movl $unos, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, unosl
poziv:
	pushl $unos
	call e13
	addl $4, %esp

ispis:
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2l, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl unosl, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
