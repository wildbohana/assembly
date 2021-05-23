# primer 2, nema slajd lol
# potprogram za konverziju interni -> oktalni razlomljeni označeni

.section .text
.globl inter_to_oct_str_float

inter_to_oct_str_float:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp		# lokalna promenljiva, ide 8 jer ćeš imati 2 lok. prom.
    pushl %ebx
    pushl %esi
    pushl %edi
    
    movl 8(%ebp), %eax      	# broj
    movl 12(%ebp), %edi     	# str (pokazivač na string u koji smeštamo onaj konvertovani)
    movl $8, %ebx           	# baza (oktalni)
    movl $0, -4(%ebp)       	# greška (kao lok prom)
    movl $100000000, -8(%ebp)	# konstanta skaliranja, 10^8, druga lok. prom.
    
    andl %eax, %eax         	# da li je broj negativan?
    jns i2o_nula		# ako nije, obrađuj odmah
    movb $'-', (%edi)       	# ako jeste, ubaci minus u string
    incl %edi			# pomeri pok na sledeću poz. u stringu
    decl 16(%ebp)           	# smanji broj slobodnih mesta
    negl %eax               	# komplement 2, negiramo neg. br, dalje ga tretiramo kao poz.
i2o_nula:
    cmpl $4, 16(%ebp)       	# provera preostalog mesta, greška je samo ako inicijalno nema
    jl i2o_greska           	# dovoljno mesta za "0." i jednu cifru
    movb $'0', (%edi)		# smesti 0 u string
    movb $'.', 1(%edi)		# smesti . na jedno mesto iza 0 (0. dobiješ)
    addl $2, %edi		# pomeri pokazivač za dva mesta iza
    decl 16(%ebp)		# smanji broj slobodnih mesta (za nulu)
i2o_cifra:
    decl 16(%ebp)           	# smanji broj slobodnih mesta (za tačku)
    cmpl $1, 16(%ebp)       	# provera slobodnih mesta (potreban je 1 znak za NULL)
    je i2o_term			# ako je preostala dužina 1, kraj konverzije, stavi NULL na kraj
    mull %ebx               	# množenje %eax bazom u %ebx, smeštanje rez. u %eax
    divl -8(%ebp)           	# deljenje konstantom skaliranja, rez u %eax, ostatak u %edx
    addb $'0', %al		# konverzija rezultata deljenja
    movb %al, (%edi)		# smeštanje celog dela konvertovanog broja u string
    incl %edi			# pomeranje pok za jednu poziciju iza
    movl %edx, %eax		# ostatak smesti iz %edx u %eax da bi mogli dalje da obrađujemo
    andl %eax, %eax		# proveri da li je ostatak 0 (kraj konverzije)
    jnz i2o_cifra		# ako nije, ponovi sve ovo
i2o_term:
    movb $0, (%edi)		# na kraj stringa stavi NULL
    jmp i2o_kraj
i2o_greska:
    incl -4(%ebp)
i2o_kraj:
    movl -4(%ebp), %eax		# smesti vrednost greške u %eax
    popl %edi			# restauracija registara
    popl %esi
    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret
