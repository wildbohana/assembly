# poslat1 *s1, *s2, *r i u %eax stavljaš razliku

.section .data
.section .text
.globl slova

slova:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl  8(%ebp), %esi		    # prvi string
	movl 12(%ebp), %edi		    # drugi string
	movl 16(%ebp), %edx		    # razlika
	movl $0, %eax			        # povratna vrednost pp
	movl $0, %ebx			        # broj malih slova u prvom
	movl $0, %ecx			        # broj malih slova u drugom
prvi:
	cmpb $10, (%esi)		      # mora b jer bajtovi
	je drugi
prvi_mala:
	cmpb $'z' , (%esi)
	jg sledeci1
	cmpb $'a' , (%esi)
	jl sledeci1
	incl %ebx			            # odmax povećaš brojač za prvi
sledeci1:
	incl %esi			            # sledeći znak u prvom stringu
	jmp prvi

drugi:
	cmpb $10, (%edi)
	je poredi
drugi_mala:
	cmpb $'z' , (%edi)
	jg sledeci2
	cmpb $'a' , (%edi)
	jl sledeci2
	incl %ecx			            # odmah povećaš brojač za drugi
sledeci2:
	incl %edi			            # sledeći element u drugom stringu
	jmp drugi

poredi:
	cmpl %ebx, %ecx
	jl vece
	jg manje
	je jednako

vece:
	movl $1, (%edx)
	jmp razlika
manje:
	movl $2, (%edx)
	jmp razlika
jednako:
	movl $3, (%edx)
	jmp razlika
razlika:
	cmpl %ebx, %ecx
	jl zameni			            # ako je ecx manje ebx, zameni ih da bude obrnuto
oduzmi:
	movl %ecx, %eax
	subl %ebx, %eax			      # odmah smeštaš u eax rezultat
	jmp kraj
zameni:
	xchgl %ebx, %ecx
	jmp oduzmi
	
kraj:
	popl %ebx
	popl %edi
	popl %esi
	
	movl %ebp, %esp
	popl %ebp
	ret
