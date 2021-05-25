Interni oblik: .long 12345  /  .long 0x3039  /  .byte 57, 48, 0, 0
Znakovni oblik: .ascii "12345\0"  /  .byte 49, 50, 51, 52, 53, 0

Za cifre: interni -> znakovni == +48
Znakovna reprezentacija je promenljive dužine i može biti duža on interne (1 cifra -> 1 bajt)
Na kraju još 1 bajt za \0 sa vrednosti 0 (ascii NULL)

Konverzija ceo dekadni broj, interni -> znakovni
1. podeliš broj sa bazom
2. izdovjiš ostatak deljenja i zapišeš ga kao cifru izlazne osnove
3. ako je količnik!=0, on postaje nova vrednost deljenika i ide na korak 1, ako ne, ide na 4.
4. dobijeni string se obrne

Konverzija razlomljen broj, interni -> znakovni
- razmatraće se samo brojevi u intervalu od (0,1)
- brojevi će se u memoriji predstavljati skalirano, sa konstantom skaliranja 10^8
- moguće je dobiti beskonačnu periodičnost
- karakteristično za ovu konverziju je to što ne moramo da obrćemo string
1. broj se pomnoži sa bazom
2. izdvoji se ceo deo broja i zapiše kao cifra izlazne osnove
3. ako je ceo deo broja!=0, oduzme se od broja
4. ako je broj!=0, ide se na korak 1, u suprotnom je kraj konverzije

Mašinski normalizovana forma - računske operacije sa skaliranim brojevima oblika X * 10^8
