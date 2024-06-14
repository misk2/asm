.intel_syntax noprefix
.text
.globl main

main:
    mov eax, offset wynik    # Załaduj adres bufora wynikowego
    push eax                 # Umieść adres bufora na stosie
    mov eax, offset argument # Załaduj adres łańcucha wejściowego
    push eax                 # Umieść adres łańcucha na stosie
    call rozszerz            # Wywołaj procedurę rozszerz
    add esp, 8               # Usuń argumenty ze stosu

    # Wypisanie wyniku
    push offset wynik        # Umieść adres bufora wynikowego na stosie
    mov eax, offset printfarg1
    push eax                 # Umieść format na stosie
    call printf              # Wywołaj funkcję printf
    add esp, 8               # Usuń argumenty ze stosu (4 bajty za wynik + 4 bajty za format)

exit:
    # Kod powrotu z programu
    mov eax, 0
    ret

rozszerz:
    push ebp                 # Zapisz wartość rejestru ebp na stosie
    mov ebp, esp             # Ustaw ebp na aktualny stos
    push ebx                 # Zapisz wartość rejestru ebx na stosie
    push esi                 # Zapisz wartość rejestru esi na stosie

    mov esi, [ebp+8]         # Wczytaj adres łańcucha argument z argumentów na stosie
    mov ebx, [ebp+12]        # Wczytaj adres bufora wynikowego z argumentów na stosie

    mov ecx, 0               # Zeruj licznik przetworzonych znaków

.copy_loop:
    mov al, byte ptr [esi]   # Wczytaj bieżący znak z łańcucha argument
    test al, al              # Sprawdź, czy to koniec łańcucha ('\0')
    jz .end_copy             # Jeśli tak, zakończ pętlę

    mov byte ptr [ebx], al   # Skopiuj bieżący znak do bufora wynikowego
    inc ebx                  # Przejdź do następnej pozycji w buforze wynikowym

    mov byte ptr [ebx], ' '  # Wstaw spację do bufora wynikowego
    inc ebx                  # Przejdź do następnej pozycji w buforze wynikowym

    inc esi                  # Przejdź do następnego znaku w łańcuchu argument
    add ecx, 2               # Zwiększ licznik przetworzonych znaków o 2 (znak + spacja)
    jmp .copy_loop           # Powtórz pętlę

.end_copy:
    mov byte ptr [ebx], 0    # Zapisz terminator '\0' na końcu bufora wynikowego

    pop esi                  # Przywróć wartość rejestru esi ze stosu
    pop ebx                  # Przywróć wartość rejestru ebx ze stosu
    pop ebp                  # Przywróć wartość rejestru ebp ze stosu
    mov eax, [ebp+12]        # Wczytaj adres bufora wynikowego do eax (wynik funkcji)
    ret                      # Zakończ procedurę

.data
argument:
    .asciz "abc aAb"         # Przykładowy łańcuch wejściowy
wynik:
    .space 20                # Bufor wynikowy na 20 bajtów (na pewność, że wystarczy na przetworzony łańcuch)
printfarg1:
    .asciz ">>%s<<"          # Format dla funkcji printf

