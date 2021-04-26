# a-m povećaš za 13, n-z smanjiš za 13, i mala i velika slova

.section .data
	maxl = 51
	t1: .ascii "Unesite Vaš string: \0"
	t1l = . - t1
	t2: .ascii "Enkodovan string: \0"
	t2l = . - t2
	unos: .fill maxl, 1, 42
	unosl: .long 0
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
	decl %edi			# \0 bespotrebna iteracija
	
provera:
	cmpl %esi, %edi
	je ispis
premesti_u_nizi:
	movb (%esi), %dl
od_A:
	cmpb $'A' , %dl
	jae do_M
	jb sledeci			# ako je manji od A onda nije slovo uopšte
do_M:
	cmpb $'M' , %dl
	jbe dodaj
do_Z:
	cmpb $'Z' , %dl
	jbe oduzmi
	ja od_a
od_a:
	cmpb $'a' , %dl
	jae do_m
	jb sledeci
do_m:
	cmpb $'m' , %dl
	jbe dodaj
do_z:
	cmpb $'z' , %dl
	jbe oduzmi
	ja sledeci
oduzmi:
	subb $13, %dl
	movb %dl, (%esi)
	jmp sledeci
dodaj:
	addb $13, %dl
	movb %dl, (%esi)
	jmp sledeci
sledeci:
	incl %esi
	jmp provera
	
ispis:
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
	movl $0, %ebx
	int $0x80
