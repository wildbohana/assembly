# primer 2, nema slajd

.section .data
	dec_br: .ascii "0.353124\0"	# kada uneseš sa tastature na kraju bude \n a ne \0
	greska: .byte 0
	scaling_const: .long 100000000
	
.section .text
.globl main

main:
	movl $dec_br, %edi
	movl $8, %ecx			# baza
	movl scaling_const, %esp
	movb $0, greska
	xorl %ebx. %ebx			# ne možeš smestiti broj u eax - treba nam za div i mul
	cmpb $0, (%edi)			# da li edi pokazuje na NULL (tj da li je string prazan)
	je i_greska			# jer je to greškaaa
trazi_null:
	cmpb $0, 1(%edi)		# proveravaš da li je pokazivač na kraju stringa
	je cifra			# ako jeste, pređi dalje
	incl %edi			# ako nije pomeraj pokazivač u desno
	jmp trazi_null			# dok ne dođeš do kraja stringa
cifra:
	xorl %eax, %eax			# anuliraj %eax - temp
	movb (%edi), %al		# vrednost poslednjeg elementa u stringu smesti u %al
	cmpb $'.', %al			# poredi ga sa .
	je cifra_kraj			# ako je tačka, nemaš više šta da konvertuješ
	subb $'0', %al			# konverzija
	js i_greska			# ako je promenio znak, bio je manji od 48 (nije bio 0+)
	cmpl %ecx, %eax			# poredi ga sa bazom
	jae i_greska			# ako je >=8 onda nije znak koji taj sistem koristi
	mull %esp			# množiš %eax sa konstantom skaliranja
	addl %ecx, %eax			# dodaj %ecx (od ranije) na %eax
	divl %ecx			# to deliš sa bazom
	movl %eax, %ebx			# rezultat smeštaš u ebx
	jc i_greska
	decl %edi			# prelazak na sledeću cifru (pomeramo se u levo)
	jmp cifra
cifra_kraj:
	jmp kraj
i_greska:
	incb greska
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
