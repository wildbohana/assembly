.section .data
	br_elem=6
	niz:	.long 0b10010100010100010000010000100101
		.long 0b01001000100001010000101000100010
		.long 0b11000100010010001001000010010001
		.long 0b01000101000010010001001000010010
		.long 0b00100100010100100001000100100100
	checksum: .long 0
.section .text
.globl main

main:
...

checksum:
	xorl %eax, %eax			# eax na 0
	movl $1, %edx			# 1 u edx (maska za najniži bit)
sledeci_bit:
	xorl %ecx, %ecx			# ecx na 0
	xorl %esi, %esi			# esi na 0
sledeci_el:
	movl niz(,%esi,4), %ebx		# element iz niza u ebx
	andl %edx, %ebx			# poredi najnizi element iz ebx da li je 1
	jz bit_nula			# ako nije preskoči sledeći korak
	incl %ecx			# ako jeste povećaj ecx (brojač za paritet)
bit_nula:
	# ne znam, nema koda
