# nzd kao potprogram, varijanta 1 u kojoj je sve u jednom fajlu

.section .data
	a:  .long 123
	b:  .long 456
	r:  .long 0
.section .text
.globl main

# int nzd(int a, int b)
nzd:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx  		# čuvaš stari %ebx na stek

    movl 8(%ebp),%eax		# drugi iznad je adresa prvog argumenta
    movl 12(%ebp),%ebx		# treci iznad je adresa drugog argumenta
nzd_uporedi:
    cmpl %ebx,%eax
    je nzd_kraj
    ja nzd_vece
    subl %eax,%ebx
    jmp nzd_uporedi
nzd_vece:
    subl %ebx,%eax
    jmp nzd_uporedi

nzd_kraj:
    popl %ebx			# restauriraš %ebx
    movl %ebp, %esp
    popl %ebp
    ret

# odavde počinje pravi program koji ti služi samo za poziv nzd
main:
    pushl b
    pushl a
    call nzd
    addl $8, %esp
    movl %eax, r

kraj:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
