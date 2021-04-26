# množenje preko sabiranja za dvostruku preciznost

.section .data
	a: .quad 0x10000000
	b: .quad 0x10
	r: .quad 0		# treba da bude 0x00000001 00000000
	greska: .byte 0
.section .text
.globl main

main:
	movl a, %eax		# niži deo
	movl a+4, %edx		# viši deo	(ne trebaju ti ona silna smeštanja)
provera:
	cmpl $0, b
	jne mnozi
	cmpl $0, b+4
	je kraj			# moraš proveriti i viši i niži deo od b
mnozi:
	addl %eax, r
	adcl %ebx, r+4
	jc prekoracenje		# prvi carry -> adcl, drugi carry -> pretera ga brate
	subl $1, b		# mora subl jer on pali carry lapmicu
	sbbl $0, b+4		# automatski oduzima 1, pa nema potrebe još jednom (zato 0)
	jmp provera	
prekoracenje:
	incb greska		# direktno incb, ne preko registra
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
