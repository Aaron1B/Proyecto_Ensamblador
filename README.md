# Proyecto_Ensamblador
1. Descripción General y Objetivos El presente proyecto consiste en el diseño e implementación de un sistema de bajo nivel capaz de traducir datos numéricos abstractos (valores hexadecimales del 0 al F) en representaciones visuales comprensibles para el usuario humano. El objetivo central es programar la lógica de control de un display de 7 segmentos utilizando lenguaje Ensamblador, gestionando directamente la interacción entre el procesador y el periférico de salida.

2. Justificación Técnica: El Papel del Lenguaje Ensamblador La elección del lenguaje Ensamblador para este proyecto no es arbitraria, sino fundamental para el control del hardware. A diferencia de los lenguajes de alto nivel, donde el compilador y el sistema operativo abstraen la gestión de los recursos, en este proyecto el Ensamblador cumple tres funciones críticas:

Control Directo de Hardware (Bit-Banging): El display de 7 segmentos carece de lógica interna; es un arreglo de LEDs que deben ser encendidos o apagados individualmente. El Ensamblador permite manipular cada bit de los registros de salida con precisión absoluta. El programador define explícitamente qué pines reciben voltaje, transformando un byte de datos (ej. 00000110) en una señal eléctrica física.

Gestión Manual de Memoria: El proyecto exige el cálculo explícito de direcciones de memoria (punteros). El código no solicita una variable por su nombre, sino que calcula su ubicación física exacta mediante el uso de direcciones base y desplazamientos (offsets), una competencia esencial en la ingeniería de computadores.

3. Lógica de Implementación: La Tabla de Búsqueda (LUT) Para optimizar el rendimiento del procesador y evitar el uso ineficiente de múltiples sentencias condicionales (como largas cadenas de if/else o switch), el sistema utiliza una estructura de datos conocida como Tabla de Búsqueda o Look-Up Table (LUT).

Esta técnica se fundamenta en almacenar en la memoria de datos los patrones de bits precalculados que corresponden a cada dígito. Por ejemplo, en la posición 0 de la tabla se almacena el byte 0x3F (que enciende los segmentos necesarios para formar un "0"), y en la posición 1 se almacena 0x06 (para el "1").

4. Flujo de Ejecución del Sistema El algoritmo diseñado opera bajo el siguiente ciclo de instrucciones:

Entrada de Datos: El sistema recibe un valor numérico (índice) que representa el dígito a mostrar.

Cálculo de Dirección Efectiva: El procesador suma este valor numérico a la dirección base donde inicia la Tabla de Búsqueda. Esto genera un puntero que señala exactamente al patrón de bits deseado.

Acceso a Memoria (Load): Se ejecuta una instrucción de carga para extraer el byte de configuración desde la dirección calculada.

Mapeo de Salida (I/O): Finalmente, el byte recuperado se escribe en el puerto de salida mapeado al display. Cada bit del registro activa un segmento específico (a, b, c, d, e, f, g), visualizando el número instantáneamente.

5. Conclusión Este proyecto demuestra la capacidad del lenguaje Ensamblador para eliminar las capas de abstracción de software, permitiendo al ingeniero actuar como un puente directo entre la lógica digital y los componentes electrónicos. Ilustra principios fundamentales de arquitectura de computadores como el mapeo de memoria, la aritmética de punteros y la decodificación por software.