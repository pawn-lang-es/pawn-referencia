# Arreglos y constantes

Junto a variables simples con un tamaño de una sola celda, PAWN admite "arreglo de variables" que contienen muchas celdas/valores. El siguiente programa muestra una serie de números primos utilizando el conocido "Tamiz de Eratosthenes". El programa también presenta otro concepto nuevo: *constantes simbólicas*. Las constantes simbólicas parecen variables, pero no se pueden cambiar.

<sub>DISPONIBLE EN: sieve.p</sub>
```pawn
/* Imprime todos los números primos menores a 100, usando el "Tamiz de Eratosthenes" */

main ()
    {
    const MAX_PRIMES = 100
    new series[MAX_PRIMES] = { true, ... }

    for (new i = 2; i < MAX_PRIMES; ++i)
        if (series[i])
            {
            printf "%d ", i
            /* filtra todo los múltiplos de este "primo" de la lista */
            for (new j = 2 * i; j < MAX_PRIMES; j += i)
                series[j] = false
            }
    }
```

Cuando un programa o subprograma tiene incorporado algún límite fijo, es
 buena práctica crear una constante simbólica para ello. En el ejemplo anterior
ejemplo, el símbolo MAX_PRIMES es una constante con el valor 100.
El programa utiliza el símbolo MAX_PRIMES tres veces después de su
definición: en la declaración de la variable `series` y en los dos
bucles `for`. Si adaptáramos el programa para imprimir todos los primos
por debajo de 500, ahora sólo hay que cambiar una línea.

> Ver **Declaración de constantes** en el capítulo [5. Sintaxis general](/05-Sintaxis%20general/00-sintaxis-general.md)

Al igual que las variables simples, los arreglos pueden ser inicializados en el momento de su creación.
 PAWN ofrece una abreviatura conveniente para inicializar todos los elementos a
un valor fijo: todos los cien elementos del array "series" se ponen a true -sin necesidad de que el programador escriba la palabra
 "true" cien veces. Los símbolos `true` y `false` son
constantes predefinidas.

> Ver **Inicializadores progresivos** en el capítulo [2. Datos y declaraciones](/02-Datos%20y%20declaraciones/09-inicializadores-progresivos-para-arreglos.md).

Cuando una variable simple, como las variables `i` y `j` en el ejemplo del tamiz de primos
se declaran en la primera expresión de un bucle `for`,
la variable sólo es válida dentro del bucle. La declaración de variables tiene
sus propias reglas; *no es una sentencia*, aunque lo parezca.
Una de las reglas especiales para la declaración de variables es que la primera
expresión de un bucle `for` puede contener una declaración de variable.

> Ver **Bucle `for`** en el capítulo [7. Sentencias](/07-Sentencias/00-sentencias.md).

Los dos bucles `for` también introducen nuevos operadores en su tercera expresión.
El operador `++` incrementa su operando en uno; es decir
que, `++i` es igual a `i = i + 1`. El operador `+=` añade la expresión de su derecha a la variable de su izquierda; es decir, `j += i` es igual
a `j = j + i`.

> Una visión global de todos los operadores en el capítulo [6. Operadores y expresiones](/06-Operadores%20y%20expresiones/00-operadores-y-expresiones.md).

Hay un problema de "off-by-one" que debe tener en cuenta cuando
trabajar con arreglos. El primer elemento de la matriz de `series` es `series[0]`, así que si la matriz contiene MAX_PRIMES elementos, el último elemento de la matriz es `series[MAX_PRIMES - 1]`. Si MAX_PRIMES es 100
el último elemento, entonces, es `series[99]`. Acceder a `series[100]` es inválido.

> [Regresar a la página anterior](01-expresiones-aritmeticas.md) (Expresiones aritméticas)
>
> [Ir a la siguiente página](03-usando-funciones.md) (Usando funciones)
>
> <sub>[Subir al principio de esta página](#arreglos-y-constantes)</sub>
