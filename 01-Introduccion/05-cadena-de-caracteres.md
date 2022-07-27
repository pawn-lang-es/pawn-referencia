# Cadena de caracteres (o texto)

PAWN no tiene un tipo intrínseco de "texto"; las cadenas de caracteres se almacenan en arreglos, con la convención de que el elemento del arreglo detrás del último carácter válido es cero. Trabajar con cadenas es, por tanto, equivalente a trabajar con arreglos.

Entre los esquemas de encriptación más sencillos se encuentra el llamado "ROT13"; en realidad, el algoritmo es bastante "débil" desde el punto de vista criptográfico. Es el más utilizado en los foros electrónicos públicos (BBS, Usenet) para ocultar textos de la lectura casual, como la solución de rompecabezas o adivinanzas. ROT13 simplemente "gira" el alfabeto por la mitad de su longitud, es decir, 13 caracteres. Es una operación simétrica: si se aplica dos veces al mismo texto, se revela el original.

<sub>DISPONIBLE EN: rot13.p</sub>
```pawn
/* Cifrado simple, usando ROT13 */

main()
    {
    printf "Por favor escriba el texto para cifrar: "

    new str[100]
    getstring str, sizeof str
    rot13 str

    printf "Después de cifrado, el texto es: \"%s\"\n", str
    }

rot13(string[])
    {
    for (new index = 0; string[index]; index++)
        if ('a' <= string[index] <= 'z')
            string[index] = (string[index] - 'a' + 13) % 26 + 'a'
        else if ('A' <= string[index] <= 'Z')
            string[index] = (string[index] - 'A' + 13) % 26 + 'A'
    }
```

En la cabecera de la función de rot13, el parámetro "string" se declara como un arreglo, pero sin especificar el tamaño del arreglo -no hay ningún valor entre los corchetes. Cuando se especifica un tamaño para un arreglo en la cabecera de una función, debe coincidir con el tamaño del parámetro real en la llamada a la función. Omitir la especificación del tamaño de la matriz en la cabecera de la función elimina esta restricción y permite llamar a la función con arreglos de cualquier tamaño. En ese caso, deberá disponer de algún otro medio para determinar el tamaño (máximo) de la matriz. En el caso de un parámetro de tipo string, se puede buscar simplemente el terminador cero.

El bucle for que recorre la cadena es típico de las funciones de procesamiento de strings. Observe que la condición del bucle es "string[índice]". La regla para las condiciones verdadero/falso en pawn es que cualquier valor es "verdadero", excepto el cero. Es decir, cuando la celda del array en string[index] es cero, es "falso" y el bucle se cancela.

El algoritmo ROT13 sólo rota las letras; los dígitos, la puntuación y los caracteres especiales se mantienen inalterados. Además, las letras mayúsculas y minúsculas deben tratarse por separado. Dentro del bucle for, dos sentencias if filtran los caracteres de interés. La forma en que el segundo if está encadenado a la cláusula "else" del primer if es digna de mención, ya que es un método típico de comprobación de múltiples condiciones no superpuestas.

Anteriormente en este capítulo, se discutió el concepto de "llamada por valor" versus "llamada por referencia". Cuando trabaje con cadenas, o arrays en general, tenga en cuenta que pawn siempre pasa los arrays por referencia. Lo hace para conservar la memoria y aumentar el rendimiento -los arrays pueden ser estructuras de datos grandes y pasarlos por valor requiere que se haga una copia de esta estructura de datos, lo que consume memoria y tiempo.

Una función que toma un array como argumento y que no lo modifica, puede marcar el argumento como "const"; ver página 72

Debido a esta regla, la función rot13 puede modificar su parámetro de función (llamado "cadena" en el ejemplo) sin necesidad de declararlo como argumento de referencia.

Otro punto de interés son las condiciones de las dos sentencias if. El primer if, por ejemplo, mantiene la condición "'a' <= string[índice] <= 'z'", lo que significa que la expresión es verdadera si (y sólo si) tanto 'a' <= string[índice] como string[índice] <= 'z' son verdaderos. En la expresión combinada, se dice que los operadores relacionales están "encadenados", ya que encadenan múltiples comparaciones en una condición.

Finalmente, observe cómo el último printf de la función main utiliza la secuencia de escape \" para imprimir una comilla doble. Normalmente una comilla doble termina la cadena literal; la secuencia de escape "\"" inserta una comilla doble en la cadena.

Siguiendo con el tema de las cadenas y las matrices, a continuación se muestra un programa que separa una cadena de texto en palabras individuales y las cuenta. Es un programa sencillo que muestra algunas características nuevas del lenguaje PAWN.

<sub>DISPONIBLE EN: wcount.p</sub>
```pawn
/* Recuento de palabras: contar palabras en una cadena de caracteres que ingreso el usuario */

main()
    {
    print "Por favor escriba una frase: "
    new string[100]
    getstring string, sizeof string

    new count = 0

    new word[20]
    new index
    for ( ;; )
        {
        word = strtok(string, index)
        if (strlen(word) == 0)
            break
        count++
        printf "Palabra %d: '%s'\n", count, word
        }

    printf "\nNúmero de palabras: %d\n", count
    }

strtok(const string[], &index)
    {
    new length = strlen(string)

    /* Saltar espacio en blanco  */
    while (index < length && string[index] <= ' ')
        index++

    /* Almacene la palabra letra por letra */
    new offset = index                /* Guardar la posición de inicio del token */
    new result[20]                    /* Cadena de caracteres para almacenar la palabra */
    while (index < length
           && string[index] > ' '
           && index - offset < sizeof result - 1)
        {
        result[index - offset] = string[index]
        index++
        }
    result[index - offset] = EOS      /* Terminar la cadena con el terminador cero  */

    return result
    }
```

La función main muestra primero un mensaje y recupera una cadena que
el usuario debe escribir. Luego entra en un bucle: escribir "for (;;)" crea un bucle sin inicialización, sin incremento y sin prueba -es un bucle infinito,

equivalente a "while (true)". Sin embargo, mientras que el analizador de peones le dará una advertencia si escribe "while (true)" (algo así como "expresión de prueba redundante; siempre es verdadera"), "for (;;)" pasa el analizador sin advertencia.

Un uso típico de un bucle infinito es un caso en el que se necesita un bucle
con la prueba en el medio -un híbrido entre un while y un do. El peón no soporta bucles con una prueba en el medio directamente,
pero se puede imitar uno codificando un bucle infinito con una ruptura condicional. En este programa de ejemplo, el bucle

 - obtiene una palabra de la cadena -código antes de la prueba ;
 - comprueba si hay una nueva palabra disponible, y sale del bucle si no es así -la prueba en el medio;
 - imprime la palabra y su número de secuencia - código después de la prueba.

Como se desprende de la línea "word = strtok(string, index)" (y de la declaración de la variable word), pawn soporta la asignación de arrays y las funciones que devuelven arrays. El analizador de peones verifica que el array que devuelve strtok tiene el mismo tamaño y dimensiones que la variable a la que se asigna.

La función strlen es una función nativa (predefinida), pero strtok no lo es: debe ser implementada por nosotros. La función strtok está inspirada en la función del mismo nombre de C/C++, pero no modifica la cadena fuente. En cambio,
copia los caracteres de la cadena fuente, palabra por palabra, en una matriz local, que luego devuelve.

> [Regresar a la página anterior](04-numeros-racionales.md) (Números racionales)
>
> [Ir a la siguiente página](06-cadena-de-caracteres.md) (Próximamente)
>
> <sub>[Subir al principio de esta página](#cadena-de-caracteres-o-texto)</sub>