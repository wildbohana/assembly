.section .data
.section .text
.global samoglasnici

samoglasnici:
	pushl %ebp
	movl %ebp, %esp

	pushl %esi
	pushl %edi
	pushl %ebx
pokazivaci:
	movl 8(%ebp) %esi
	movl $0, %ebx			        # da se ne bi obavljala bezveze iteracija za \0
provera:
	cmpb $0, (%esi)
	je kraj
smesti_u_nizi:
	movb (%esi), %dl
switch:
	cmpb $'a' , %dl
	je jeste
	
	cmpb $'e' , %dl
	je jeste
	
	cmpb $'i' , %dl
	je jeste
	
	cmpb $'o' , %dl
	je jeste
	
	cmpb $'u' , %dl
	je jeste
	
	jmp sledeci
jeste:
	incl %ebx
sledeci:
	incl %esi
	jmp provera
kraj:
	movl %ebx, %eax

	popl %ebx
	popl %edi
	popl %esi

	movl %ebp, %esp
	popl %ebp
	ret
