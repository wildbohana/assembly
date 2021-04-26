# razmak prednji i zadnji

.section .data
	s: .ascii "   Neki tekst   \0"
.section .text
.globl main

main:
	movl $s, %eax		# premesti pokazivač na string u registar a
kraj_s:
	cmpb $0, (%eax)		# poredi \0 (u ascii vrednost 0) sa brojem 0
	je razmaci1		# ako je jednako, idi na sledeći deo zadatka
	incl %eax		# increment a (pokazivač na string ++)
	jmp kraj_s		# ponovi ovu petlju dok ne dođeš do \0 (elem iza poslednjeg)
razmaci1:
	cmpb $' ' , -1(%eax)	# poredi ascii vrednost od razmaka sa charom pre \0 (zato ide ovo -1)
	jne izbaci1		# ako nije jednako (tj nije razmak), pređi na izbacivanje
	decl %eax		# decrement a (pokazivač na kraj --)
	jmp razmaci1		# ponovi ovu petlju
izbaci1:
	movb $0, (%eax)		# a pokazuje na razmak odmah iza stringa, tu stavi 0 tj ascii \0)
reset:
	movl $s, %eax
razmaci2:
	cmpb $' ' , (%eax)	# poredi razmak i vrednost u eax (prvi element niza)
	jne kraj		# ako nije razmak nema šta da izbacuje	
izbaci2:
	movb 1(%eax), %bl	# premesti eax+1 u low b, znači pokazivač na s[1] je sad low b
	movb %bl, (%eax)	# premesti iz temp u eax (sad eax postaje pok na s[1])
				# ovo valjda eax preuzme prvo vrednost drugog elementa iz niza
	incl %eax		# povećaj eax (da bi mogla da porediš sledeći element)
				# a ovde pomera da pokazivač pokazuje na sledeći el iz niza
	jmp razmaci2		# poredi ' ' sa novim stringom
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80	
