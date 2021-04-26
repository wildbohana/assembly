# pronađi najveći element u nizu

.section .data
	n_el = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	maks: .long 0
.section .text
.globl main

main:
	movl $0, %esi		# indeks
	movl maks, %eax		# trenutni maks, ide bez $ !!!
petlja:
	cmpl $n_el, %esi	# indeks < n_el, ovde ide $ jer je n_el konstanta
	je kraj
	cmpl %eax, niz(,%esi,4)	# porediš
	ja promena
	incl %esi
	jmp petlja
promena:
	movl niz(,%esi,4), %eax
	incl %esi
	jmp petlja
kraj:
	movl %eax, maks
	movl $1, %eax
	movl $0, %ebx
	int $0x80
