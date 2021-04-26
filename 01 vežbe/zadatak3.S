# faktorijel za broj n
# prvo mnozis 5*1, pa onda 4*5, pa onda 3*20 pa onda 2*60 i onda se 1*120 preskače
# (bespotrebna iteracija)

.section .data
.section .text
.globl main

main:
	movl $5, %esi		# n
	movl $1, %edi		# faktorijel (koji očigledno mora da počne od 1)
provera:
	cmpl $1, %esi
	jbe kraj
	movl %esi, %eax		# izgleda da su esi i edi bile pomoćne promenljive
	movl %edi, %ebx		# tj nisu njih dve nego eax i ebx	
prep_mnozi:
	movl $0, %ecx
mnozi:
	cmpl $0, %eax		# ako je gotovo, pređi na faktorijel
	je fakt
	addl %ebx, %ecx		# rezultat je u ecx
	decl %eax
	jmp mnozi
fakt:
	movl %ecx, %edi		# smesti rezultat množenja u faktorijel
	decl %esi		# smanji n
	jmp provera
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
