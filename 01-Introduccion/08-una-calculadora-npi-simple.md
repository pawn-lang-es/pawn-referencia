# Una calculadora NPI simple
La notación matemática común, con expresiones como "26 - 3 (5 + 2)", se conoce como notación algebraica. Es una notación compacta y
nos hemos acostumbrado a ella. pawn y, en general, la mayoría de los lenguajes de programación utilizan la notación algebraica para sus expresiones de programación. 

La notación algebraica tiene algunas desventajas. Por ejemplo, ocasionalmente requiere que el orden de las operaciones se haga explícito encerrando una parte de la expresión entre paréntesis. La expresión que encabeza este párrafo puede reescribirse para eliminar los paréntesis, pero a costa de casi duplicar su longitud. En la práctica, la notación algebraica se complementa con reglas de nivel de precedencia que dicen, por ejemplo, que la multiplicación va antes que la suma y la resta.∗ Los niveles de precedencia reducen en gran medida la necesidad de los paréntesis, pero no los evitan del todo. Lo peor es que cuando el número de operadores crece, la jerarquía de niveles de precedencia y el nivel de precedencia particular
de precedencia para cada operador se hace difícil de memorizar, por lo que un lenguaje rico en operadores como APL elimina por completo los niveles de precedencia.

Alrededor de 1920, el matemático polaco Jan 'Lukasiewicz demostró que poniendo los operadores delante de sus operandos, en lugar de entre ellos,
los niveles de precedencia eran redundantes y los paréntesis no eran necesarios. Esta notación se conoció como la "Notación Polaca".† Charles Hamblin propuso más tarde poner los operadores detrás de los operandos, llamándola "Notación Polaca Inversa".

La ventaja de invertir el orden es que los operadores se enumeran en el mismo orden en que deben ejecutarse: al
leer los operadores de izquierda a derecha, también tiene las operaciones que realizarse en ese orden. La expresión algebraica del principio de esta sección se leería en NPI como

26 3 5 2 + × -

Si nos fijamos sólo en los operadores, tenemos: primero una suma, luego una multiplicación y finalmente una resta. Los operandos de cada operador se leen de derecha a izquierda: los operandos del operador + son los valores 5
y 2, los del operador son el resultado de la suma anterior y el valor 3, y así sucesivamente.

Es útil imaginar que los valores se encuentran colocados en una especie de pila, donde los operadores toman uno o más operandos de la parte superior de la pila y colocan el resultado en la parte superior de la pila. Al leer la expresión NPI, los valores 26, 3, 5 y 2 están "apilados" en ese orden. El operador + elimina los dos primeros elementos
de la pila (5 y 2) y empuja la suma de estos valores hacia atrás -la pila ahora se lee "26 3 7". A continuación, el operador elimina 3 y 7 y coloca el producto de los valores en la pila -la pila es "26 21". Por último, el operador resta 21 de 26 y almacena el único valor 5, el resultado final de la expresión, en la pila.

La notación polaca inversa se hizo popular porque era fácil de entender y de implementar en las (primeras) calculadoras. También abre el camino a los operadores con más de dos operandos (por ejemplo, la integración) o a los operadores con más de un resultado (por ejemplo, la conversión entre coordenadas polares y cartesianas).

El programa principal de una calculadora de Notación Polaca Inversa se encuentra a continuación:

<sub>DISPONIBLE EN: rpn.p</sub>
```pawn
/* una calculadora NPI simple */
#include strtok
#include stack
#include rpnparse

main()
    {
    print "Escriba una expresión en notación polaca inversa: "
    new string[100]
    getstring string, sizeof string
    rpncalc string
    }
```

El programa principal contiene muy poco código en sí; en su lugar, incluye el código necesario de otros tres archivos, cada uno de los cuales implementa algunas funciones que, en conjunto, construyen la calculadora NPI. Cuando los programas o scripts se hacen más grandes, normalmente se aconseja dividir la implementación en varios archivos, para facilitar el mantenimiento.

La función main primero pone un prompt y llama a la función nativa getstring para leer una expresión que el usuario escribe. Luego llama a la función personalizada rpncalc para que haga el verdadero trabajo. La función rpncalc está implementada en el archivo
archivo rpnparse.inc, que se muestra a continuación:

