# Arreglos y el operador sizeof

El operador `sizeof` devuelve el tamaño de una variable en "elementos". Para una variable simple (no compuesta), el resultado de `sizeof` es siempre 1, porque un elemento es una celda en una variable simple.

Un arreglo con una dimensión *contiene un número de celdas* y el operador `sizeof` devuelve ese número. Por lo tanto, el siguiente fragmento imprimiría "6" en
la pantalla, porque el arreglo `msg` contiene cinco caracteres (cada uno en una celda) más un terminador cero:

<sub>OBSERVANDO: operador sizeof</sub>
```pawn
new msg[] = "Ayuda"
printf("%d", sizeof msg)
```

Con arreglos multidimensionales, el operador `sizeof` puede devolver el número de elementos de cada dimensión. Para la última dimensión (menor), un elemento
será de nuevo una celda, pero para la(s) dimensión(es) mayor(es), un elemento es un subarreglo. En el siguiente fragmento de código, observe que la sintaxis `sizeof matrix` se refiere a la dimensión mayor del arreglo bidimensional y la sintaxis `sizeof matrix[]` se refiere a la dimensión menor del arreglo. Los valores que imprime este fragmento son 3 y 2 (para las dimensiones mayor y menor respectivamente):

<sub>OBSERVANDO: operador sizeof y arreglos multidimensionales</sub>
```pawn
new matrix[3][2] = { { 1, 2 }, { 3, 4 }, { 5, 6 } }
printf("%d %d", sizeof matrix, sizeof matrix[]);
```

El uso del operador `sizeof` en arreglos multidimensionales es especialmente conveniente cuando se utiliza como valor por defecto para los argumentos de las funciones.

> Véase argumentos por defecto en funciones en el capítulo [3.1 Argumentos de función](../03-Funciones/01-argumentos-de-funcion.md). 

> [Regresar a la página anterior](11-arreglos-de-multiples-dimensiones.md) (Arreglos de múltiples dimensiones)
>
> [Ir a la página siguiente](13-etiquetas.md) (Etiquetas)
>
> <sub>[Subir al principio de esta página](#arreglos-y-el-operador-sizeof)</sub>