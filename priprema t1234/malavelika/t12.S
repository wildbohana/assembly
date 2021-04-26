# unos dva teksta, brojiš mala slova (ascii 97 - 122) (velika ascii 65 - 90)
# pišeš poruku sa tim koji ima više malih slova, u %ebx kao povratnu vrednost ide razlika u broju malih slova
# razlika mora biti pozitivna

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
	mali1: .long 0
	mali2: .long 0
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
	movl %eax, s2l			# unet drugi
prvi:
	movl $s1, %esi
	movl %esi, %edi
	addl s1l, %edi
	decl %edi
provera1:
	cmpl %esi, %edi
	je drugi
prvi_mala:
	movb (%esi), %al
	cmpb $'a' , %al
	jl sledeci1			  # ako je manji od 'a' onda nije mali def
	cmpb $'z' , %al
	jle mali1plus
	jmp sledeci1
mali1plus:
	incl mali1
	jmp sledeci1
sledeci1:
	incl %esi
	jmp provera1

drugi:
	movl $s2, %esi
	movl %esi, %edi
	addl s2l, %edi
	decl %edi
provera2:
	cmpl %esi, %edi
	je poredi
drugi_mala:
	movb (%esi), %al
	cmpb $'a' , %al
	jl sledeci2
	cmpb $'z' , %al
	jle mali2plus
	jmp sledeci2
mali2plus:
	incl mali2
	jmp sledeci2
sledeci2:
	incl %esi
	jmp provera2

poredi:
	movl mali1, %ebx
	movl mali2, %ecx
	cmpl %ebx, %ecx
	jl vece
	ja manje
	je jednako

vece:
	movl $4, %eax
	movl $1, %ebx
	movl $i1, %ecx
	movl $i1l, %edx			# ovo nije promenljiva nego konstanta pa ide $
	int $0x80
	jmp razlika_prep
manje:
	movl $4, %eax
	movl $1, %ebx
	movl $i2, %ecx
	movl $i2l, %edx
	int $0x80
	jmp razlika_prep
jednako:
	movl $4, %eax
	movl $1, %ebx
	movl $i3, %ecx
	movl $i3l, %edx
	int $0x80
	movl $0, %ebx
	jmp kraj
razlika_prep:
	movl mali1, %ebx
	movl mali2, %ecx
razlika:
	cmpl %ecx, %ebx
	jl zameni
	subl %ecx, %ebx
	jmp kraj
zameni:
	xchgl %ecx, %ebx
	jmp razlika
	
kraj:
	movl $1, %eax
	int $0x80
