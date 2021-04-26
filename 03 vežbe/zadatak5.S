# ukloni sve razmake sa početka teksta

.section .data
	tekst: .ascii "    Primer teksta.\0"
.section .text
.globl main

main:
	movl $tekst, %eax	# pokazivač na početak teksta
	cmpb $' ' , (%eax)	# mora razmak između ' ' i , -> inače ih spoji u jedno
	jne kraj		# dokle god je ' ' na početku, ide petlja
izbaci:
	cmpb $0, (%eax)		# 0 u ascii je \0, tj kraj stringa
	je main			# ako je kraj prolaza proveriš u main da li je to to
	movb 1(%eax), %bl	# selektuješ jedno slovo ispred slova na koje pokazuje
	movb %bl, (%eax)	# staviš to slovo ispred na to slovo na koje pokazuje
	incl %eax		# pomeriš pokazivač dalje
	jmp izbaci		# i sve to ponoviš
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
