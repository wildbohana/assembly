# ne znam više, dosta brate

.section .data
	t1: .ascii "Unesite string: \0"
	t1l = . - t1
	ima: .ascii "Ovaj string sadrzi cifre.\0"
	imal = . - ima
	nema: .ascii "Ovaj string ne sadrzi cifre.\0"
	nemal = . - nema
	maxl = 21
	unos: .fill maxl, 1, 42
	unosl: .long 0
	broj: .long 0
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $t1, %ecx
	movl $t1l, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, unosl
	
	movl $unos, %esi
	movl %esi, %edi
	addl %eax, %edi
	
prolazak:
	cmpl %esi, %edi
	je gotov
	movb (%esi), %dl
	cmpb $'0', %dl
	jl sledeci
	cmpb $'9', %dl
	jg sledeci
	incl broj
sledeci:
	incl %esi
	jmp prolazak
gotov:
	cmpl $0, broj
	je nemabr
imabr:
	movl $4, %eax
	movl $1, %ebx
	movl $ima, %ecx
	movl $imal, %edx
	int $0x80
	jmp kraj
nemabr:
	movl $4, %eax
	movl $1, %ebx
	movl $nema, %ecx
	movl $nemal, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl broj, %ebx
	int $0x80
