# poslat samo string

.section .data
.section .text
.globl space

space:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl $0, %ebx		# brojač za broj (može odmah eax)

pokazivaci:
	movl 8(%ebp), %esi
	movl %esi, %edi
	addl $20, %edi
provera:
	cmpl %esi, %edi		# provera kraja
	je kraj
	movb (%esi), %dl
	cmpb $' ' , %dl
	je razmak
	incl %esi
	jmp provera
razmak:
	movb $'0', (%esi)
	incl %ebx
	incl %esi
	jmp provera

kraj:
	movl %ebx, %eax
	popl %ebx
	popl %edi
	popl %esi
	
	movl %ebp, %esp
	popl %ebp
	ret
