# broj ! u stringu, šalješ string i r (jer ti treba r za ebx na kraju)

.section .data
	maxl = 40
	t1: .ascii "Unesite string: \0"
	t1l = . - t1
	unos: .fill maxl, 1, 42
	unosl: .long 0
	broj: .long 0
	r: .long 0
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
#########################
poziv:
	pushl $r
	pushl $unos
	call usklik
	addl $8, %esp
#########################
kraj:
	movl $1, %eax
	movl r, %ebx
	int $0x80
