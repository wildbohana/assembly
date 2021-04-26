# poređenje u dvostrukoj preciznosti (na kraju smesti 1 ili -1 (ili 0) u %eax kao rezultat)

.section .data
	a: .quad 0x123456789ABCDEF0
	b: .quad 0xFEDCBA9876543210
.section .text
.globl main
main:
	movl a+4, %edx		# procesor može max jednom da pristupa memoriji
	cmpl b+4, %edx		# drugo mora biti registar pa zato premeštaš deo a u %edx
	jg a_vece
	jl b_vece		# ovaj deo je bio za poređenje viših delova
	
	movl a, %edx		# a ovaj deo poredi niže delove
	cmpl b, %edx
	ja a_vece
	jb b_vece
	
	movl $0, %eax		# ako propadne dovde, onda su jednaki
	jmp kraj

a_vece:
	movl $1, %eax
	jmp kraj

b_vece:
	movl $-1, %eax		# ne mora jmp kraj jer svakako propada na kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
