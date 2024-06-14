.intel_syntax noprefix
.text
.global main

main:
    mov eax, 5    # Przykład: załaduj argument do stosu
    push eax
    call znajdz
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

znajdz:
    push ebp                # Zapisz wartość rejestru ebp na stosie
    mov ebp, esp            # Ustaw ebp na aktualny stos

    mov eax, [ebp+8]        # Pobierz argument ze stosu (8 bajtów powyżej ebp)
    imul eax, eax, 2024     # Pomnóż argument przez 2024

    pop ebp                 # Przywróć wartość rejestru ebp ze stosu
    ret                     # Zakończ procedurę

.data
printfarg1:
    .asciz "%i "

