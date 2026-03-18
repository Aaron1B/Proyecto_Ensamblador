section .data
    menu db "1  Menú", 10, \
            "2  Cifrar", 10, \
            "3 Descifrar", 10, \
            "4 Salir", 10, \
            "Selecciona una opción: "
    
    menu_len equ $ - menu

    pedir_texto db "Introduce el texto a cifrar: "
    pedir_texto_len equ $ - pedir_texto

    pedir_clave db "Introduce la clave de cifrado (0-25): "
    pedir_clave_len equ $ - pedir_clave

section .bss
    opcion_usuario resb 1
    mensaje resb 256
    longitud_mensaje resd 1 ; Longitud del mensaje del usuario

    clave resb 2


section .text
global _start

_start:
    ; sys_write(stdout, menu, menu_len)
    mov  eax, 4        ; sys_write
    mov  ebx, 1        ; stdout
    mov  ecx, menu     ; direccion del mensaje
    mov  edx, menu_len ; longitud del mensaje
    int  0x80

    ; Leer opcion 
    mov eax,  3
    mov ebx,  0
    mov ecx,  opcion_usuario
    mov edx,  1 
    int 0x80
    
    ; Comparar opcion 
    cmp byte [opcion_usuario], '1'
    je  opcion_cifrar 

    cmp byte [opcion_usuario], '2'
    je opcion_descifrar

    cmp byte [opcion_usuario], '3'
    je salir

    jmp _start

opcion_cifrar:
    mov eax, 4                 
    mov ebx, 1                
    mov ecx, pedir_texto     
    mov edx, pedir_texto_len 
    int 0x80

    mov eax, 3                 
    mov ebx, 0                  
    mov ecx, mensaje           
    mov edx, 256                
    int 0x80

    mov [longitud_mensaje], eax ; Guardar Longitud

    jmp salir

opcion_descifrar:
    mov eax, 1
    mov ebx, 0
    int 0x80

; Salida del programa
salir:
    mov eax, 1
    mov ebx, 0
    int 0x80