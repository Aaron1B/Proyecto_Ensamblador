section .data
    menu db "Menú", 10
            "Cifrar", 10
            "Descifrar", 10
            "Salir", 10
            "Selecciona una opción: "
    
    menu_len equ $ - menu_msg


section .bss

section .text

global _start
_start:



    ;Salida del programa
    mov eax, 1
    mov ebx, 0
    int 0x80

