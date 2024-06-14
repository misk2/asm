.intel_syntax noprefix    # Ustawienie składni Intel bez prefiksu

.text                     # Sekcja tekstowa (kod programu)

.global main              # Deklaracja funkcji main jako globalnej

main:                     # Funkcja main
    mov eax, 0x0000F0F1   # Przypisanie wartości szesnastkowej 0x0000F0F1 do rejestru eax
    push eax              # Umieszczenie wartości eax na stosie
    call znajdz           # Wywołanie funkcji znajdz
    add esp, 4            # Zwolnienie 4 bajtów ze stosu (jeden argument)

    # Wypisanie wyniku
    mov eax, ebx          # Przypisanie liczby znalezionych par bitów do eax (ebx jest wynikiem z funkcji znajdz)
    push eax              # Umieszczenie wartości eax na stosie
    mov eax, OFFSET msg   # Przypisanie adresu wiadomości "Liczba par bitów 01: %d\n" do eax
    push eax              # Umieszczenie adresu wiadomości na stosie
    call printf           # Wywołanie funkcji printf
    add esp, 8            # Zwolnienie 8 bajtów ze stosu (2 argumenty)

    mov eax, 0            # Przypisanie eax wartości 0 (kod wyjścia programu)
    ret                   # Powrót z funkcji main

znajdz:                   # Deklaracja funkcji znajdz
    xor ecx, ecx          # Zerowanie rejestru ecx (będzie przechowywać liczbę znalezionych par)

petla:
    test eax, eax         # Testowanie wartości eax
    jz koniec_petli       # Jeśli eax jest równe 0, koniec pętli

    shr eax, 1            # Przesunięcie zawartości eax o 1 bit w prawo
    jc sprawdz_bit        # Sprawdzenie, czy nie wystąpiło przeniesienie przez carry (jeśli tak, to bit 1 na końcu)
    jmp petla             # W przeciwnym razie kontynuuj pętlę

sprawdz_bit:
    test eax, 1           # Sprawdzenie najmniej znaczącego bitu eax
    jz sprawdz_kolejny    # Jeśli bit jest zerowy, przejdź do sprawdzenia kolejnego bitu

    test eax, 2           # Sprawdzenie kolejnego bitu (czy jest jedynką)
    jz sprawdz_kolejny    # Jeśli bit nie jest jedynką, przejdź do sprawdzenia kolejnego bitu

    inc ecx               # Inkrementacja licznika znalezionych par bitów 01

sprawdz_kolejny:
    shr eax, 1            # Przesunięcie zawartości eax o 1 bit w prawo
    jmp petla             # Kontynuuj pętlę

koniec_petli:
    mov ebx, ecx          # Przypisanie wyniku (liczby znalezionych par) do rejestru ebx
    ret                   # Powrót z funkcji znajdz

.data                     # Sekcja danych

msg:
    .asciz "Liczba par bitów 01: %d\n"  # Wiadomość do wyświetlenia liczby znalezionych par bitów 01

