# deljenje preko oduzimanja (a-b sve dok a<b)

.section .data
.section .text
.globl main

main:
	movl $16, %eax		# šta deliš
	movl $3, %ebx		# sa čim deliš
	movl $0, %ecx		# rezultat
deli:
	cmpl %eax, %ebx		# porediš b sa a, znači b>a -> ja skok
	ja kraj
	subl %ebx, %eax
	addl $1, %ecx
	jmp deli
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
