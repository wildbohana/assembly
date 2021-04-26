# broj samoglasnika u stringu

.section .data
	maxl = 40
	t1: .ascii "Unesite Vaš string: \0"
	t1l = . - t1
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
pokazivaci:
	movl $unos, %esi
	movl %esi, %edi
	addl unosl, %edi
	decl %edi			        # da se ne bi obavljala bezveze iteracija za \0
provera:
	cmpl %esi, %edi
	je kraj
smesti_u_nizi:
	movb (%esi), %dl
switch:
	cmpb $'a' , %dl
	je samoglasnik
	
	cmpb $'e' , %dl
	je samoglasnik
	
	cmpb $'i' , %dl
	je samoglasnik
	
	cmpb $'o' , %dl
	je samoglasnik
	
	cmpb $'u' , %dl
	je samoglasnik
	
	jmp sledeci
samoglasnik:
	incl broj
sledeci:
	incl %esi
	jmp provera
kraj:
	movl $1, %eax
	movl broj, %ebx
	int $0x80
