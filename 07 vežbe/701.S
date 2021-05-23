# unsigned int inter_to_oct_str(int broj, char* str, unsigned int duzina)

.section .data
.section .text
.globl inter_to_oct

inter_to_oct:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp		# lokalna promenljiva
	pushl %ebx		# na stek
	pushl %esi		# na stek
	pushl %edi		# na stek
	
	movl 8(%ebp), %eax	# broj
	movl 12(%ebp), %edi	# str (pokazivač na string)
	movl $8, %ebx		# baza sistema (oktalni)
	movl $0, -4(%ebp)	# greška (kao lok. prom.)
	
	andl %eax, %eax		# da li je broj negativan=
	jns i2o_cifra		# ako nije, obrađuj odmah
	movb $'-', (%edi)	# ako jeste, ubaci minus
	incl %edi		# pomeri str na sled. poz. u stringu
	incl 12(%ebp)		# pomeri pokazivač, da se ne bi obrtao minus kasnije
	decl 16(%ebp)		# smanji broj slobodnih mesta
	negl %eax		# komplement 2, negiramo neg. br, dalje ga tretiramo kao poz.
i2o_cifra:
	decl 16(%ebp)		# provera preostalog mesta
	cmpl $1, 16(%ebp)	# neophodan je i 1 bajt za NULL
	jl i2o_greska
	xorl %edx, %edx		# edx na 0
	divl %ebx		# deliš %eax sa %ebx, rez u %eax, ostatak u %edx
	addb $'0', %dl		# dodaj +48 (ascii 0) na broj (konverzija)
	movb %dl, (%edi)	# smesti ga u konvertovan string
	incl %edi		# pomeri pokazivač
	andl %eax, %eax		# gledaš da li je broj 0 (kraj konverzije)
	jnz i2o_cifra		# ako nije nula, ponovi sve
	movb $0, (%edi)		# ako je nula, smesti NULL na kraj stringa
	decl %edi		# pokazivač pomeri na poziciju pre null
	movl 12(%ebp), %esi	# pokazivač na početak stringa smesti u esi
i2o_obrni:
	cmpl %edi, %esi		# esi - poćetak stringa, edi - kraj stringa
	jae i2o_kraj		# ako se obrnu ili su na istom, onda si obrnula sve
	movb (%esi), %ah
	movb (%edi), %al
	movb %al, (%esi)
	movb %ah, (%edi)
	decl %edi		# jedan znak nazad
	incl %esi		# jedan znak napred
	jmp i2o_obrni
i2o_greska:
	incl -4(%ebp)
i2o_kraj:
	movl -4(%ebp), %eax	# vrednost greške je povratna vrednost potpr
	popl %edi		# restauracija
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret			# vraćanje u main
	
