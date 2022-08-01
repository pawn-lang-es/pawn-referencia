# Etiquetas

Una etiqueta es un atributo que denota el objetivo -o el significado- de una variable, una constante o el resultado de una función. Las etiquetas son opcionales, su único propósito es permitir una mayor comprobación de errores en tiempo de compilación de los operandos en las expresiones, de los argumentos de las funciones y de los índices de los arreglos.

Una etiqueta consiste en un nombre simbólico seguido de dos puntos. Una etiqueta precede al nombre del símbolo de una variable, constante o función.

En una asignación, sólo se puede etiquetar la parte derecha del signo "=". Ejemplos de definiciones válidas de variables y constantes etiquetadas son:

<sub>OBSERVANDO: etiquetas</sub>
```pawn
new bool:flag = true                /* "flag" solo puede almacenar "true" o "false" */ 

const error:success = 0
const error:fatal = 1
const error:nonfaltal = 2

error:errno = fatal
```

La secuencia de las constantes `success`, `fatal` y `nonfatal` podría declararse más convenientemente utilizando una instrucción `enum`, como se ilustra a continuación.
La siguiente instrucción de enumeración crea cuatro constantes, `success`, `fatal`, `nonfatal` y `error`, todas con la etiqueta *error*.

<sub>OBSERVANDO: enumeraciones</sub>
```pawn
enum error {
    success,
    fatal,
    nonfatal,
}
```

Un uso típico de los enum "etiquetados" es en conjunto con los arreglos. Si cada campo de un arreglo tiene un propósito distinto, puede usar un enum etiquetado para declarar el tamaño de un arreglo y agregar la verificación de etiquetas al uso del arreglo en un solo paso:

<sub>OBSERVANDO: enumeraciones y arreglos</sub>
```pawn
enum rectangle
{
    left,
    top,
    right,
    bottom
}

new my_rect[rectangle] /* el arreglo es declarado con 4 celdas */

my_rect[left] = 10
my_rect[top] = 5
my_rect[right] = 30
my_rect[bottom] = 12

for (new i = 0; rectangle:i < rectangle; ++i)
    my_rect[rectangle:i] *= 2
```

Después de la declaración de "my_rect" arriba, puedes acceder al segundo campo de my_rect con "my_rect[top]", pero decir "my_rect[1]" dará un diagnóstico del parser (un mensaje de advertencia o error). Un superposición de etiquetas (o un cambio de etiquetas) ajusta una función, constante o variable al nombre de la etiqueta deseada. El bucle for de las dos últimas líneas del ejemplo anterior muestra esto: la variable del bucle i es una celda simple, sin etiqueta, y debe ser convertida a la etiqueta rectángulo antes de usarla como índice en el array my_rect. Observe que la estructura enum ha creado tanto una constante como una etiqueta con el nombre "rectángulo".

Los nombres de etiquetas introducidos hasta ahora empiezan con una letra minúscula; son etiquetas "**débiles**". Los nombres de etiquetas que comienzan con una letra mayúscula son etiquetas "**fuertes**". La diferencia entre las etiquetas débiles y las fuertes es que las etiquetas débiles pueden, en algunas circunstancias, ser eliminadas implícitamente por el analizador sintáctico de PAWN, de modo que una expresión débilmente etiquetada se convierte en una expresión no etiquetada. El mecanismo de comprobación de etiquetas verifica las siguientes situaciones:

- Cuando las expresiones a ambos lados de un operador binario tienen una etiqueta diferente, o cuando una de las expresiones está etiquetada y la otra no, el compilador emite un diagnóstico de "desajuste de etiqueta" (*tag mismatch*). En esta situación no hay diferencia entre etiquetas débiles y fuertes.

- Hay un caso especial para el operador de asignación: el compilador emite un diagnóstico si la variable del *lado izquierdo* de un operador de asignación tiene una etiqueta, y la expresión del lado derecho tiene una etiqueta diferente o no tiene etiqueta. Sin embargo, si la variable a la izquierda del operador de asignación no tiene etiqueta, acepta una expresión (en el lado derecho) con una etiqueta débil. En otras palabras, una etiqueta débil se elimina en una asignación cuando la variable de la izquierdad no está etiquetada.

- El paso de argumentos a las funciones sigue la regla de las asignaciones. El compilador emite un diagnóstico cuando el parámetro formal (en una definición de función) tiene una etiqueta y el parámetro real (en la llamada a la función) no tiene etiqueta o tiene una etiqueta diferente. Sin embargo, si el parámetro formal no tiene etiqueta, también acepta un parámetro con cualquier etiqueta débil.

- Un arreglo puede especificar una etiqueta para cada dimensión, véase el ejemplo de "my_rect". La comprobación de las etiquetas de los índices de los arreglos sigue la regla de la comprobación de las etiquetas de los operadores binarios: no hay diferencia entre las etiquetas débiles y las fuertes.

> [Regresar a la página anterior](12-arreglos-y-el-operador-sizeof.md) (Arreglos y el operador sizeof)
>
> [Ir al siguiente capítulo](../03-Funciones/00-funciones.md) (3. Funciones)
>
> <sub>[Subir al principio de esta página](#etiquetas)</sub>
