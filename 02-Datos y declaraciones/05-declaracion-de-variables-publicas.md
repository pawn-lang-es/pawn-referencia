# Declaración de variables públicas

Las variables globales "simples" (sin arrays) pueden declararse "publicas" de dos maneras

- declarar la variable utilizando la palabra clave `public` en lugar de `new`;

- empezar el nombre de la variable con el símbolo "@".

Las variables públicas se comportan como las globales, con el añadido de que el programa anfitrión también puede leer y escribir variables públicas. Una variable global (normal) sólo puede ser accedida por las funciones de su script —el programa anfitrión
no tiene conocimiento de ellas. Como tal, un programa anfitrión puede requerir que declare una variable con un nombre específico como "pública" para propósitos especiales —como el número de error más reciente, o el estado general del programa.

> [Regresar a la página anterior]() ()
>
> [Ir a la página siguiente]() ()
>
> <sub>[Subir al principio de esta página]()</sub>