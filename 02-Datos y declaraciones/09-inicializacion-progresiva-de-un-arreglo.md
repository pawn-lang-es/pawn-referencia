# Inicialización progresiva de un arreglo

El operador de elipsis continúa la secuencia de las constantes que inicializan un arreglo, basándose en los dos últimos elementos inicializados. El operador de elipsis (tres puntos, o `...`) inicializa el arreglo hasta su tamaño declarado.

Ejemplos:

```pawn
new a[10] = { 1, ... }                  /* establece todos los diez elementos en 1 */

new b[10] = { 1, 2, ... }               /* establece: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 */

new c[8] = { 1, 2, 40, 50, ... }        /* establece: 1, 2, 40, 50, 60, 70, 80, 90 */

new d[10] = { 10, 9, ... }              /* establece: 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 */
```

> [Regresar a la página anterior](08-inicializacion-de-una-variable.md) (Inicialización de una variable)
>
> [Ir a la página siguiente](10-inicializacion-enumerada-de-un-arreglo.md) ()
>
> <sub>[Subir al principio de esta página]()</sub>