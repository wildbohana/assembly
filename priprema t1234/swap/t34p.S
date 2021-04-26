# poslat samo *unos

.section .data
.section .text
.globl swat

swat:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi		# pokazuje na niz
	pushl %edi		# u sebi sadrži broj elemenata niza
	pushl %ebx		# parnost, paran neparan

	movl 8(%ebp), %esi
	movl $0, %edi
broj_el:
	cmpl $10, (%esi)
	je parnost
	incl %esi
	jmp broj_el
	
parnost:
	subl $2, %edi
	cmpl $1, %edi
	je neparno
	jb parno
	jmp parnost
parno:
	movl $1, %ebx
	jmp ispitaj
neparno:
	movl $0, %ebx
ispitaj:
	addl %esi, %edi			# sad je edi na kraju stringa
	cmpl $1, %ebx
	je svi
	jb predzadnji
	
svi:
	jmp provera
predzadnji:
	decl %edi
	jmp provera			# mada ne mora

provera:
	cmpl %esi, %edi
	je kraj
menjaj:
	movl %esi, %eax			# čuva adresu trenurnog karaktera
	movb (%esi), %cl		# čuva vrednost prvog karaktera
	incl %esi			# pređi na sledeći element
	movl %esi, %ebx			# sačuvaj adresu trenutnog karaktera
	movb (%ebx), %dl		# sačuvaj vrednost trenurnog karaktera
	
	xchgb %dl, (%eax)		# prepiši vrednost drugog na vrednost prvog
	xchgb %cl, (%ebx)		# prepiši vrednost prvog na vrednost drugog
	
	incl %esi			# pređi na sledeći element (incl + incl)
	jmp provera

kraj:
	popl %ebx
	popl %edi
	popl %esi
	
	movl %ebp, %esp
	popl %ebp
	ret
	
