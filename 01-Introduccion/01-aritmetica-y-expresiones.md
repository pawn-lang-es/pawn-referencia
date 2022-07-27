# Aritmética y expresiones
Un aspecto fundamental en la mayoría de los programas son los cálculos, las decisiones (ejecución condicional), las iteraciones (bucles) y las variables
para almacenar los datos de entrada, los de salida y los resultados intermedios. El
siguiente ejemplo ilustra muchos de estos conceptos. El programa
calcula el máximo común divisor de dos valores
utilizando un algoritmo inventado por Euclides.

<sub>DISPONIBLE EN: gcd.p</sub>
```pawn
/*
    El máximo común divisor de dos valores,
    usando el algoritmo de Euclides.
*/
main ()
    {
    print "Digita dos valores\n"
    new a = getvalue()
    new b = getvalue()
    while (a != b)
        if (a > b)
            a = a - b
        else
            b = b - a
    printf "El máximo común divisor es %d\n", a
    }
```

La función `main` ahora contiene más que una sola sentencia "`print`". Cuando el cuerpo de una función contiene más de una sentencia, éstas deben ir entre llaves -los caracteres "`{`"
y "`}`". Esto agrupa las instrucciones en una única sentencia compuesta. La noción de agrupar sentencias en una sentencia compuesta se aplica también a los cuerpos de las instrucciones `if`-`else` y las instrucciones en los bucles.

La palabra reservada `new` crea una variable. El nombre de la variable sigue a `new`. Es común, pero no obligatorio, asignar un valor a la variable en el momento de su creación. Las variables deben ser declaradas antes de ser utilizadas en una expresión. La función `getvalue` (también una función común  predefinida) lee un valor del teclado y devuelve el resultado. Tenga en cuenta que PAWN es un lenguaje sin tipado, todas las variables son celdas numéricas que pueden
contener un valor integral con signo.

El nombre de la función `getvalue` va seguido de un par de paréntesis.
Estos son necesarios porque el valor que devuelve `getvalue` se
se almacena en una variable. Normalmente, los argumentos (o parámetros) de la función aparecerían entre los paréntesis, pero `getvalue`
(tal como se utiliza en este programa) no toma ningún argumento explícito.
Si no se asigna el resultado de una función a una variable o se utiliza
en una expresión de otra manera, los paréntesis son opcionales.
Por ejemplo, el resultado de las sentencias `print` y `printf`
no se utilizan. Puede seguir utilizando paréntesis alrededor de los argumentos,
pero no es obligatorio.

Las instrucciones tipo bucle, como "`while`", repiten una única instrucción mientras mientras la condición del bucle (la expresión que sigue a la palabra reservada `while`) sea "verdadera". Se pueden ejecutar varias instrucciones en un bucle
agrupándolas en una sentencia compuesta. La instrucción `if`-`else`
tiene una instrucción para la condicion "verdadera" y otra para
la "falsa".

Observe que algunas sentencias, como `while` e `if`-`else`, contienen
(o "se despliegan alrededor de") otra instrucción -en el caso de `if`-`else`
incluso otras dos instrucciones más. El paquete completo es, de nuevo,
una sola instrucción. Es decir:

- las sentencias de asignación "`a = a - b`" debajo del `if` y "`b = b - a`" debajo del `else` son sentencias;
- la sentencia `if`-`else` se pliega alrededor de estas dos asignaciones y forma una única sentencia en sí misma;
- la sentencia `while` se pliega alrededor de la sentencia `if`-`else` y
forma, de nuevo, una única sentencia.

Es habitual hacer explícito el anidamiento de las sentencias mediante
la sangría de las sub-sentencias seguido a una sentencia en el código fuente. En el ejemplo del "Máximo común divisor", el margen izquierdo aumenta en cuatro caracteres de espacio después de la sentencia `while`, y de nuevo después de las palabras reservarda `if` y `else`. Las sentencias que
pertenecen al mismo nivel, como las invocaciones `printf` y el 
bucle while, tienen la misma sangría.

La condición del bucle `while` es "(a != b)"; el símbolo
!= es el operador "no igual a". Es decir, la instrucción if-else
se repite hasta que "a" sea igual a "b". Es una buena práctica sangrar las
instrucciones que se ejecutan bajo el control de otra sentencia, como se
ha hecho en el ejemplo anterior.
La llamada a `printf`, cerca de la parte inferior del ejemplo, difiere de
la llamada a `print` justo debajo de la llave de apertura ("{"). La "f" en
`printf` significa "formateado", lo que quiere decir que la función
puede formatear e imprimir valores numéricos y otros datos (en un formato especificado por el usuario), así como texto literal. El símbolo `%d` en la cadena de caracteres
es un token que indica la posición y el formato que
debe imprimir el siguiente argumento de la función `printf`.
En tiempo de ejecución, el token `%d` se sustituye por el valor de la variable "a"
(el segundo argumento de `printf`).
La función `print` sólo puede imprimir texto; es más rápida que `printf`. Si
quieres imprimir un literal `%` en la pantalla, tienes que usar
`print`, o tienes que duplicarlo en el texo que le das a
`printf`. Es decir:
```pawn
print "El 20% del personal representa el 80% de los gastos\n"
```
y
```pawn
printf "El 20%% del personal representa el 80%% de los gastos\n"
```
imprimen la misma cadena.


> [Regresar a la página anterior](00-introduccion.md) (Introducción)
>
> [Ir a la siguiente página](02-arreglos-y-constantes.md) (Arreglos y constantes)
>
> <sub>[Subir al principio de esta página](#aritmética-y-expresiones)</sub>