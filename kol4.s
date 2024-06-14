.intel_syntax noprefix
.text
.globl main

main:
    mov eax, offset messg  # Załaduj adres łańcucha znaków do rejestru eax
    push eax               # Umieść adres łańcucha na stosie
    call policz            # Wywołaj funkcję policz
    add esp, 4             # Usuń argument (adres łańcucha) ze stosu

    # Wypisanie wyniku
    push eax               # Umieść wynik na stosie
    mov eax, offset printfarg1
    push eax               # Umieść format na stosie
    call printf            # Wywołaj funkcję printf
    add esp, 8             # Usuń argumenty ze stosu (4 bajty za wynik + 4 bajty za format)

exit:
    # Kod powrotu z programu
    mov eax, 0
    ret

policz:
    mov eax, [esp+4]       # Pobierz adres łańcucha znaków ze stosu
    xor ecx, ecx           # Ustaw licznik wystąpień na 0

.loop:
    movzx edx, byte ptr [eax]    # Wczytaj bieżący znak spod adresu eax
    test dl, dl                  # Sprawdź, czy znak to '\0'
    jz .end                      # Jeśli koniec łańcucha, zakończ pętlę

    cmp dl, '+'                  # Porównaj bieżący znak z '+'
    jne .next_char               # Jeśli bieżący znak nie jest '+', przejdź do następnego znaku

    movzx edx, byte ptr [eax+1]  # Wczytaj następny znak spod adresu eax+1
    cmp dl, '+'                  # Porównaj następny znak z '+'
    jne .next_char               # Jeśli następny znak nie jest '+', przejdź do następnego znaku

    inc ecx                      # Zwiększ licznik wystąpień
    add eax, 2                   # Przesuń wskaźnik o 2 znaki do przodu
    jmp .loop                    # Powtórz pętlę

.next_char:
    inc eax                      # Przesuń wskaźnik o 1 znak do przodu
    jmp .loop                    # Powtórz pętlę

.end:
    mov eax, ecx                 # Przenieś wynik (liczbę wystąpień '++') do eax
    ret                          # Zakończ procedurę

.data
messg:
    .asciz "P+r+zy++kla++++dowy++tekst"
printfarg1:
    .asciz "%i"

