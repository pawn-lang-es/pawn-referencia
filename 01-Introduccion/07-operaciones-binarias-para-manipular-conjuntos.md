# Operaciones binarias
Algunos algoritmos se resuelven más fácilmente con "**operaciones de conjunto**", como la intersección, la unión y la inversión. En la siguiente figura, por ejemplo, queremos diseñar un algoritmo que nos devuelva los puntos que se pueden alcanzar desde algún otro punto en un número máximo de pasos especificado. Por ejemplo, si le pedimos que nos devuelva los puntos a los que se puede llegar en dos pasos partiendo de **B**, el algoritmo tiene que devolver **C**, **D**, **E** y **F**, *pero no G porque G requiere tres pasos desde B*.

![Imagen del conjunto de ejemplo](https://i.ibb.co/m9Dq7x2/image.png)

Nuestro enfoque es mantener, para cada punto del gráfico, el conjunto de otros puntos que puede alcanzar en un paso -este es el conjunto `siguiente_paso`. También tenemos un conjunto `resultado` que guarda todos los puntos que hemos encontrado hasta ahora. Empezamos estableciendo el conjunto de resultados igual al conjunto `siguiente_paso` para el punto de partida. Ahora tenemos en el conjunto de resultados todos los puntos que se pueden alcanzar en un paso. Luego, para cada punto de nuestro conjunto de resultados, creamos una unión del conjunto de resultados y el conjunto `siguiente_paso` para ese punto. Este proceso se itera durante un número determinado de bucles.

Un ejemplo puede aclarar el procedimiento descrito anteriormente. Cuando el punto de partida es **B**, comenzamos estableciendo el conjunto de resultados en **D** y **E** -estos son los puntos que se pueden alcanzar desde **B** en un paso. A continuación, recorremos el conjunto de resultados. El primer punto que encontramos en el conjunto es **D**, y comprobamos qué puntos se pueden alcanzar desde **D** en un paso: son **C** y **F**. Así que añadimos **C** y **F** al conjunto de resultados. Sabíamos que los puntos que se pueden alcanzar desde **D** en un paso son **C** y **F**, porque **C** y **F** están en el conjunto `siguiente_paso` para **D**. Así que lo que hacemos es fusionar el conjunto siguiente_paso para el punto **D** en el conjunto de resultados. La fusión se llama "unión" en la teoría de conjuntos. El conjunto de resultados original también contenía el punto **E**, pero el conjunto de pasos siguientes de **E** está vacío, por lo que no se añade ningún punto más. Por tanto, el nuevo conjunto resultante contiene ahora **C**, **D**, **E** y **F**.

Un **conjunto** es un contenedor de elementos de propósito general. La única información que un conjunto contiene de un elemento es si está presente en el conjunto o no. El orden de los elementos en un conjunto es insignificante y un conjunto no puede contener el mismo elemento
varias veces. El lenguaje PAWN no proporciona un tipo de datos "conjunto" ni operadores que funcionen con conjuntos. Sin embargo, se pueden simular conjuntos de hasta 32 elementos mediante operaciones de bits. Sólo se necesita un bit para almacenar un estado "presente/ausente" y, por tanto, una celda de 32 bits puede mantener el estado de 32 elementos del conjunto -siempre que se asigne a cada elemento una posición de bit única-.

La relación entre las operaciones de conjunto y las operaciones bit a bit se resumen en la siguiente tabla. En la tabla, una letra mayúscula representa un conjunto y una letra minúscula un elemento de ese conjunto.

| Concepto | Notación matemática | Expresión en PAWN |
| --- | --- | --- |
| Intersección | A ∩ B | A & B |
| Unión | A ∪ B | A \| B |
| Complemento | Ā | ~A
| Conjunto vacío | ɛ | 0 |
| Pertenencia | x ∈ A | (1 << x) & A |

Para comprobar la pertenencia, es decir, para consultar si un conjunto contiene un elemento concreto, se crea un conjunto con un solo elemento y se toma la intersección. Si el resultado es 0 (el conjunto vacío), el elemento no está en el conjunto. La numeración de los bits comienza normalmente en cero; el bit más bajo es el 0 y el más alto en una celda de 32 bits es el 31. Para hacer una celda con sólo el bit 7 establecido, desplaza el valor 1 a la izquierda por siete -o en una expresión de PAWN `1 << 7`.

A continuación se muestra el programa que implementa el algoritmo descrito anteriormente para encontrar todos los puntos a los que se puede llegar desde una salida concreta en un número determinado de pasos. El algoritmo está completamente en la función `findtargets`.

<sub>DISPONIBLE EN: set.p</sub>
```pawn
/* Operaciones de conjunto, usando aritmética binaria */

main()
    {
    enum (<<= 1) { A = 1, B, C, D, E, F, G }
    new nextstep[] =
        { C | E,     /* A puedo alcanzar C y E */
          D | E,     /* B  "    "   D y E */
          G,         /* C  "    "   G */
          C | F,     /* D  "    "   C y F */
          0,         /* E  "    "   none */
          0,         /* F  "    "   none */
          E | F,     /* G  "    "   E y F */
        }
    #pragma unused A, B

    print "El punto de partida: "
    new start = clamp( .value = toupper(getchar()) - 'A',
                       .min = 0,
                       .max = sizeof nextstep - 1
                     )

    print "\nEl número de pasos: "
    new steps = getvalue()

    /* crear el conjunto */
    new result = findtargets(start, steps, nextstep)
    printf "Los puntos en el rango de %C en %D pasos:", start + 'A', steps
    for (new i = 0; i < sizeof nextstep; i++)
        if (result & 1 << i)
            printf "%c ", i + 'A'
    }

findtargets(start, steps, nextstep[], numpoints = sizeof nextstep)
    {
    new result = 0
    new addedpoints = nextstep[start]
    while (steps-- > 0 && result != addedpoints)
        {
        result = addedpoints
        for (new i = 0; i < numpoints; i++)
            if (result & 1 << i)
                addedpoints |= nextstep[i]
        }
    return result
    }
```

La declaración `enum` justo debajo de la cabecera de la función `main` declara las constantes de los nodos **A** a **G**, pero con un giro. Normalmente, el `enum` empieza a contar desde cero; aquí, el valor de la primera constante, **A**, se establece explícitamente en 1. 

Lo más destacable es la expresión `(<<= 1)` entre la palabra reservada `enum` y el corchete de apertura que inicia la enumeración: especifica un incremento por "desplazamiento de bits". Por defecto, cada constante en una lista `enum` obtiene un valor que es 1 por encima de su predecesor, pero se puede especificar que cada constante sucesiva en una enumeración tenga un valor que sea

 - su predecesora incrementada por cualquier valor (no sólo 1) -por ejemplo, `(+= 5)`;
 - su predecesora multiplicada por cualquier valor -por ejemplo, "`(*= 3)`";
 - su predecesor desplazado a la izquierda por cualquier valor -por ejemplo, "`(<<= 1)`";

Tenga en cuenta que, en aritmética binaria, desplazar un bit a la izquierda equivale a multiplicar por dos, lo que significa que (/*= 2) y (<<= 1) hacen lo mismo.

Cuando se trabaja con conjuntos, una tarea típica que surge es determinar el número de elementos del conjunto. Una función directa que hace esto es la siguiente:

```pawn
bitcount(set)
{
    new count = 0
    for (new i = 0; i < cellbits; ++i)
        if (set & (i << i))
            ++count
    return count
}
```

Con un tamaño de celda de 32 bits, el bucle de esta función itera 32 veces para comprobar un solo bit en cada iteración. Con un poco de magia aritmética binaria, podemos reducirlo a un bucle solo para el número de bits que están "establecidos".
Es decir, la siguiente función itera solo una vez si el valor de entrada tiene solo un bit establecido:

```pawn
bitcount(set)
{
    new count = 0
    if (set)
        do
            count++
        while ((set = set & (set - 1)))
    return count
}
```

> [Regresar a la página anterior](06-enumeraciones.md) (Enumeraciones)
>
> [Ir a la siguiente página](08-una-calculadora-npi-simple.md) (Una calculadora NPI simple)
>
> <sub>[Subir al principio de esta página](#operaciones-binarias)</sub>