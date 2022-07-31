# Declaración de variables de estado
Una variable de estado es una variable global con un **clasificador de estado** añadido al final. El alcance y la duración de la variable están restringidos a los estados que aparecen en el clasificador.

> Enteder estados y clasificador de estado en el capítulo [1.10 Programación por estados](../01-Introduccion/10-programacion-por-estados.md).

Las variables de estado no pueden ser inicializadas. A diferencia de las variables normales (que están en cero después de la declaración —a menos que se inicialicen explícitamente), las variables de estado **mantienen un valor indeterminado después de la declaración** y después de entrar por primera vez en un estado de su clasificador. Normalmente, se utiliza la(s) función(es) de entrada de estado para inicializar adecuadamente la variable de estado.

> [Regresar a la página anterior](00-datos-y-declaraciones.md) (Datos y declaraciones)
>
> [Ir a la página siguiente](02-declaracion-de-variables-locales-estaticas.md) (Declaración de variables locales estáticas)
>
> <sub>[Subir al principio de esta página](#declaración-de-variables-de-estado)</sub>