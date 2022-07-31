# Arreglos de múltiples dimensiones

Los arreglos multidimensionales son arreglos que contienen referencias a los subarreglos[^1]. Es decir, un arreglo bidimensional es un "arreglo de arreglos unidimensionales". A continuación se muestran algunos ejemplos de declaraciones de arreglos bidimensionales.

[^1]: La actual implementación del compilador Pawn soporta solo arreglos de hasta dos dimensiones. Puede que tu compilador soporte más dimensiones.

```pawn
new a[4][3]
new b[3][2] = { { 1, 2 }, { 3, 4 }, { 5, 6 } }
new c[3][3] = { { 1 }, { 2, ... }, { 3, 4, ... } }
new d[2][5] = { !"aceptar", !"rechazar" }
new e[2][]  = { "Si", "Cancelar" } 
new f[][] = { "Si", "Cancelar" }
```

Como muestran las dos últimas declaraciones (variable "e" y " f"), la dimensión final de un arreglo puede tener una longitud no especificada, en cuyo caso la longitud de cada subarreglo se determina a partir del inicializador correspondiente. Cada subarreglo puede tener un tamaño diferente; en este ejemplo concreto, "e[1][5]" contiene la letra "l" de la palabra "Cancelar", pero "e[0][5]" no es válido porque la longitud del subarreglo "e[0]" es sólo de tres celdas (que contienen las letras "S", "i" y un terminador cero).

La diferencia entre las declaraciones de las matrices "e" y "f" es que en ellas dejamos que el compilador cuente el número de inicializadores para la dimensión mayor - `sizeof f` es 2, como `sizeof e` (véase la siguiente sección sobre el operador `sizeof`).

> [Regresar a la página anterior](10-inicializacion-enumerada-de-un-arreglo.md) (Inicialización enumerada de un arreglo)
>
> [Ir a la página siguiente](12-arreglos-y-el-operador-sizeof.md) (Arreglos y el operador sizeof)
>
> <sub>[Subir al principio de esta página](#arreglos-de-múltiples-dimensiones)</sub>