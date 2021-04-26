# void potprogram(unsigned char *s1, unsigned char *s2, char *r)

.section .data
.section .text
.globl counting

counting:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl $0, %ebx			# brojac za plus
	movl $0, %ecx			# brojac za minus
	
pocetak1:
	movl 8(%ebp), %esi
	movl %esi, %edi
	addl $20, %edi
	jmp provera1
provera1:
	cmpl %esi, %edi
	je pocetak2
smestanje_u_nizi1:
	movb (%esi), %dl
poredi1:
	cmpb $'+' , %dl
	je plus
	jmp sledeci1
plus:
	addl $1, %ebx
sledeci1:
	incl %esi
	jmp provera1	
	
pocetak2:
	movl 12(%ebp), %esi
	movl %esi, %edi
	addl $20, %edi
	jmp provera2
provera2:
	cmpl %esi, %edi
	je vrednost
smestanje_u_nizi2:
	movb (%esi), %dl
poredi2:
	cmpb $'-' , %dl
	je minus
	jmp sledeci2
minus:
	addl $1, %ecx
sledeci2:
	incl %esi
	jmp provera2

vrednost:
	cmpl %ecx, %ebx
	ja kec
	jb dvica
	je trica
kec:
	movl $1, %edx
	jmp kraj
dvica:
	movl $2, %edx
	jmp kraj
trica:
	movl $3, %edx

kraj:
	movl 16(%ebp), %esi		# esi je pokazivač na niz
	movl %edx, (%esi)		# edx je mesto gde si smestila povratni rezultat
	
	popl %edi
	popl %esi
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret

