# unesi ime i prezime sa konzole i ispiši ih, max_l = 20

.section .data
	max_l = 20+1
	t1: .ascii "Unesite Vaše ime: \0"
	t1_l = . - t1
	t2: .ascii "Unesite Vaše prezime: \0"
	t2_l = . - t2
	ime: .fill max_l, 1, 42		# 42 je ascii za *
	prz: .fill max_l, 1, 42
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $t1, %ecx
	movl $t1_l, %edx
	int $0x80			# printf za ime
	
	movl $3, %eax
	movl $0, %ebx
	movl $ime, %ecx
	movl $max_l, %edx
	int $0x80			# scanf za ime
	movl %eax, %esi			# dužinu čuvaš
	
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2_l, %edx
	int $0x80			# printf za prezime
	
	movl $3, %eax
	movl $0, %ebx
	movl $prz, %ecx
	movl $max_l, %edx
	int $0x80			# scanf za prezime
	movl %eax, %edi			# dužinu čuvaš
	
	movl $4, %eax
	movl $1, %ebx
	movl $ime, %ecx
	movl %esi, %edx
	int $0x80			# štampa ime
	
	movl $4, %eax
	movl $1, %ebx
	movl $prz, %ecx
	movl %edi, %edx
	int $0x80			# štampa prezime

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
