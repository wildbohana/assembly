# neparni el dva niza se međusobno sabiraju a parni se međusobno množe
# dužina niza n
# nekorektan rezultat za poziciju -> tu upisati 11111 (vrv carry ako bude)
# povraatna vrednost je broj elemenata konačnog niza koji imaju nekorektno rešenje

.section .data
	n = 6
	a: .word 2, 2, 3, 4, 5, 6
	b: .word 65535, 65534, 2, 2, 10, 10
	r: .fill n, 2, 0		# 2 jer je word tip podataka u pitanju
	greska: .byte 0
.section .text
.globl main

main:
	movl $a, %eax
	movl $b, %ebx
	movl %eax, %ebp
	addl $n, %ebp
	addl $n, %ebp
	movl $r, %esi			# niz za resenje
	movl $2, %edi			# 2 za parne, 1 za neparne
provera:
	cmpl %ebp, %eax
	jae kraj
parnost:
	cmpl $1, %edi
	je sabiranje
	cmpl $2, %edi
	je mnozenje_prep
sabiranje:
	movl $2, %edi
	movw (%eax), %dx
	addw (%ebx), %dx
	jc prekoracenje
	movw %dx, (%esi)
	jmp sledeci
mnozenje_prep:
	movl $1, %edi
	movw (%eax), %cx
	movw $0, %dx			# rezultat
mnozenje:
	cmpw $0, %cx
	je mnozenje_kraj
	addw %cx, %dx
	decw %cx
	jc prekoracenje
	jmp mnozenje
mnozenje_kraj:
	movw %dx, (%esi)
	jmp sledeci
sledeci:
	addl $2, %eax
	addl $2, %ebx
	addl $2, %esi
	jmp provera
prekoracenje:
	incl greska
	movw $11111, (%esi)
	jmp sledeci
kraj:
	movl $1, %eax
	movl greska, %ebx
	int $0x80
	
