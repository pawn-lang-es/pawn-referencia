# Declaración de variables de reserva

Una variable global puede ser declarada como "de reserva". Una declaración `stock` es aquella que el analizador sintáctico puede eliminar o ignorar *si la variable no es utilizada en el programa*.

Las variables de reserva son útiles en combinación con las funciones de reserva. Una variable pública también puede ser declarada como "de reserva" —declarar las variables públicas como `public stock` le permite declarar todas las variables públicas que una aplicación anfitriona proporciona en un archivo de inclusión, con sólo aquellas variables que el script realmente utiliza terminando en el archivo P-code.

> [Regresar a la página anterior](03-declaracion-de-variables-globales-estaticas.md) (Declaración de variables globales estáticas)
>
> [Ir a la página siguiente](05-declaracion-de-variables-publicas.md) (Declaración de variables públicas)
>
> <sub>[Subir al principio de esta página](#declaración-de-variables-de-reserva)</sub>