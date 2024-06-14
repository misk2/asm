.intel_syntax noprefix
.text
.globl main

main:
    mov ebx, 4              # Przykład: obliczenie wylicz(4)
    push ebx
    call wylicz
    add esp, 4              # Usuń argument ze stosu

    # Wypisanie wyniku
    push eax
    mov eax, offset printfarg1
    push eax
    call printf
    add esp, 8              # Usuń argumenty ze stosu (4 bajty za wynik + 4 bajty za format)

exit:
    # Kod powrotu z programu
    mov eax, 0
    ret

wylicz:
    push ebp                # Zapisz wartość rejestru ebp na stosie
    mov ebp, esp            # Ustaw ebp na aktualny stos
    push ebx                # Zapisz wartość rejestru ebx na stosie

    mov eax, [ebp+8]        # Pobierz argument n ze stosu (8 bajtów powyżej ebp)
    cmp eax, 1
    jle .base_case          # Jeśli n <= 1, przejdź do warunku bazowego

    sub eax, 2              # Oblicz n - 2
    push eax                # Umieść argument n - 2 na stosie
    call wylicz             # Wywołaj rekurencyjnie wylicz(n - 2)
    add esp, 4              # Usuń argument ze stosu po wywołaniu

    shl eax, 1              # Pomnóż wynik przez 2 (eax = 2 * wylicz(n - 2))
    add eax, [ebp+8]        # Dodaj n (eax = 2 * wylicz(n - 2) + n)

    jmp .end_recursive      # Zakończ procedurę

.base_case:
    mov eax, 1              # Ustaw wynik na 1 dla n = 0 lub n = 1

.end_recursive:
    pop ebx                 # Przywróć wartość rejestru ebx ze stosu
    pop ebp                 # Przywróć wartość rejestru ebp ze stosu
    ret                     # Zakończ procedurę

.data
printfarg1:
    .asciz "%i "

