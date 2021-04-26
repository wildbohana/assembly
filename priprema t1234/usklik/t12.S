# broj ! u stringu, za [0,3] ide 1 u ebx, za [4,8] ide 2 u ebx, za [9,Inf] ide 3 u ebx

.section .data
	maxl = 40
	t1: .ascii "Unesite string: \0"
	t1l = . - t1
	unos: .fill maxl, 1, 42
	unosl: .long 0
	broj: .long 0
	r: .byte 0
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
registri:
	movl $unos, %esi
	movl %esi, %edi
	addl %eax, %edi
	decl %edi
provera:
	cmpl %esi, %edi
	je vrednost
smesti_u_nizi:
	movb (%esi), %dl
poredi:
	cmpb $'!' , %dl
	je usklik
sledeci:
	incl %esi
	jmp provera
usklik:
	incl broj
	jmp sledeci
vrednost:
	cmpl $4, broj
	jl kec
	cmpl $9, broj
	jl dvica
	jmp trojka
kec:
	movb $1, r
	jmp kraj
dvica:
	movb $2, r
	jmp kraj
trojka:
	movb $3, r
	
kraj:
	movl $1, %eax
	movl r, %ebx
	int $0x80
