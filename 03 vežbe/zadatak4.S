# ukloni sve razmake sa kraja teksta

.section .data
	tekst: .ascii "    Primer teksta.      \0"
.section .text
.globl main

main:
	movl $tekst, %eax	# smeštaš pokazivača na početak teksta u eax (zato ide $)
end:
	cmpb $0, (%eax)
	je razmaci
	incl %eax		# u suštini tražiš dužinu stringa (tražiš adresu \0)
	jmp end
razmaci:
	cmpb $' ', -1(%eax)	# prvi element iza pokazivača na \0
	jne izbaci
	decl %eax		# smanjuj pokazivač na kraj stringa za 1 dok ne dođeš do
	jmp razmaci		# prvog znaka koji nije razmak
izbaci:
	movb $0, (%eax)		# samo zameniš ' ' sa '\0' (ascii vrednost 0) i tjt
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
