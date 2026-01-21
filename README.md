Plan de Trabajo: Desarrollo del Controlador de Display de 7 Segmentos
El desarrollo del proyecto se estructura en cinco fases secuenciales, diseñadas para aislar la complejidad lógica de la complejidad sintáctica del lenguaje Ensamblador. Esta metodología asegura que cada etapa valide los resultados de la anterior antes de avanzar.

Fase 1: Ingeniería de Datos y Mapeo de Hardware
El objetivo inicial es determinar los valores estáticos que alimentarán el sistema. Antes de escribir cualquier línea de código, es necesario traducir la representación visual de los números decimales (0-9) a su equivalente en señales digitales.

Se realizará un análisis de la tabla de verdad, asignando cada segmento del display (a, b, c, d, e, f, g) a un bit específico de un byte (del bit 0 al bit 6). Mediante este mapeo manual, se calcularán los códigos hexadecimales necesarios para dibujar cada número.

Entregable: Tabla de verdad en Excel (tabla_verdad.xlsx) con los 16 códigos hexadecimales verificados.

Fase 2: Prototipado y Validación Lógica (Python)
Para mitigar el riesgo de errores lógicos durante la programación en bajo nivel, se implementará primero una simulación del algoritmo en un lenguaje de alto nivel (Python). Esta fase utiliza el entorno de VS Code para validar que los códigos hexadecimales calculados en la Fase 1 generan los patrones visuales correctos.

El script de Python actuará como un "banco de pruebas", simulando las operaciones de desplazamiento de bits (shifts) y máscaras (AND) que posteriormente realizará la CPU.

Entregable: Script de simulación funcional (simulador.py) validando la integridad de los datos.

Fase 3: Configuración del Entorno y Estructura Base
Esta fase se centra en la infraestructura. Se procederá a la instalación y configuración del entorno de desarrollo (IDE) específico para la arquitectura elegida (MARS para MIPS o SASM para x86).

Se creará el archivo fuente principal (main.asm) definiendo las secciones críticas de memoria:

Sección .data: Donde se transcribirá la Tabla de Búsqueda (LUT) validada en la fase anterior.

Sección .text: Donde se establecerá el punto de entrada del programa y una rutina básica de finalización (exit) para asegurar que el código compila y se ejecuta sin errores de sintaxis.

Entregable: Archivo .asm compilable con la estructura de memoria definida.

Fase 4: Implementación del Algoritmo en Ensamblador
Esta es la fase crítica de desarrollo, donde se traduce la lógica validada a instrucciones máquina. Se subdivide en dos tareas:

Aritmética de Punteros: Implementación de la lógica de acceso a memoria. Se programará el cálculo de direcciones efectivas (Dirección Base + Índice) para recuperar el patrón de bits correcto según el número ingresado por el usuario.

Decodificación (Bit-Banging): Implementación del bucle de visualización. Se utilizarán instrucciones de manipulación de bits para leer secuencialmente el registro recuperado y activar las señales de salida correspondientes (simuladas mediante impresión en consola o I/O mapeado en memoria).

Entregable: Código fuente completo y funcional capaz de traducir una entrada numérica en su representación gráfica.

Fase 5: Documentación Técnica y Entrega
La fase final se dedica a elevar la calidad del proyecto. Se documentará el código fuente añadiendo comentarios explicativos en cada bloque de instrucciones, justificando el uso de registros y la gestión de la pila.

Asimismo, se generará el diagrama de flujo final utilizando herramientas de diagramación (Draw.io) y se redactará el archivo README.md, consolidando la información técnica, las instrucciones de uso y la justificación teórica del diseño.

Entregable: Paquete final del proyecto (.zip) con código, documentación y memoria técnica.