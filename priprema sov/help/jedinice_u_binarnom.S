.section .data
.section .text
.globl main

main:
	movl $12345, %eax			# smesti broj
	movl $0, %ecx				# broj jedinica
petlja:
	cmpl $0, %eax				# proveri da li smo prešli ceo broj
	je kraj
	testl $1, %eax				# da li je najniži bit eax jednak 1
	jz nula					# ako nije, preskoči sledeći korak
	incl %ecx				# ako jeste, povećaj brojač za 1
nula:
	shrl $1, %eax				# pomeri ceo broj u desno (1234 ostaje)
	jmp petlja				# ponovi petlju
kraj:
	movl $1, %eax				# sistemski poziv
	movl $0, %ebx
	int $0x80
