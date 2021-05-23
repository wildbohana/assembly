# primer 1, slajd 5

.section .data
	dec_br: .ascii "3133734892\0"
	greska: .byte 0
.section .text
.globl main

main:
	movl $dec_br, %esi		# pokazivač na string
	movb $0, greska			# greška je 0
	xorl %eax, %eax			# setuj na 0, ovde smeštaš konvertovan broj
	xorl %ebx, %ebx			# setuj na 0
	movl $10, %ecx			# osnova dekadnog sistema
dec_cifra:
	movb (%esi), %bl		# smesti karakter iz stringa u %bl
	andb %bl, %bl			# proveri da li je taj karakter 0 (NULL)
	jz kraj_dec
	subb $'0', %bl			# ako nije, oduzmi mu 48 (konverzija)
	mull %ecx			# množiš %eax sa %ecx (bazom br. sis.)
	addl %ebx, %eax			# dodaj konvertovan broj na ostale konvertovane
	incl %esi			# pomeri pokazivač za 1 poziciju desno
	jmp dec_cifra			# ponovi
kraj_dec:
	cmpl $dec_br, %esi		# provera da li je adresa na koju %esi pokazuje ista kao
	jne kraj			# i adresa početka dec_br (ako jeste, onda je string
					# dec_br bio prazan što predstavlja grešku)
					# ako nije, preskoči greška++ (jer nije došlo do greške)ec
i_greska:
	incb greska
kraj:
	movl $1, %eax			# sistemski poziv
	movl $0, %ebx
	int $0x80
