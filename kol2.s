.intel_syntax noprefix    # Ustawienie składni Intel bez prefiksu

.text                     # Sekcja tekstowa (kod programu)

.global main              # Deklaracja funkcji main jako globalnej

main:
    mov eax, offset messg  # Załaduj adres łańcucha znaków do rejestru eax
    push eax               # Umieść adres łańcucha na stosie
    push eax               # Umieść adres łańcucha ponownie na stosie (drugi raz)
    call znajdz            # Wywołaj funkcję znajdz
    add esp, 8             # Usuń oba argumenty (2x4 bajty) ze stosu

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

znajdz:
    mov eax, [esp+4]       # Pobierz pierwszy argument (adres łańcucha) ze stosu
    mov ebx, [esp+8]       # Pobierz drugi argument ze stosu (jeśli potrzebny)
    xor ecx, ecx           # Ustaw licznik znaków na 0

.loop:
    movzx edx, byte ptr [eax]  # Wczytaj znak spod adresu eax
    cmp dl, '*'            # Porównaj znak z '*'
    je .found_star         # Skocz jeśli znaleziono '*'

    test dl, dl            # Sprawdź, czy znak to '\0'
    jz .not_found          # Skocz jeśli to koniec łańcucha

    inc ecx                # Zwiększ licznik znaków
    inc eax                # Przejdź do następnego znaku
    jmp .loop              # Powtórz pętlę

.found_star:
    mov eax, ecx           # Zwróć liczbę znaków przed '*'
    ret                    # Zakończ procedurę

.not_found:
    mov eax, -1            # Zwróć -1
    ret                    # Zakończ procedurę

.data
messg:
    .asciz "Przykłado*wy * tekst"
printfarg1:
    .asciz "%i"

