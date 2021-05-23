# potptogram za generisanje 64-bit maske
# 63 -> 0b00111111

.section .data
	n: .long 43
	v: .byte 0
.section .text
.globl main

main:
	movl n, %ecx			# broj n
	xorl %edx, %edx			# viši deo maske
	testl $0b11111111111111111111111111000000, %ecx
	jnz maska_gr			# ako je n veći od 63, greška
	movl $1, %eax			# inicijalna maska
	andl $0b11111, %ecx		# ovo bi bio ostatak kada bi se ecx podelio sa 31
	shll %cl, %eax			# pomeraš 1 na poziciju na koju treba
	movl v, %esi
	testl $0b11111111111111111111111111111110, %esi
	jnz maska_gr			# v nije 0 ili 1 nego nešto veće, greška
	testl $1, %esi			# da li je v 0 ili 1
	jnz maska_niza_kraj
	notl %eax			# ako je 0, invertujemo bite u maskama
	notl %edx			# i u nižoj i u višoj
	jmp maska_niza_kraj
maska_niza_kraj:
	movl n, %edi
	testl $0b100000, %edi		# da li je n bilo veće od 31?
	jz maska_cela_kraj
	xchgl %eax, %edx		# ako jeste, zameni viši i niži deo
	jmp maska_cela_kraj
maska_gr:
	xorl %eax, %eax			# ako je došlo do greške, anuliraj %eax
maska_cela_kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
