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
    push ebx               # Zapisz wartość rejestru ebx na stosie
    push ecx               # Zapisz wartość rejestru ecx na stosie
    push edx               # Zapisz wartość rejestru edx na stosie

    mov eax, [esp+16]      # Pobierz adres łańcucha znaków ze stosu (16 bajtów powyżej ESP po zapisaniu rejestrów)
    xor ecx, ecx           # Ustaw licznik bieżącej sekwencji na 0
    xor edx, edx           # Ustaw maksymalną liczbę powtarzających się 'A' na 0

.loop:
    movzx ebx, byte ptr [eax]  # Wczytaj bieżący znak spod adresu eax
    test bl, bl                # Sprawdź, czy znak to '\0'
    jz .end                    # Jeśli koniec łańcucha, zakończ pętlę

    cmp bl, 'a'                # Porównaj bieżący znak z 'A'
    jne .reset_count           # Jeśli bieżący znak nie jest 'A', zresetuj licznik

    inc ecx                    # Zwiększ licznik bieżącej sekwencji
    cmp ecx, edx               # Porównaj bieżącą sekwencję z maksymalną
    jle .next_char             # Jeśli bieżąca sekwencja nie jest większa, przejdź do następnego znaku

    mov edx, ecx               # Ustaw nową maksymalną liczbę powtarzających się 'A'

.next_char:
    inc eax                    # Przesuń wskaźnik o 1 znak do przodu
    jmp .loop                  # Powtórz pętlę

.reset_count:
    xor ecx, ecx               # Zresetuj licznik bieżącej sekwencji
    jmp .next_char             # Przejdź do następnego znaku

.end:
    mov eax, edx               # Przenieś wynik (maksymalną liczbę 'A') do eax

    pop edx                    # Przywróć wartość rejestru edx ze stosu
    pop ecx                    # Przywróć wartość rejestru ecx ze stosu
    pop ebx                    # Przywróć wartość rejestru ebx ze stosu
    ret                        # Zakończ procedurę

.data
messg:
    .asciz "abc aabbbcc"
printfarg1:
    .asciz "%i"

