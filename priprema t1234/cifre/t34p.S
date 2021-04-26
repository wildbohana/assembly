# poslat samo uneti string

.section .data
.section .text
.globl cifre

cifre:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %esi
	movl $0, %ebx			# ovde smeštaš broj cifara
	
prolazak:
	cmpb $10, (%esi)		# ovde ide cmpb a ne cmpl !!!!!!!!!!
	je kraj
	movb (%esi), %dl
	cmpb $'0', %dl
	jl sledeci
	cmpb $'9', %dl
	jg sledeci
	incl %ebx
sledeci:
	incl %esi
	jmp prolazak
kraj:
	movl %ebx, %eax
	
	popl %ebx
	popl %edi
	popl %esi
	
	movl %ebp, %esp
	popl %ebp
	ret
