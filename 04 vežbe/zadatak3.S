# ispitaj palindrom (mala slova, bez razmaka) i ispiši odgovarajuću poruku
# (indirektno adresiranje)

.section .data
	display: .ascii "Unesite Vaš string: \n"
	displayl = . - display
	jeste: .ascii "Uneti string jeste palindrom.\n"
	jestel = . - jeste
	nije: .ascii "Uneti string nije palindrom.\n"
	nijel = . - nije
	maxl = 50
	pali: .fill maxl, 1, 42
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $display, %ecx
	movl $displayl, %edx
	int $0x80
	
	movl $3, %eax
	movl $1, %ebx
	movl $pali, %ecx
	movl $maxl, %edx
	int $0x80			# ne čuvaš %eax u %esi nego pazi sad ovo
pokazivaci:
					# ti već imaš dužinu stringa u %eax, sad to koristiš
					# tako što na to dodaš adresu palindroma -2
	addl $pali-2, %eax		# (indeksi idu od nule, ne od 1; poslednji znak je \n)
	movl $pali, %ebx		# pokazivač na početak
provera:
	movb (%eax), %cl
	cmpb %cl, (%ebx)
	jne false			# čim jedna jednakost ne važi nije palindrom def
	decl %eax			# smanji kraj za jedan
	incl %ebx			# povećaj početak za jedan
	cmpl %ebx, %eax
	jg provera			# ako je kraj > početak (pokazivači se nisu susreli)
true:
	movl $4, %eax			# ako su se susreli (bez prekida) onda jeste palindrom
	movl $1, %ebx
	movl $jeste, %ecx
	movl $jestel, %edx
	int $0x80
	movl $0, %ebx			# izlazni kod 0
	jmp kraj
false:
	movl $4, %eax
	movl $1, %ebx
	movl $nije, %ecx
	movl $nijel, %edx
	int $0x80
	movl $1, %ebx			# izlazni kod 1, ne ide jmp kraj jer sam propadne dole
kraj:
	movl $1, %eax			# ovde ne pišeš %ebx jer je to već urađeno gore
	int $0x80
