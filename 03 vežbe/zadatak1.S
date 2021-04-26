# suma svih elemenata u nizu, znaš broj elemenata (statički zadat niz)

.section .data
	n_el = 10			# ne ide .long nego ide odmah =
	niz: .long 1,2,3,4,5,6,7,8,9,10
	suma: .long 0
.section .text
.globl main

main:
	movl $0, %esi			# brojač za adresu kao (indeks niza da ne kažem)
	movl $0, %eax			# suma (u registru)
petlja:
	addl niz(,%esi,4), %eax
	incl %esi			# kao i++ u a[i]
	cmpl $n_el, %esi		# i<n_el (uslov za petlju)
	jl petlja			# da je n_el bilo bez = bila bi beskonačna petlja
kraj:
	movl %eax, suma			# smesti sumu iz registra u memoriju
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
