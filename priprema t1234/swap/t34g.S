# unesi string, svaka dva susedna se menjaju, šalješ *s1 i vraćaš ga

.section .data
	maxl = 50
	t1: .ascii "Unesite string: \0"
	t1l = . - t1
	unos: .fill maxl, 1, 42
	unosl: .long 0
	paran: .byte -1	
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
	movl %eax, unosl		# smeštaš dužinu

###################
poziv:
	pushl $unos
	call swat
	addl $4, %esp
	
##################
ispis:
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl unosl, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
