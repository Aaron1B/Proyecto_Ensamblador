section .data
    menu db "Menú", 10
            "Cifrar", 10
            "Descifrar", 10
            "Salir", 10
            "Selecciona una opción: "
    
    menu_len equ $ - menu_msg


section .bss
    opcion_usuario resb 1
section .text

global _start
_start:
    ; sys_write(stdout, menu, menu_len)
    mov  eax, 4        ; sys_write
    mov  ebx, 1        ; stdout
    mov  ecx, menu     ; dirreccion del mensaje
    mov  edx, menu_len ; longitud del mensaje
    int  0x80
    ; Leer opcion 
    mov eax,  3
    mov ebx,  0
    mov ecx,  opcion
    mov edx,  1 
    int 0x80
    ;Salida del programa
    mov eax, 1
    mov ebx, 0
    int 0x80 

