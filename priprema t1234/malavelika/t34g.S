# koji niz ima više malih slova, šalješ *s1, *s2 i *r, a u %eax ti se vraca razlika


.section .data
	maxl = 41
	t1: .ascii "Unesite prvi string: \0"
	t1l = . - t1
	t2: .ascii "Unesite drugi string: \0"
	t2l = . - t2
	s1: .fill maxl, 1, 42
	s1l: .long 0
	s2: .fill maxl, 1, 42
	s2l: .long 0
	r: .long 0
	povratna: .long 0
	i1: .ascii "Prvi string ima vise malih slova nego drugi.\n\0"
	i1l = . - i1
	i2: .ascii "Drugi string ima vise malih slova nego prvi.\n\0"
	i2l = . - i2
	i3: .ascii "Oba stringa imaju isti broj malih slova.\n\0"
	i3l = . - i3
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
	movl $s1, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, s1l			# unet prvi
	
	movl $4, %eax
	movl $1, %ebx
	movl $t2, %ecx
	movl $t2l, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $s2, %ecx
	movl $maxl, %edx
	int $0x80
	movl %eax, s2l			# unet drugi, ajmo na posao

poziv:
	pushl $r
	pushl $s2
	pushl $s1
	call slova
	addl $12, %esp
	movl %eax, povratna

stampa:
	cmpl $2, r
	jl vece
	je manje
	jg jednako

vece:
	movl $4, %eax
	movl $1, %ebx
	movl $i1, %ecx
	movl $i1l, %edx			# ovo nije promenljiva nego konstanta pa ide $
	int $0x80
	jmp kraj
manje:
	movl $4, %eax
	movl $1, %ebx
	movl $i2, %ecx
	movl $i2l, %edx
	int $0x80
	jmp kraj
jednako:
	movl $4, %eax
	movl $1, %ebx
	movl $i3, %ecx
	movl $i3l, %edx
	int $0x80
	jmp kraj
	
kraj:
	movl $1, %eax
	movl povratna, %ebx
	int $0x80
