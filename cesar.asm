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

    msg_resultado db "El mensaje cifrado es: "
    msg_resultado_len equ $ - msg_resultado

section .bss
    opcion_usuario resb 1
    mensaje resb 256
    longitud_mensaje resd 1

    clave resb 2

section .text
global _start

_start:
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, menu
    mov  edx, menu_len
    int  0x80

    mov eax,  3
    mov ebx,  0
    mov ecx,  opcion_usuario
    mov edx,  1 
    int 0x80
    
    cmp byte [opcion_usuario], '1'
    je  opcion_cifrar 

    cmp byte [opcion_usuario], '2'
    je opcion_descifrar

    cmp byte [opcion_usuario], '3'
    je salir

    jmp _start

opcion_cifrar:
    call cifrar
    jmp _start

cifrar:
    push eax
    push ebx
    push ecx
    push edx
    push esi

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

    mov [longitud_mensaje], eax

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

    xor eax, eax
    mov al, [clave]
    sub al, '0'
    mov [clave], al

    mov esi, mensaje
    mov ecx, [longitud_mensaje]

bucle_recorrido:
    cmp ecx, 0
    je fin_bucle

    mov al, [esi]  

    cmp al, 'A'
    jl siguiente_caracter 
    cmp al, 'Z' 
    jle es_mayuscula 

    cmp al, 'a'
    jl siguiente_caracter
    cmp al, 'z'
    jle es_minuscula 

    jmp siguiente_caracter

es_mayuscula:
    add al, [clave]
    cmp al, 'Z'
    jle guardar_caracter
    sub al, 26
    jmp guardar_caracter

es_minuscula:
    add al, [clave]
    jmp guardar_caracter

guardar_caracter:
    mov [esi], al

siguiente_caracter:
    inc esi 
    dec ecx
    jmp bucle_recorrido

fin_bucle:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_resultado
    mov edx, msg_resultado_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, [longitud_mensaje]
    int 0x80

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    ret

opcion_descifrar:
    call descifrar
    jmp _start

descifrar:
    push eax
    push ebx
    push ecx
    push edx
    push esi

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

    mov [longitud_mensaje], eax

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

    xor eax, eax
    mov al, [clave]
    sub al, '0'
    mov [clave], al

    mov esi, mensaje
    mov ecx, [longitud_mensaje]

bucle_recorrido_d:
    cmp ecx, 0
    je fin_bucle_d

    mov al, [esi]  

    cmp al, 'A'
    jl siguiente_caracter_d 
    cmp al, 'Z' 
    jle es_mayuscula_d 

    cmp al, 'a'
    jl siguiente_caracter_d
    cmp al, 'z'
    jle es_minuscula_d 

    jmp siguiente_caracter_d

es_mayuscula_d:
    sub al, [clave]
    cmp al, 'A'
    jge guardar_caracter_d
    add al, 26
    jmp guardar_caracter_d

es_minuscula_d:
    sub al, [clave]
    cmp al, 'a'
    jge guardar_caracter_d
    add al, 26
    jmp guardar_caracter_d

guardar_caracter_d:
    mov [esi], al

siguiente_caracter_d:
    inc esi 
    dec ecx
    jmp bucle_recorrido_d

fin_bucle_d:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_resultado
    mov edx, msg_resultado_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, [longitud_mensaje]
    int 0x80

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    ret

salir:
    mov eax, 1
    mov ebx, 0
    int 0x80