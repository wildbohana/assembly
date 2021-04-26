# void usklik(unsigned char *unos, char *r)

.section .data
.section .text
.globl usklik

usklik:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl $0, %ebx			# brojac za uskličnike

registri:
	movl 8(%ebp), %esi
	movl %esi, %edi
	addl $40, %edi
provera:
	cmpl %esi, %edi
	je vrednost
smesti_u_nizi:
	movb (%esi), %dl
poredi:
	cmpb $'!' , %dl
	je usklicnik
sledeci:
	incl %esi
	jmp provera
usklicnik:
	incl %ebx
	jmp sledeci
vrednost:
	cmpl $4, %ebx
	jl kec
	cmpl $9, %ebx
	jl dvica
	jmp trojka
kec:
	movb $1, %dl
	jmp kraj
dvica:
	movb $2, %dl
	jmp kraj
trojka:
	movb $3, %dl

kraj:
	movl 12(%ebp), %esi
	movb %dl, (%esi)
	
	popl %edi
	popl %esi
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
