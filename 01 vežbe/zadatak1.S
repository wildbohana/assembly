# mnozenje preko sabiranja

.section .data
.section .text
.globl main

main:
	movl $5, %eax	# broj
	movl $3, %ebx	# kolko puta
	movl $0, %ecx	# rezultat
ponovi:
	cmpl $0, %ebx
	je kraj
	addl %eax, %ecx
	subl $1, %ebx
	jmp ponovi	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

# optimizovana verzija: namestiš da je a veće od b
# pre ponovi dodaš sledeće:
# cmpl %eax, %ebx
# ja ponovi
# xchgl %eax, %ebx 
