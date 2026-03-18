Issue 1: Esqueleto del programa y configuración de secciones
Descripción: Crear el archivo fuente inicial definiendo las tres secciones fundamentales de memoria y estableciendo una salida limpia del sistema para evitar errores de segmentación.

Tareas:

[ ] Crear el archivo principal cesar.asm.

[ ] Definir la sección .data para futuras constantes y cadenas de texto.

[ ] Definir la sección .bss para la reserva de búferes de entrada.

[ ] Definir la sección .text y declarar el punto de entrada global _start.

[ ] Implementar la llamada al sistema sys_exit en el flujo principal cargando el valor uno en el registro EAX para terminar el programa sin errores.

[ ] Crear un script básico de bash o incluir en el archivo README las instrucciones para ensamblar con nasm formato elf y enlazar con ld.

Issue 2: Interfaz de consola y captura de opción
Descripción: Implementar las llamadas al sistema necesarias para mostrar el menú principal y leer la respuesta del usuario, controlando el flujo mediante saltos condicionales.

Tareas:

[ ] Declarar el mensaje del menú principal en la sección de datos terminando con el carácter de salto de línea.

[ ] Utilizar la llamada al sistema sys_write cargando cuatro en EAX para imprimir el menú.

[ ] Reservar un byte en la sección .bss para almacenar la opción del usuario.

[ ] Utilizar la llamada sys_read cargando tres en EAX para leer la entrada estándar.

[ ] Implementar instrucciones CMP para evaluar el byte leído comparándolo con los valores ASCII de uno, dos y tres.

[ ] Configurar instrucciones de salto condicional como JE para dirigir el flujo hacia diferentes etiquetas según la opción elegida.

Issue 3: Gestión de búferes y entrada de datos
Descripción: Solicitar al usuario el mensaje a procesar y la clave numérica, almacenándolos correctamente y realizando las conversiones de ASCII a valores numéricos tratables.

Tareas:

[ ] Reservar un espacio de memoria contiguo en .bss, por ejemplo doscientos cincuenta y seis bytes, para el mensaje del usuario.

[ ] Solicitar y leer el mensaje de texto utilizando sys_read y guardar la longitud real leída..

[ ] Solicitar y leer la clave de desplazamiento ingresada por el usuario.

[ ] Implementar una pequeña rutina que reste el valor hexadecimal treinta o el carácter cero al byte de la clave para convertirlo de su representación ASCII a un valor entero binario utilizable en operaciones aritméticas.

Issue 4: Rutina principal de desplazamiento de caracteres
Descripción: Crear la lógica central que recorre el búfer de memoria byte a byte, evalúa si es una letra y aplica la transformación matemática.

Tareas:

[ ] Utilizar el registro ESI como puntero de origen para recorrer el búfer del mensaje introducido.

[ ] Crear un bucle utilizando etiquetas y el registro ECX como contador para iterar sobre cada carácter.

[ ] Extraer un byte de la memoria hacia el registro AL.

[ ] Utilizar instrucciones CMP para verificar si el byte se encuentra en el rango de letras mayúsculas o minúsculas ignorando espacios y signos de puntuación.

[ ] Sumar el valor del registro que contiene la clave numérica al registro AL.

[ ] Implementar la lógica circular verificando si el nuevo valor supera la letra Z; si es así, restar veintiséis al registro AL para devolverlo al inicio del alfabeto.

[ ] Escribir el byte modificado de vuelta en la memoria y avanzar el puntero ESI incrementándolo en uno.

Issue 5: Implementación de la subrutina de Cifrado
Descripción: Encapsular la lógica de desplazamiento positivo dentro de un procedimiento formal y conectarlo con la primera opción del menú.

Tareas:

[ ] Crear una etiqueta identificativa para el procedimiento de cifrado.

[ ] Configurar el código del menú principal para invocar esta subrutina utilizando la instrucción CALL.

[ ] Proteger el estado del programa utilizando PUSH para guardar los registros importantes en la pila al inicio de la rutina.

[ ] Integrar el núcleo de desplazamiento desarrollado en el issue cuatro.

[ ] Restaurar los registros utilizando POP en el orden inverso antes de ejecutar la instrucción RET.

[ ] Utilizar sys_write para imprimir el búfer resultante en pantalla informando que es el mensaje cifrado.

Issue 6: Implementación de la subrutina de Descifrado
Descripción: Replicar y adaptar la lógica anterior para realizar la operación inversa, conectándola con la segunda opción del menú.

Tareas:

[ ] Crear un procedimiento independiente para la acción de descifrar.

[ ] Invocar el procedimiento mediante CALL desde la etiqueta correspondiente a la segunda opción del menú.

[ ] Modificar la lógica matemática en el registro AL restando la clave en lugar de sumarla.

[ ] Ajustar la lógica circular verificando si el valor cae por debajo de la letra A; si esto ocurre, sumar veintiséis para volver al final del alfabeto.

[ ] Retornar al menú principal tras imprimir el mensaje modificado y limpiar los registros de trabajo.

Issue 7: Refactorización y manejo de casos límite
Descripción: Mejorar la robustez del programa evitando cierres abruptos ante entradas no esperadas y optimizando el código fuente.

Tareas:

[ ] Implementar una verificación para limpiar los registros adecuadamente utilizando la instrucción XOR antes de iniciar operaciones matemáticas críticas.

[ ] Añadir soporte para claves mayores a veintiséis dividiendo la clave introducida y utilizando el resto de la operación, extraído del registro EDX o AH dependiendo de la instrucción DIV empleada.

[ ] Manejar el salto de línea residual que la llamada sys_read captura al pulsar la tecla Enter en la consola.

[ ] Modularizar el código creando macros en NASM para las llamadas de impresión y lectura, reduciendo así la repetición de instrucciones en el archivo fuente.




Instrucciones para ejecutar:

    - Ordenador Aarón :

cd /mnt/c/Users/Aaron/Documents/GitHub/Proyecto_Ensamblador
sudo apt update
sudo apt install nasm
nasm -f elf32 -o cesar.o cesar.asm
ld -m elf_i386 -o cesar cesar.o

./cesar
