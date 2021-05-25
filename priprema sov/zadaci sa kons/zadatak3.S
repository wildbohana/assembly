# Mogući tip zadatka sa konsultacija 3:
# Korisnik unosi string u određenom formatu. Na primer "25+53\n". Od vas se traži da izvršite aritmetičku operaciju nad brojevima koji je korisnik uneo.

.section .data
	textt1 : .ascii "Unesite String"
	t1len = . -textt1
	max = 50+1
	input : .fill max,1,0
	greska: .long 0
	prvi: .long 0
	drugi: .long 0
	firstRead: .byte 0
	oznak: .ascii "x"
	rezultat: .long 0
	
.section .text

.global main

main:
 

	movl $4, %eax
	movl $1, %ebx
	leal textt1, %ecx
	movl $t1len, %edx
	int $0x80


	movl $3, %eax
	movl $0, %ebx
	leal input, %ecx
	movl $max, %edx
	int $0x80

	leal input, %esi
	
	movl $10, %ecx
	xorl %edx, %edx

in:
	xorl %eax, %eax
	movb (%esi), %bl
	cmpb $'0', %bl
	jb dalje
	cmpb $'9', %bl
	ja dalje	

konv:
	cmpb $'0', %bl
	jb krajKonv
	cmpb $'9', %bl
	ja krajKonv
	subb $'0', %bl
	mull %ecx
	addl %ebx, %eax
	incl %esi
	movb (%esi), %bl
	jmp konv
drugiRead:
	movl %eax, drugi
	jmp operacija
dalje:
	incl %esi
	jmp in
krajKonv:
	cmpb $1 , firstRead
	je drugiRead
	movl %eax, prvi
	incb firstRead
kojiOznak:
	xorl %eax, %eax
	cmpb $'+',%bl
	je plus
	cmpb $'-', %bl
	je minus
	cmpb $'*', %bl
	je puta
	cmpb $'/', %bl
	je deljenje
	incl %esi
	movb (%esi), %bl
	jmp kojiOznak
plus:
	movl $'+', oznak
	jmp in
minus:
	movl $'-', oznak
	jmp in
puta:
	movl $'*', oznak
	jmp in
deljenje:
	movl $'/', oznak
	jmp in

operacija:
	cmpb $'+', oznak
	je usingPlus
	cmpb $'-', oznak
	je usingMinus
	cmpb $'*', oznak
	je usingPuta
	cmpb $'/', oznak
	je usingDeljenje
usingPlus:
	movl prvi, %eax
	addl drugi, %eax
	movl %eax, rezultat
	jmp end 
usingMinus:
	movl prvi, %eax
	subl drugi, %eax
	movl %eax, rezultat
	jmp end 
usingPuta:
	movl prvi,%eax
	mull drugi
	movl %eax, rezultat
	jmp end 
usingDeljenje:
	movl prvi,%eax
	divl drugi
	movl %eax, rezultat
	jmp end 

end:
	movl $1, %eax
	movl rezultat, %ebx
	int $0x80
