# fibonačijev niz - vrednost n-tog broja

.section .data
.section .text
.globl main

main:
	movl $13, %esi		# broj n
	movl $1, %eax		# prvi el
	movl $1, %ebx		# drugi el (ovde će na kraju biti i rezultat)
	movl $2, %ecx		# brojač iteracija (i<n)
petlja:
	cmpl %esi, %ecx		# provera za kraj
	jae kraj
	movl %eax, %edx
	addl %ebx, %edx		# edx dođe kao privremena ovde
	movl %ebx, %eax		# drugi el postaje prvi
	movl %edx, %ebx		# privremena postaje drugi (pomeraš fokus na sledeći par u nizu)
	addl $1, %ecx		# obavljena iteracija, povećaj brojač
	jmp petlja	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
