# Declaración de variables públicas

Las variables globales "simples" (sin arreglos) pueden declararse "publicas" de dos maneras:

- declarar la variable utilizando la palabra reservada `public` en lugar de `new`;

- empezar el nombre de la variable con el símbolo `@`.

Las variables públicas se comportan como las globales, con el añadido de que el programa anfitrión también puede leer y escribir variables públicas. Una variable global (normal) solo puede ser accedida por las funciones de su script —el programa anfitrión
no tiene conocimiento de ellas. Como tal, un programa anfitrión puede requerir que declare una variable con un nombre específico como "pública" para propósitos especiales —como el número de error más reciente, o el estado general del programa.

> [Regresar a la página anterior](04-declaracion-de-variables-de-reserva.md) (Declaración de variables de reserva)
>
> [Ir a la página siguiente](06-declaracion-de-variables-constantes.md) (Declaración de variables constantes)
>
> <sub>[Subir al principio de esta página](#declaración-de-variables-públicas)</sub>