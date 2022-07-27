# Usando funciones

Los programas más grandes separan las tareas y operaciones en funciones. El uso de funciones aumenta la modularidad de los programas y las funciones, cuando están bien escritas, son portables a otros programas. El siguiente ejemplo implementa una función para calcular números de la serie de Fibonacci.

La secuencia de Fibonacci fue descubierta por Leonardo "Fibonacci" de Pisa, un matemático italiano del siglo XIII, cuyo mayor logro fue popularizar para el mundo occidental los números hindúes-árabes. El objetivo de la secuencia era describir el crecimiento de una población de conejos (idealizados);

y la secuencia es 1, 1, 2, 3, 5, 8, 13, 21,. . (cada valor siguiente es la suma de sus dos predecesores).

<sub>DISPONIBLE EN: fib.p</sub>
```pawn
/* Cálculo de números de fibonacci por iteración */

main()
    {
    print "Ingrese un valor: "
    new v = getvalue()
    if (v > 0)
        printf "El valor del número de fibonacci %d es %d\n",
               v, fibonacci(v)
    else
        printf "El número de fibonacci %d no existe\n", v
    }

fibonacci(n)
    {
    assert n > 0

    new a = 0, b = 1
    for (new i = 2; i < n; i++)
        {
        new c = a + b
        a = b
        b = c
        }
    return a + b
    }
```

La instrucción `assert` en la parte superior de la función `fibonacci` merece una mención explícita; protege contra condiciones "imposibles" o inválidas. Un número Fibonacci negativo es inválido, y la instrucción `assert` lo marca como un error del programador si se da este caso. Las aserciones sólo deben marcar los errores del programador, nunca los errores de entrada del usuario.

La implementación de una función definida por el usuario no es muy diferente a la de la función `main`. Sin embargo, la función `fibonacci` muestra dos conceptos nuevos: recibe un valor de entrada a través de un parámetro y devuelve un valor (tiene un "resultado").

Los parámetros de la función se declaran en la cabecera de la función; el único parámetro en este ejemplo es "n". Dentro de la función, un parámetro se comporta como una variable local, pero cuyo valor se pasa desde el exterior en la llamada a la función.

La sentencia `return` termina una función y establece el resultado de la misma. No es necesario que aparezca al final de la función; se permiten salidas anticipadas.

La función principal del ejemplo de Fibonacci llama a funciones "nativas" predefinidas, como `getvalue` y `printf`, así como a la función definida por el usuario `fibonacci`. Desde la perspectiva de la llamada a una función (como en la función `main`), no hay diferencia entre las funciones definidas por el usuario y las nativas.

La secuencia de números de Fibonacci describe una sorprendente variedad de fenómenos naturales. Por ejemplo, los dos o tres conjuntos de espirales de las piñas, las piñas y los girasoles suelen tener números de Fibonacci consecutivos entre el 5 y el 89 como número de espirales. Los números que se dan de forma natural en los patrones de ramificación (por ejemplo, el de las plantas) son efectivamente números de Fibonacci. Por último, aunque la secuencia de Fibonacci no es una secuencia geométrica, cuanto más se extiende la secuencia, más se acerca la relación entre los términos sucesivos a la razón áurea, de 1,618. . . ∗ que aparece tan a menudo en el arte y la arquitectura.

## Llamada por referencia y llamada por valor

Las fechas son una fuente especialmente rica de algoritmos y rutinas de conversi-n, porque los calendarios a los que se refiere una fecha han conocido una gran diversidad, a travŽs del tiempo y de todo el mundo.

El "número de día juliano" se atribuye a Josephus Scaliger† y cuenta el número de días desde el 24 de noviembre de 4714 a.C. (cal- endar‡ proléptico). Scaliger eligi- ó esa fecha porque marcaba la coincidencia de tres ciclos bien establecidos: el Ciclo Solar de 28 años (del antiguo calendario juliano), el Ciclo Metónico de 19 años y el Ciclo de Indicación de 15 años (impuestos periódicos o requisas gubernamentales en la antigua Roma), y porque no se conocía ninguna literatura o historia registrada anterior a esa fecha concreta en el pasado remoto. Scaliger utilizó este concepto para conciliar fechas en documentos históricos, y posteriormente los astrónomos lo adoptaron para calcular más fácilmente los intervalos entre dos acontecimientos.

∗ El valor exacto de la razón áurea es 1/2(√5 + 1). La relación entre los números de Fibonacci y la Proporción Áurea también permite un cálculo "directo" de cualquier número de la secuencia, en lugar del método iterativo descrito aquí.
∗ Hay cierto debate sobre qué inventó exactamente Josephus Scaliger y a quién o a qué llamó.
∗ El calendario gregoriano fue decretado para comenzar el 15 de octubre de 1582 por el papa Gregorio XIII, lo que significa que las fechas anteriores no existen realmente en el calendario gregoriano. Al extender el calendario gregoriano a días anteriores al 15 de octubre de 1582, nos referimos a él como calendario gregoriano proléptico.
Interfaz de la función nativa: 85

Los números del Día Juliano (a veces denotados con la unidad "jd") no deben ser con- fundidos con las Fechas Julianas (el número de días desde el comienzo del mismo año), o con el calendario Juliano que fue introducido por Julio César.

A continuación se muestra un programa que calcula el número del Día Juliano a partir de una fecha del calendario gregoriano (proléptico), y viceversa. Tenga en cuenta que en el calendario gregoriano proléptico, el primer año es 1 AD (Anno Domini) y el año anterior es 1 BC (Antes de Cristo): ¡el año cero no existe! El programa utiliza valores negativos para los años AC y valores positivos (no nulos) para los años AD.

