# sortiranje 16-bit niza

.section .data
	n_el = 10
	niz: .word 5,2,6,88,0,3342,-4,10,22,623
.section .text
.globl main

main:
	movl $niz, %ebx			# bazni registar za unutrašnju petlju
	movl $n_el, %esi		# bazni registar za glavnu petlju
glavna:					# glavna petlja
	decl %esi			# esi ide od 10 do 1 (tj do 0, na 0 prekida program)
	jz kraj
	movl $n_el, %edi		# indeks za unutrašnju petlju, edi počinje sa 10 uvek
unutrasnja:				# unutrasnja petlja
	decl %edi
	jz glavna			# edi ide od 10 do 0, na 0 prelazi na sledeci element
	movw (%ebx, %edi, 2), %ax	# niz + edi*2 (2 byte = word)
	movw -2(%ebx, %edi, 2), %dx	# ovo je vlj jedan element pre toga sa edi indeksom
	cmpw %dx, %ax			# poređenje ax sa prethodnikom dx
	jnl unutrasnja			# ako je ax veći od dx onda nikom ništa
zameni:					# ako je manji, zameni im mesta
	movw %ax, -2(%ebx, %edi, 2)
	movw %dx, (%ebx, %edi, 2)	# ax i dx ti dođu kao privremene promenljive
	jmp unutrasnja
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
