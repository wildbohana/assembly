# primer 2, nema slajd

.section .data
.section .text
.globl oct_str_float_to_inter

oct_str_float_to_inter:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp			# mesto za 2 lok. prom.
	pushl %ebx
	pushl %edi
	movl $8, -4(%ebp)		# smeštamo bazu u prvu lok. prom.
	movl $100000000, -8(%ebp)	# konstanta skaliranja
	movl $0, %edi			# greška
	xorl %ecx. %ecx			# setuj na 0, tu smeštaš broj
	movl 8(%ebp), %ebx		# adresa početka stringa
	cmpb $0, (%ebx)			# da li ebx pokazuje na NULL (tj da li je string prazan)
	je o2i_greska			# jer je to greškaaa
o2i_null:
	cmpb $0, 1(%ebx)		# proveravaš da li je pokazivač na kraju stringa
	je o2i_cifra			# ako jeste, pređi dalje
	incl %ebx			# ako nije pomeraj pokazivač u desno
	jmp o2i_null			# dok ne dođeš do kraja stringa
o2i_cifra:
	xorl %eax, %eax			# anuliraj %eax
	movb (%ebx), %al		# vrednost poslednjeg elementa u stringu smesti u %al
	cmpb $'.', %al			# poredi ga sa .
	je o2i_kraj			# ako je tačka, nemaš više šta da konvertuješ
	subb $'0', %al			# smanji ga za 48 (konverzija)
	js o2i_greska			# ako je promenio znak, greška (tj broj je u ascii bio
					# manji od 48 i onda npr 46-48=-2 što ima znak)
	cmpl -4(%ebp), %eax		# poredi ga sa bazom
	jae o2i_greska			# ako je >=8 onda nije znak koji taj sistem koristi
	mull -8(%ebp)			# množiš %eax sa konstantom skaliranja
	addl %ecx, %eax			# dodaj %ecx (od ranije) na %eax
	divl -4(%ebp)			# to deliš sa bazom
	movl %eax, %ecx			# rezultat smeštaš u eax
	decl %ebx			# prelazak na sledeću cifru (pomeramo se u levo)

# formula za konverzijom