<sub>DISPONIBLE EN: julian.p</sub>
```pawn
/* Calcule el número de día juliano desde una fecha, y viceversa */

main()
    {
    new d, m, y, jdn

    print "Dar una cita (dd-mm-yyyy): "
    d = getvalue(_, '-', '/')
    m = getvalue(_, '-', '/')
    y = getvalue()

    jdn = DateToJulian(d, m, y)
    printf("Fecha %d/%d/%d = %d JD\n", d, m, y, jdn)

    print "Dar un número de día juliano: "
    jdn = getvalue()
    JulianToDate jdn, d, m, y
    printf "%d JD = %d/%d/%d\n", jdn, d, m, y
    }

DateToJulian(day, month, year)
    {
    /* El primer año es 1. El año 0 no existe: es 1 aC (o -1) */
    assert year != 0
    if (year < 0)
        year++

    /* Mover enero y febrero hasta el final del año anterior */
    if (month <= 2)
        year--, month += 12
    new jdn = 365*year + year/4 - year/100 + year/400
              + (153*month - 457) / 5
              + day + 1721119
    return jdn
    }

JulianToDate(jdn, &day, &month, &year)
    {
    jdn -= 1721119

    /* año aproximado, luego ajuste en un bucle */
    year = (400 * jdn) / 146097
    while (365*year + year/4 - year/100 + year/400 < jdn)
        year++
    year--

    /* determinar el mes */
    jdn -= 365*year + year/4 - year/100 + year/400
    month = (5*jdn + 457) / 153

    /* determinar el día */
    day = jdn - (153*month - 457) / 5

    /* mover enero y febrero al comienzo del año */
    if (month > 12)
        month -= 12, year++

    /* Ajuste los años negativos (el año 0 debe convertirse en 1 aC, o -1) */
    if (year <= 0)
        year--
    }
```
La función main comienza creando variables para mantener el día, el mes y el año, y el número del día juliano calculado. Luego lee una fecha -tres llamadas a getvalue- y llama a la función DateToJulian para calcular el número del día. Después de calcular el resultado, main imprime la fecha introducida y el número del día juliano para esa fecha. Ahora, centrémonos en la función DateToJulian. . .

Cerca de la parte superior de la función DateToJulian, incrementa el valor del año si es negativo; lo hace para hacer frente a la ausencia de un año "cero" en el calendario gregoriano proléptico. En otras palabras, la función DateToJulian modifica sus argumentos de la función (posteriormente, también modifica el mes). Dentro de una función, un argumento se comporta como una variable local: se puede modificar. Sin embargo, estas modificaciones siguen siendo locales para la función DateToJulian. La función main pasa los valores de d, m e y a DateToJulian, que los asigna a sus argumentos de función día, mes y año respectivamente. A pesar de que DateToJulian modifica el año y el mes, no cambia y y m en la función main; sólo cambia las copias locales de y y m. Este concepto se llama "llamada por valor".

El ejemplo utiliza intencionadamente diferentes nombres para las variables locales en las funciones main y DateToJulian, con el fin de facilitar la ex- plicación anterior. Renombrar las variables de main d, m e y a día, mes y año respectivamente, no cambia el asunto: entonces resulta que tienes dos variables locales llamadas día, dos llamadas mes y dos llamadas año, lo cual es perfectamente válido en peón.

"Llamada por valor" frente a "Llamada por referencia": 71

El resto de la función DateToJulian es, con respecto al lenguaje pawn, aritmética sin interés.

Volviendo a la segunda parte de la función main vemos que ahora pide un número de día y llama a otra función, JulianToDate, para encontrar la fecha que coincide con el número de día. La función JulianToDate es interesante porque toma un argumento de entrada (el número del día juliano) y necesita calcular tres valores de salida, el día, el mes y el año. Por desgracia, una función sólo puede tener un único valor de retorno, es decir, una sentencia de retorno en una función sólo puede contener una expresión. Para resolver esto, JulianToDate pide específicamente que los cambios que realiza en algunos de los argumentos de su función se copien de nuevo en las variables del llamador de la función. Entonces, en main, las variables que deben contener el resultado de JulianToDate se pasan como argumentos a JulianToDate.

La función JulianToDate marca los argumentos apropiados para ser "copiados de vuelta al llamador" prefijándolos con un símbolo &. Los argumentos con un & se copian, los argumentos sin él no. "Copiar de vuelta" no es en realidad el término correcto. Un argumento etiquetado con un & se pasa a la función de una manera especial que permite a la función modificar directamente la variable original. Esto se llama "llamada por referencia" y un argumento que lo utiliza es un "argumento de referencia".

En otras palabras, si main pasa y a JulianToDate -que lo asigna a su argumento de función year- y JulianToDate modifica year, entonces JulianToDate realmente modifica y. Sólo mediante argumentos de referencia puede una función modificar directamente una variable que está declarada en una función diferente.

Para resumir el uso de la llamada por valor frente a la llamada por referencia: si una función tiene un valor de salida, se suele utilizar una sentencia return; si una función tiene más valores de salida, se utilizan argumentos de referencia. Puede combinar los dos dentro de una misma función, por ejemplo en una función que devuelve su salida "normal" a través de un argumento de referencia y un código de error en su valor de retorno.

Como curiosidad, muchas aplicaciones de escritorio utilizan conversiones a y desde
números del Día Juliano (o variedades del mismo) para calcular convenientemente el número de días entre dos fechas o para calcular la fecha que es dentro de 90 días -por ejemplo.---.

> [Regresar a la página anterior](02-arreglos-y-constantes.md) (Arreglos y constantes)
>
> [Ir a la siguiente página](04-numeros-racionales.md) (Números racionales)
>
> <sub>[Subir al principio de esta página](#usando-funciones)</sub>