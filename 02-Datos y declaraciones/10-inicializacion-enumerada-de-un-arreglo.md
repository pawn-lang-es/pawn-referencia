# Inicialización enumerada de un arreglo

El tamaño de un arreglo puede establecerse con una constante que represente una
enumeración: un ejemplo de esto es el programa "cola de prioridad" en el capítulo [1.6 Enumeraciones](../01-Introduccion/06-enumeraciones.md). Cuando los campos individuales de la enumeración tienen un tamaño, los elementos del arreglo asociados se interpretan como subarreglos, en ocasiones. Para un ejemplo de este comportamiento, véase el programa calculador NPI en el capítulo [1.8 Una calculadora NPI simple](../01-Introduccion/08-una-calculadora-npi-simple.md).

La sintaxis de subarreglo se aplica también a la inicialización de un arreglo "enumerado". Refiriéndonos de nuevo al programa de ejemplo de la "cola prioritaria", para inicializar un arreglo "de mensajes" con valores fijos, la sintaxis es:

```pawn
enum message /* declaración copiada desde "QUEUE.P" */
    {
        text[40 char],
        priority
    }

new msg[message] = { !"nuevo mensaje", 1 }
```

El inicializador consiste de una cadena de caracteres (un arreglo literal) y un valor; estos van en los campos `text` y `priority` respectivamente. 

> [Regresar a la página anterior](09-inicializacion-progresiva-de-un-arreglo.md) (Inicialización progresiva de un arrreglo)
>
> [Ir a la página siguiente](11-arreglos-de-multiples-dimensiones.md) (Arreglos de múltiples dimensiones)
>
> <sub>[Subir al principio de esta página](#inicialización-enumerada-de-un-arreglo)</sub>