# sumiranje intervala niza (a,b) -> indeksi kreću od 0 (index 2 je treći po redu)

.section .data
	n_el = 10
	niz: .long 1,2,3,4,5,6,7,8,9,19
	suma: .long 0
	a: .long 2
	b: .long 6
.section .text
.globl main

main:
	movl a, %esi			# početni indeks
	movl $0, %eax			# suma na nulu
petlja:
	addl niz(,%esi,4), %eax		# adresno pristupanje elementima niza
	incl %esi
	cmpl b, %esi
	jle petlja			# ako a nije veće od b, ponovi petlju
kraj:
	movl %eax, suma
	movl $1, %eax
	movl $0, %ebx
	int $0x80
