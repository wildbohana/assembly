# deljenje preko oduzimanja, dvostruka preciznost

.section .data
	a:  .quad 12345678
	b:  .quad 912
	k:  .quad 0
	o:  .quad 0
	greska: .byte 0
.section .text
.globl main

main:
	movl a, %eax
	movl a+4, %edx
	cmpl $0, b		# da li deliš nulom (zaštita lowkey)
	jne deli
	cmpl $0, b+4		# proveri i više i niže delove
	je nula
provera:
	cmpl b+4, %edx		# a ? b
	jg deli
	jl kraj			# ako je viši deo manji, onda je ceo broj def manji, kraj
	cmpl b, %eax		# ako su jednaki, propašće do ove provere
	jl kraj			# ako su jednaki, opet će se deliti (rezultat +1)
deli:
	subl b, %eax
	sbbl b+4, %edx
	addl $1, k
	adcl $0, k+4		# isto kao da sbbl, sam već doda 1, ne moraš opet (biće +2)
	jmp provera	
nula:
	incb greska
kraj:
	movl %eax, o		# upiši ostatak
	movl %edx, o+4		# i niži i viši deo
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
