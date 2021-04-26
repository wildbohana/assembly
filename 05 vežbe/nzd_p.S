# nzd potprogram

.section .data
.section .text
.globl nzd

nzd:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx		# mogla si i da ne koristiš ebx, onda ne bi morala ovo (npr ecx)
	
	movl 8(%ebp), %eax	# stavi a u eax
	movl 12(%ebp), %ebx	# stavi b u ebx
uporedi:
	cmpl %ebx, %eax
	je kraj
	ja vece
	subl %eax, %ebx
	jmp uporedi
vece:
	subl %ebx, %eax
	jmp uporedi
kraj:
	popl %ebx		# restauracija ebx
	movl %ebp, %esp		# ne znam iskreno
	popl %ebp
	ret
