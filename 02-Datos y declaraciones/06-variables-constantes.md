# Variables constantes

A veces es conveniente poder crear una variable que se inicializa una vez y que no puede ser modificada. Una variable de este tipo se comporta como una *constante simbólica*, pero sigue siendo una variable.

Para declarar una variable constante, inserte la palabra reservada `const` entre la palabra reservada que inicia la declaración de la variable -`new`, `static`, `public` o `stock`- y el nombre de la variable.

Ejemplos:
```pawn
new const address[4] = { 192, 0 , 168, 66}

public const status         /* inicializada en cero */
```

Tres situaciones típicas en las que se puede utilizar una variable constante son:

- Para crear una arreglo constante; las constantes simbólicas no pueden ser indexadas.

- Para una variable pública que debe ser establecida por la aplicación anfitriona, y sólo por la aplicación anfitriona. 

> Véase la sección anterior para las variables públicas.

- Un caso especial es marcar los arreglos que se pasan como  argumentos de funciones como constantes. Los arreglos como argumentos siempre se pasan por referencia, declararlos como `const` protege contra modificaciones involuntarias. 

> Consulte el capítulo [3.1 Argumentos de función](/03-Funciones/01-argumentos-de-funcion.md) para ver un ejemplo de argumentos constantes.

> [Regresar a la página anterior]() ()
>
> [Ir a la página siguiente]() ()
>
> <sub>[Subir al principio de esta página]()</sub>