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
    xor ecx, ecx           # Ustaw licznik słów na 0
    xor edx, edx           # Ustaw flagę stanu (0 = w spacji, 1 = w słowie)

.loop:
    movzx ebx, byte ptr [eax]  # Wczytaj znak spod adresu eax
    test bl, bl                # Sprawdź, czy znak to '\0'
    jz .end                    # Jeśli koniec łańcucha, zakończ pętlę

    cmp bl, ' '                # Porównaj znak z ' '
    je .in_space               # Jeśli znak to spacja, przejdź do .in_space

.in_word:
    cmp edx, 1                 # Sprawdź, czy jesteśmy w słowie
    je .next_char              # Jeśli jesteśmy już w słowie, przejdź do .next_char
    inc ecx                    # Zwiększ licznik słów
    mov edx, 1                 # Ustaw flagę stanu na "w słowie"
    jmp .next_char

.in_space:
    mov edx, 0                 # Ustaw flagę stanu na "w spacji"

.next_char:
    inc eax                    # Przejdź do następnego znaku
    jmp .loop                  # Powtórz pętlę

.end:
    mov eax, ecx               # Przenieś wynik (liczbę słów) do eax
    ret                        # Zakończ procedurę

.data
messg:
    .asciz "Przykladowy tekst zadania siemanko piec"
printfarg1:
    .asciz "%i"

