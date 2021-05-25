# Moguči tip zadatka sa konsultacija 2
# Prolazak kroz string koji je korisnik uneo sa tastature i pronalaženje numeričkih karaktera koje treba (npr) sumirati (ili pomnoziti ili podeliti itd.) Ovde je potrebno da nakon što naiđemo na numerički karakter da ga konvertujemo iz znakovnog u interni.

.section .data

unos:      .ascii "Unesite neki string:\0"
unos_len= . - unos

string:   .fill 20,1,0
greska:   .byte 0
.section .text
.globl main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $unos, %ecx
	movl $unos_len, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $20, %edx
	int $0x80
konverzija:
	movl $string, %esi
	movl $0, %eax		# rez
	movl $0, %ecx		# trenutni
	movl $0, %edx
	movl $10, %ebx
	movl $0, %edi		# suma
proveri:
	movb (%esi), %cl
	cmpb $'0', %cl
	jb sledeci
	cmpb $'9', %cl
	ja sledeci
konvertuj:
	movb (%esi), %cl
	subb $'0', %cl
	mull %ebx
	cmpl $0, %edx
	jne greska_
	
	addl %ecx, %edi         #trenutni na sumu
	addl %ecx, %eax         #trenutni na eax
sledeci:
	incl %esi
	movb (%esi), %cl
	cmpb $10, %cl
	jne proveri
greska_:
	incl greska
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
