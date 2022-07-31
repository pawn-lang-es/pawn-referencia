# Enumeraciones (datos estructurados)
En un lenguaje sin tipado, podríamos asignar un propósito diferente a algunos 
elementos de un arreglo que a otros elementos en el mismo arreglo. PAWN soporta 
constantes **enumeradas** con una extensión que le permite imitar algunas funcionalidades
que otros lenguajes implementan con "estructuras" o "registros".

El ejemplo para ilustrar las **enumeraciones** y los arreglos es más largo que los
programas PAWN anteriores, y también muestra algunas otras características, como 
las variables globales y los parámetros con nombre.

<sub>DISPONIBLE EN: queue.p</sub>
```pawn
/* Cola prioritaria (para cadenas de texto simples) */

enum message
    {
    text[40 char],
    priority
    }

main()
    {
    new msg[message]

    /* Inserte algunos elementos (lea la entrada de la consola) */
    printf "Inserte algunos mensajes y sus prioridades; \
            Termina con un texto vacío\n"
    for ( ;; )
        {
        printf "Mensaje:  "
        getstring .string = msg[text], .maxlength = 40, .pack = true
        if (strlen(msg[text]) == 0)
            break
        printf "Prioridad: "
        msg[priority] = getvalue()
        if (!insert(msg))
            {
            printf "La cola está llena, no se puede insertar más elementos\n"
            break
            }
        }

    /* Ahora imprima los mensajes extraídos de la cola */
    printf "\nContenido de la cola:\n"
    while (extract(msg))
        printf "[%d] %s\n", msg[priority], msg[text]
    }

const queuesize = 10
new queue[queuesize][message]
new queueitems = 0

insert(const item[message])
    {
    /* Compruebe si la cola puede contener un mensaje más */
    if (queueitems == queuesize)
        return false            /* la cola está llena */

    /* Encuentre la posición para insertarlo */
    new pos = queueitems        /* Empiece en la parte inferior */
    while (pos > 0 && item[priority] > queue[pos-1][priority])
        --pos                   /* mayor prioridad: mueve una ranura */

    /* Hacer lugar para el artículo en el lugar de inserción */
    for (new i = queueitems; i > pos; --i)
        queue[i] = queue[i-1]

    /* Agregue el mensaje a la ranura correcta */
    queue[pos] = item
    queueitems++

    return true
    }

extract(item[message])
    {
    /* Compruebe si la cola tiene un mensaje más */
    if (queueitems == 0)
        return false            /* la cola está vacía */

    /* Copie el artículo más alto */
    item = queue[0]
    --queueitems

    /* Mueva la cola una posición hacia arriba */
    for (new i = 0; i < queueitems; ++i)
        queue[i] = queue[i+1]

    return true
    }
```

En la parte superior del ejemplo se encuentra la declaración de la enumeración `message`. 
Esta enumeración define dos constantes: text, que es cero, y priority, que es 1 
(asumiendo una celda de 32 bits). La idea de una enumeración es definir rápidamente 
una lista de constantes simbólicas sin duplicados. Por defecto, cada constante de la 
lista es 1 mayor que su predecesora y la primera constante de la lista es cero.
Sin embargo, se puede dar un incremento extra a una constante para que el sucesor 
tenga un valor de 1 más ese incremento extra. La constante especifica un incremento 
extra de `40 char`. En PAWN, `char` es un operador que devuelve el número de celdas 
necesarias para contener una cadena empaquetada del número especificado de caracteres. 
Asumiendo una celda de 32 bits y un carácter de 8 bits, 10 celdas pueden contener 40 
caracteres empaquetados.

Inmediatamente al principio de la función `main`, se declara un nuevo arreglo con el 
tamaño de `message`. El símbolo `message` es el nombre de la enumeración. También es
una constante con el valor de la última constante de la lista de enumeración más el 
incremento extra opcional para ese último elemento. Así que en este ejemplo, `message` 
es 12. Es decir, el arreglo `msg` se declara para contener 12 celdas.

Además en `main` hay dos bucles. El bucle `for` lee el texto y los valores de prioridad 
desde la consola y los inserta en una cola. El bucle `while` que se encuentra debajo
extrae elemento por elemento de la cola e imprime la información en la pantalla. El 
punto a tener en cuenta, es que el bucle `for` almacena tanto la cadena como el número 
de prioridad (un entero) en la misma variable `msg`; de hecho, la función `main` declara 
una sola variable. La función `getstring` almacena el texto del mensaje que se escribe a 
partir del arreglo `msg[text]` mientras que el valor de la prioridad se almacena (mediante 
una asignación unas líneas más abajo) en `msg[priority]`. La función `printf` en el bucle 
`while` lee la cadena y el valor de esas prioridades también.

Al mismo tiempo, el arreglo `msg` es una entidad en sí misma: se pasa en su totalidad 
a la función `insert`. Esa función, cerca del final, dice `queue[queueitems]= item`, 
donde `item` es un arreglo con tamaño de mensaje y `queue` es un arreglo bidimensional 
que contiene elementos de tamaño `message`. La declaración de `queue` y `queuesize` están 
justo encima de la función `insert`.

El ejemplo implementa una "cola prioritaria". Se puede insertar un número de mensajes 
en la cola y cuando todos estos mensajes tienen la misma prioridad, se extraen de la 
cola en el mismo orden. Sin embargo, cuando los mensajes tienen diferentes prioridades, 
el de mayor prioridad sale primero. La "lógica" de esta operación está dentro de 
la función `insert`: primero determina la posición del nuevo mensaje a añadir, y luego 
mueve algunos mensajes una posición hacia arriba para hacer espacio para el nuevo 
mensaje. La función `extract` simplemente recupera siempre el primer elemento de la 
cola y desplaza todos los elementos restantes una posición hacia abajo.

Observe que tanto las funciones `insert` como `extract` trabajan sobre dos variables 
compartidas, `queue` y `queueitems`. Una variable que se declara dentro de una función
como la variable `msg` en la función `main`, sólo puede ser accedida desde esa función. 
Una "**variable global**" es accesible por todas las funciones, y esa variable se 
declara fuera del ámbito de cualquier función. Las variables deben ser declaradas 
antes de ser utilizadas, por lo que `main` no puede acceder a las variables `queue` y 
`queueitems`, pero `insert` y `extract` sí.

La función `extract` devuelve los mensajes con mayor prioridad a través de su argumento 
de función `item`. Es decir, cambia su argumento de función copiando el primer elemento
del arreglo en `item`. La función `insert` copia en la otra dirección y no cambia su 
argumento de función en `item`. En este caso, se aconseja marcar el argumento de la 
función como `const`. Esto ayuda al analizador sintáctico de PAWN a comprobar los errores
y a generar un código mejor (más compacto y rápido).

Un último comentario sobre este último ejemplo es la llamada a `getstring` en la 
función `main`: observe cómo se atribuyen los parámetros con una descripción. 
El primer parámetro lleva la etiqueta ".string", el segundo ".maxlength" y el tercero 
".pack". La función `getstring` recibe "parámetros con nombre" en lugar de parámetros 
posicionales. El orden en que se enumeran los parámetros con nombre no es importante. 
Los parámetros con nombre son convenientes para especificar -y descifrar- largas 
listas de parámetros.

> [Regresar a la página anterior](05-cadena-de-caracteres.md) (Cadena de caracteres)
>
> [Ir a la siguiente página](07-operaciones-binarias-para-manipular-conjuntos.md) (Operaciones binarias)
>
> <sub>[Subir al principio de esta página](#enumeraciones-datos-estructurados)</sub>