<sub>DISPONIBLE EN: rpnparser.p</sub>
```pawn
/* Parser RPN principal y análisis léxico, parte de la calculadora RPN */
#include <rational>
#include <string>

enum token
    {
              t_type,           /* tipo de operador o token */
    Rational: t_value,          /* valor, si t_type es "número" */
              t_word[20],       /* texto simplemente */
    }

const Number    = '0'
const EndOfExpr = '#'

rpncalc(const string[])
    {
    new index
    new field[token]
    for ( ;; )
        {
        field = gettoken(string, index)
        switch (field[t_type])
            {
            case Number:
                push field[t_value]
            case '+':
                push pop() + pop()
            case '-':
                push - pop() + pop()
            case '*':
                push pop() * pop()
            case '/', ':':
                push 1.0 / pop() * pop()
            case EndOfExpr:
                break   /* termina el bucle "for" */
            default:
                printf "Operador desconocido: '%s'\n", field[t_word]
            }
        }
    printf "Result = %r\n", pop()
    if (clearstack())
        print "Stack not empty\n", red
    }

gettoken(const string[], &index)
    {
    /* Primero obtenga la próxima "palabra" de la cadena */
    new word[20]
    word = strtok(string, index)

    /* luego analizarlo */
    new field[token]
    field[t_word] = word
    if (strlen(word) == 0)
        {
        field[t_type] = EndOfExpr /* símbolo especial de "parada" */
        field[t_value] = 0
        }
    else if ('0' <= word[0] <= '9')
        {
        field[t_type] = Number
        field[t_value] = rationalstr(word)
        }
    else
        {
        field[t_type] = word[0]
        field[t_value] = 0
        }

    return field
    }
```

La calculadora NPI utiliza el soporte de números racionales y rpnparse.inc incluye
el archivo "rational" para tal propósito. Casi todas las operaciones con números racionales
está oculta en la aritmética. Las únicas referencias directas a
números racionales son el código de formato `%r` en la sentencia `printf` cerca de la parte inferior
de la función `rpncalc` y la llamada a `rationalstr` a mitad de la función `gettoken`.

El primer elemento notable en el archivo rpnparse.inc es la declaración `enum`
donde un elemento tiene una etiqueta (t_field) y el otro elemento tiene un tamaño
(t_palabra). La función `rpncalc` declara la variable `field` como un arreglo utilizando
el símbolo de la enumeración como su tamaño. Detrás de cáramas, esta declaración lo único que hace es
crear un arreglo con 22 celdas:

La etiqueta de índice del array se establece con el nombre: `token:`. Esto significa que puedes indexar el array con cualquiera de los elementos de la enumeración, pero no con valores que tengan una etiqueta diferente. En otras palabras, `field[t_type]` está bien, pero `field[1]` da un diagnóstico del analizador.

El nombre de la etiqueta de la enumeración anula el nombre de la etiqueta de la variable del arreglo, si la hay. La variable `field` no tiene etiqueta, pero `field[t_value]` tiene la etiqueta `Rational:`, porque el elemento de enumeración `t_value` está declarado como tal. Esto, por lo tanto, permite crear un array cuyos elementos tienen diferentes nombres de etiqueta.

Cuando un elemento en la enumeración tiene un tamaño, el elemento del arreglo indicado con ese elemento se trata a veces como un subarreglo. En `rpncalc`, la expresión `field[t_type]` es una sola celda, "field[t_value]" es una sola celda, pero "field[t_word]" es un arreglo unidimensional de 20 celdas. Lo vemos específicamente en la línea

```pawn
printf "Operador desconocido: '%s'\N", campo[t_palabra]
```

donde el token de formato `%s` espera una cadena de caracteres (o simplemente texto) -un arreglo terminado en cero.

Si conoces C/C⁺⁺ o Java, es posible que quieras examinar la sentencia `switch`.
La sentencia `switch` difiere en varios aspectos de los otros lenguajes
que la proporcionan. Los casos no son *fall-through*, lo cual a su vez significa que la sentencia `break` para el caso `EndOfExpr` rompe el bucle del bucle que lo encierra (en este caso, el bucle `for`), en lugar de salir del `switch`.

