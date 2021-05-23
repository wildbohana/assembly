# primer 2, nema slajd lol
# potprogram za konverziju interni -> oktalni razlomljeni označeni

.section .data
	broj: .long 0			# neki razlomljeni ???
	dec_razl_max=10
	dec_razl: .fill dec_razl_max, 1, 0
	scaling_const: .long 100000000
.section .text
.globl main

main:
	movl broj, %eax      		# broj
	movl $dec_razl, %edi		# pokazivač na krajnji string
	movl $8, %ebx           	# baza (oktalni)
	movl $0, %ecx			# greška	greska		greska		greska
	movl scaling_const, %esp	# konstanta skaliranja, 10^8
znak:
	andl %eax, %eax         	# da li je broj negativan?
	jns nula
	movb $'-', (%edi)       	# ubaci minus u string
	incl %edi
	decl $dec_razl_max          	# smanji broj slobodnih mesta
	negl %eax               	# komplement 2, negiramo br, dalje ga tretiramo kao poz.
nula:
	movl $dec_razl_max, %esi
	cmpl $4, %esi			# provera preostalog mesta
	jl greska			# 4 neophodna el: "0" + "." + jedna cifra + NULL
	movb $'0', (%edi)		# smesti 0 u string
	incl %edi
	movb $'.', 1(%edi)		# smesti . (dobiješ 0.)
	incl %edi
	decl %esi			# smanji broj slobodnih mesta (za nulu)
cifra:
	decl %esi		    	# smanji broj slobodnih mesta (za tačku) (kasnije cifre)
	cmpl $1, %esi		     	# provera slobodnih mesta (potreban je 1 znak za NULL)
	je dodaj_null			# ako je preostala dužina 1, tu stavi NULL
	mull %ebx			# broj * baza
	divl %esp			# broj / const. skaliranja
	addb $'0', %al			# konverzija celog dela broja
	movb %al, (%edi)		# smeštaš ga u string
	incl %edi
	movl %edx, %eax			# ostatak iz %edx smesti u %eax za dalju obradu
	andl %eax, %eax			# proveri da li je ostatak 0 (kraj konverzije)
	jnz cifra			# ako nije, ponovi sve ovo
dodaj_null:
	movb $0, (%edi)			# na kraj stringa stavi NULL
	jmp kraj
greska:
	incl %ecx
kraj:
	movl $1, %eax
	movl %ecx, %edx			# greska kao povr. vr.
	int $0x80
