# Números racionales
Todos los cálculos realizados hasta este momento involucraban sólo números enteros 
-valores enteros-. PAWN también tiene soporte para números que pueden contener 
valores fraccionarios: estos se llaman "números racionales". Sin embargo, el hecho 
de que este soporte esté habilitado depende de la aplicación anfitriona.

Los números racionales pueden ser implementados como números de punto flotante o 
de punto fijo. La aritmética de punto flotante se utiliza habitualmente para cálculos
científicos y de propósito general, mientras que la aritmética de punto fijo es más 
adecuada para el procesamiento financiero y las aplicaciones en las que los errores 
de redondeo no deberían entrar en juego (o, al menos, deberían hacerlo).

El kit de herramientas de PAWN tiene tanto un módulo de punto flotante como uno 
de punto fijo, y los detalles (y compensaciones) de estos módulos en su respectiva
documentación. La cuestión es, sin embargo, que una aplicación anfitriona puede 
implementar tanto el punto flotante como el punto fijo, o ambos o ninguno[^1]. El 
programa de abajo requiere que al menos cualquiera de los dos tipos de soporte 
de números racionales esté disponible; fallará al ejecutarse si la aplicación 
anfitriona no soporta números racionales en absoluto.

[^1]: De hecho, esto es verdadero para *todas* las funciones nativas, incluyendo todas
las funciones que se usan en los ejemplos de este manual.

<sub>DISPONIBLE EN: c2f.p</sub>
```pawn
#include <rational>

main()
    {
    new Rational: Celsius
    new Rational: Fahrenheit

    print "Celsius\t Fahrenheit\n"
    for (Celsius = 5; Celsius <= 25; Celsius++)
        {
        Fahrenheit = (Celsius * 1.8) + 32
        printf "%r \t %r\n", Celsius, Fahrenheit
        }
    }
```

El programa de ejemplo convierte una tabla de grados Celsius a grados Fahrenheit. 
La primera [directiva]() de este programa es importar definiciones para el soporte 
de números racionales desde un archivo de inclusión. El archivo "rational" incluye 
soporte para números de punto flotante o para números de punto fijo, dependiendo 
de lo que esté disponible.

Las variables Celsius y Fahrenheit se declaran con una etiqueta "`Rational:`" entre 
la palabra reservada `new` y el nombre de la variable. Un nombre de etiqueta **denota 
el propósito de la variable**, su uso permitido y, como caso especial para los números 
racionales, su disposición en memoria.

> Ver etiquetas en el capítulo [2.13 Etiquetas](/02-Datos%20y%20declaraciones/13-etiquetas.md).

La etiqueta Rational: indica al analizador que las variables Celsius y Fahrenheit 
contienen valores fraccionarios, en lugar de números enteros.

La ecuación para obtener los grados Fahrenheit a partir de los grados Celsius es:

°F = ⁹⁄₅ + 32 °C

El programa utiliza el valor 1,8 para el cociente 9/5. Cuando se activa el soporte de 
números racionales, PAWN soporta valores con una parte fraccionaria detrás de el punto 
decimal.

El único otro cambio no trivial con respecto a los programas anteriores es que el texto 
formateado para la función `printf` tiene ahora marcadores de posición variables denotados 
con "%r" en lugar de "%d". El marcador de posición %r imprime un número racional en la 
posición; %d es sólo para enteros ("números enteros").

Utilicé el archivo de inclusión "rational" en lugar de "float" o "fixed" en un intento 
de hacer el programa de ejemplo portable. Si sabe que la aplicación anfitriona soporta 
aritmética de punto flotante, puede ser más conveniente "#incluir" las definiciones del 
archivo float y usar la etiqueta `Float:` en lugar de Rational -al hacerlo, también debe 
reemplazar %r por %f en la llamada a `printf`. Para más detalles sobre el soporte de punto 
fijo y punto flotante, consulte las notas de aplicación "Librería de soporte de punto fijo" 
y "Librería de soporte de punto flotante" que están disponibles por separado.

> [Regresar a la página anterior](03-usando--funciones.md) (Usando funciones)
>
> [Ir a la siguiente página](05-cadena-de-caracteres.md) (Cadena de caracteres)
>
> <sub>[Subir al principio de esta página](#números-racionales)</sub>