En la parte superior del bucle `for` de la función `rpncalc`, se encuentra la instrucción
`field = gettoken(string, index)`. Como ya se ejemplificó en
wcount.p ("recuento de palabras"), las funciones pueden devolver arreglos.
La cosa se pone más interesante con una línea similar en la función gettoken

```field[t_word] = word```

donde `word` es un arreglo de 20 celdas y `field` es un arreglo de 22 celdas.
Sin embargo, como el campo de la enumeración `t_word` se declara con un tamaño de 20 celdas,
"`field[t_word]`" se considera un subarreglo de 20 celdas, que coincide precisamente con el
tamaño del arreglo de `word`.

<sub>DISPONIBLE EN: strtok.i</sub>
```pawn
/* extrae palabras de un texto (palabras separadas por un espacio en blanco) */
#include <strin>

strtok(const string[], &index)
    {
    new length = strlen(string)

    /* saltar espacio en blanco */
    while (index < length && string[index] <= ' ')
        index++

    /* almacena la palabra letra por letra */
    new offset = index     /* guardar la posición de inicio del token */
    new result[20]         /* cadena de caracter para guardar la palabra */
    while (index < length
        && string[index] > ' '
        && index - offset < sizeof result - 1)
            {
            result[index - offset] = string[index]
            index++
            }
    result[index - offset] = EOS /* terminar la cadena con cero */

    return result
    }
```

La función `strtok` es la misma que se utiliza en el ejemplo wcount.p. Está implementada en un archivo separado para el programa de la calculadora NPI. Tenga en cuenta que la función `strtok`, tal como se implementa aquí, sólo puede manejar palabras con un máximo de 19
caracteres -el vigésimo carácter es el terminador cero. Una implementación verdaderamente reutilizable de propósito general de una función `strtok` pasaría la cadena de destino como un parámetro, de modo que podría manejar palabras de cualquier tamaño. El soporte de cadenas empaquetadas y desempaquetadas también sería una característica útil de una función de propósito general.

Al discutir los méritos de la Notación Polaca Inversa, mencioné que una pila es tanto una ayuda para "visualizar" el algoritmo como un método conveniente para implementar un analizador de NPI. Este ejemplo de calculadora NPI, utiliza una pila con las omnipresentes funciones `push` y `pop`. Para la comprobación de errores y para restablecer la pila, hay una tercera función que borra la pila.

<sub>DISPONIBLE EN: stack.inc</sub>
```pawn
/* funciones para manipular pilas, parte de una calculadora NPI */
#include <rational>

static Rational: stack[50]
static stackidx = 0

push(Rational: value)
    {
    assert stackidx < sizeof stack
    stack[stackidx++] = value
    }

Rational: pop()
    {
    assert stackidx > 0
    return stack[--stackidx]
    }

clearstack()
    {
    assert stackidx >= 0
    if (stackidx == 0)
        return false
    stackidx = 0
    return true
    }
```

El archivo stack.inc incluye de nuevo el archivo rational. Esto no es técnicamente necesario (rpnparse.inc ya incluía las definiciones para el soporte de números racionales), pero tampoco hace ningún daño y, en aras de la reutilización del código, es mejor hacer que cualquier fichero incluya las definiciones de las librerías de las que depende.

Observe cómo las dos variables globales stack y stackidx se declaran
como variables "estáticas", utilizando la palabra clave static en lugar de new. Esto hace que las variables globales sean "visibles" sólo en ese archivo. Para todos los demás archivos en un
proyecto más grande, los símbolos stack y stackidx son invisibles y no pueden (evidentemente) modificar las variables. También permite que los otros módulos declaren sus propias variables privadas con estos nombres, por lo que se evita el choque de nombres.

La calculadora rpn es en realidad un programa bastante pequeño, pero se ha configurado como si fuera un programa más grande. También fue diseñado para demostrar un conjunto de elementos del lenguaje de peones y el programa de ejemplo podría haber sido implementado de forma más compacta.

> [Regresar a la página anterior](07-operaciones-binarias-para-manipular-conjuntos.md) (Operaciones binarias)
>
> [Ir a la siguiente página]() (Próximamente)
>
> <sub>[Subir al principio de esta página](#una-calculadora-npi-simple)</sub>