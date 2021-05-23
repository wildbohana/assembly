# primer 1, slajd 4

.section .data
	dec_br_max = 10
	dec_br: .fill dec_br_max, 1, 0
.section .text
.globl main

main:
	movl $375000000, %eax		# broj
	movl $dec_br, %edi		# pokazivač na string gde smeštaš konvertovani broj
	movl $10, %ebx			# baza
dec_cifra:
	xorl %edx, %edx			# setuješ edx na 0
	divl %ebx			# deliš %eax sa %ebx, rez u %eax, ostatak u %edx
	addb $'0', %dl			# +48 (konverzija sama)
	movb %dl, (%edi)		# smesti taj konvertovan u string
	incl %edi			# pomeri pokazivač za jedno mesto
	andl %eax, %eax			# da li je kraj (ako je %eax prazan, ovo daje 0)
	jnz dec_cifra			# ako nije prazan, ponovi ovo sve
dodaj_null:
	movb $0, (%edi)			# pokazivač taman pokazuje na jedno mesto posle kraja
	decl %edi			# vrati edi za poziciju u nazad
	movl $dec_br, %esi		# postavi esi na početak stringa
obrni:
	cmpl %edi, %esi
	jae kraj			# ako obrnu mesta ili pokazuju na istu lokaciju -> kraj
	movb (%esi), %ah
	movb (%edi), %al
	movb %al, (%esi)
	movb %ah, (%edi)
	decl %edi			# pomeri ga za poziciju ispred
	incl %esi			# pomeri ga za poziciju iza
	jmp obrni			# i tako dok ne prođeš ceo string
kraj:
	# možeš ispisati dec_br sa $4, $1...
	movl $1, %eax			# sistemski poziv
	movl $0, %ebx
	int $0x80
