# pronađi najmanji el u nizu

.section .data
	n_el = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	min: .long 99999999
.section .text
.globl main

main:
	movl $0, %esi		# indeks
	movl min, %eax		# trenutni min, smeštaš ovo bez $ jer sa $ ne uzme dobru vr
				# ovo je promenljiva i njima pristupaš samo sa imenom (bez $)
petlja:
	cmpl $n_el, %esi	# indeks < n_el
	je kraj
	cmpl %eax, niz(,%esi,4)	# porediš
	jb promena
	incl %esi
	jmp petlja
promena:
	movl niz(,%esi,4), %eax
	incl %esi
	jmp petlja
kraj:
	movl %eax, min
	movl $1, %eax
	movl $0, %ebx
	int $0x80
