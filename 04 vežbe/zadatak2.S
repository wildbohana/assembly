# unesi ime i prezime sa konzole, sve pretvori u upcase i ispiši ih (max_l=50)

.section .data
	t1: .ascii "Unesite Vaše ime i prezime: \0"
	t1l = . - t1
	t2: .ascii "Vi ste: \0"
	t2l = . - t2
	maxl = 50
	unos: .fill maxl, 1,42
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $t1, %ecx
	movl $t1l, %edx
	int $0x80			# printf
	
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $maxl, %edx
	int $0x80			# scanf
	
					# dužina unetog stringa se smešta u eax
	movl %eax, %esi			# čuvaš je za kasnije, a eax oslobađaš za korišćenje
	movl $unos, %eax		# pokazivač na string
upcase:
	cmpb $97, (%eax)		# moglo je i $'a'
	jb dalje			# provera da li je malo slovo, ako nije, idi na dalje
	cmpb $'z' , (%eax)
	ja dalje			# provera da li je iznad z (jer se samo a->z menjaju)
	subl $32, (%eax)		# velika slova su za 32 veća od malih
					# moglo je i addl $-32 ili addl $'A'-'a'
dalje:
	incl %eax			# sledeće slovo
	cmpb $10, (%eax)		# kod read poziva, string se završava sa 10 (\n)
	jne upcase			# u suštini, gledaš da li si došla do kraja stringa
printf:
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2l, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl %esi, %edx			# zapamćena dužina
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
