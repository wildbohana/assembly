and	or	xor	not
test - and ali bez promene odredišnog operanda
 neg - komplement 2 broja (kombinacija not i dodavanja $1 rezultatu)

Maskiranje - setujemo određeni bit registra na neku vrednost
andl $0b11111111111111111111111111111110, %eax -> najniži bit eax na 0
orl  $0b00000000000000000000000000000001, %eax -> najniži bit eax na 1
xorl $0b00000000000000000000000000000001, %eax -> najniži bit eax se invertuje

Binarno pomeranje:
~ kod označenih brojeva moramo proveravati stanje indikatora o
shl - sve pomera levo (na kraju dolazi 0), u carry se smešta vrednost skroz levog bita
shr - sve pomera desno (na početak dolazi 0), u carry se smešta vrednost skroz desnog bita
sar - sve pomera u desno i na početak prekopira vrednost skroz levog da ga sačuva
    - aritmetičko šiftovanje u desno (prvi bit - znak broja, zato se on čuva)

Binarno rotiranje:
rol - bit sa početka levo stavlja na kraj desno, u carry smešta vrednost pomerenog bita
ror - bit sa kraja desno stavlja na početak levo, u carry smešta vrednost pomerenog bita
rcl - bit sa početka levo smešta u carry, a na kraj desno stavlja pređašnju vrednost carry
rcr - bit sa kraja desno smešta u carry, a na početak levo stavlja pređašnju vrednost carry

Primena:
cmpl $0, %eax  /  je ...			==	andl %eax, %eax  /  jz ...
movl $0, %eax					==	xorl %eax, %eax
movl $2, %edx  /  mull %edx			==	shll $1, %eax
movl $2, %ecx  /  movl $0, %edx  /  divl %ecx	==	shrl $1, %eax

Paritet	- proverava broj jedinica u broju, parni (0) i neparni (1)
	- smešta se u najznačajniji bit				(horizontalni paritet)
Kontrolna suma	- paritet bitova na određenoj poziciji		(vertikalni paritet)
		- smešta se u novi element koji se dodaje kao n+1 paket

# mul - u %eax ono šta množiš, u %ebx koliko puta množiš, mull %ebx -> rezultat u %eax
# div - u %eax ono šta deliš, u %ebx ono čime deliš, div %ebx -> rezultat u %eax, ostatak u %edx
#     - pre toga moraš movl $0, %edx, u suprotnom to gleda kao 64-bit



	  Dodatak:
### dvostruka preciznost ###


~ Negacija - kompliment 2 = kompliment 1 (not) uvećan za 1
notl %eax
notl %edx
addl $1, %eax
adcl $0, %edx


~ Pomeranje
shl:
shll $1, %eax				# shift u carry prebaci levi broj
rcll $1, %edx				# a rcl na kraj edx prebaci vrednost iz carry

shr:
shrl $1, %eax
rcrl $1, %edx

sar:
sarl $1, %eax
rcrl $1, %edx


~ Rotiranje
rol:
shll $1, %eax				# shift, leva cifra u carry
rcll $1, %edx				# vrednost iz carry stavi na kraj edx, prvu cifru eax u c
rcrl $1, %eax				# i onda na levi kraj eax staviš to iz carry
roll $1, %eax				# i ceo broj rotiraš (obično) u desno

ror:
shrl $1, %eax
rcrl $1, %edx
rcll $1, %eax
rorl $1, %eax
