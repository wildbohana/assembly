# sve razmake u stringu zameni nulom

.section .data
	t1: .ascii "Unesite vaš string: \0"
	t1l = .- t1
	t2: .ascii "Promenjen string je: \0"
	t2l = .- t2
	max = 20
	unos: .fill max, 1, 42
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
	movl $max, %edx
	int $0x80
	movl %eax, unosl
	
pokazivaci:
	movl $unos, %esi
	movl %esi, %edi
	addl %eax, %edi
provera:
	cmpl %esi, %edi
	je stampa
	movb (%esi), %dl
	cmpb $' ' , %dl
	je razmak
	incl %esi
	jmp provera
razmak:
	movb $'0', (%esi)
	incl broj
	incl %esi
	jmp provera
stampa:
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2l, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl unosl, %edx
	int $0x80
	
kraj:
	movl $1, %eax
	movl broj, %ebx
	int $0x80
