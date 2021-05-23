# Potprogram za postavljanje pariteta niza 16-bitnih brojeva
# Potprogram koristi SetParity za postavljanje pariteta za jedan element, pa se i taj potprogram mora dodati prilikom kompajliranja

.section .data
	v: .word 0x12ac 	# i ovde treba još elemenata za niz, i sve da se prepravi za main
.section .text
.globl main

# int SetParity(unsigned short int* v)
SetParity:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %ecx
    andw $0x7fff, (%ecx)	# najviši bit na 0 (njega ne gledaš za paritet) 
    movw $1, %dx        	# inicijalna maska
    xorl %eax, %eax     	# brojač bita, postaviš ga na 0 ovako
parity_petlja:
    testw %dx, (%ecx)		# da li je bit na poziciji gde je maska 1?
    jz parity_dalje		# ako nije, onda idi dalje
    incl %eax			# ako jeste, povećaj brojač za 1
parity_dalje:
    shlw $1, %dx        	# sledeća bit pozicija
    jnc parity_petlja		# kada dođe maska skroz levo, biće carry i onda smo prešli sve
    andl $1, %eax		# ako je gotovo proveravamo da li je najniži bit brojača 1
    pushl %eax			# i rezultat se smešta u %eax koji dižeš na stek da ga sačuvaš
    shlw $1, (%ecx)     	# left shift niza koji proveravamo (skroz desno -> 0)
    shrl $1, %eax       	# desni shift brojača bita (0 ili 1) (ubaci se to u carry)
    rcrw $1, (%ecx)     	# desna carry rotacija za niz koji proveravamo
    				# ceo niz se pomeri u desno, skroz levo ostane 0 slobodna
    				# to iz carry se smesti na tu 0 skroz levo i to je parnost
    popl %eax			# restauracija %eax (ovo nam treba kasnije da mnogo jednostavnije
    				# vidimo da li je paritet 0 ili 1
parity_kraj:
    movl %ebp, %esp
    popl %ebp
    ret


#int SetParityArray(unsigned short int* niz, int n)
main:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp       	# lok. prom., brojač postavljenih jedinica
    movl $0, -4(%ebp)		# setuj brojač na 0
    pushl %esi          	# ovaj registar ostaje sačuvan između poziva (cdecl)
    movl 8(%ebp), %esi  	# pa će se koristiti kao pokazivač elemenata niza
paritya_petlja:
    cmpl $0, 12(%ebp)   	# da li su obrađeni svi elementi (jer se smanjuje do 0)
    je paritya_kraj		# ako je n nula, onda je kraj
    pushl %esi          	# poziv SetParity potprograma
    call SetParity
    addl $4, %esp		# oslobađaš lok. prom.
    andl %eax, %eax     	# da li je postavljena jedinica za paritet (ono sačuvano %eax)
    jz paritya_dalje		# ako nije, preskoči sledeći korak
    incl -4(%ebp)		# povećaj brojač za 1
paritya_dalje:
    addl $2, %esi       	# sledeći element (+2 jer je 16 bit niz)
    decl 12(%ebp)       	# broj elemenata se koristi kao brojač, smanjuješ ga svaki put
    jmp paritya_petlja		# idi na petlju opet
paritya_kraj:
    popl %esi
    movl -4(%ebp), %eax		# brojač smesti u %eax i vrati u main (ovo je onda checksum?)
    movl %ebp, %esp
    popl %ebp
    ret

