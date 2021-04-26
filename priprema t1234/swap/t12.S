# unesi string, svaka dva susedna karaktera se menjaju, kod neparnog broja se poslednji ne menja

.section .data
	maxl = 50
	t1: .ascii "Unesite string: \0"
	t1l = . - t1
	unos: .fill maxl, 1, 42
	unosl: .long 0
	paran: .byte -1	
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
	movl %eax, unosl		  # smeštaš dužinu
	
	movl $unos, %esi
	movl %esi, %edi
	decl %eax		          # poslednji karakter je \0 koji nam ne treba za ovo
	addl %eax, %edi
	
parnost:
	subl $2, %eax
	cmpl $1, %eax
	je neparno
	jb parno
	jmp parnost
parno:
	movb $1, paran
	jmp ispitaj
neparno:
	movb $0, paran
ispitaj:
	cmpb $1, paran
	je svi
	jb predzadnji

svi:
	jmp provera
predzadnji:
	decl %edi
	jmp provera		    	# mada ne mora

provera:
	cmpl %esi, %edi
	je ispis
menjaj:
	movl %esi, %eax		  # čuva adresu trenutnog karaktera
	movb (%esi), %cl		# čuva vrednost prvog karaktera
	incl %esi			      # pređi na sledeći element
	movl %esi, %ebx			# sačuvaj adresu trenutnog karaktera
	movb (%ebx), %dl		# sačuvaj vrednost trenurnog karaktera
	
	xchgb %dl, (%eax)		# prepiši vrednost drugog na vrednost prvog
	xchgb %cl, (%ebx)		# prepiši vrednost prvog na vrednost drugog
	
	incl %esi			      # pređi na sledeći element (incl + incl)
	jmp provera

ispis:
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl unosl, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
