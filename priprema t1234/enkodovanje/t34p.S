# void potprogram(unsigned char *unos)

.section .data
.section .text
.globl e13

e13:
	pushl %ebp
	movl %esp, %ebp
	
	movl 8(%ebp), %eax		# početak stringa
	movl %eax, %ecx
	addl $50, %ecx			# krajnji kraj stringa
	
# v2 za kraj stringa
# movb (%esi), %dl
# cmpb $10, %dl		# 10 je ascii za \n
# je kraj		# ovo ima mnogo manje iteracija	
		
provera:
	cmpl %eax, %ecx
	je kraj
premesti_u_nizi:
	movb (%eax), %dl
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
	cmpb $'a' , %dl			# mala slova su iza velikih
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
	movb %dl, (%eax)
	jmp sledeci
dodaj:
	addb $13, %dl
	movb %dl, (%eax)
	jmp sledeci
sledeci:
	incl %eax
	jmp provera

kraj:	
	movl %ebp, %esp
	popl %ebp
	ret
