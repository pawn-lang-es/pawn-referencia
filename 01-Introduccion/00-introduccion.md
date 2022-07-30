# Introducción

PAWN es un lenguaje de programación sencillo con una [sintaxis](https://github.com/pawn-lang-es/pawn-referencia/blob/main/terminologia.md#sintaxis) que se asemeja al lenguaje de programación "C". Un programa PAWN consta de un conjunto de funciones y un conjunto de variables. Las variables son objetos que almacenan datos y las funciones contienen instrucciones (llamadas "[sentencias](https://github.com/pawn-lang-es/pawn-referencia/blob/main/terminologia.md#sentencia)") que operan sobre las variables o que realizan tareas.

El primer programa en casi cada lenguaje de programacion es el que imprime un texto simple; "Hola mundo" es un ejemplo clásico. En PAWN, luciría como[^1]:

```pawn
main()
    printf "Hola mundo\n"
```

> Este manual asume que ya sabes ejecutar un programa PAWN; sino, consulta el manual de aplicacion o [Apéndice B](../../).

[^1]: Compilar y ejectuar scripts: **[Incluir referencia]()**

Un programa PAWN comienza su ejecución en una función de "entrada"[^note] -en
casi todos los ejemplos de este manual, esta función de entrada se llama
`main`. Aquí, la función `main` contiene una sola instrucción, que se encuentra en la línea inferior de la propia cabeza de la función. Los saltos de línea y la sangría son insignificantes; la invocación de la función `printf` podría estar igualmente en la misma línea que la cabeza de la
función `main`.

[^note]: No confundir con las funciones de entrada, las cuales son llamadas de 
entrada, pero sirven para otro propósito.

La **definición de una función** requiere de un par de paréntesis
después del nombre de la función. Si una función recibe parámetros, sus declaraciones
aparecen entre los paréntesis. La función `main`
lleva paréntesis. Las reglas son diferentes para una **invocación de función** (o una llamada de función); los paréntesis son opcionales en
la llamada a la función `printf`.

> ¿Cuál es la diferencia entre la definición de una función y la invocación de una función? Ver capítulo [3. Funciones](/03-Funciones/01-argumentos-de-funcion.md).

El único argumento de la función `printf` es una [cadena de caracteres](), que debe ir entre comillas dobles. Los caracteres `\n` cerca del final de
la cadena forman una [secuencia de escape](), en este caso indican un símbolo de "nueva línea". Cuando `printf` encuentra la secuencias de escape de nueva línea, avanza el cursor a la primera columna de la siguiente
línea. Hay que utilizar la secuencia de escape `\n` para insertar una "nueva línea" en la cadena, porque una cadena no puede envolver varias líneas.

> Ver [cadena de caracteres literales]() - Ver [secuencias de escape]().

PAWN es un lenguaje "sensible a las mayúsculas": las mayúsculas y las minúsculas se consideran letras diferentes. Sería un error
escribir la función `printf` en el ejemplo anterior como "PrintF". Las palabras reservadas y los símbolos predefinidos, como el nombre de la función `main`, *deben escribirse en minúsculas*.
Si conoces el lenguaje C, puedes pensar que el ejemplo anterior
no se parece mucho al programa "Hola mundo" equivalente en
C/C++. Sin embargo, PAWN también puede parecerse mucho a C. El siguiente
ejemplo es también una sintaxis válida de PAWN (y tiene la misma
[semántica]() que el ejemplo anterior):

```pawn
#include <console>

main()
{
    printf("Hola mundo\n");
}
```

Estos primeros ejemplos también revelan algunas diferencias entre PAWN y el lenguaje C:
- normalmente no es necesario incluir ningún "archivo de cabecera" definido por el sistema;
- el punto y coma es opcional (excepto cuando se escriben varias sentencias en una línea);
- cuando el cuerpo de una función es una sola instrucción, los corchetes
(para una instrucción compuesta) son opcionales;
- cuando no se utiliza el resultado de una función en una expresión
o asignación, los paréntesis alrededor del argumento de la función son
opcionales.

Como apunte, los pocos puntos anteriores se refieren a sintaxis **opcionales**. Usted elige la sintaxis que desea utilizar: ningún estilo es
"obsoleto" o "preferido". Los ejemplos de este manual colocan las llaves y utilizan una sangría que se conoce como el
"[estilo Whitesmith](https://en.wikipedia.org/wiki/Indentation_style#Whitesmiths_style)", pero PAWN es un lenguaje de formato libre y
otros estilos de sangría son igual de buenos.

Debido a que PAWN está diseñado para ser un lenguaje de extensión para aplicaciones, el conjunto de funciones/librerías que un programa PAWN tiene a su disposición depende de la aplicación anfitriona. Como resultado, el lenguaje PAWN
no tiene conocimiento en sí de ninguna función. La función  `printf`, utilizada en este primer ejemplo, debe ser puesta a disposición por
la aplicación anfitriona y ser "declarada" al analizador sintáctico (*[parser]()*) de PAWN[^2].
Se asume, sin embargo, que todas las aplicaciones anfitrionas proporcionan un mínimo
conjunto de funciones comunes, como `print` y `printf`.

> Más descripción de las funciones en el capítulo [9. Librerías propuestas](). 

[^2]: En la especificación del lenguaje, el término "analizador sintáctico" (*parser* en inglés) se refiere a cualquier implementación que procese y ejecute programas Pawn adecuados, ya sean intérpretes o [compiladores](https://github.com/pawn-lang-es/pawn-referencia/blob/main/terminologia.md#compilador).

En algunos entornos, la pantalla o el terminal deben estar habilitados
antes de que cualquier texto pueda ser emitido en él. Si este es el caso, usted
debe añadir una llamada a la función "console" antes de la primera llamada a
función `print` o `printf`. La función consola también permite
especificar las características del dispositivo, como el número de líneas y
columnas de la pantalla. Los programas de ejemplo de este manual
no utilizan las funciones de consola, porque muchas plataformas 
no la requieren o no la proporcionan.

> [Regresar a la página anterior](../README.md) (Índice)
>
> [Ir a la siguiente página](01-expresiones-aritmeticas.md) (Expresiones aritméticas)
>
> <sub>[Subir al principio de esta página](#introducción)</sub>
