.section .data 
	ispis1: .ascii "Unesite 8 elemenata niza:\n"
	ispis1_len = .-ispis1
	ispis2: .ascii "NEPARAN broj jedinica.\n"
	ispis2_len = .-ispis2
	ispis3: .ascii "PARAN broj jedinica.\n"
	ispis3_len = .-ispis3
	ispis4: .ascii "Doslo je do greske."
	ispis4_len = .-ispis4
	maska: 	.byte 0b10000001
		.byte 0b01000010
		.byte 0b00100100
		.byte 0b00011000	
		.byte 0b00100100
		.byte 0b01000010
		.byte 0b10000001   
	niz: .fill 8, 1, 0
	brojac: .long 0
	string: .fill 100, 1, 0
	maska_provera: .byte 0b01000000
	ispis5: .ascii "Povratna vrednost programa: \0"
	ispis5_len = .-ispis5
	ispis_brojac: .fill 10, 1, 0
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	leal ispis1, %ecx
	movl $ispis1_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	leal string, %ecx
	movl $100, %edx
	int $0x80

	leal string, %esi			# adresa stringa za konverziju u esi
	movl $16, %ecx				# baza brojevnog sistema u ecx
	xorl %edi, %edi				# indeks niza

string1:
	cmpb $10, (%esi)			# \n?
	je kraj_konverzije
	cmpb $'0', (%esi)
	jne proveri_x
	incl %esi
	jmp string1
	
proveri_x:
	cmpb $'x', (%esi)
	jne greska
	xorb %al, %al				# naisli smo na slucaj 0x i rezultat konverzije stavljamo na 0
	xorb %bl, %bl				# zbog karaktera
	jmp proveri_broj	

proveri_broj:
	incl %esi
	cmpb $32, (%esi)			# space?
	je ubaci_u_niz
	cmpb $10, (%esi)			# \n?
	je kraj_konverzije
	cmpb $'0', (%esi)
	jb greska
	cmpb $'9', (%esi)
	ja provera_slova
	jmp konverzija_brojeva

provera_slova:
	cmpb $'a', (%esi)
	jb greska
	cmpb $'f', (%esi)
	ja greska
	jmp konverzija_slova

konverzija_brojeva:
	movb (%esi), %bl
	subb $'0', %bl
	mull %ecx
	jc greska
	addb %bl, %al
	jc greska
	jmp proveri_broj

konverzija_slova:
	movb (%esi), %bl	
	subb $87, %bl				# 'A'-10 == 87
	mull %ecx
	jc greska
	addb %bl, %al
	jc greska
	jmp proveri_broj
	
ubaci_u_niz:	
	movb %al, niz(, %edi, 1)		# rezultat konverzije u niz
	incl %edi				# predji na sledeci element niza
	incl %esi				# predji na sledeci karakter
	jmp string1

kraj_konverzije:
	cmpl $string, %esi			# "\n" slucaj
	je greska
	movb %al, niz(, %edi, 1)
	xorl %esi, %esi				# indeks niza u esi
	xorl %edi, %edi				# indeks maske u edi
	
provera_jedinica:
	cmpl $7, %esi
	ja kraj_provere				# da li smo dosli do kraja niza?
	movb maska(, %edi, 1), %bl		# trenutna maska u bl
	andb niz(, %esi, 1), %bl		
	cmpb $0, %bl				# da li ima jedna jedinica?
	ja provera_jedinica2
	incl %esi
	incl %edi
	jmp provera_jedinica

provera_jedinica2:				# rez andb        maska za proveru
	cmpb maska_provera, %bl			# da li je 10000001 manji od 01000000, ako jeste onda ima jedna 1, ako nije onda imaju dve 1
	jbe jedna_jedinica
	addl $2, brojac
	jmp siftovanje_maske_za_proveru

jedna_jedinica:
	incl brojac

siftovanje_maske_za_proveru:
	incl %esi
	incl %edi
	cmpl $4, %edi
	je siftovanje_maske_za_proveru1		# treca i cetvrta maska su iste i ostacemo samo na trecoj(pocevsi od nulte maske)
	ja siftovanje_maske_za_proveru2		# maske iznad cetvrte su iste kao pre trece i onda se maska za proveru mnozi sa dva
	shrb maska_provera			# maska za proveru se deli sa dva
	jmp provera_jedinica

siftovanje_maske_za_proveru1:
	cmpl %esi, %edi
	jb siftovanje_maske_za_proveru2    	# ako je brojac niza veci od brojaca maske prosli smo slucaj trece i cetvrte maske
	decl %edi				# vracamo se na trecu masku(sada ce brojac maske biti uvek manji od brojaca niza) 
	jmp provera_jedinica			# maska za proveru ostaje ista

siftovanje_maske_za_proveru2:
	shlb maska_provera
	jmp provera_jedinica

kraj_provere:
	movl brojac, %eax			# broj za konverziju
	movl $10, %ecx				# baza br sistema
	leal ispis_brojac, %esi

konverzija:
	xorl %edx, %edx
	divl %ecx
	addb $'0', %dl
	movb %dl, (%esi)
	incl %esi
	andl %eax, %eax
	jnz konverzija
	movb $0, (%esi)
	decl %esi
	leal ispis_brojac, %edi
	
obrni:
	cmpl %esi, %edi
	jae parnost
	movb (%esi), %ah
	movb (%edi), %al
	movb %al, (%esi)
	movb %ah, (%edi)
	incl %edi
	decl %esi
	jmp obrni

parnost:
	movl brojac, %edx
	shrl %edx				# ako je u brojacu cifra najmanje tezine 1, onda je neparan broj
	jc neparan

	movl $4, %eax
	movl $1, %ebx
	leal ispis3, %ecx
	movl $ispis3_len, %edx
	int $0x80
	jmp ispis_brojac1

neparan:
	movl $4, %eax
	movl $1, %ebx
	leal ispis2, %ecx
	movl $ispis2_len, %edx
	int $0x80

ispis_brojac1:
	movl $4, %eax
	movl $1, %ebx
	leal ispis5, %ecx
	movl $ispis5_len, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal ispis_brojac, %ecx
	movl $10, %edx
	int $0x80
	jmp kraj

greska:
	movl $4, %eax
	movl $1, %ebx
	leal ispis4, %ecx
	movl $ispis4_len, %edx
	int $0x80

	movl $1, %eax
	movl $-1, %ebx
	int $0x80

kraj:
	movl $1, %eax
	movl brojac, %ebx
	int $0x80
