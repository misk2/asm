.intel_syntax noprefix
.text
.global main

main:
    mov ebx, 3              # Przykład: obliczenie wylicz(3)
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
    cmp eax, 0
    jne .recursive_case     # Jeśli n > 0, przejdź do kroku rekurencyjnego

    mov eax, 2022           # Ustaw wynik na 2022 dla n = 0
    jmp .end_recursive      # Zakończ procedurę

.recursive_case:
    dec eax                 # Oblicz n - 1
    push eax                # Umieść argument n - 1 na stosie
    call wylicz             # Wywołaj rekurencyjnie wylicz(n - 1)
    add esp, 4              # Usuń argument ze stosu po wywołaniu

    shl eax, 1              # Pomnóż wynik przez 2 (eax = 2 * wylicz(n - 1))
    dec eax                 # Odejmij 1 (eax = 2 * wylicz(n - 1) - 1)

.end_recursive:
    pop ebx                 # Przywróć wartość rejestru ebx ze stosu
    pop ebp                 # Przywróć wartość rejestru ebp ze stosu
    ret                     # Zakończ procedurę

.data
printfarg1:
    .asciz "%i "

