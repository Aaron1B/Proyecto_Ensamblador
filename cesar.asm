section .data

section .bss

section .text

global _start
start:
    mov eax, 1
    mov ebx, 0
    int 0x80

