# nzd dva broja

.section .data
.section .text
.globl main

main:
	movl $12, %eax
	movl $8, %ebx
nzd:
	cmpl %eax, %ebx		# porediš b sa a, za b>a ide ja skok (znači a<b)
	je kraj			# mogla sam napraviti dva skoka za oba slučaja
	ja a_manji		# ali je bolje napraviti jedan a za drugi slučaj
	subl %ebx, %eax		# samo pusti da prođe dalje (za slučaj a>b konkretno)
	jmp nzd
a_manji:
	subl %eax, %ebx		# kada je b veći onda je b-=a
	jmp nzd
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
