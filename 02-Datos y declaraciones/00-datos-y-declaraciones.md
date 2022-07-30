# Datos y declaraciones
PAWN es un lenguaje sin tipos. Todos los elementos de datos son de tipo "celda", y una celda puede contener un número integral. El tamaño de una celda (en bytes) depende del sistema —normalmente, una celda tiene 32 bits.

La palabra reservada `new` declara una nueva variable. Para declaraciones especiales, `new` se sustituye por `static`, `public` o `stock` (ver siguientes unidades). Una **declaración de variable** normal crea una variable que ocupa una "celda" de la memoria. A menos que se inicialice explícitamente, el valor de la nueva variable es cero.

Una declaración de variable puede ocurrir:

- en cualquier posición donde una declaración sería válida —variables locales;

- en cualquier posición en la que sería válida una **declaración de función** (declaraciones de función nativa) o una **implementación de función** —variables globales;

- en la primera expresión de una instrucción de bucle `for` —también variables locales.

### **Declaraciones locales**
    
    Una declaración local aparece dentro de una [sentencia compuesta](). Solo se puede acceder a una variable local desde el interior de la sentencia compuesta, y desde las sentencias compuestas anidadas. Una declaración en la primera expresión de una instrucción de bucle `for` también es una declaración local.

> Ver sentencias compuestas en el capítulo [7. Sentencias]().

### **Declaraciones globales**
    
    Una declaración global aparece fuera de una función y una variable global es accesible en cualquier función. Los datos globales sólo pueden inicializarse con expresiones constantes.

> [Regresar al capítulo anterior](/01-Introduccion/14-en-conclusion.md) (En conclusión)
>
> [Ir a la página siguiente](01-declaracion-de-variables-de-estado.md) (Declaración de variables de estado)
>
> <sub>[Subir al principio de esta página](#datos-y-declaraciones)</sub>