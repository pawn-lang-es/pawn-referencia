# Inicialización

Las variables pueden ser inicializadas en su declaración. El inicializador de un variable *global* debe ser una constante. Los arreglos, globales o locales, también deben ser inicializadas con constantes.

Las variables no inicializadas se ponen en cero por defecto. 

Ejemplos:

```pawn
new i = 1
new j                                   /* j es cero */
new k = 'a'                             /* k tiene un código para la letra 'a' */

new a[] = { 1, 4, 9, 16, 25 }           /* a tiene 5 elementos */
new s1[20] = { 'a', 'b' }               /* los otros 18 elementos son 0 */

new s2[] = "Hola mundo..."              /* un string desempaquetada */
```

Ejemplos de declaraciones inválidas:

```pawn
new c[3] = 4                            /* un arreglo no puede ser establecido a un valor */
new i = "Good-bye"                      /* solo un arreglo puede almacenar texto */
new q[]                                 /* tamaño desconocido del arreglo */
neq p[2] = { i + j, k -3 }              /* los inicializadores de un arreglo deben ser constantes */
```

> [Regresar a la página anterior]() ()
>
> [Ir a la página siguiente]() ()
>
> <sub>[Subir al principio de esta página]()</sub>