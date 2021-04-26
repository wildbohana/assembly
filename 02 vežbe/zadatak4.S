# faktorijel za broj n u dvostrukoj preciznosti (nemoguće za sad)

.section .data
	n: .quad 0x100
	r: .quad 0
	greska: .byte 0
.section .text
.globl main

main:
	movl n, %eax
	movl n+4, %edx		# ovo n ti služi kao brojač
	movl $1, %ebx		# a ovo ti je resenje
	movl $0, %ecx
provera:
	cmpl $1, %eax
	ja mn_prep
	cmpl $0, %edx
	jmp kraj
mn_prep:
	movl $0, %esi		# temp za rezultat množenja
	movl $0, %edi		# ovo dvoje kasnije dodaješ u ukupno rešenje
mnozi:
	# ovo je jako zajebano izvesti jer treba 10 registara a ti imaš 8 ukupno (velikih)
	# bukvalno ne mogu, jer uvek mora da se smešta sve u registre
	# a onda u mnozi petlji da se stavi u temp
	# za 32 bit ide 5 registara, ovde ide 10 minimum jer je sve duplo
fakt:
	movl %esi, %ebx		# smesti rezultat u resenje
	movl %edi, %ecx
	subl $1, %eax		# smanji n
	sbbl $0, %edx
	jmp provera
kraj:
	movl %ebx, r		# smestanje rezultata
	movl %ecx, r+4
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
