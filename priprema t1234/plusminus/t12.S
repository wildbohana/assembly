# prvi string broji +, drugi broji -, ima vrednost 1 ako + > -, 2 ako + < -, 3 ako + = -

.section .data
	maxl = 21
	t1: .ascii "Unesite S1: \0"
	t1l = . - t1
	t2: .ascii "Unesite S2: \0"
	t2l = . - t2
	s1: .fill maxl, 1, 42
	s1l: .long 0
	s2: .fill maxl, 1, 42
	s2l: .long 0
	brp: .long 0
	brm: .long 0
	r: .byte 0
	gotovo: .long 0
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
	movl $s1, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, s1l			# unet prvi
	
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2l, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $s2, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, s2l			# unet drugi

pocetak1:
	movl $s1, %esi
	movl %esi, %edi
	addl s1l, %edi
	decl %edi
	jmp provera1
provera1:
	cmpl %esi, %edi
	je pocetak2
smestanje_u_nizi1:
	movb (%esi), %dl
poredi1:
	cmpb $'+' , %dl
	je plus
	jmp sledeci1
plus:
	addl $1, brp
sledeci1:
	incl %esi
	jmp provera1	
	
pocetak2:
	movl $s2, %esi
	movl %esi, %edi
	addl s2l, %edi
	decl %edi
	jmp provera2
provera2:
	cmpl %esi, %edi
	je vrednost
smestanje_u_nizi2:
	movb (%esi), %dl
poredi2:
	cmpb $'-' , %dl
	je minus
	jmp sledeci2
minus:
	addl $1, brm
sledeci2:
	incl %esi
	jmp provera2

vrednost:
	movl brp, %eax
	cmpl brm, %eax
	ja kec
	jb dvica
	je trica
kec:
	movb $1, r
	jmp kraj
dvica:
	movb $2, r
	jmp kraj
trica:
	movb $3, r

kraj:
	movl $1, %eax
	movl r, %ebx
	int $0x80
