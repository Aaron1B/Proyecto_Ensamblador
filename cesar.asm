section .data
    menu db " - Menú -", 10, \
            "1 Cifrar", 10, \
            "2 Descifrar", 10, \
            "3 Salir", 10, \
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

    mov eax, 4                 
    mov ebx, 1
    mov ecx, pedir_clave
    mov edx, pedir_clave_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, clave
    mov edx, 2
    int 0x80

    mov al, [clave]
    sub al, '0';Conversion de ASCII a número
    mov [clave], al

    mov esi, mensaje

    mov ecx, [longitud_mensaje]
bucle_recorrido:
    cmp ecx, 0
    je fin_bucle

    mov al, [esi]  

    cmp al, 'A'
    jl siguiente_caracter 
    cmp al 'Z' 
    jle es_mayuscula 

    cmp al, 'a'
    jl siguiente_caracter
    cmp al, 'z'
    jle es_minuscula 

    jmp siguiente_caracter
es_mayuscula:
    add al, [clave]
    jmp siguiente_caracter
es_minuscula:
    add al, [clave]
    jmp siguiente_caracter

siguiente_caracter:
    inc esi 
    dec ecx
    jmp bucle_recorrido
fin_bucle:
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