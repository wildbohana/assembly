Znakovni oblik: .ascii "12345\0"  /  .byte 49, 50, 51, 52, 53, 0
Interni oblik: .long 12345  /  .long 0x3039  /  .byte 57, 48, 0, 0

Za cifre: znakovni -> interni == -48

Moguće greške u znakovnom obliku:
- znak ne pripada zadatoj osnovi
- konvertivana vrednost ne može da stane u zadatu preciznost
- prazan string

Konverzija ceo dekadni broj, znakovni -> interni
1. rezultat konverzije se inic. na 0 i postavi se tekuća pozicija u nizu cifara na prvu
2. rezultat se pomnoži sa osnovom brojnog sistema
3. vrednost cifre na tekućoj poziciji se doda na rezultat
4. ako ima još cifara, tekuča pozicija se pomeri za 1 mesto u desno i prelazi se na korak 2.
   u suprotnom kraj

Konverzija razlomljeni broj, znakovni -> interni
1. rezultat se postavi na 0 i pozicionira se na poslednju cifru u broju
2. rezultat se sabere sa cifrom i podeli sa bazom
3. ukoliko ima još cifara prelazi se na prethodnu cifru i ide se na korak 2., u suptonom kraj
