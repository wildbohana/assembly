# maska(unsigned int n, unsigned int v) - generiše masku za 32bit vrednosti
# n - redni broj bita kog treba postaviti na vrednost parametra v (svi ostali bit suprotno)
# ukoliko je neki od parametra neispravan, vratiti 0 kao rezultat
# neispravni parametri: v koji nije 0 ili 1, n koji je >31 (jer 32bit podatak ima 32 bita)

# koristi se not a ne neg (neg = not + incl)

.section .data
	n: .long 10
	v: .byte 1
.section .text
.globl main

main:
	movl n, %ecx				# vrednost n
	testl $0b11111111111111111111111111100000, %ecx
	jnz maska_gr				# ako nije 0, greška, setuješ %eax na 0
	movl $1, %eax				# inicijalna maska
	shll %cl, %eax				# pomeranje maske za n pozicija
	movl v, %esi		# ili ide movb ???
	testl $0b11111111111111111111111111111110, %esi
	jnz maska_gr				# ako nije 0, neki od bitova >1 je pun
	testl $1, %esi				# provera da li je v 0 ili 1
	jnz maska_kraj				# maska u %eax je ona koja nam treba
	notl %eax				# ako je 0, invertujemo bite
	jmp maska_kraj				# i dobijemo masku koja nam treba	
maska_gr:
	xorl %eax, %eax				# u potp. povr. vr. je u eax
						# ovde će ona biti 0 zbog greške
maska_kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
